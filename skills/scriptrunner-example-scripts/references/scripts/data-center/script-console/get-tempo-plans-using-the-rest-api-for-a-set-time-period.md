# Get Tempo Plans Using the REST API for a Set Time Period

- Platform: data-center
- Feature: script-console
- Tags: automate, issue
- Language: groovy
- Doc ID: example-dataCenter-get-tempo-plans-onPrem
- Source: https://examples.scriptrunner.io/scripts/get-tempo-plans-onPrem

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

* This script requires Tempo Planner by Tempo for Jira.
* API request credentials are stored as user properties. This property is named as `basicAuthCreds` and it contains
  user and password in the following format: `<user>:<password>`.
* For an example of setting/getting user properties, see [Library documentation](https://library.adaptavist.com/entity/jira-user-properties)

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.config.properties.APKeys
import groovyx.net.http.ContentType
import groovyx.net.http.EncoderRegistry
import groovyx.net.http.HttpResponseDecorator
import groovyx.net.http.RESTClient

import java.time.LocalDate
import java.time.format.DateTimeFormatter

// The user-defined property where the user name and password are stored into
final userPropertyKey = "jira.meta.basicAuthCreds"
// ID of the item which the plan is for
final planItemId = 1
// By default, startDate and endDate is set to today date
final today = DateTimeFormatter.ISO_LOCAL_DATE.format(LocalDate.now())

def loggedInUser = ComponentAccessor.jiraAuthenticationContext.loggedInUser
def credentials = ComponentAccessor.userPropertyManager.getPropertySet(loggedInUser).getString(userPropertyKey)
def baseUrl = ComponentAccessor.applicationProperties.getString(APKeys.JIRA_BASEURL)

def client = new RESTClient(baseUrl)
client.encoderRegistry = new EncoderRegistry(charset: 'UTF-8')
client.setHeaders([
    Authorization      : "Basic ${credentials.bytes.encodeBase64()}",
    "X-Atlassian-Token": "no-check"
])

client.handler.success = { resp, reader ->
    def plannedTime = (reader as List<Map>).'seconds'.sum() ?: 0
    log.debug "Total planned time: $plannedTime"
    plannedTime
}

client.handler.failure = { HttpResponseDecorator response ->
    log.error response.entity.content.text
}

client.get(
    path: '/rest/tempo-planning/1/allocation',
    contentType: ContentType.JSON,
    query: [
        planItemId  : planItemId,
        planItemType: 'ISSUE',
        assigneeType: 'user',
        startDate   : today,
        endDate     : today
    ]
)
```

