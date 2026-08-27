# Prefill fields with user info and dates for JSM

- Platform: cloud
- Feature: behaviours
- Tags: automate, fields, user
- Language: typescript
- Doc ID: example-cloud-prefill-fields-with-user-info-and-dates-cloud
- Source: https://examples.scriptrunner.io/scripts/prefill-fields-with-user-info-and-dates-cloud

## Overview

This script reads the Employee Name and Start Date fields and uses their values to automatically populate the Summary and Description fields.

## Example

Pre-fill the Summary with the employee name and start date, and populate the Description with the same details.

## Good to Know

* Ensure the fields on which you want to apply this script are present on the screen.
* Replace the custom field IDs in the script with the ones from your Jira instance.

## Script

```typescript
// Replace with your actual custom field IDs
const employeeNameField = getFieldById("customfield_11546");
const startDateField = getFieldById("customfield_10015");
const summaryField = getFieldById("summary");
const descriptionField = getFieldById("description");

const employeeName = employeeNameField.getValue();
const startDate = startDateField.getValue();

// Only update when both fields have values
if (employeeName && startDate) {
    summaryField.setValue(`${employeeName} will be joining the company on ${startDate}`);
    descriptionField.setValue({
        "version": 1,
        "type": "doc",
        "content": [
            {
                "type": "paragraph",
                "content": [{ "type": "text", "text": `Employee: ${employeeName}` }]
            },
            {
                "type": "paragraph",
                "content": [{ "type": "text", "text": `Start date: ${startDate}` }]
            }
        ]
    });
}
```

