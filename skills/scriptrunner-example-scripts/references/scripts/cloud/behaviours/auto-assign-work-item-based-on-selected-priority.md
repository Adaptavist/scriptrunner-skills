# Auto assign work item based on  selected priority

- Platform: cloud
- Feature: behaviours
- Tags: automate, issue, user
- Language: typescript
- Doc ID: example-cloud-auto-assign-issue-based-on-selected-priority-cloud
- Source: https://examples.scriptrunner.io/scripts/auto-assign-issue-based-on-selected-priority-cloud

## Overview

This script will assign a user to the ticket based on the priority of the work item.

## Example

Assign high priority work to the team lead and all other work to developer.

## Good to Know

To assign the work item to a specific user you will need to pass the user accountId to replace the *USER1* and *USER2* placeholders with the users *accountId*. 

You can get the user key by going to the users profile and getting the accountId from the URL.

This example will work on both the Create View and work item View in Jira Cloud.

## Script

```typescript
const priorityField = getFieldById("priority")
const assigneeField = getFieldById("assignee")

console.log(priorityField.getValue().name)

// Assign user based on work item priority
switch (priorityField.getValue().name) {
    case "Highest":
        assigneeField.setValue("USER1")
        break;
    case "Medium":
        assigneeField.setValue("USER2")
        break;
    default:
        break;
}
```

