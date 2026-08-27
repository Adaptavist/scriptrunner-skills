# Get the Name of the Workflow

- Platform: data-center
- Feature: rest-endpoints
- Tags: workflow
- Language: groovy
- Doc ID: example-dataCenter-get-workflow-name-using-rest-onPrem
- Source: https://examples.scriptrunner.io/scripts/get-workflow-name-using-rest-onPrem

## Overview

When the details of a project's workflow are required, a REST Endpoint request is made to retrieve the details.

## Example

In this example, only the workflow's name is retrieved. The information from this REST Endpoint is then invoked by the [Behaviour](https://library.adaptavist.com/entity/set-the-list-value-according-to-the-workflow-name)
to identify which workflow the project belongs to and to update a Single Select List accordingly.

## Description

#### Overview
When the details of a project's workflow are required, a REST Endpoint request is made to retrieve the details.

#### Example
In this example, only the workflow's name is retrieved. The information from this REST Endpoint is then invoked by the [Behaviour](https://library.adaptavist.com/entity/set-the-list-value-according-to-the-workflow-name)
to identify which workflow the project belongs to and to update a Single Select List accordingly.

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
getWorkflowNames { MultivaluedMap queryParams ->
    def applicationProperties = ComponentAccessor.applicationProperties

    final def hostUrl = applicationProperties.getString('jira.baseurl')

    final def projectKey = queryParams.getFirst('projectKey')

    final def username = '<USERNAME>'
    final def password = '<PASSWORD>'

    final def headers = ['Authorization': "Basic ${"${username}:${password}".bytes.encodeBase64()}", 'Accept': 'application/json'] as Map

    def http = new RESTClient(hostUrl)
    http.setHeaders(headers)

    def resp = http.get(path: "/rest/projectconfig/1/workflowscheme/${projectKey}") as HttpResponseDecorator

    if (resp.status != 200) {
        log.warn 'Commander did not respond with 200'
    }

    def workflowName = resp.data['mappings']['name'] as List

    Response.ok(new JsonBuilder(workflowName.first()).toPrettyString()).build()
}
```

