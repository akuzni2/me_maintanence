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
fi
