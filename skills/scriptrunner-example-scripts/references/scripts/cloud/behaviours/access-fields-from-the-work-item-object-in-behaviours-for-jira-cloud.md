# Access fields from the work item object in Behaviours for Jira Cloud

- Platform: cloud
- Feature: behaviours
- Tags: issue
- Language: typescript
- Doc ID: example-cloud-access-issue-fields-cloud
- Source: https://examples.scriptrunner.io/scripts/access-issue-fields-cloud

## Overview

Need to access field values on the work item object in your behaviours script then you can do this by making a request to the Jira Rest API to return the current work item.

## Example

Check if a work item is in a current status on the work item and perform some actions if the work item is in a certain status.

## Good to Know

* You can can access any field on the work item inside the *issue.body.fields* property 

* Note this will not work on the *Create View* and will only work on views where the work item has been created.

## Script

```typescript
// Access the context for the UI Modification
const context = await getContext()

// Get the current work item key
const workItemKey = context.extension.issue.key;

// Get the current work item object 
const workItem = await makeRequest("/rest/api/2/issue/" + workItemKey);

// Log out to the browser some field values to show how to get them from the work item.  
// Note you can access any field on a work item through the fields property

console.log("Work item Field Values:")
console.log("Status field: ", workItem.body.fields.status)
console.log("Assignee field: ", workItem.body.fields.assignee)
```

