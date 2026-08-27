# Use TrustedRequestFactory to make an HTTP POST request without the user password

- Platform: data-center
- Feature: script-console
- Tags: administer
- Language: groovy
- Doc ID: example-dataCenter-post-request-using-trusted-request-factory-onPrem
- Source: https://examples.scriptrunner.io/scripts/post-request-using-trusted-request-factory-onPrem

## Overview

Sometimes it can be useful to make a REST request to the currently running instance on behalf of the logged in user.

This method allows you to make the request, as the end user, without having access to the user's password. 

**NOTE** - the SSL certificate for your Jira host must be in the `truststore` for the JDK this Jira runs with.
Additionally if you use client SSL certificates (rare) it will not work without further configuration.

For these reasons and others it's normally better to use the Java API if possible - but this method can be used as a 
fallback when there is no public API.

For making a GET request see [this solution](https://library.adaptavist.com/entity/use-trustedrequestfactory-to-make-an-http-get-request-without-the-user-password).

## Description

#### Overview

Sometimes it can be useful to make a REST request to the currently running instance on behalf of the logged in user.

This method allows you to make the request, as the end user, without having access to the user's password. 

**NOTE** - the SSL certificate for your Jira host must be in the `truststore` for the JDK this Jira runs with.
Additionally if you use client SSL certificates (rare) it will not work without further configuration.

For these reasons and others it's normally better to use the Java API if possible - but this method can be used as a 
fallback when there is no public API.

For making a GET request see [this solution](https://library.adaptavist.com/entity/use-trustedrequestfactory-to-make-an-http-get-request-without-the-user-password).

## Script

```groovy
import com.atlassian.jira.config.IssueTypeManager
import com.atlassian.jira.project.ProjectManager
import com.atlassian.sal.api.ApplicationProperties
import com.atlassian.sal.api.UrlMode
import com.atlassian.sal.api.net.Request
import com.atlassian.sal.api.net.TrustedRequestFactory
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import groovy.json.JsonOutput
import groovy.json.JsonSlurper
import groovyx.net.http.URIBuilder

@PluginModule
TrustedRequestFactory trustedRequestFactory

@PluginModule
ApplicationProperties applicationProperties

@PluginModule
ProjectManager projectManager

@PluginModule
IssueTypeManager issueTypeManager

def project = projectManager.getProjectByCurrentKey('JRA')
def issueType = issueTypeManager.issueTypes.find { it.name == 'Bug' }

def url = applicationProperties.getBaseUrl(UrlMode.CANONICAL) + '/rest/api/2/issue'
def request = trustedRequestFactory.createTrustedRequest(Request.MethodType.POST, url)

def host = new URIBuilder(url).host
request.addTrustedTokenAuthentication(host)
request.setRequestBody(JsonOutput.toJson([
    fields: [
        project: [
            id: project.id
        ],
        issuetype: [
            id: issueType.id
        ],
        summary: 'build me a rocket',
    ]
]), 'application/json')

def responseBody = request.execute()

def issueAsMap = new JsonSlurper().parseText(responseBody) as Map

issueAsMap

/*
   responseBody is a JSON string that looks like:

  {
    "id": "10030",
    "key": "JRA-8",
    "self": "http://localhost:8080/jira/rest/api/2/issue/10030"
  }

 */
```

