# Hide/Show relevant fields based on IT Request Type for JSM

- Platform: cloud
- Feature: behaviours
- Tags: automate, fields
- Language: typescript
- Doc ID: example-cloud-show-hide-fields-based-on-request-type-cloud
- Source: https://examples.scriptrunner.io/scripts/show-hide-fields-based-on-request-type-cloud

## Overview

This script retrieves the current Jira Service Management request type via the API and uses it to show or hide relevant fields on the portal form.
It also marks those fields as required and auto-populates the Summary with the current user's name and the selected field values.

## Example

Show relevant fields and auto-fill the summary based on the selected IT request type.

## Good to Know

* This script gets the request type from the Jira Service Management API, not from a custom field.
* Ensure the fields on which you want to apply this script are present on the screen.
* Replace the custom field IDs in the script with the ones from your Jira instance.
* If your logic depends on request type names, updating those names in Jira will require updating the script as well.

## Script

```typescript
// Get IT Request Type
const context = await getContext()
const serviceDeskId = context.extension.portal.id
const reqTypeId = context.extension.request.typeId

const response = await makeRequest(`/rest/servicedeskapi/servicedesk/${serviceDeskId}/requesttype/${reqTypeId}`);

if (!response || response.status !== 200 || !response.body?.name) {
    logger.error(`Failed to retrieve request type. Status: ${response?.status}, Body: ${JSON.stringify(response?.body)}`);
}

const itRequestTypeValue = response.body.name

// Fields to hide, show or mark as required (fill in with your own custom fields)
const affectedHardware = getFieldById("customfield_10083");
const requestedNewSoftwareSingleSelect = getFieldById("customfield_10157");
const systemsToAccessSingleSelect = getFieldById("customfield_10158");

const isNewSoftwareRequest = itRequestTypeValue === 'Request new software';
const isHardwareRequest = itRequestTypeValue === 'Report broken hardware';
const isAccessRequest = itRequestTypeValue === 'Request admin access';

logger.info(itRequestTypeValue + ' selected, filtering relevant fields');

requestedNewSoftwareSingleSelect.setVisible(isNewSoftwareRequest);
requestedNewSoftwareSingleSelect.setRequired(isNewSoftwareRequest);

affectedHardware.setVisible(isHardwareRequest);
affectedHardware.setRequired(isHardwareRequest);

systemsToAccessSingleSelect.setVisible(isAccessRequest);
systemsToAccessSingleSelect.setRequired(isAccessRequest);

//Auto-populate the summary
const summary = getFieldById("summary");
const user = await makeRequest("/rest/api/2/myself");
const { displayName } = user.body;

if (isNewSoftwareRequest && requestedNewSoftwareSingleSelect.getValue()) {
    summary.setValue("New software request from " + displayName + " for " + requestedNewSoftwareSingleSelect.getValue().value);
    summary.setReadOnly(true)
} else if (isHardwareRequest && affectedHardware.getValue()) {
    summary.setValue("Hardware issue reported by " + displayName + " for " + affectedHardware.getValue());
    summary.setReadOnly(true)
} else if (isAccessRequest && systemsToAccessSingleSelect.getValue()) {
    summary.setValue("Software access requested by " + displayName + " for " + systemsToAccessSingleSelect.getValue().value);
    summary.setReadOnly(true)
} else {
    summary.setReadOnly(false)
}
```

