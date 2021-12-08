package main

import (
	reminders2 "api/pkg/reminders"
	"context"
	"fmt"
	"github.com/aws/aws-lambda-go/lambda"
	"os"
	"time"
)

var (
	reminderService = reminders2.NewService(reminders2.NewRepository())
)

type MyEvent struct {
	Name string `json:"name"`
}

func HandleRequest(ctx context.Context, name MyEvent) (string, error) {
	runReminderProcess()
	return fmt.Sprintf("Hello %s!", name.Name), nil
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
	fmt.Printf("Hello got it! %s", len(reminders))
}

// Step 1
func getRemindersToActOn() ([]reminders2.ReminderInformation, error) {
	var searchTime = time.Now().UnixMilli()
	fmt.Printf("Getting reminders expired before %s", searchTime)
	rem, err := reminderService.GetRemindersYoungerThan(searchTime)
	return rem, err
}

// Step 2
func sendReminderNotification() {}

// Step 3
func updateNextReminderTime() {}

func isInLambda() bool {
	_, inLambda := os.LookupEnv("AWS_EXECUTION_ENV")
	return inLambda
}

// 1) Create lambda in AWS - DONE
// 2) Deploy Lambda script to AWS in S3
// 3) Create Cloud watch event to trigger every minute
// 4) Query Reminders table
// 5) Query Prev_care table
// 6) Send alert to user
// 7) Update Rem. To be reminded next interval
