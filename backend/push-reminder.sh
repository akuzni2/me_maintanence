#!/usr/bin/env bash

env=$1

if [[ $env == "" ]]
then
  echo ""
  echo "!!! ---- Attention!! Must specify one of (local/stg/prd) environments! ---- "
  echo ""
  echo "Usage: $0 <env>"
  echo "Example: $0 local"
  echo ""
  exit 0
fi


if [[ $env == "stg" ]]
then
  echo "Push to stage"
  GOOS=linux go build -o reminder-function cmd/reminder-lambda/main.go
  zip reminder-function.zip reminder-function
  echo "updating s3 artifact with file"
  aws s3 cp reminder-function.zip s3://account-870029572904-artifacts/reminder-lambda/
  aws lambda update-function-code \
      --function-name reminder_lambda \
      --zip-file fileb://reminder-function.zip
fi
