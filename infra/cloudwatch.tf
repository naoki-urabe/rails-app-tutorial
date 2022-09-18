resource "aws_cloudwatch_event_rule" "start_instances_event_rule" {
  name                = "start_instances_event_rule"
  description         = "Starts stopped EC2 instances"
  schedule_expression = "cron(00 13 ? * MON-SUN *)"
  depends_on          = ["aws_lambda_function.ec2_start_scheduler_lambda"]
}

resource "aws_cloudwatch_event_target" "start_instances_event_target" {
  target_id = "start_instances_lambda_target"
  rule      = aws_cloudwatch_event_rule.start_instances_event_rule.name
  arn       = aws_lambda_function.ec2_start_scheduler_lambda.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_start_scheduler" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ec2_start_scheduler_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.start_instances_event_rule.arn
}

resource "aws_cloudwatch_event_rule" "stop_instances_event_rule" {
  name                = "stop_instances_event_rule"
  description         = "Stops running EC2 instances"
  schedule_expression = "cron(00 15 ? * MON-SUN *)"
  depends_on          = ["aws_lambda_function.ec2_stop_scheduler_lambda"]
}

resource "aws_cloudwatch_event_target" "stop_instances_event_target" {
  target_id = "stop_instances_lambda_target"
  rule      = aws_cloudwatch_event_rule.stop_instances_event_rule.name
  arn       = aws_lambda_function.ec2_stop_scheduler_lambda.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_stop_scheduler" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ec2_stop_scheduler_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.stop_instances_event_rule.arn
}