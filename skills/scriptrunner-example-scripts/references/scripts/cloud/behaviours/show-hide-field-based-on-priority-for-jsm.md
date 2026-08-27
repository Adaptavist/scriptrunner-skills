# Show/Hide field based on priority for JSM

- Platform: cloud
- Feature: behaviours
- Tags: automate, fields
- Language: typescript
- Doc ID: example-cloud-show-hide-field-based-on-priority-cloud
- Source: https://examples.scriptrunner.io/scripts/show-hide-field-based-on-priority-cloud

## Overview

This script checks the Priority field and shows or hides another field based on the priority selected.

## Example

I want to show or hide a field based on the highest priority.

## Good to Know

* Ensure the fields on which you want to apply this script are present on the screen.
* Replace the custom field IDs in the script with the ones from your Jira instance.

## Script

```typescript
const priorityField = getFieldById("priority");
const customField = getFieldById("customfield_11444"); // Field you want to show/hide

const currentPriority = priorityField.getValue()?.id;

// Assume 1 is the Highest priority
if (currentPriority === "1") {
    customField.setVisible(true) // Make field visible
    customField.setRequired(true); // Make field required
} else {
    customField.setVisible(false);
    customField.setRequired(false);
}
```

