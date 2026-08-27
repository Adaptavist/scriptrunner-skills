# Display Summarized Worklog Cost

- Platform: data-center
- Feature: script-fields
- Tags: automate, issue
- Language: groovy
- Doc ID: example-dataCenter-display-summarized-worklog-cost-onPrem
- Source: https://examples.scriptrunner.io/scripts/display-summarized-worklog-cost-onPrem

## Overview

The Timetracker plugin provides cost management functionality. You can add cost rates to each employee and/or a default rate.
Using this script, you can add a scripted field to display the total cost of work on that issue for a specific date range.

## Example

I am the project manager of a team developing an app for a specific cost.
I need to keep track of how much development has cost so that I can maintain an accurate financial report.
Using this script, I can find out how much the work of the selected employees cost in a given period when I view the issue.

## Good to Know

* This script requires [Timetracker - Time Tracking & Reporting for Jira](https://marketplace.atlassian.com/apps/1211243/timetracker-time-tracking-reporting).
* To configure this script: *Create a Custom scripted field with *Number field* template and *Number* or *Number Range* searcher.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import org.everit.jira.timetracker.service.WorklogService
import java.time.Instant
import java.time.Period

@WithPlugin("org.everit.jira.timetracker.plugin")

@PluginModule
WorklogService worklogService

// The period since when the worklogs are taken into account (customise it to your chosen period of time)
final period = Period.ofDays(7)

// Check the worklogs on the issue in the last time period (ex. the last 7 days)
def endDate = Instant.now()
def startDate = endDate - period

// Customise the lists to add your chosen users names and groups names
// Empty users and groups list means the summary will include all users
final usersNames = [] as List<String>
final groupsNames = [] as List<String>

// Get the users based on their usernames
def userManager = ComponentAccessor.userManager
def users = usersNames.collect { userName -> userManager.getUserByName(userName) }

worklogService.costSummary(issue.key, startDate, endDate, users*.key, groupsNames)
```

