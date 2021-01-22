resource "aws_s3_bucket" "myS3bucket" {
//  count = length(aws_elb.myELB.id) > 0 ? 1 : 0
  bucket = local.bucket_name
  acl = "private"
  force_destroy = true
  tags = merge(var.common_tags, {Name = "myS3Bucket-${var.env}", Env = var.env})
}

resource "aws_s3_bucket_policy" "elb_access_to_s3_bucket" {
  count = length(aws_s3_bucket.myS3bucket[*].id) > 0 ? 1 : 0
  bucket = aws_s3_bucket.myS3bucket.id
  policy = <<POLICY
{
  "Id": "Policy",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.myS3bucket.id}/AWSLogs/*",
      "Principal": {
        "AWS": [
          "${data.aws_elb_service_account.main.arn}"
        ]
      }
    }
  ]
}
POLICY
}