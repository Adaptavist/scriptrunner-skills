# Dynamically show or hide a field

- Platform: cloud
- Feature: behaviours
- Tags: customise, issue, fields
- Language: typescript
- Doc ID: example-cloud-dynamically-hide-or-show-a-field-cloud
- Source: https://examples.scriptrunner.io/scripts/dynamically-hide-or-show-a-field-cloud

## Overview

In this example, when the Department field is selected and the Finance option is chosen, the line manager field is hidden, and the ticket category field is shown.
When the HR option is selected, the ticket category field is hidden, and the line manager field is shown. 
When the Product option is selected both fields are hidden.

## Example

Show different sets of field options to different departments.

## Good to Know

This example will work on the Create View only inside of Jira Cloud.

## Script

```typescript
const departmentField = getFieldById('customfield_10035');
const ticketCategoryField = getFieldById('customfield_10037');
const lineManagerField = getFieldById('customfield_10036');
const changedField = getChangeField();

switch (changedField.getName()) {
    case 'Department':
        switch (changedField.getValue().value) {
            case 'Finance':
                lineManagerField.setVisible(false);
                ticketCategoryField.setVisible(true);
                break;
            case 'HR':
                ticketCategoryField.setVisible(false);
                lineManagerField.setVisible(true);
                break;
            case 'Product':
                ticketCategoryField.setVisible(false);
                lineManagerField.setVisible(false);
                break;
        }
        break;
}
```

