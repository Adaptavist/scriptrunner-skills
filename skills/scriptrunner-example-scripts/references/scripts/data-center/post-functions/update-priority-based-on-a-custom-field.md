# Update Priority based on a Custom Field

- Platform: data-center
- Feature: post-functions
- Tags: automate, workflow, fields, hapi
- Language: groovy
- Doc ID: example-dataCenter-update-priority-based-on-customfield-onPrem
- Source: https://examples.scriptrunner.io/scripts/update-priority-based-on-customfield-onPrem

## Overview

This script is used as a post function to change the priority of an issue based on the value of a single-select field.

## Example

There is a single-select custom field with a single-select custom field called 'Audit Group'. Based on the value of this field,
I want to assign different priorities to the issue.

## Good to Know

* This post function should be above the system functions for saving and reindexing the issue.

## Description

#### Overview
This script is used as a post function to change the priority of an issue based on the value of a single-select field.

#### Example
There is a single-select custom field with a single-select custom field called 'Audit Group'. Based on the value of this field,
I want to assign different priorities to the issue.

### Good to know
* This post function should be above the system functions for saving and reindexing the issue.

## Script

```groovy
def auditGroupFieldValue = issue.getCustomFieldValue('Audit Group').value

issue.set {
    if (auditGroupFieldValue == 'Audit (Internal)') {
        setPriority('Highest')
    } else if (auditGroupFieldValue == 'Audit (External)') {
        setPriority('High')
    }
}
```

