# Add Comment On Issue Created

- Platform: cloud
- Feature: listeners
- Tags: issue, hapi, automate
- Language: groovy
- Doc ID: example-cloud-add-comment-on-issue-created-cloud
- Source: https://examples.scriptrunner.io/scripts/add-comment-on-issue-created-cloud

## Overview

This script illustrates how to automatically add a comment to a newly created work item in Jira. 
This functionality enhances communication by ensuring that relevant information is provided immediately upon work item creation.

## Good to Know

The comment can include dynamic content, such as the creator's name or specific details about the work item.

## Description

#### Overview
This script illustrates how to automatically add a comment to a newly created work item in Jira. 
This functionality enhances communication by ensuring that relevant information is provided immediately upon work item creation.

#### Good to know
The comment can include dynamic content, such as the creator's name or specific details about the work item.

## Script

```groovy
def eventWorkItem = WorkItems.getByKey(issue.key as String)

def author = eventWorkItem.getCreator().displayName
eventWorkItem.addComment("""Thank you ${author} for creating a support request.
We'll respond to your query within 24hrs.
In the meantime, please read our documentation: http://example.com/documentation""")
```

