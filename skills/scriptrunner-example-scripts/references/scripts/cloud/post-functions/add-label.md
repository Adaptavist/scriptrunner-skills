# Add label

- Platform: cloud
- Feature: post-functions
- Tags: workflow, automate, issue
- Language: groovy
- Doc ID: example-cloud-add-label-cloud
- Source: https://examples.scriptrunner.io/scripts/add-label-cloud

## Overview

This example shows how to add a label when using the clone work item perform actions rule.

## Description

#### Overview

This example shows how to add a label when using the clone work item perform actions rule.

## Script

```groovy
List labels = issue.fields.labels ?: [] // get the labels for the current issue
labels += "newLabel"
issueInput.fields.labels = labels
```

