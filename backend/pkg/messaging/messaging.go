package messaging

import (
	"fmt"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/sns"
)

type Message struct {
	Body      string
	Recipient string
}

type Service interface {
	Send(m Message) error
}

type snsService struct {
}

func NewService() Service {
	return &snsService{}
}

func (s snsService) Send(m Message) error {
	fmt.Printf("sending content", m.Body)

	sess := session.Must(session.NewSession())

	svc := sns.New(sess)

	params := &sns.PublishInput{
		Message:     aws.String(m.Body),
		PhoneNumber: aws.String(m.Recipient),
	}
	resp, err := svc.Publish(params)

	if err != nil {
		// Print the error, cast err to awserr.Error to get the Code and
		// Message from an error.
		fmt.Println(err.Error())
		return err
	}

	// Pretty-print the response data.
	fmt.Println(resp.GoString())

	return nil
}
