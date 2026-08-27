# Show or hide fields conditionally based on the selection in another field

- Platform: cloud
- Feature: behaviours
- Tags: automate, issue
- Language: typescript
- Doc ID: example-cloud-show-hide-based-select-item-cloud
- Source: https://examples.scriptrunner.io/scripts/show-hide-based-select-item-cloud

## Overview

With this script, when a selection is made on a select field. It will show or hide another field based on the selection made.

## Example

I want to show or hide a field based on the selection made in another field.

## Good to Know

Ensure the fields on which you want to apply this script are present on the screen.

## Script

```typescript
// Retrieve the 'Opportunity' drop-down field and other relevant fields
const opportunityField = getFieldById("customfield_10057");  // Replace with your actual custom field ID
const contractValueField = getFieldById("customfield_10061"); // Field for 'Contract value'
const lossReasonField = getFieldById("customfield_10060");    // Field for 'Loss reason'

// Get the current selected value from the 'Opportunity' field
const opportunityValue = opportunityField.getValue()?.value;

// Control visibility based on the selected value
if (opportunityValue === 'Won') {
    // If 'Won' is selected, show the 'Contract value' field and hide 'Loss reason'
    contractValueField.setVisible(true);
    lossReasonField.setVisible(false);
} else if (opportunityValue === 'Lost') {
    // If 'Lost' is selected, show the 'Loss reason' field and hide 'Contract value'
    contractValueField.setVisible(false);
    lossReasonField.setVisible(true);
} else {
    // If neither 'Won' nor 'Lost' is selected, hide both fields
    contractValueField.setVisible(false);
    lossReasonField.setVisible(false);
}
```

