# Set label

- Platform: cloud
- Feature: post-functions
- Tags: workflow, automate, issue
- Language: groovy
- Doc ID: example-cloud-set-label-cloud
- Source: https://examples.scriptrunner.io/scripts/set-label-cloud

## Overview

This example shows how you can set labels when updating a work item.

## Description

#### Overview

This example shows how you can set labels when updating a work item.

## Script

```groovy
issueInput.update.labels = [[set: ["finance"]]]
```

