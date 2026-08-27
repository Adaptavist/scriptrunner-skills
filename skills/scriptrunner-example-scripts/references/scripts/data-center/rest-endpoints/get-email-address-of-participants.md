# Get Email Address of Participants

- Platform: data-center
- Feature: rest-endpoints
- Tags: issue, email, project
- Language: groovy
- Doc ID: example-dataCenter-get-email-address-of-the-participants-onPrem
- Source: https://examples.scriptrunner.io/scripts/get-email-address-of-the-participants-onPrem

## Overview

When the details of the participants of an issue on a Service Desk are required, a REST endpoint request is made to
retrieve the details.

## Example

In this example, only the email addresses of the participants who have been added to the ticket are included.
The information from this REST endpoint is invoked by the [ScriptRunner Console](https://library.adaptavist.com/entity/get-domain-name-from-participants-email)
which filters the domain names from the emails.

## Description

#### Overview

When the details of the participants of an issue on a Service Desk are required, a REST endpoint request is made to
retrieve the details.
                                
#### Example

In this example, only the email addresses of the participants who have been added to the ticket are included.
The information from this REST endpoint is invoked by the [ScriptRunner Console](https://library.adaptavist.com/entity/get-domain-name-from-participants-email)
which filters the domain names from the emails.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.json.JsonBuilder
import groovy.transform.BaseScript
import groovyx.net.http.HttpResponseDecorator
import groovyx.net.http.RESTClient
import javax.ws.rs.core.MultivaluedMap
import javax.ws.rs.core.Response

@BaseScript CustomEndpointDelegate delegate
getParticipantsEmail { MultivaluedMap queryParams ->
    def applicationProperties = ComponentAccessor.applicationProperties
    def issueKey = queryParams.getFirst('issueKey')
    def hostUrl = applicationProperties.getString('jira.baseurl')
    //Set the Username
    def username = '<USERNAME>'
    //Set the Password
    def password = '<PASSWORD>'

    final def headers = ['Authorization': "Basic ${"${username}:${password}".bytes.encodeBase64()}", 'Accept': 'application/json'] as Map

    def http = new RESTClient(hostUrl)
    http.setHeaders(headers)

    def resp = http.get(path: "/rest/servicedeskapi/request/${issueKey}/participant") as HttpResponseDecorator

    if (resp.status != 200) {
        log.warn 'Commander did not respond with 200'
    }

    def participantEmails = resp.data['values']['emailAddress']

    Response.ok(new JsonBuilder(participantEmails).toPrettyString()).build()
}
```

