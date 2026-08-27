# A post-function for deleting all subtasks of the current issue

- Platform: data-center
- Feature: post-functions
- Tags: administer
- Language: groovy
- Doc ID: example-dataCenter-delete-Subtasks-on-transition-onPrem
- Source: https://examples.scriptrunner.io/scripts/delete-Subtasks-on-transition-onPrem

## Overview

You could use this if, for example, your subtasks represent transient objects that are no longer required at a later
stage in the workflow, and you wish to delete them all on transition.

Set this up as a workflow post-function, putting it at the top of the list of post-functions.

## Description

#### Overview

You could use this if, for example, your subtasks represent transient objects that are no longer required at a later
stage in the workflow, and you wish to delete them all on transition.

Set this up as a workflow post-function, putting it at the top of the list of post-functions.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.event.type.EventDispatchOption
import com.atlassian.jira.util.BuildUtilsInfo
import org.ofbiz.core.entity.DelegatorInterface

final int JIRA_8_9_0 = 809000

def user = ComponentAccessor.jiraAuthenticationContext.getLoggedInUser()
def issueManager = ComponentAccessor.issueManager
def delegatorInterface = ComponentAccessor.getComponent(DelegatorInterface)
def buildUtilsInfo = ComponentAccessor.getComponent(BuildUtilsInfo)

def subTasks = issue.getSubTaskObjects()

subTasks.each { subTask ->
    // add a condition here if you want to delete selective subtasks
    issueManager.deleteIssue(user, subTask, EventDispatchOption.ISSUE_DELETED, false)
    if (buildUtilsInfo.applicationBuildNumber >= JIRA_8_9_0) {
        delegatorInterface.removeByAnd("IssueVersion", [issueId: subTask.id, deleted: 'Y'])
    }
}
```

