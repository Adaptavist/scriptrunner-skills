# Restrict the number of attachments that can be added to an issue

- Platform: data-center
- Feature: validators
- Tags: issue
- Language: groovy
- Doc ID: example-dataCenter-restrict-the-number-of-attachments-in-an-issue-onPrem
- Source: https://examples.scriptrunner.io/scripts/restrict-the-number-of-attachments-in-an-issue-onPrem

## Overview

This validator script can be used to set a fixed limit to the number of attachments permitted to an issue. 
Exceeding the limit will return a validation error message and the issue will not be able to transition.

## Example

I am a Jira admin and have used this script to limit the number of attachments that can be added to an issue.

## Description

#### Overview
 
This validator script can be used to set a fixed limit to the number of attachments permitted to an issue. 
Exceeding the limit will return a validation error message and the issue will not be able to transition.

#### Example

I am a Jira admin and have used this script to limit the number of attachments that can be added to an issue.

## Script

```groovy
import com.atlassian.jira.issue.fields.AttachmentSystemField
import webwork.action.ActionContext

def attachmentFiles = ActionContext.request?.getParameterValues(AttachmentSystemField.FILETOCONVERT)

!(attachmentFiles && attachmentFiles.size() > 5)
```

