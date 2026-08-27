# Set Priority Using an Impact-Urgent Matrix

- Platform: data-center
- Feature: behaviours
- Tags: customise, issue, fields
- Language: groovy
- Doc ID: example-dataCenter-priority-by-impact-urgent-matrix-onPrem
- Source: https://examples.scriptrunner.io/scripts/priority-by-impact-urgent-matrix-onPrem

## Overview

This script calculates the priority of an issue based on the *Impact* and *Urgency* fields (single-select custom fields)
set by the user. The calculated priority is displayed in a read-only *Priority* field.

## Example

As a team leader, I want to define an issue priority based on the assigned *Impact* and *Urgency* level. This allows me
to sort by the *Priority* field so developers can work on the most crucial issues.
With this script, I can do this with a priority matrix definition.

## Good to Know

* You need two single-select custom fields for this script to work.
* You can set the field names, priority matrix values, and single-select options.
* You must configure the *Priority* field with the priority matrix values for it to work.
* It is recommended that you set the *Priority* field read-only.

## Script

```groovy
import com.atlassian.jira.issue.IssueFieldConstants
import groovy.transform.BaseScript
import com.onresolve.jira.groovy.user.FieldBehaviours

@BaseScript FieldBehaviours fieldBehaviours

def priorityMatrix = [
    Critical: [
        Extensive  : 'Critical',
        Significant: 'Critical',
        Moderate   : 'High',
        Minor      : 'Medium'
    ],
    High    : [
        Extensive  : 'Critical',
        Significant: 'High',
        Moderate   : 'Medium',
        Minor      : 'Medium'
    ],
    Medium  : [
        Extensive  : 'High',
        Significant: 'Medium',
        Moderate   : 'Medium',
        Minor      : 'Low'
    ],
    Low     : [
        Extensive  : 'Medium',
        Significant: 'Medium',
        Moderate   : 'Low',
        Minor      : 'Low'
    ]
]
def priorityField = getFieldById(IssueFieldConstants.PRIORITY)

def impactFieldValue = getFieldByName('Impact').value as String
def urgencyFieldValue = getFieldByName('Urgency').value as String

def priority = priorityMatrix[urgencyFieldValue][impactFieldValue]
priorityField.setFormValue(priority)
```

