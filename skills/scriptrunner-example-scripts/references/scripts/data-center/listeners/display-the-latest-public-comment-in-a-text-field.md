# Display the Latest Public Comment in a Text Field

- Platform: data-center
- Feature: listeners
- Tags: issue, fields
- Language: groovy
- Doc ID: example-dataCenter-display-latest-public-comment-in-text-field-onPrem
- Source: https://examples.scriptrunner.io/scripts/display-latest-public-comment-in-text-field-onPrem

## Overview

This script copies the latest public comment from a Service Desk issue and displays it in a Text Field.

## Example

As a Service Desk Project Admin, I would like to get only the latest public comment in the issues displayed in a text field.
In this script, when a comment is added to the issue, if it is a public comment, the script will copy it and update the text field with it.

## Description

#### Overview
This script copies the latest public comment from a Service Desk issue and displays it in a Text Field.
                                
#### Example
As a Service Desk Project Admin, I would like to get only the latest public comment in the issues displayed in a text field.
In this script, when a comment is added to the issue, if it is a public comment, the script will copy it and update the text field with it.

## Script

```groovy
import com.atlassian.jira.bc.issue.comment.property.CommentPropertyService
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.event.issue.IssueEvent
import com.atlassian.jira.event.type.EventDispatchOption
import com.atlassian.jira.issue.MutableIssue
import com.atlassian.jira.issue.comments.Comment
import groovy.json.JsonSlurper

final SD_PUBLIC_COMMENT = 'sd.public.comment'
final textFieldName = '<TEXT_FIELD_NAME>'

def issue = event.issue as MutableIssue
def issueEvent = event as IssueEvent
def user = issueEvent.user
def comment = issueEvent.comment

def customFieldManager = ComponentAccessor.customFieldManager
def issueManager = ComponentAccessor.issueManager
def commentPropertyService = ComponentAccessor.getComponent(CommentPropertyService)

def sampleMultiLine = customFieldManager.getCustomFieldObjectsByName(textFieldName).first()

def isInternal = { Comment cmt ->
    def commentProperty = commentPropertyService.getProperty(user, cmt.id, SD_PUBLIC_COMMENT).entityProperty.orNull

    if (commentProperty) {
        def props = new JsonSlurper().parseText(commentProperty.value) as Map
        props['internal'].toString().toBoolean()
    }
    else {
        null
    }
}

if (comment && !isInternal(comment)) {
    issue.setCustomFieldValue(sampleMultiLine, comment.body)
    issueManager.updateIssue(user, issue, EventDispatchOption.DO_NOT_DISPATCH, false)
}
```

