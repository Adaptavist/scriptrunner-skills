# Set the Users in a Multi-user Picker when the Issue Transitions

- Platform: data-center
- Feature: post-functions
- Tags: workflow
- Language: groovy
- Doc ID: example-dataCenter-set-the-users-for-the-multi-user-picker-onPrem
- Source: https://examples.scriptrunner.io/scripts/set-the-users-for-the-multi-user-picker-onPrem

## Overview

This script automatically sets the users for a multi-user picker when the issue transitions to a particular status.

## Example

I am a project administrator, and I have a multi-user picker field within my Jira issues that allows me to tag my 
colleague(s) when the status of an issue changes. I can use this script to limit the users displayed by the multi-user picker. 
This makes it easier for me to find the people I want to tag in the issue and helps ensure that the wrong people are not 
tagged in any issues.

## Description

#### Overview
This script automatically sets the users for a multi-user picker when the issue transitions to a particular status.
                              
#### Example
I am a project administrator, and I have a multi-user picker field within my Jira issues that allows me to tag my 
colleague(s) when the status of an issue changes. I can use this script to limit the users displayed by the multi-user picker. 
This makes it easier for me to find the people I want to tag in the issue and helps ensure that the wrong people are not 
tagged in any issues.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.event.type.EventDispatchOption
import com.atlassian.jira.user.ApplicationUser

final def user1 = '<USERNAME_1>'
final def user2 = '<USERNAME_2>'
final def user3 = '<USERNAME_2>'
final def fieldName = '<MULTI_USER_PICKER_FIELD_NAME>'

def customFieldManager = ComponentAccessor.customFieldManager
def issueManager = ComponentAccessor.issueManager
def loggedInUser = ComponentAccessor.jiraAuthenticationContext.loggedInUser
def userManager = ComponentAccessor.userManager

def multiUserPicker = customFieldManager.getCustomFieldObjectsByName(fieldName).first()

def selectedUsers = [userManager.getUserByName(user1) , userManager.getUserByName(user2) , userManager.getUserByName(user3)] as List<ApplicationUser>

issue.setCustomFieldValue(multiUserPicker, selectedUsers)
issueManager.updateIssue(loggedInUser, issue, EventDispatchOption.DO_NOT_DISPATCH, false)
```

