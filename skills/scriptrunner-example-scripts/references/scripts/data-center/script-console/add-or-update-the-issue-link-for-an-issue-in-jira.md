# Add or Update the Issue Link for an Issue in Jira

- Platform: data-center
- Feature: script-console
- Tags: automate, fields, hapi
- Language: groovy
- Doc ID: example-dataCenter-basics-updating-issue-links-onPrem
- Source: https://examples.scriptrunner.io/scripts/basics-updating-issue-links-onPrem

## Overview

Linking issues creates an association between two existing issues. 
This script demonstrates how to programmatically link issues.

## Description

#### Overview
Linking issues creates an association between two existing issues. 
This script demonstrates how to programmatically link issues.

## Script

```groovy
def sourceIssue = Issues.getByKey("SR-1")
def destinationIssue = Issues.getByKey("ABC-1")

// to link the issues in the other direction you would use 'is blocked by'
sourceIssue.link('blocks', destinationIssue)
```

