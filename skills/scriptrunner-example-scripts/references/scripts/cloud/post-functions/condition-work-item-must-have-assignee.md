# Condition work item must have assignee

- Platform: cloud
- Feature: post-functions
- Tags: workflow, automate, issue
- Language: groovy
- Doc ID: example-cloud-condition-issue-must-have-assignee-cloud
- Source: https://examples.scriptrunner.io/scripts/condition-issue-must-have-assignee-cloud

## Overview

The condition for workflow post function that will run only if the work item has Assignee

## Description

#### Overview

The condition for workflow post function that will run only if the work item has Assignee

## Script

```groovy
issue.fields.assignee != null
```

