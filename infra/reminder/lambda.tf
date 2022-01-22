resource "aws_lambda_function" "reminder_lambda" {
  function_name = "reminder_lambda"
  description = "Scans for all the reminders"
  handler = "reminder-function"
  runtime = "go1.x"
  role = aws_iam_role.lambda_role.arn
  s3_bucket = var.tf_state_bucket
  timeout = 300
  s3_key = "reminder-lambda/reminder-function.zip"
  environment {
    variables = {
      USE_MESSAGE_SERVICE = true
      DB_PW = var.db_password
      DB_HOST = var.db_host
    }
  }

}

// This creates the IAM permissions for reminder a.k.a the "execution" role

data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_role" {
  name = "mr-reminder-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

// log group
resource "aws_cloudwatch_log_group" "example" {
  name = "/aws/lambda/${aws_lambda_function.reminder_lambda.function_name}"
  retention_in_days = 14
}

data "aws_iam_policy_document" "reminder_iam_policy_document" {

  statement {
    effect = "Allow"
    sid = "CloudwatchLogsAccess"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:*:*:*"
    ]
  }

  statement {
    effect = "Allow"
    sid = "SNSAccess"
    actions = [
      "sns:Publish"
    ]
    resources = [
      "*"
    ]
  }

}

resource "aws_iam_policy" "reminder_lambda_policy" {
  name = "mr_reminder_lambda_policy"
  policy = data.aws_iam_policy_document.reminder_iam_policy_document.json
}


resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.reminder_lambda_policy.arn
}






