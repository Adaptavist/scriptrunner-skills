# Copy an Issue to a New Project and Link to the Original

- Platform: data-center
- Feature: script-console
- Tags: automate, issue
- Language: groovy
- Doc ID: example-dataCenter-copy-issue-with-links-onPrem
- Source: https://examples.scriptrunner.io/scripts/copy-issue-with-links-onPrem

## Overview

Copy an issue from one project to another. Either copy the entire issue or the parts of the issue required.

## Example

My team has multiple projects in Jira, a main project and several client projects, each with their own product owners and dashboards. Issues are created in the main project; however, one of my colleagues found the same issue in their client project. Using this snippet they can copy this issue over to their project.

## Good to Know

* This script links the source and copy issues together, but there is a [similar script](https://library.adaptavist.com/entity/copy-an-issue-to-a-separate-project) that does not do it.
* Copy this snippet into a listener, post function, or other features of ScriptRunner for Jira.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.config.properties.APKeys
import com.onresolve.scriptrunner.canned.jira.utils.AbstractCloneIssue
import com.onresolve.scriptrunner.canned.jira.utils.CannedScriptUtils
import com.onresolve.scriptrunner.canned.jira.utils.ConditionUtils
import com.onresolve.scriptrunner.canned.jira.workflow.postfunctions.CloneIssue
import com.onresolve.scriptrunner.runner.ScriptRunnerImpl
import groovy.xml.MarkupBuilder

def targetProjectKey = "PROJB"
def issueToCloneKey = "PROJA-1"

def issueToClone = ComponentAccessor.issueManager.getIssueByCurrentKey(issueToCloneKey)
def linkBetweenIssues = CannedScriptUtils.getAllLinkTypesWithInwards(true).find { it.value == "blocks" }?.key?.toString()

// Set the creation parameters/inputs (use clone issue with link type)
def params = [
    (CloneIssue.FIELD_TARGET_PROJECT)       : targetProjectKey,
    (CloneIssue.FIELD_TARGET_ISSUE_TYPE)    : null,
    (CloneIssue.FIELD_COPY_FIELDS)          : AbstractCloneIssue.COPY_ALL_FIELDS,
    (CloneIssue.FIELD_SELECTED_FIELDS)      : null,
    (CloneIssue.FIELD_COPY_COMMENTS)        : false,
    (CloneIssue.FIELD_USER_KEY)             : null,
    (ConditionUtils.FIELD_ADDITIONAL_SCRIPT): ["", ""],
    (CloneIssue.FIELD_LINK_TYPE)            : linkBetweenIssues
] as Map<String, Object>
def executionContext = [issue: issueToClone] as Map<String, Object>

def cloneIssueAction = ScriptRunnerImpl.scriptRunner.createBean(CloneIssue)
// Execute the clone action with the specified params
def updatedExecutionContext = cloneIssueAction.execute(params, executionContext)

// Return the link to the cloned issue
cloneIssueAction ? "Cloned issue: ${createHrefLinkToIssue(updatedExecutionContext.newIssue as String)}" :
    "Could not clone issue, check the logs for errors"

static String createHrefLinkToIssue(String issueKey) {
    def baseUrl = ComponentAccessor.applicationProperties.getString(APKeys.JIRA_BASEURL)
    def writer = new StringWriter()
    def html = new MarkupBuilder(writer)

    html.html {
        a href: "$baseUrl/browse/$issueKey", issueKey
    }

    writer
}
```

