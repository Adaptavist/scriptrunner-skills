# Bulk Update the Value of a Custom Field on Jira Cloud Work Items

- Platform: cloud
- Feature: script-console
- Tags: issue, hapi, automate, fields
- Language: groovy
- Doc ID: example-cloud-update-cf-values-all-issues-cloud-cloud
- Source: https://examples.scriptrunner.io/scripts/update-cf-values-all-issues-cloud-cloud

## Overview

Use this script in the *Script Console* to update the value of a custom text field for all work items returned by a query.

## Example

I have a space with many work items. I need to change the custom field value for all the work items in this space. 
With this script, I can easily bulk change all of these work items automatically.

## Good to Know

-  Run as an admin user or as "ScriptRunner Add-On User" to make sure permissions to update are granted.

## Script

```groovy
// Specify all the required parameters
def spaceKey = 'TEST'
def customFieldName = 'Story Points'
def newCustomFieldValue = 100

// Extract work item key using JQL Query
WorkItems.search("project = $spaceKey and '${customFieldName}' is not EMPTY").each { workItem ->
    workItem.update  {
        setCustomFieldValue(customFieldName, newCustomFieldValue)
    }
}
```

