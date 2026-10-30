Task1

The prod-database instance has prevent_destroy = true to help prevent accidental deletion because it may contain important data.

Task2

Earlier, Terraform stored the state file locally on my computer. If two people ran terraform apply at the same time using separate local state files, they could make conflicting changes because neither person would see the other's latest state.

I added an S3 backend to store the state file in one shared location and a DynamoDB table to manage state locking.

When one person runs terraform apply, Terraform locks the state. If another person tries to modify the same state at the same time, Terraform waits for the lock instead of allowing both operations to run together.

This helps prevent conflicting changes and keeps the state consistent.