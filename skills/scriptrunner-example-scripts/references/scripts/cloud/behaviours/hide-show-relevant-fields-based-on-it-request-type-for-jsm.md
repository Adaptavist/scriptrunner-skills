# Hide/Show relevant fields based on IT Request Type for JSM

- Platform: cloud
- Feature: behaviours
- Tags: automate, fields
- Language: typescript
- Doc ID: example-cloud-show-hide-fields-based-on-request-type-cloud
- Source: https://examples.scriptrunner.io/scripts/show-hide-fields-based-on-request-type-cloud

## Overview

This script reads the Request Type field on a Jira Service Management portal and shows or hides relevant fields depending on the selected option.
It also marks those fields as required and auto-populates the Summary with the current user's name and the selected values.

## Example

Show relevant fields and auto-fill the summary based on the selected IT request type.

## Good to Know

* Ensure the fields on which you want to apply this script are present on the screen.
* Replace the custom field IDs in the script with the ones from your Jira instance.

## Script

```typescript
// Get IT Request Type
const itRequestType = getFieldById("customfield_12732");
const itRequestTypeValue = itRequestType.getValue().value;

// Fields to hide, show or mark as required
const newSoftwareNameVersion = getFieldById("customfield_12733");
const hardwareProblemDescription = getFieldById("customfield_12734");
const requestedNewSoftwareMultiSelect = getFieldById("customfield_12735");
const systemsToAccessMultiSelect = getFieldById("customfield_12736");

const isNewSoftwareRequest = itRequestTypeValue === 'New Software';
const isHardwareRequest = itRequestTypeValue === 'Hardware Issue';
const isAccessRequest = itRequestTypeValue === 'Access Request';

logger.info(itRequestType + ' selected, filtering relevant fields');

newSoftwareNameVersion.setVisible(isNewSoftwareRequest);
newSoftwareNameVersion.setRequired(isNewSoftwareRequest);
requestedNewSoftwareMultiSelect.setVisible(isNewSoftwareRequest);
requestedNewSoftwareMultiSelect.setRequired(isNewSoftwareRequest);

hardwareProblemDescription.setVisible(isHardwareRequest);
hardwareProblemDescription.setRequired(isHardwareRequest);
systemsToAccessMultiSelect.setVisible(isAccessRequest);
systemsToAccessMultiSelect.setRequired(isAccessRequest);

//Auto-populate the summary
const summary = getFieldById("summary");
const user = await makeRequest("/rest/api/2/myself");
const { displayName } = user.body;

if (isNewSoftwareRequest && newSoftwareNameVersion.getValue()) {
    summary.setValue("New software request from " + displayName + " for " + newSoftwareNameVersion.getValue());
    summary.setReadOnly(true)
} else if (isHardwareRequest && hardwareProblemDescription.getValue()) {
    summary.setValue("Hardware issue reported by " + displayName + " for " + hardwareProblemDescription.getValue());
    summary.setReadOnly(true)
} else if (isAccessRequest && systemsToAccessMultiSelect.getValue().length > 0) {
    summary.setValue("Software access requested by " + displayName + " for " + systemsToAccessMultiSelect.getValue().map(i => i.value).join(","));
    summary.setReadOnly(true)
} else {
    summary.setReadOnly(false)
    summary.setValue("")
}
```

