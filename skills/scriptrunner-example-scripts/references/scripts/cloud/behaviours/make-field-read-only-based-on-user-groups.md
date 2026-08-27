# Make field read-only based on user groups

- Platform: cloud
- Feature: behaviours
- Tags: automate, issue
- Language: typescript
- Doc ID: example-cloud-Make-field-read-only-based-on-user-groups-cloud
- Source: https://examples.scriptrunner.io/scripts/Make-field-read-only-based-on-user-groups-cloud

## Overview

This script shows how you can get the user groups that the current logged in user is a member of and to make fields read-only if the user is a member of a specific group.

## Example

As a product manager I want to make fields read only to users in the Example Group but allow them to be editable to other users.

## Good to Know

* This script should be run when screen first loads. Do this by selecting "On load" in the "Run the script" check box.
* Replace the field variable names and ids appropriately. They can be found by accessing https://YOUR\_ATLASSIAN\_INSTANCE/rest/api/3/field.
* This script works on both the *Create* view and *Issue* views inside of Jira Cloud. 
* This script is [part](https://youtu.be/7PLWGYH_erU) of the behaviours demo [here](https://youtube.com/playlist?list=PLnsCytbU4bI6SwVAp1DJlzua9vk1oLQ-G).

## Script

```typescript
const ticketDepartment = getFieldById("customfield 10205")
const userRegion = getFieldById("customfield 10206")
const ticketCat = getFieldById("customfield 10207")
const priority = getFieldById("priority")

const group = "Example Group";

const user = await makeRequest("/rest/api/2/myself");
if (user) {
    const { accountId } = user.body;
    const userGroups = await makeRequest ("/rest/api/2/user/groups?accountId=" + accountId);
    if (userGroups) {
        const groupNames = userGroups.body.map(({ name }) => name);
        if (groupNames.includes(group)) {
            ticketDepartment.setVisible(false)
            userRegion.setVisible(false)
            ticketCat.setVisible(false)

            priority.setReadOnly(true)
        }
    }
}
```

