# Copy an Issue to a Separate Project

- Platform: data-center
- Feature: script-console
- Tags: automate, issue
- Language: groovy
- Doc ID: example-dataCenter-copy-issue-no-links-onPrem
- Source: https://examples.scriptrunner.io/scripts/copy-issue-no-links-onPrem

## Overview

Copy an issue from one project to another project, keeping the same or similar ticket info. This example does not link
the issues together.

## Example

I am managing three teams, and we have one large master project where we keep all issues in one backlog. During each
team's sprint planning, they are able to copy upcoming issues from the master project into their sprint project
backlogs.

## Good to Know

* This script does not link the source and copy issues together, but there is a
[similar script](https://library.adaptavist.com/entity/copy-an-issue-to-a-new-project-and-link-to-the-original) that does it.
* Copy this snippet into a listener, post function, or other features of ScriptRunner for Jira.
* The fields added in the list of 'CloneIssue.FIELD_SELECTED_FIELDS' are the ones cloned.
To know which fields can be added, please consult the class 'com.onresolve.scriptrunner.canned.jira.utils.AbstractCloneIssue.ALL_SYSTEM_FIELDS'

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.onresolve.scriptrunner.canned.jira.utils.ConditionUtils
import com.onresolve.scriptrunner.canned.jira.workflow.postfunctions.CloneIssue
import com.onresolve.scriptrunner.runner.ScriptRunnerImpl

def projectKey = "Project Key" //Replace with the key of the project you want to copy to
def issueKey = "Issue Key" //Replace with the key of the issue you want to copy

def projectManager = ComponentAccessor.projectManager
def issueManager = ComponentAccessor.issueManager

def projectToCopyTo = projectManager.getProjectByCurrentKey(projectKey)
def issueToCopy = issueManager.getIssueObject(issueKey)

// Block creation of intra-project links
def blockIntraprojectLinks = '{l -> l.sourceObject.projectObject != l.destinationObject.projectObject}'

if (!issueToCopy) {
    log.warn("Issue ${issueKey} does not exist")
    return
}

//Set the creation parameters/inputs (use clone issue but with no link type)
def inputs = [
    (CloneIssue.FIELD_TARGET_PROJECT)       : projectToCopyTo.key,
    (CloneIssue.FIELD_LINK_TYPE)            : null,
    (ConditionUtils.FIELD_ADDITIONAL_SCRIPT): [
        "checkLink = $blockIntraprojectLinks;",
        ""
    ],
    (CloneIssue.FIELD_SELECTED_FIELDS)      : null, //clone all the fields
    (CloneIssue.SKIP_EPIC_LINKS)            : "true",
] as Map<String, Object>
def executionContext = [issue: issueToCopy] as Map<String, Object>

def newClonedIssue = ScriptRunnerImpl.scriptRunner.createBean(CloneIssue)
// Execute the clone action with the specified inputs
def updatedExecutionContext = newClonedIssue.execute(inputs, executionContext)
//The issue has been successfully cloned
assert updatedExecutionContext.newIssue
```

