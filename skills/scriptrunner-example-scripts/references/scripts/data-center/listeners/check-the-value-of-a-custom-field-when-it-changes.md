# Check the Value of a Custom Field when it Changes

- Platform: data-center
- Feature: listeners
- Tags: none
- Language: groovy
- Doc ID: example-dataCenter-check-custom-field-with-listener-onPrem
- Source: https://examples.scriptrunner.io/scripts/check-custom-field-with-listener-onPrem

## Overview

We can use this script to detect whether a custom field has been updated in a change to an issue. 
We can then execute additional code depending on the new value for the custom field.

## Example

As a Jira administrator, I want to send an email when a custom field has a particular value.
We have a custom field that indicates whether a customer has escalated an issue. If they have, then we send an email to the project manager to highlight this issue's updated priority status.
This script automates that process by checking to see if the custom field has changed each time an issue is updated. If the custom field has changed, it checks whether the new value indicates that the issue has been escalated. If the issue has been escalated, an email is sent to a specified mailbox.

## Description

#### Overview
We can use this script to detect whether a custom field has been updated in a change to an issue. 
We can then execute additional code depending on the new value for the custom field.

#### Example
As a Jira administrator, I want to send an email when a custom field has a particular value.
We have a custom field that indicates whether a customer has escalated an issue. If they have, then we send an email to the project manager to highlight this issue's updated priority status.
This script automates that process by checking to see if the custom field has changed each time an issue is updated. If the custom field has changed, it checks whether the new value indicates that the issue has been escalated. If the issue has been escalated, an email is sent to a specified mailbox.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor

//Define the current Issue and the desired Custom Field Name
def issue = event.issue
def customFieldName = '<CUSTOM_FIELD_NAME>'

//Define Change History Manager and retrieve the last updated item for this issue
def changeHistoryManager = ComponentAccessor.changeHistoryManager
def lastChangedItem = changeHistoryManager.getAllChangeItems(issue).last() as String

//Then check if the latest update to the Issue had a change to this Custom Field
if (lastChangedItem.contains(customFieldName)) {
    //Add code to be executed if this condition is met

    //For example, if the Custom Field is a certain value
    def customFieldManager = ComponentAccessor.customFieldManager
    def customFieldObject = customFieldManager.getCustomFieldObjectsByName(customFieldName).first()
    def customFieldValue = issue.getCustomFieldValue(customFieldObject) as String

    if (customFieldValue == '<DESIRED_VALUE>') {
        //Execute further code, for example, send a log message
        log.warn("The Custom Field $customFieldName has a value of $customFieldValue")
    }
}
```

