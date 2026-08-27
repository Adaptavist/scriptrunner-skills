# Change the visibility of the priority field

- Platform: cloud
- Feature: behaviours
- Tags: automate, issue
- Language: typescript
- Doc ID: example-cloud-Show-Priority-To-Users-In-Specific-Group-cloud
- Source: https://examples.scriptrunner.io/scripts/Show-Priority-To-Users-In-Specific-Group-cloud

## Overview

This example shows how you make the priority field visible to users in a certain group.

## Example

Need to make the priority field visible to users in a certain group.

## Good to Know

This example will work on the *Create View* and *Issue View* in Jira Cloud and should be configured to run on the *On Load* event.

## Script

```typescript
const user = await makeRequest("/rest/api/2/myself");

const { accountId } = user.body;

const getUserGroups = await makeRequest(`/rest/api/2/user/groups?accountId=${accountId}`);

const groupNames = getUserGroups.body.map(({ name }) => name);

// Select group for priority field to be displayed
 const group = "administrators";

if (!groupNames.includes(group)) {
  getFieldById("priority").setVisible(false);
}
```

