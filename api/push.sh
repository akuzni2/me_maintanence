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

if [[ $env == "prd" ]]
then
  echo "Push to prod"
  heroku container:push web --app me-maintenance
  heroku container:release web --app me-maintenance
  heroku logs --tail --app me-maintenance
fi

if [[ $env == "stg" ]]
then
  echo "Push to stage"
  heroku container:push web --app me-maintenance-api
  heroku container:release web --app me-maintenance-api
  heroku ps:scale web=1 --app me-maintenance-api # why isn't this done automatically?
  heroku logs --tail --app me-maintenance-api
fi

if [[ $env == "local" ]]
then
  docker build -t flutterapp .
  docker run -e PORT=8000 -p 1200:8000 flutterapp
fi
