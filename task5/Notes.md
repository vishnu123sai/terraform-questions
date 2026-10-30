The original code used user/roleB in the trust policy, but roleB is an IAM role, not a user.

I fixed it by changing user/roleB to role/roleB and adding Account A's correct account ID.

Now, roleB can assume roleC, provided it also has permission to call sts:AssumeRole.

The roleC_s3 policy gives roleC access to S3.