# Add Tempo Planning Information

- Platform: data-center
- Feature: listeners
- Tags: automate, fields
- Language: groovy
- Doc ID: example-dataCenter-add-tempo-planning-information-as-jira-custom-field-onPrem
- Source: https://examples.scriptrunner.io/scripts/add-tempo-planning-information-as-jira-custom-field-onPrem

## Overview

Gather all existing Tempo plans for a Jira issue (defined by its ID from Jira, and interpreted as the planItemId in
Tempo) for a given period (start date to end date) and get total time planned, using the Tempo REST API.
This script uses the Tempo REST Endpoint with basic authentication in the headers of the request.
The authenticated user must have permission to view the plans for users; otherwise, the API does not return plans.
Read more about permissions in Tempo in this [article](https://tempo-io.atlassian.net/wiki/spaces/THC/pages/293863570/Editing+Team+Permissions+-+Tempo+Server).

## Example

As a project manager, I want to see the total time planned for projects in my next sprint. I need to know if the
planned work is greater than my team capacity. I can use this script to see the total planned time for selected
projects over the two week sprint period.

## Good to Know

* This script requires [Tempo Planner by Tempo for Jira][Tempo Planner](https://marketplace.atlassian.com/apps/1211881/tempo-planner).
* API request credentials are stored as user properties. This property is named as `basicAuthCreds` and it contains
  user and password in the following format: `<user>:<password>`.
* For an example of setting/getting user properties, see [Library documentation](https://library.adaptavist.com/entity/jira-user-properties).
* Set the script listener for the `AllocationEvent` Tempo event, so once a Tempo item is created, updated or deleted, the script is
  executed.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.config.properties.APKeys
import com.atlassian.jira.event.type.EventDispatchOption
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import com.tempoplugin.planner.api.event.AllocationEvent
import groovyx.net.http.ContentType
import groovyx.net.http.HttpResponseDecorator
import groovyx.net.http.RESTClient
import groovyx.net.http.EncoderRegistry

import java.time.Duration
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.util.concurrent.TimeUnit

@WithPlugin('com.tempoplugin.tempo-plan-core')

// The user-defined property where the user name and password are stored into
final userPropertyKey = 'jira.meta.basicAuthCreds'
final plannedTimeField = 'Planned Time'

/**
 * Helper method to print Duration time as hours, minutes and seconds.
 * @param duration Time to be formatted.
 * @return Duration formatted as String.
 */
String prettyPrintDuration(Duration duration) {
    String.format("%s h ${duration.toMinutes() == 0 ? '%s m' : ''} ${duration.seconds == 0 ? '%s s' : ''}",
        duration.toHours(),
        duration.toMinutes() - TimeUnit.HOURS.toMinutes(duration.toHours()),
        duration.seconds - TimeUnit.MINUTES.toSeconds(duration.toMinutes())).trim()
}

def loggedInUser = ComponentAccessor.jiraAuthenticationContext.loggedInUser
def credentials = ComponentAccessor.userPropertyManager.getPropertySet(loggedInUser).getString(userPropertyKey)
def baseUrl = ComponentAccessor.applicationProperties.getString(APKeys.JIRA_BASEURL)

def client = new RESTClient(baseUrl)
client.encoderRegistry = new EncoderRegistry( charset: 'UTF-8' )
client.setHeaders([
    Authorization      : "Basic ${credentials.bytes.encodeBase64()}",
    "X-Atlassian-Token": "no-check"
])

client.handler.failure = { HttpResponseDecorator response ->
    log.error response.entity.content.text
    []
}
client.handler.success = { resp, reader ->
    [response: resp, reader: reader]
}

def today = LocalDate.now()
def todayPlus90Days = today.plusDays(90)

def event = event as AllocationEvent

def allocationResult = (client.get(
    path: '/rest/tempo-planning/1/allocation',
    query: [
        planItemId  : event.allocation.planItemId,
        planItemType: 'ISSUE',
        assigneeType: 'user',
        startDate   : DateTimeFormatter.ISO_LOCAL_DATE.format(today),
        endDate     : DateTimeFormatter.ISO_LOCAL_DATE.format(today)
    ]
) as Map).reader as List<Map>

if (!allocationResult) {
    log.error "There is no allocation result related with the plan"
    return
}

def taskKey = (allocationResult.first()?.planItem as Map)?.key

if (!taskKey) {
    log.error "There is no issue related with the plan"
    return
}

def planSearchResult = (client.post(
    path: '/rest/tempo-planning/1/plan/search',
    contentType: ContentType.JSON,
    body: [
        from   : DateTimeFormatter.ISO_LOCAL_DATE.format(today),
        to     : DateTimeFormatter.ISO_LOCAL_DATE.format(todayPlus90Days),
        taskKey: [taskKey]
    ]
) as Map).reader as List<Map>

if (!planSearchResult) {
    log.error "There is no time planned related with the plan"
    return
}

def totalSeconds = planSearchResult.sum { (it as Map).timePlannedSeconds }
def duration = Duration.ofSeconds(totalSeconds as Long)
def plannedTime = prettyPrintDuration(duration)

def cfManager = ComponentAccessor.customFieldManager
def plannedTimeCf = cfManager.getCustomFieldObjectsByName(plannedTimeField).first()
def issueManager = ComponentAccessor.issueManager
def issue = issueManager.getIssueObject(taskKey as String)

issue.setCustomFieldValue(plannedTimeCf, plannedTime)
issueManager.updateIssue(loggedInUser, issue, EventDispatchOption.DO_NOT_DISPATCH, false)
```

