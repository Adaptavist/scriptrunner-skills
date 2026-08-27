# Display Summarised Worklog for a Date Range by Attribute

- Platform: data-center
- Feature: script-fields
- Tags: fields, reporting, issue
- Language: groovy
- Doc ID: example-dataCenter-display-summarized-worklog-for-date-range-by-attribute-onPrem
- Source: https://examples.scriptrunner.io/scripts/display-summarized-worklog-for-date-range-by-attribute-onPrem

## Overview

A new ScriptRunner number-formatted custom field was added to Jira issues. The field displays the summary of worklogs
on a selected Timetracker attribute for a date range.

## Example

I am a Project Manager who develops an app with my team for a client.
I do not want to bill the customer for some work, such as code refactor or bug fixes, so we separate the worklogs
as “Billable” and “Not Billable” with attributes. I would like to know how much work is billable on a task at a given
time. This script allows me to find out how much work of the selected employees can be billed to the customer in a
given period when I view the issue.

## Good to Know

* This script requires Timetracker - Time Tracking & Reporting for Jira by Everit.
* To configure this script: Create a Custom Script Field with Template.
* Duration (time-tracking) and Searcher: Duration Searcher.
* Timetracker allows you to add additional attributes to your worklogs.
You can use this categorization for example if you have an external and internal project as well,
and you want to separate the “Billable” and “Not Billable” worklogs.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import org.everit.jira.timetracker.service.WorklogService
import java.time.Instant
import java.time.Period

@WithPlugin('org.everit.jira.timetracker.plugin')

@PluginModule
WorklogService worklogService

def worklogAttributes = ['billable']
// Empty will summarize and display all worklogs (with and without attribute)
// To summarize and display worklogs without attributes to the summary use the "#NO_CATEGORY" constant

// The period since when the worklogs are taken into account (customise it to your chosen period of time)
final period = Period.ofDays(7)

// Check the last 7 days billable worklogs on the issue
def endDate = Instant.now()
def startDate = endDate - period

//Empty users and groups list means the summary will include all users
final usersNames = [] as List<String>
final groupsNames = [] as List<String>

// Get the users based on their usernames
def userManager = ComponentAccessor.userManager
def users = usersNames.collect { userName -> userManager.getUserByName(userName) }

worklogService.categorySummary(issue.key, worklogAttributes, startDate, endDate, users*.key, groupsNames)
```

