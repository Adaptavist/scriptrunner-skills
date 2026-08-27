# Make a custom field read-only when the work item is in a particular workflow step

- Platform: cloud
- Feature: behaviours
- Tags: automate, issue
- Language: typescript
- Doc ID: example-cloud-make-fields-readonly-by-workflow-step-cloud
- Source: https://examples.scriptrunner.io/scripts/make-fields-readonly-by-workflow-step-cloud

## Overview

This script makes a custom field read-only (and un-editable) when the work item is in a particular step in the workflow.

## Example

I want to make a field called Business Justification read-only after the work item has been approved.

## Good to Know

Ensure the fields on which you want to apply this script are present on the screen.

## Script

```typescript
// Retrieve the current context and work item key
const context = await getContext();
const workItemKey = context.extension.issue.key;

// Access the business justification field. Replace this with your own custom field Id.
const businessJustification = getFieldById("customfield_10050");

// Attempt to fetch the current work item data
try {
    const res = await makeRequest(`/rest/api/3/issue/${workItemKey}`);
    const currentStatus = res.body.fields.status.name;

    // Determine if the business justification field should be read-only
    const restrictBusinessJustificationEditing = currentStatus === "Approved";

    // Set the field to read-only based on the status
    businessJustification.setReadOnly(restrictBusinessJustificationEditing);
} catch (error) {
    // Log any errors encountered during the request
    logger.error(`Failed to retrieve work item data for ${workItemKey}: ${error}`);
}
```

