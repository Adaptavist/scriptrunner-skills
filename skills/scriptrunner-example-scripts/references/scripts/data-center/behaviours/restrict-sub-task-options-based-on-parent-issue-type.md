# Restrict Sub-task options based on parent issue type

- Platform: data-center
- Feature: behaviours
- Tags: administer, issue
- Language: groovy
- Doc ID: example-dataCenter-restrict-subtask-options-onPrem
- Source: https://examples.scriptrunner.io/scripts/restrict-subtask-options-onPrem

## Overview

*Behaviours* allow you to change how fields behave on issue Create or Update screens. 
Use this script to automatically restrict the sub-task options based on the parent issue type.

## Description

#### Overview

*Behaviours* allow you to change how fields behave on issue Create or Update screens. 
Use this script to automatically restrict the sub-task options based on the parent issue type.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.onresolve.jira.groovy.user.FieldBehaviours
import groovy.transform.BaseScript

import static com.atlassian.jira.issue.IssueFieldConstants.ISSUE_TYPE

@BaseScript FieldBehaviours fieldBehaviours
def issueManager = ComponentAccessor.getIssueManager()

if (getIssueContext().getIssueType().isSubTask()) {
    def parentIssueId = getFieldById('parentIssueId').getFormValue() as Long
    def parentIssue = issueManager.getIssueObject(parentIssueId)

    if (parentIssue.issueType.name in ['Task', 'Story', 'Bug']) {
        getFieldById(ISSUE_TYPE).setFieldOptions(['Other Sub-task'])
    }
}
```

