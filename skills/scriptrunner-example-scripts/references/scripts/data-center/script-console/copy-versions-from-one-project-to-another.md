# Copy Versions from one Project to Another

- Platform: data-center
- Feature: script-console
- Tags: automate
- Language: groovy
- Doc ID: example-dataCenter-copy-project-versions-onPrem
- Source: https://examples.scriptrunner.io/scripts/copy-project-versions-onPrem

## Overview

Bulk copy all versions from a source project to a destination project.

## Example

As a project manager, I want to apply the same versions to different projects.
I can copy all versions existing in a source project to a destination project.

## Good to Know

* Versions with the same name should not already exist in the destination project.
* For Jira Server/DC, only the REST endpoint invocation code is provided. You also need to use
  the [ScriptRunner Console](https://library.adaptavist.com/entity/invoke-rest-endpoint-and-copy-versions) example to invoke the REST endpoint
  and update the versions in the respective project(s).

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
getVersions { MultivaluedMap queryParams ->
    def applicationProperties = ComponentAccessor.applicationProperties
    def hostUrl = applicationProperties.getString('jira.baseurl')
    //Specify the Username
    def username = '<USERNAME>'
    //Specify the Password
    def password = '<PASSWORD>'
    //Specify the Project Key
    def projectKey = '<PROJECT_KEY>'

    final def headers = ['Authorization': "Basic ${"${username}:${password}".bytes.encodeBase64()}", 'Accept': 'application/json'] as Map

    def http = new RESTClient(hostUrl)
    http.setHeaders(headers)

    def resp = http.get(path: "/rest/api/2/project/${projectKey}/versions") as HttpResponseDecorator

    if (resp.status != 200) {
        log.warn 'Commander did not respond with 200'
    }

    def row = resp.data['name']

    Response.ok(new JsonBuilder(row).toPrettyString()).build()
}
```

