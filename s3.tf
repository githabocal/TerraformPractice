resource "aws_s3_bucket" "s3" {
  bucket = "s3-bucket-with-terraform"

}

resource "aws_s3_bucket_policy" "prevent_deletion" {
  bucket = aws_s3_bucket.s3.id
  policy = data.aws_iam_policy_document.prevent_deletion_policy.json
}

data "aws_iam_policy_document" "prevent_deletion_policy" {
  statement {
    effect = "Deny"
    principals {
      type        = "AWS"
      identifiers = ["123456789012"]
    }
    actions = [
      # "s3:GetObject",
      # "s3:ListBucket",
      "s3:DeleteBucket"
    ]

    resources = [
      # aws_s3_bucket.arn,
      # "${aws_s3_bucket.arn}/*"
    ]
  }
}