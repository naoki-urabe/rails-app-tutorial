/*data "archive_file" "start_scheduler" {
  type        = "zip"
  source_file = "start_instances.py"
  output_path = "start_instances.zip"
}

resource "aws_lambda_function" "ec2_start_scheduler_lambda" {
  function_name    = "start_instances"
  filename         = data.archive_file.start_scheduler.output_path
  role             = aws_iam_role.ec2_start_stop_scheduler.arn
  handler          = "start_instances.lambda_handler"
  runtime          = "python3.9"
  timeout          = 300
  source_code_hash = data.archive_file.start_scheduler.output_base64sha256
}*/

data "archive_file" "stop_scheduler" {
  type        = "zip"
  source_file = "stop_instances.py"
  output_path = "stop_instances.zip"
}

resource "aws_lambda_function" "ec2_stop_scheduler_lambda" {
  function_name    = "stop_instances"
  filename         = data.archive_file.stop_scheduler.output_path
  role             = aws_iam_role.ec2_start_stop_scheduler.arn
  handler          = "stop_instances.lambda_handler"
  runtime          = "python3.9"
  timeout          = 300
  source_code_hash = data.archive_file.stop_scheduler.output_base64sha256
}