# Set Field Value From User Property Using Behaviours

- Platform: data-center
- Feature: behaviours
- Tags: administer, issue
- Language: groovy
- Doc ID: example-dataCenter-set-field-value-from-user-property-behaviours-onPrem
- Source: https://examples.scriptrunner.io/scripts/set-field-value-from-user-property-behaviours-onPrem

## Overview

*Behaviours* allow you to change how fields behave on issue Create or Update screens. 
Use this script in Behaviours to automatically set a custom field value based on the assignee's email.

## Description

#### Overview

*Behaviours* allow you to change how fields behave on issue Create or Update screens. 
Use this script in Behaviours to automatically set a custom field value based on the assignee's email.

## Script

```groovy
def assigneeField = getFieldByName('Assignee').value

if (assigneeField && assigneeField != '-1') {
    def assigneeEmail = Users.getByName(assigneeField as String).emailAddress
    getFieldByName('Contact for more information').setFormValue(assigneeEmail)
}
```

