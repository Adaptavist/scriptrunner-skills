# Updates system fields on an issue, without affecting change history or last update time

- Platform: data-center
- Feature: script-console
- Tags: automate, workflow, user, hapi
- Language: groovy
- Doc ID: example-dataCenter-update-system-fields-without-change-history-onPrem
- Source: https://examples.scriptrunner.io/scripts/update-system-fields-without-change-history-onPrem

## Overview

This script can be useful for bulk changing issues, without sending emails, or affecting the last udpate time of the issue.
No record of the change will appear in the change history either.

This script can only be used for system fields. 
To update custom fields see [this script](https://library.adaptavist.com/entity/update-custom-fields-without-change-history).

## Example

Change or unset the resolution across multiple issues, if for instance you are consolidating resolution values.

## Description

#### Overview

This script can be useful for bulk changing issues, without sending emails, or affecting the last udpate time of the issue.
No record of the change will appear in the change history either.

This script can only be used for system fields. 
To update custom fields see [this script](https://library.adaptavist.com/entity/update-custom-fields-without-change-history).

#### Example

Change or unset the resolution across multiple issues, if for instance you are consolidating resolution values.

## Script

```groovy
import com.adaptavist.hapi.jira.issues.Issues
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.MutableIssue
import com.atlassian.jira.issue.index.IssueIndexingParams
import com.atlassian.jira.issue.index.IssueIndexingService

def issueIndexingService = ComponentAccessor.getComponent(IssueIndexingService)

def issue = Issues.getByKey('SR-1') as MutableIssue

issue.set {
    setPriority('Highest')
    setSummary('my new summary')
}

issue.store()
issueIndexingService.reIndex(issue, IssueIndexingParams.INDEX_ISSUE_ONLY)
```

