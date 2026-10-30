NOTES.md
Account A
group1 contains engine and ci for CLI access.
group2 contains alice and bob for console and CLI access.
roleA has administrator permissions, except for IAM actions.
roleB can assume roleC in Account B.
Account B
roleC can access only the my-private-bucket S3 bucket.
Its trust policy allows only roleB from Account A to assume it.
1. IAM Users in Production

I would avoid using long-term access keys for engine and ci in production. I would prefer IAM roles and temporary credentials because they reduce the risk of leaked keys.

2. RoleC Trust Policy

Trusting the whole Account A root can allow other principals in that account to be authorized to assume roleC if they have the required permissions.

Trusting only the specific roleB ARN is safer because it limits who can assume roleC. This follows the principle of least privilege.