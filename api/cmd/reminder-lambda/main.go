package main

import (
	"context"
	"fmt"
	"github.com/aws/aws-lambda-go/lambda"
)

type MyEvent struct {
	Name string `json:"name"`
}

func HandleRequest(ctx context.Context, name MyEvent) (string, error) {
	return fmt.Sprintf("Hello %s!", name.Name), nil
}

func main() {
	lambda.Start(HandleRequest)
}

// 1) Create lambda in AWS
// 2) Deploy Lambda to AWS in S3
// 3) Create Cloud watch event to trigger every minute
// 4) Query Reminders table
// 5) Query Prev_care table
// 6) Send alert to user
// 7) Update Rem. To be reminded next interval
