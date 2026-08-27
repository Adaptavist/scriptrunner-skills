# Make Fields Editable to only users in a certain role

- Platform: cloud
- Feature: behaviours
- Tags: automate, issue
- Language: typescript
- Doc ID: example-cloud-Restrict-Field-Actions-To-Certain-Roles-cloud
- Source: https://examples.scriptrunner.io/scripts/Restrict-Field-Actions-To-Certain-Roles-cloud

## Overview

This script shows how you can get all the space roles that the current logged in user is a member of and to make them editable to that role and read only for other roles.

## Example

As a product manager I want to make fields read only to users in the *Administrators* role but allow them to be editable to users in the *Developers* role.

## Good to Know

* This script works on both the *Create* view and *Issue* views inside of Jira Cloud.

## Script

```typescript
// Fields to be updated
const summaryField = getFieldById("summary");
const descriptionField = getFieldById("description")

// Get the spaceId out of the context
const context = await getContext();
const spaceId = context.extension.project.id

// Return all space roles the current user belongs to
const getSpaceRolesForCurrentUser = await makeRequest(`/rest/api/3/project/${ spaceId }/roledetails?currentMember=true`);

// Get the name of each space role the user belongs to
const roleNames = getSpaceRolesForCurrentUser.body.map(item => item.name);

// Switch on each role and update fields if conditions met
switch (true) {
    case roleNames.includes("Developers"):
        summaryField.setName("Ticket Summary");
        descriptionField.setName("Ticket Description");
        break;
    case roleNames.includes("Administrators"):
        summaryField.setReadOnly(true)
        descriptionField.setReadOnly(true);
        break;
    default:
        logger.info("No roles were matched. No actions were performed.");
}
```

