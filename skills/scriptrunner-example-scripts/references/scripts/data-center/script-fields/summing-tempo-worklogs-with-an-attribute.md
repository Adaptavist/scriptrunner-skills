# Summing Tempo Worklogs with an Attribute

- Platform: data-center
- Feature: script-fields
- Tags: reporting, issue, fields
- Language: groovy
- Doc ID: example-dataCenter-summing-tempo-worklogs-attribute-onPrem
- Source: https://examples.scriptrunner.io/scripts/summing-tempo-worklogs-attribute-onPrem

## Overview

Tempo allows to categorise worklogs with additional attributes.
With this script, collect all worklogs in an issue with a specific attribute value and show a summary of them in a script field.

## Example

As a billing administrator, I want to check the total overtime that employees have worked on an issue.
Employees register overtime in Tempo by creating a worklog and checking an "Overtime" checkbox.
I can use this script to see the sum of all overtime registered for each issue, and have that data displayed in a script field.

## Good to Know

* This script requires [Tempo Timesheets](https://marketplace.atlassian.com/apps/6572/tempo-timesheets-time-tracking-report).
* Create a worklog attribute with "_Overtime_" as the key and "CHECKBOX" as the type.
* Use 'Duration (time-tracking)' as the template for the custom script field and 'Duration Searcher' as the searcher.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.worklog.Worklog
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import com.tempoplugin.core.workattribute.api.WorkAttributeService
import com.tempoplugin.core.workattribute.api.WorkAttributeValueService

@WithPlugin("is.origo.jira.tempo-plugin")

@PluginModule
WorkAttributeService workAttributeService

@PluginModule
WorkAttributeValueService workAttributeValueService

def worklogManager = ComponentAccessor.worklogManager

// Get the worklogs of the issue
def worklogs = worklogManager.getByIssue(issue)

// Filter the worklogs which are marked as "Overtime"
def overtimeLogs = worklogs.findAll { worklog ->
    def attribute = workAttributeService.getWorkAttributeByKey("_Overtime_").returnedValue
    workAttributeValueService.getWorkAttributeValueByWorklogAndWorkAttribute(worklog.id, attribute.id).returnedValue
}

// Sum the overtime in seconds. If there aren't any overtime worklogs, just return null
overtimeLogs.sum { Worklog worklog ->
    worklog.timeSpent
} as Long
```

