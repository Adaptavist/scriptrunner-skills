# Limit work item types based on user group

- Platform: cloud
- Feature: behaviours
- Tags: automate, issue
- Language: typescript
- Doc ID: example-cloud-Limit-issue-types-based-on-groups-cloud
- Source: https://examples.scriptrunner.io/scripts/Limit-issue-types-based-on-groups-cloud

## Overview

This script will limit the users ability to create work to a specific subset of work item types, if they belong to a certain group.

## Example

Show only the Story and Task work item types to users in the *Developers* group.

## Good to Know

You will need to replace the ID's of *10001* and *10004* in this script with the ID's of the work item types in your instance. 

This example will work on the Create View in Jira Cloud only.

## Script

```typescript
 // Note: You should run this script by selecting "On load" in the check box above.

 const workItemTypeField = getFieldById("issuetype")

const user = await makeRequest("/rest/api/2/myself");
const { accountId } = user.body;
const userGroups= await makeRequest("/rest/api/2/user/groups?accountId=" + accountId);
const groupNames = userGroups.body.map(({ name }) => name);

 // Select the group that the specific work item types will be shown for.
const group = "Developer";

if (groupNames.includes(group)) {
    workItemTypeField.setOptionsVisibility(["10001", "10004"], true)
}
```

