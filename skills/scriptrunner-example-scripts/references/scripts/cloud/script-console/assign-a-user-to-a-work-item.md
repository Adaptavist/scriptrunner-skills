# Assign a User to a Work Item

- Platform: cloud
- Feature: script-console
- Tags: automate, issue, hapi, user
- Language: groovy
- Doc ID: example-cloud-assign-a-user-to-an-issue-cloud
- Source: https://examples.scriptrunner.io/scripts/assign-a-user-to-an-issue-cloud

## Overview

This example demonstrates how to assign a work item to a specific user by referencing their Atlassian account ID.

## Example

Need to dynamically assign design tickets to the UX designer in Jira Cloud.

## Good to Know

- Atlassian APIs no longer support fetching user details by name.
- You can use this example in both the Create view and the Issue View in Jira Cloud.

## Script

```groovy
def assigneeAccountId = 'assignee_account_id'
WorkItems.getByKey("TVP-1").update{
    setAssignee(assigneeAccountId)
}
```

