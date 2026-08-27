# Automatically Set the Assignee of an Issue in a Post Function

- Platform: data-center
- Feature: post-functions
- Tags: automate, workflow, user, hapi
- Language: groovy
- Doc ID: example-dataCenter-set-assignee-post-function-onPrem
- Source: https://examples.scriptrunner.io/scripts/set-assignee-post-function-onPrem

## Overview

Use this post function script to automatically add a specific user as the assignee when a defined workflow transition occurs.

## Example

I work in support and when transitioning a workflow from 'In Progress' to 'In Review', I need my manager to be assigned to this issue so they can review it. 
This script automatically assigns this issue so I don't have to do this manually every time.

## Description

#### Overview

Use this post function script to automatically add a specific user as the assignee when a defined workflow transition occurs.

#### Example

I work in support and when transitioning a workflow from 'In Progress' to 'In Review', I need my manager to be assigned to this issue so they can review it. 
This script automatically assigns this issue so I don't have to do this manually every time.

## Script

```groovy
issue.set {
    setAssignee('jdoe')
}
```

