# Hide Fields With No Values

- Platform: cloud
- Feature: behaviours
- Tags: automate, issue
- Language: typescript
- Doc ID: example-cloud-hide-fields-with-no-values-cloud
- Source: https://examples.scriptrunner.io/scripts/hide-fields-with-no-values-cloud

## Overview

This example shows how to hide fields that do not have any value assigned.

## Example

As a product owner hide all fields from a Jira work item that do not have any value assigned to them.

## Good to Know

This example will work on the *Issue View* in Jira Cloud and should be configured to run on the *On Load* event.

## Script

```typescript
// Replace CUSTOM_FIELD_ID_HERE with field id of choice or the ID of a new scripted field when created
const field = getFieldById("CUSTOM_FIELD_ID_HERE")
if (!field.getValue()) {
    getFieldById("CUSTOM_FIELD_ID_HERE").setVisible(false)
}
else {
     getFieldById("CUSTOM_FIELD_ID_HERE").setVisible(true)
}
```

