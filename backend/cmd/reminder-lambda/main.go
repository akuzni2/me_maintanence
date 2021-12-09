package main

import (
	"api/pkg/messaging"
	reminders2 "api/pkg/reminders"
	"context"
	"fmt"
	"github.com/aws/aws-lambda-go/lambda"
	"os"
	"time"
)

var (
	reminderService = reminders2.NewService(reminders2.NewRepository())
	messageService  = messaging.NewService()
)

type MyEvent struct {
	Name string `json:"name"`
}

func HandleRequest(ctx context.Context, name MyEvent) (string, error) {
	runReminderProcess()
	return fmt.Sprintf("Ran reminder process"), nil
}

func main() {
	if isInLambda() {
		lambda.Start(HandleRequest)
	} else {
		runReminderProcess()
	}

}

func runReminderProcess() {
	reminders, _ := getRemindersToActOn()
	fmt.Printf("Hello got it! Num of reminders: %d \n", len(reminders))

	for _, reminder := range reminders {
		err := sendReminderNotification(reminder)
		if err != nil {
			return
		}
		updateNextReminderTime(reminder)
		time.Sleep(time.Duration(1) * time.Second)
	}

}

// Step 1
func getRemindersToActOn() ([]reminders2.ReminderInformation, error) {
	var searchTime = time.Now().UnixMilli()
	fmt.Printf("Getting reminders expired before %d \n", searchTime)
	rem, err := reminderService.GetRemindersYoungerThan(searchTime)
	return rem, err
}

// Step 2
func sendReminderNotification(rem reminders2.ReminderInformation) error {

	//t := time.UnixMilli(rem.NextReminderDateEpoch)
	//timeString := fmt.Sprintf("%d-%s-%d %d:%d UTC", t.Year(), t.Month().String(), t.Day(), t.Hour(), t.Minute())
	message := fmt.Sprintf("ME Maintenance - This is your reminder about %s", rem.PreventativeCareTitle)

	msg := messaging.Message{Body: message, Recipient: rem.PhoneNumber}
	fmt.Println(msg)

	var useSvc = shouldUseMessageService()
	if useSvc {
		err := messageService.Send(msg)
		if err != nil {
			return err
		}
	}

	return nil
}

// Step 3
func updateNextReminderTime(rem reminders2.ReminderInformation) {
	fmt.Println("Updating next reminder")
	msPerYear := 3.1536e+16
	var updatedReminder = reminders2.Reminder{}
	updatedReminder.Id = rem.Id
	updatedReminder.Username = rem.Username

	// TODO fix this. How to conditonally update when this is null?
	updatedReminder.PreventativeCareId = rem.PreventativeCareId

	if rem.Recurring {
		currRemDate := time.UnixMilli(rem.NextReminderDateEpoch)
		timeToAdd := time.Duration(int64(msPerYear / rem.AnnualInterval))
		newRemDate := currRemDate.Add(timeToAdd)
		updatedReminder.ReminderDateEpoch = int(newRemDate.UnixMilli())
	} else {
		updatedReminder.ReminderDateEpoch = int(rem.NextReminderDateEpoch)
		updatedReminder.Completed = true
	}

	err := reminderService.UpdateReminder(updatedReminder)
	if err != nil {
		fmt.Printf("Error updating reminder: %s", err.Error())
		return
	}
	fmt.Println("Updating reminder completed")
}

func isInLambda() bool {
	_, inLambda := os.LookupEnv("AWS_EXECUTION_ENV")
	return inLambda
}

// if environment variable exists - we will use it. Otherwise we wont
func shouldUseMessageService() bool {
	if _, ok := os.LookupEnv("USE_MESSAGE_SERVICE"); ok {
		return true
	}
	return false
}

// 1) Create lambda in AWS - DONE
// 2) Deploy Lambda script to AWS in S3
// 3) Create Cloud watch event to trigger every minute
// 4) Query Reminders table
// 5) Query Prev_care table
// 6) Send alert to user
// 7) Update Rem. To be reminded next interval
