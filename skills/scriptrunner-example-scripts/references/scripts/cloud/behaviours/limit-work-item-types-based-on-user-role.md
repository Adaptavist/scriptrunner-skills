# Limit work item types based on user role

- Platform: cloud
- Feature: behaviours
- Tags: automate, issue
- Language: typescript
- Doc ID: example-cloud-Limit-issue-types-based-on-roles-cloud
- Source: https://examples.scriptrunner.io/scripts/Limit-issue-types-based-on-roles-cloud

## Overview

This script will limit the users ability to create work to a specific subset of work item types, if they belong to a certain group.

## Example

Show only the Story and Task work item types to users in the *Developers* group.

## Good to Know

You will need to replace the IDs *10133* and *10134* in this script with the IDs of the work item types in your instance. 

This example will work on the Create View in Jira Cloud only.

## Script

```typescript
 // Note: You should run this script by selecting "On load" in the check box above.

 const context = await getContext();
 const spaceId = context.extension.project.id;

 const spaceRoles = await makeRequest(`/rest/api/3/project/${ spaceId }/roledetails?currentMember=true`);
 const spaceRoleNames = spaceRoles.body.map(role => role.name);

 const workItemTypeField = getFieldById("issuetype");
 const allowedWorkItemTypeIds = ['10133', '10134']; // IDs for Story and Task

 if (spaceRoleNames.includes('Developers')) {
     workItemTypeField.setOptionsVisibility(allowedWorkItemTypeIds, true);

     if (!allowedWorkItemTypeIds.includes(workItemTypeField.getValue()?.id)) {
         workItemTypeField.setValue("10133"); // Default to Story if the current value is not allowed
     }
 }
```

