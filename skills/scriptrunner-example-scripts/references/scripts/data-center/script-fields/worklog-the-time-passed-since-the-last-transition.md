# Worklog the Time Passed since the Last Transition

- Platform: data-center
- Feature: script-fields
- Tags: automate, issue
- Language: groovy
- Doc ID: example-dataCenter-worklog-time-passed-last-transition-onPrem
- Source: https://examples.scriptrunner.io/scripts/worklog-time-passed-last-transition-onPrem

## Overview

Timetracker provides the ability to create worklogs with associated attributes.
Use this script to log the time that has passed since the last transition, automatically as part of a workflow post function.
The time you log in this way must comply with the rules and restrictions configured in the Timetracker app, such as the loggable hours per day.

## Example

As a developer, I want to log the amount of time that has passed since the last transition automatically when I move an issue to another status.
This way, I know how long the job in that status took and I don't need to log work manually.

## Good to Know

* This script requires [Timetracker - Time Tracking & Reporting for Jira](https://marketplace.atlassian.com/apps/1211243/timetracker-time-tracking-reporting).
* Timetracker has numerous validation rules, permissions and additional attributes that apply when a worklog is created with it.
* [Learn more](https://everit.atlassian.net/wiki/spaces/TD/pages/932118547/Scriptrunner+integration) about ways to integrate Timetracker and ScriptRunner.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import org.everit.jira.timetracker.service.WorklogService
import java.time.Instant
import java.time.temporal.ChronoUnit

@WithPlugin("org.everit.jira.timetracker.plugin")

@PluginModule
WorklogService worklogService

def changeHistoryManager = ComponentAccessor.changeHistoryManager

// Get the time of the last transition and the current time
def timeLastTransition = changeHistoryManager.getChangeItemsForField(issue, 'status')?.last()?.created
final currentTime = Instant.now()

// Get the time since the last transition in minutes
def timeToLog = ChronoUnit.MINUTES.between(timeLastTransition.toInstant(), currentTime)

// Define optional worklog attributes (case sensitive)
def worklogAttributes = ['billable']

// Create the worklog with the following paramters: issue key, duration, start date, comment, attributes
// The worklog will be created by the logged in user
def worklogCreateFailed = worklogService.createWorklog(issue.key, "${timeToLog}m", Instant.now(), 'PostFunction Worklog', worklogAttributes)
if (!worklogCreateFailed.empty) {
    log.error("Worklog creation failed: ${worklogCreateFailed}")
}
```

