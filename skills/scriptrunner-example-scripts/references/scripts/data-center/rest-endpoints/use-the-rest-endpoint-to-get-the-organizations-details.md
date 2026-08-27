# Use the REST endpoint to get the organization's details

- Platform: data-center
- Feature: rest-endpoints
- Tags: issue, fields
- Language: groovy
- Doc ID: example-dataCenter-use-the-rest-endpoint-to-get-list-of-organizations-onPrem
- Source: https://examples.scriptrunner.io/scripts/use-the-rest-endpoint-to-get-list-of-organizations-onPrem

## Overview

When the organization's details in a Service Desk are required, a REST endpoint request is made to
invoke the details.

## Example

This sample script lists all the organization names and IDs that have been configured for the Service Desk. Only the organization's name and ID are extracted.
The JSON response returned from the REST request can then be invoked as required. For example, you could use [Behaviour](https://library.adaptavist.com/entity/validate-the-organizations-field) 
to perform validation on the organization's name format.

## Description

#### Overview
When the organization's details in a Service Desk are required, a REST endpoint request is made to
invoke the details.
                                
#### Example
This sample script lists all the organization names and IDs that have been configured for the Service Desk. Only the organization's name and ID are extracted.
The JSON response returned from the REST request can then be invoked as required. For example, you could use [Behaviour](https://library.adaptavist.com/entity/validate-the-organizations-field) 
to perform validation on the organization's name format.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.json.JsonBuilder
import groovy.transform.BaseScript
import groovyx.net.http.HttpResponseDecorator
import groovyx.net.http.RESTClient
import javax.servlet.http.HttpServletRequest
import javax.ws.rs.core.MultivaluedMap
import javax.ws.rs.core.Response

@BaseScript CustomEndpointDelegate delegate

getOrganizations { MultivaluedMap queryParams, body, HttpServletRequest request ->
    def serviceDeskId = queryParams.getFirst('serviceDeskId')
    def applicationProperties = ComponentAccessor.applicationProperties

    final def baseUrl = applicationProperties.getString('jira.baseurl')
    final def username = 'admin'
    final def password = 'q'
    final def headers = ['Authorization': "Basic ${"${username}:${password}".bytes.encodeBase64()}",
                         'X-ExperimentalApi': 'opt-in', 'Accept': 'application/json'] as Map

    def http = new RESTClient(baseUrl)
    http.setHeaders(headers)

    def resp = http.get(path: "/rest/servicedeskapi/servicedesk/${serviceDeskId}/organization") as HttpResponseDecorator

    if (resp.status != 200) {
        log.warn 'Commander did not respond with 200 for retrieving project list'
    }

    def issueJson = resp.data as Map
    def values = issueJson.get('values') as Map
    def idList = values['id']
    def nameList = values['name']
    def result = [idList, nameList].transpose().collectEntries {
        def filter = it as List
        [filter[0], filter[1]]
    }
    Response.ok(new JsonBuilder(result).toPrettyString()).build()
}
```

