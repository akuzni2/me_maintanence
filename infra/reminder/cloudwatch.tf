resource "aws_cloudwatch_event_rule" "reminder_scheduler_rule" {
  name                = "${aws_lambda_function.reminder_lambda.function_name}-scheduler"
  description         = "MR Reminder scheduler to invoke lambda function"
  schedule_expression = "cron(* 0-6,12-23 * * ? *)"
  is_enabled          = true

}

resource "aws_cloudwatch_event_target" "reminder_scheduler_target" {
  rule = aws_cloudwatch_event_rule.reminder_scheduler_rule.name
  arn  = aws_lambda_function.reminder_lambda.arn
}

# Lambda Invocation Permission
resource "aws_lambda_permission" "lambda_reminder_allow_cloudwatch_event" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.reminder_lambda.arn
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.reminder_scheduler_rule.arn

}
