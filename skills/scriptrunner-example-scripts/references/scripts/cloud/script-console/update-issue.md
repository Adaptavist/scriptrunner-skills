# Update Issue

- Platform: cloud
- Feature: script-console
- Tags: issue, fields, automate
- Language: groovy
- Doc ID: example-cloud-update-issue-cloud
- Source: https://examples.scriptrunner.io/scripts/update-issue-cloud

## Overview

This example shows how you can update the summary of a specified issue.

## Good to Know

It is useful for scripting tasks in Jira where you need to modify issue descriptions based on status changes or when automating bulk updates to issue titles for consistency across tasks.

## Description

#### Overview
This example shows how you can update the summary of a specified issue.

#### Good to know
It is useful for scripting tasks in Jira where you need to modify issue descriptions based on status changes or when automating bulk updates to issue titles for consistency across tasks.

## Script

```groovy
def issueKey = 'TP-1'
def newSummary = 'Updated by a script'

def result = put('/rest/api/2/issue/' + issueKey)
    .header('Content-Type', 'application/json')
    .body([
        fields:[
            summary: newSummary
        ]
    ])
    .asString()
if (result.status == 204) {
 return 'Success'
} else {
 return "${result.status}: ${result.body}"
}
```

