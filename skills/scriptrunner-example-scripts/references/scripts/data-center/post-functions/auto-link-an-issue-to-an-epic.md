# Auto Link an Issue to an Epic

- Platform: data-center
- Feature: post-functions
- Tags: workflow, hapi
- Language: groovy
- Doc ID: example-dataCenter-auto-link-an-issue-to-an-epic-onPrem
- Source: https://examples.scriptrunner.io/scripts/auto-link-an-issue-to-an-epic-onPrem

## Overview

A Post-Function to automatically link an issue type (for example a Task) to a specific Epic when the issue is being created.
This will take effect only if the Epic Link field in that issue is left blank.

## Example

In the sample code below, an issue type is automatically linked to an Epic if the Epic Link is not added when the issue is being created.

## Description

#### Overview

A Post-Function to automatically link an issue type (for example a Task) to a specific Epic when the issue is being created.
This will take effect only if the Epic Link field in that issue is left blank.

#### Example

In the sample code below, an issue type is automatically linked to an Epic if the Epic Link is not added when the issue is being created.

## Script

```groovy
//This requires name of the Issue Type that is to be linked to the Epic
final def issueTypeName = 'Task'

//This requires key of the Epic that will be linked the issues
final def epicIssueKey = 'ABC-1'

def epic = Issues.getByKey(epicIssueKey)

if (issue.issueType.name != issueTypeName) {
    return
}

if (!issue.getEpic()) {
    issue.set {
        setEpic(epic)
    }
}
```

