# Updates custom fields on an issue, without affecting change history or last update time

- Platform: data-center
- Feature: script-console
- Tags: automate, workflow, user, hapi
- Language: groovy
- Doc ID: example-dataCenter-update-custom-fields-without-change-history-onPrem
- Source: https://examples.scriptrunner.io/scripts/update-custom-fields-without-change-history-onPrem

## Overview

This script can be useful for bulk changing issues, without sending emails, or affecting the last udpate time of the issue.
No record of the change will appear in the change history either.

This script can only be used for custom fields. 
To update system fields see [this script](https://library.adaptavist.com/entity/update-system-fields-without-change-history).

## Example

Change or unset a custom field across multiple issues.

## Description

#### Overview

This script can be useful for bulk changing issues, without sending emails, or affecting the last udpate time of the issue.
No record of the change will appear in the change history either.

This script can only be used for custom fields. 
To update system fields see [this script](https://library.adaptavist.com/entity/update-system-fields-without-change-history).

#### Example

Change or unset a custom field across multiple issues.

## Script

```groovy
import com.adaptavist.hapi.jira.issues.Issues
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.ModifiedValue
import com.atlassian.jira.issue.MutableIssue
import com.atlassian.jira.issue.index.IssueIndexingParams
import com.atlassian.jira.issue.index.IssueIndexingService
import com.atlassian.jira.issue.util.DefaultIssueChangeHolder

def issueIndexingService = ComponentAccessor.getComponent(IssueIndexingService)
def customFieldManager = ComponentAccessor.customFieldManager

def issue = Issues.getByKey('SR-1') as MutableIssue

// a text custom field
def customField = customFieldManager.getCustomFieldObjects(issue).findByName('TextFieldA')

customField.updateValue(null, issue, new ModifiedValue(issue.getCustomFieldValue(customField), 'bananas'), new DefaultIssueChangeHolder())

issueIndexingService.reIndex(issue, IssueIndexingParams.INDEX_ISSUE_ONLY)
```

