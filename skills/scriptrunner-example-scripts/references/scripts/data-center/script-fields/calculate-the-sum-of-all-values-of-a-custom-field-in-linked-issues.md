# Calculate the Sum of all Values of a Custom Field in Linked Issues

- Platform: data-center
- Feature: script-fields
- Tags: automate, fields
- Language: groovy
- Doc ID: example-dataCenter-sum-of-linked-cf-values-onPrem
- Source: https://examples.scriptrunner.io/scripts/sum-of-linked-cf-values-onPrem

## Overview

This script sums up the values of several customs fields across all linked issues and displays the result in the
parent issue.

## Example

I'm working on a large project with multiple colleagues working on several linked issues. I have a custom field
showing the number of users that have been involved in working on an issue. Using this script, I can show the sum
of all users working on all linked issues, on the parent issue view.

## Good to Know

* Use the 'Number Field' as the template for the custom script field and 'Number Searcher' as the searcher.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.Issue

// The issue type for which we want the scripted field to be displayed
final issueTypeName = 'Bug'

// The linked issues with that issue type will used
final linkedIssueType = 'Support'

// The values of that custom field - of type number - we want to sum up
final numberOfUsersFieldName = 'Number of Users'

if (issue.issueType.name != issueTypeName) {
    return null
}

def linkedIssues = ComponentAccessor.issueLinkManager.getOutwardLinks(issue.id).findAll { it.destinationObject.issueType.name == linkedIssueType }
if (!linkedIssues) {
    return null
}

def numberOfUsersField = ComponentAccessor.customFieldManager.getCustomFieldObjects(linkedIssues.first().destinationObject).findByName(numberOfUsersFieldName)
if (!numberOfUsersField) {
    log.debug "Custom field is not configured for that context"
    return null
}

linkedIssues*.destinationObject.sum { Issue it -> it.getCustomFieldValue(numberOfUsersField) ?: 0 }
```

