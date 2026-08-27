# Create a Sub-task and Link to Parent Issue in Jira

- Platform: data-center
- Feature: script-console
- Tags: automate, issue, hapi
- Language: groovy
- Doc ID: example-dataCenter-basics-create-subtask-onPrem
- Source: https://examples.scriptrunner.io/scripts/basics-create-subtask-onPrem

## Overview

This script creates a sub-task of the provided parent issue, with the minimum fields required.

## Example

Automatically create sub-tasks for new *Enhancements* for the pre-requisites, such as Design and Analysis. 
This could be done in a post-function or a listener.

## Description

#### Overview

This script creates a sub-task of the provided parent issue, with the minimum fields required. 

#### Example

Automatically create sub-tasks for new *Enhancements* for the pre-requisites, such as Design and Analysis. 
This could be done in a post-function or a listener.

## Script

```groovy
def parentIssue = Issues.getByKey('SR-1')

parentIssue.createSubTask('Sub-task') {
    setSummary('This is a sub-task...')

    // any other fields on the sub-task can be set, in the same way as when creating a standard issue
}
```

