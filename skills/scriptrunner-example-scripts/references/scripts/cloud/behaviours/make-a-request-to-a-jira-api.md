# Make a request to a Jira API

- Platform: cloud
- Feature: behaviours
- Tags: customise, issue, fields, user
- Language: typescript
- Doc ID: example-cloud-search-for-a-user-and-assign-that-user-to-the-issue-cloud
- Source: https://examples.scriptrunner.io/scripts/search-for-a-user-and-assign-that-user-to-the-issue-cloud

## Overview

This example shows how you can call a Jira API to search for a user and assign the work item to that user.

## Example

Need to assign design tickets to the UX designer but we don't have their account ID in Jira Cloud and need to look this up based on their name.

## Good to Know

This example will work on the Create view and the Issue View inside of Jira Cloud.

## Script

```typescript
const assigneeName = 'Demo User';

const res = await makeRequest(`/rest/api/3/user/search?query=${assigneeName}`);

const assigneeAccountId = res.body[0].accountId;
getFieldById("assignee").setValue(assigneeAccountId);
// Assign the user to the work item
```

