# Update the Approvers According to the Users Selected from the Insight Object

- Platform: data-center
- Feature: post-functions
- Tags: workflow, issue, fields
- Language: groovy
- Doc ID: example-dataCenter-update-approvers-according-to-users-selected-from-insight-picker-onPrem
- Source: https://examples.scriptrunner.io/scripts/update-approvers-according-to-users-selected-from-insight-picker-onPrem

## Overview

When the values from the Insight object field are to be set for the Approvers field, the post-function is used to first 
extract the values from the Insight object field, filter them and then pass it to the Approver field.

## Example

As a Project Manager, I use Insight a lot in my Service Desk projects. When the issues in my projects transition, 
I would like to automatically set the approvers to the users selected in the Insight Objects field. 
This script helps me to do so.

## Good to Know

* Prior to running this script, you will need to ensure that the Insight object field has been configured correctly. Please
  refer to this [Atlassian Documentation](https://confluence.atlassian.com/servicemanagementserver0416/adding-insight-custom-fields-to-screens-in-jira-1062242135.html)
  for more information.

* Please note, that if the user that has been selected from the Insight object field doesn't exist in Jira, that user will not be added to the Approver list.

* Also, if you are using Jira Service Management 5.0 and above, the Insight field will not be known as Insight object, but Assets object.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.event.type.EventDispatchOption

//Set name for the Insight Objects field that is being used.
final def INSIGHT_FIELD = '<INSIGHT_FIELD_NAME>'
final def APPROVERS = 'Approvers'

def customFieldManager = ComponentAccessor.customFieldManager
def issueManager = ComponentAccessor.issueManager
def loggedInUser = ComponentAccessor.jiraAuthenticationContext.loggedInUser
def userSearchService = ComponentAccessor.userSearchService

def insightField = customFieldManager.getCustomFieldObjectsByName(INSIGHT_FIELD).first()
def insightFieldValue = issue.getCustomFieldValue(insightField) as List

def approvers = customFieldManager.getCustomFieldObjectsByName(APPROVERS).first()

/*
In the insightFieldValue variable, the user's full name and the Insight object's key are stored, for example, Max Peterson (SI-2).
To check if the user selected from the Insight objects field exists in Jira, the user's full name is used to perform the search.
In order for the search to work, the key from the Insight object field value needs to be truncated starting from the opening
braces character, i.e. the ( character and any empty space from the name needs to be trimmed
 */
def approverList = insightFieldValue.collectMany(({
    def value = it.toString()
    def insightUsers = value[0..value.indexOf('(') - 1].trim()
    userSearchService.findUsersByFullName(insightUsers)
} as Closure<? extends Collection<?>>))

issue.setCustomFieldValue(approvers, approverList)
issueManager.updateIssue(loggedInUser, issue, EventDispatchOption.DO_NOT_DISPATCH, false)
```

