# Calculate Custom Field on Work Item Update

- Platform: cloud
- Feature: listeners
- Tags: automate, issue, hapi
- Language: groovy
- Doc ID: example-cloud-calculate-custom-field-on-issue-update-cloud
- Source: https://examples.scriptrunner.io/scripts/calculate-custom-field-on-issue-update-cloud

## Overview

Using the `IssueUpdated` event, the sum of multiple fields can be calculated when a work item is updated.

## Example

My space has three custom fields: Cost, Shipping Cost, and Total Cost. These fields are available for all work item types.
When a work item or sub-task is created, I can define the values of the *Cost* and **Shipping Cost** fields, however, the
**Total Cost** field is not automatically calculated as calculated custom fields are not available in Jira Cloud.
Using this script I can trigger a calculation when the work item is updated, allowing me to sum the **Cost** and **Shipping
Cost** the **Total Cost** field.

## Good to Know

* The code is designed to be used with the `Issue Updated` event.
* If using the add-on user to run the script, it is possible to set the `overrideScreenSecurity` property to modify
fields that are not on the current screen.

## Script

```groovy
def eventWorkItem = WorkItems.getByKey(issue.key as String)

final spaceKey = 'TEST'

if (eventWorkItem.projectObject.key != spaceKey) {
    logger.info("Wrong Space ${eventWorkItem.projectObject.key}")
    return
}

//get the value of each of the custom fields or use 0 as default if a value isn't set yet
def input1 = eventWorkItem.getCustomFieldValue("Custom Field 1") as Integer ?: 0
def input2 = eventWorkItem.getCustomFieldValue("Custom Field 2") as Integer ?: 0

def output = input1 + input2

//do not attempt to update the result if it is the same as the existing one.
if(eventWorkItem.getCustomFieldValue("Output Custom Field") == output) {
    logger.info("The reulst was the same as the existing one, no update needed.")
} else {
    eventWorkItem.update {
        setCustomFieldValue("Output Custom Field", output)
    }
    logger.info("Output Custom Field updated to ${output}")
}
```

