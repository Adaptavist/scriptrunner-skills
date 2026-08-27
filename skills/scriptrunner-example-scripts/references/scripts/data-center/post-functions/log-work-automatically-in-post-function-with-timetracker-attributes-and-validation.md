# Log Work Automatically in Post Function with Timetracker Attributes and Validation

- Platform: data-center
- Feature: post-functions
- Tags: automate, workflow
- Language: groovy
- Doc ID: example-dataCenter-log-work-timetracker-attributes-validation-onPrem
- Source: https://examples.scriptrunner.io/scripts/log-work-timetracker-attributes-validation-onPrem

## Overview

Add a ScriptRunner post function to a workflow step to automate work logging. The hours you log in this way must
comply with the rules and restrictions configured in the Timetracker app.

## Example

As a developer, I want to log a certain amount of work automatically when I move the issue to another status.
In some cases, I need to log a certain amount of time for a task when working on a specific step. For example,
I had to spend an hour each time working on a task to examine its feasibility. We have a dedicated "Research" status
before the "In Progress" status. These times are usually billable. This script allows me to log the one hour
automatically when I start working on the Issue.

## Good to Know

* This script requires Timetracker - Time Tracking & Reporting for Jira by Everit.
* Timetracker has numerous validation rules, permissions, and additional attributes that apply when a worklog is
created with it.

## Script

```groovy
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import org.everit.jira.timetracker.service.WorklogService
import java.time.Instant

@WithPlugin('org.everit.jira.timetracker.plugin')

@PluginModule
WorklogService worklogService

// Define optional worklog attributes (case sensitive)
def worklogAttributes = ['billable']

//Define the worklog duration
final duration = '1h'
//Define the worklog comment
final comment = 'PostFunction Worklog'

// Create the worklog with the following paramters: issue key, duration, start date, comment, attributes
// The worklog will be created by the logged in user
def worklogCreateFailed = worklogService.createWorklog(issue.key, duration, Instant.now(), comment, worklogAttributes)
if (!worklogCreateFailed.empty) {
    log.error("Worklog failed: ${worklogCreateFailed}")
}
```

