# Create a Tempo Worklog

- Platform: data-center
- Feature: script-console
- Tags: automate, workflow
- Language: groovy
- Doc ID: example-dataCenter-create-tempo-worklog-onPrem
- Source: https://examples.scriptrunner.io/scripts/create-tempo-worklog-onPrem

## Overview

Create a Tempo worklog, with worklog attributes, using the Tempo Java API.

## Example

As a project manager, I want to add a worklog automatically when a user transitions an issue out of any state.
For example, in our workflow, all issues raised by customers go through a Triage state. When the triage is complete,
I want to automatically log the amount of time it took us to triage the issue.

## Good to Know

* This script requires [Tempo Timesheets](https://marketplace.atlassian.com/apps/6572/tempo-timesheets-time-tracking-report)

## Script

```groovy
import com.adaptavist.hapi.jira.issues.Issues
import com.adaptavist.hapi.jira.users.Users
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import com.tempoplugin.common.TempoDateTimeFormatter
import com.tempoplugin.core.datetime.api.TempoDate
import com.tempoplugin.core.workattribute.api.WorkAttributeService
import com.tempoplugin.worklog.v4.rest.InputWorklogsFactory
import com.tempoplugin.worklog.v4.rest.TimesheetWorklogBean
import com.tempoplugin.worklog.v4.rest.WorkAttributeValueInputBean
import com.tempoplugin.worklog.v4.services.WorklogService

import java.util.concurrent.TimeUnit

@WithPlugin('is.origo.jira.tempo-plugin')

@PluginModule
WorkAttributeService workAttributeService

@PluginModule
WorklogService worklogService

@PluginModule
InputWorklogsFactory inputWorklogsFactory

def issue = Issues.getByKey('SR-1')

def currentUser = Users.loggedInUser
def startDate = TempoDateTimeFormatter.formatTempoDate(TempoDate.now())

def geAttributeId = { String name ->
    def workAttribute = workAttributeService.workAttributes.get().find { it.name == name }
    if (!workAttribute) {
        throw new IllegalArgumentException("Could not find attribute with name '${name}'")
    }
    workAttribute.key
}

// Add all fields needed to create a new worklog
def timesheetWorklogBean = new TimesheetWorklogBean.Builder()
    .issueIdOrKey(issue.key)
    .comment('my worklog')
    .startDate(startDate)
    .workerKey(currentUser.key)
    .timeSpentSeconds(TimeUnit.HOURS.toSeconds(5)) // log 5 hours
    .remainingEstimate(TimeUnit.HOURS.toSeconds(3)) // 3 hours remaining
    .attributes([
        // add as many work attributes as you need
        (geAttributeId('A text attribute')): new WorkAttributeValueInputBean('Set by automation'),
        (geAttributeId('Static Select'))   : new WorkAttributeValueInputBean('Bananas'),
    ])
    .build()

def inputWorklogs = inputWorklogsFactory.buildForCreate(timesheetWorklogBean)
worklogService.createTempoWorklogs(inputWorklogs)
```

