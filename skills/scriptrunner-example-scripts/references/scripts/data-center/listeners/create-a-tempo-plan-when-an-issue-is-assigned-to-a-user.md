# Create a Tempo Plan when an Issue is Assigned to a User

- Platform: data-center
- Feature: listeners
- Tags: automate, fields
- Language: groovy
- Doc ID: example-dataCenter-create-tempo-planning-information-when-issue-is-assigned-onPrem
- Source: https://examples.scriptrunner.io/scripts/create-tempo-planning-information-when-issue-is-assigned-onPrem

## Overview

This script allows you to create Tempo plans for a Jira issue when this issue has been assigned.
A Tempo plan is created for each day between the current date, and the due date. The remaining estimate is used as the
planned time over the newly created plans. This script uses the Tempo REST Endpoint. The authenticated user must have permission to view the plans for users; otherwise, the API
does not return plans.
Read more about permissions in Tempo in this [article](https://tempo-io.atlassian.net/wiki/spaces/THC/pages/293863570/Editing+Team+Permissions+-+Tempo+Server).

## Example

As a project manager, I want to create all plans automatically when an issue is assigned to a user saving me the time
of manually setting up plans for each issue in my project. I can use this script to automate the creation of these plans.

## Good to Know

* This script requires Tempo Planner by Tempo for Jira.
* Set the script listener for the `Issue Assigned` event, so once a Tempo item is created, updated or deleted, the
  script is executed.

## Script

```groovy
import com.atlassian.sal.api.ApplicationProperties
import com.atlassian.sal.api.UrlMode
import com.atlassian.sal.api.net.Request
import com.atlassian.sal.api.net.TrustedRequestFactory
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import groovy.json.JsonOutput
import groovyx.net.http.URIBuilder

import java.time.LocalDate
import java.time.format.DateTimeFormatter

@WithPlugin('com.tempoplugin.tempo-plan-core')

@PluginModule
ApplicationProperties applicationProperties

@PluginModule
TrustedRequestFactory trustedRequestFactory

// Default start time
final startTime = '09:00'

// Weekends and holidays are not included by default. If a plan needs to be created on weekends and holidays, set this to "true"
final includeNonWorkingDays = false

final today = LocalDate.now()

def issue = event.issue
def endDate = issue.dueDate?.toLocalDateTime()?.toLocalDate()

// Do nothing if the issue has been unassigned
if (!issue.assignee) {
    return
}

if (!(issue.estimate && endDate)) {
    log.error('Issue requires both an estimate and a due date. Plan not created')
    return
}

def url = applicationProperties.getBaseUrl(UrlMode.CANONICAL) + '/rest/tempo-planning/1/plan'
def request = trustedRequestFactory.createTrustedRequest(Request.MethodType.POST, url)

def host = new URIBuilder(url).host
request.addTrustedTokenAuthentication(host)
request.setRequestBody(JsonOutput.toJson([
    assigneeKey          : 'JIRAUSER10000',
    assigneeType         : 'USER',
    day                  : DateTimeFormatter.ISO_LOCAL_DATE.format(today),
    end                  : DateTimeFormatter.ISO_LOCAL_DATE.format(endDate),
    includeNonWorkingDays: includeNonWorkingDays,
    planItemId           : issue.id,
    planItemType         : 'ISSUE',
    secondsPerDay        : issue.estimate,
    start                : DateTimeFormatter.ISO_LOCAL_DATE.format(today),
    startTime            : startTime
]), 'application/json')

request.execute()
```

