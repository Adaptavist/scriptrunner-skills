# Set the assignee field when the priority is set to High

- Platform: cloud
- Feature: behaviours
- Tags: customise, issue, fields
- Language: typescript
- Doc ID: example-cloud-set-the-assignee-field-when-the-priority-is-set-to-high-cloud
- Source: https://examples.scriptrunner.io/scripts/set-the-assignee-field-when-the-priority-is-set-to-high-cloud

## Overview

This example should be configured on the On Change event. 
It shows how you can set the assignee field when the priority field is set to high and clear it when it is set to any other value.

## Example

As a project manager, I want to ensure all high priority work get assigned to the technical lead.

## Good to Know

This example will work on the Create view and the Issue View inside of Jira Cloud.

## Script

```typescript
// Get the field changed on the screen. 
const changedField = getChangeField();

// Specify below the AccountId of the user to assign the work item to.
const accountId = "123456-8545622-54522";

if (changedField.getName() === 'Priority') {

    const priorityName = changedField.getValue().name.toString();

    if (priorityName === "High") {
        getFieldById("assignee").setValue(accountId);
    } else {
        getFieldById("assignee").setValue(null);
    }
}
```

