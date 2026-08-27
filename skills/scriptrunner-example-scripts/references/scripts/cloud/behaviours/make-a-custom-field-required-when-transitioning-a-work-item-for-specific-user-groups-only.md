# Make a custom field required when transitioning a work item for specific user groups only

- Platform: cloud
- Feature: behaviours
- Tags: automate, issue
- Language: typescript
- Doc ID: example-cloud-make-fields-required-on-transition-for-user-groups-cloud
- Source: https://examples.scriptrunner.io/scripts/make-fields-required-on-transition-for-user-groups-cloud

## Overview

Makes the release notes field required based on user group and workflow transition

## Example

I want the Release Notes field to be required for users in the team-leads user group only when work items are moved from In-Progress to Done.

## Good to Know

* Ensure the fields on which you want to apply this script are present on the screen.
* The user must be added the user group in the User Management settings in Jira Cloud

## Script

```typescript
// Asynchronously retrieve the transition ID from the current work item context
const transitionId = await getContext().then(context => context.extension.issueTransition.id);

// Check if the transition is from "In-Progress" to "Done" by comparing the transition ID
if (transitionId == 51) {
    // Access the Release Notes field using its custom field ID. Replace this with your own custom field Id.
    const releaseNotesField = getFieldById("customfield_10041");

    // Retrieve the current user's account details
    const user = await makeRequest("/rest/api/2/myself?expand=applicationRoles");
    const { accountId } = user.body;

    // Fetch the groups that the current user belongs to
    const userGroups = await makeRequest("/rest/api/2/user/groups?accountId=" + accountId);
    const groupNames = userGroups.body.map(({ name }) => name);

    // Define the group name that is allowed to interact with the Release Notes field. Replace this with your own user group name.
    const allowedGroup = "team-leads";

    // Decide whether the Release Notes field should be visible and required based on user membership
    const shouldShow = groupNames.includes(allowedGroup);

    // Adjust the visibility of the Release Notes field
    releaseNotesField.setVisible(shouldShow);

    // Set the Release Notes field as required or optional
    releaseNotesField.setRequired(shouldShow);
}
```

