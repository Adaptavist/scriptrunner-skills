# Restrict field option based on group for JSM

- Platform: cloud
- Feature: behaviours
- Tags: automate, fields, user
- Language: typescript
- Doc ID: example-cloud-restrict-field-option-based-on-group-cloud
- Source: https://examples.scriptrunner.io/scripts/restrict-field-option-based-on-group-cloud

## Overview

This script checks if the current user is a member of a specific group. If they are not, a field option is hidden from view, making it only available to members of that group.

## Example

Show an additional Impact field option exclusively to users in the team-leads group.

## Good to Know

* Ensure the fields on which you want to apply this script are present on the screen.
* The user must be added to the user group.

## Script

```typescript
// Define the group
const allowedGroup = "team-leads";

// Get the impact field
const impactField = getFieldById("customfield_10004"); 

// Get current user and their groups
const user = await makeRequest("/rest/api/2/myself");

if (user) {
    const { accountId } = user.body;
    const userGroups = await makeRequest("/rest/api/2/user/groups?accountId=" + accountId);

    if (userGroups) {
        const groupNames = userGroups.body.map(({ name }) => name);

        if (!groupNames.includes(allowedGroup)) {
            const optionId = "10144" // Replace with actual option

            impactField.setOptionsVisibility([optionId], false);
        }
    }
}
```

