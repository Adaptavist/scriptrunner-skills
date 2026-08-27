# Make a field required when a value is selected inside a select list field.

- Platform: cloud
- Feature: behaviours
- Tags: customise, issue, fields
- Language: typescript
- Doc ID: example-cloud-make-field-required-when-another-field-selected-cloud
- Source: https://examples.scriptrunner.io/scripts/make-field-required-when-another-field-selected-cloud

## Overview

This example shows how you can make the ticket priority select list type field required when it has the Must Have value selected. 
The field is then made optional when it has any other value.

## Example

Make a field required when a specific option is selected in a field.

## Good to Know

This example will work on the Create View in Jira Cloud only. 
This script should be configured to work on the On Change event.

## Script

```typescript
const changedField = getChangeField();

const isRequired = changedField.getType() == "com.atlassian.jira.plugin.system.customfieldtypes:select"
    && changedField.getName() == "Ticket Priority"
    && changedField.getValue().value == "Must have";

getFieldById("customfield_10038").setRequired(isRequired);
```

