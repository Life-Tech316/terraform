data "aws_prefix_list" "s3_pl" {
  # This data source retrieves the S3 prefix list for the current AWS region
  name = "com.amazonaws.*.s3"
}