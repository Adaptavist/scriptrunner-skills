# Get Work Item Fields

- Platform: cloud
- Feature: script-console
- Tags: automate, issue, hapi
- Language: groovy
- Doc ID: example-cloud-get-issue-fields-cloud
- Source: https://examples.scriptrunner.io/scripts/get-issue-fields-cloud

## Overview

This example shows how you can retrieve all of the fields on a specified work item.

## Description

#### Overview

This example shows how you can retrieve all of the fields on a specified work item.

## Script

```groovy
def workItemKey = 'TP-1'

WorkItems.getByKey(workItemKey).fields
```

