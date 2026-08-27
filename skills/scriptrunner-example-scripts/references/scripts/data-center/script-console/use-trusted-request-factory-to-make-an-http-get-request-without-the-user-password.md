# Use TrustedRequestFactory to make an HTTP GET request without the user password

- Platform: data-center
- Feature: script-console
- Tags: administer
- Language: groovy
- Doc ID: example-dataCenter-get-request-using-trusted-request-factory-onPrem
- Source: https://examples.scriptrunner.io/scripts/get-request-using-trusted-request-factory-onPrem

## Overview

Sometimes it can be useful to make a REST request to the currently running instance on behalf of the logged in user.

This method allows you to make the request, as the end user, without having access to the user's password. 

**NOTE** - the SSL certificate for your Jira host must be in the `truststore` for the JDK this Jira runs with.
Additionally if you use client SSL certificates (rare) it will not work without further configuration.

For these reasons and others it's normally better to use the Java API if possible - but this method can be used as a 
fallback when there is no public API.

For making a POST request see [this solution](https://library.adaptavist.com/entity/use-trustedrequestfactory-to-make-an-http-post-request-without-the-user-password).

## Description

#### Overview

Sometimes it can be useful to make a REST request to the currently running instance on behalf of the logged in user.

This method allows you to make the request, as the end user, without having access to the user's password. 

**NOTE** - the SSL certificate for your Jira host must be in the `truststore` for the JDK this Jira runs with.
Additionally if you use client SSL certificates (rare) it will not work without further configuration.

For these reasons and others it's normally better to use the Java API if possible - but this method can be used as a 
fallback when there is no public API.

For making a POST request see [this solution](https://library.adaptavist.com/entity/use-trustedrequestfactory-to-make-an-http-post-request-without-the-user-password).

## Script

```groovy
import com.atlassian.sal.api.ApplicationProperties
import com.atlassian.sal.api.UrlMode
import com.atlassian.sal.api.net.Request
import com.atlassian.sal.api.net.TrustedRequestFactory
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import groovy.json.JsonSlurper
import groovyx.net.http.URIBuilder

@PluginModule
TrustedRequestFactory trustedRequestFactory

@PluginModule
ApplicationProperties applicationProperties

def url = applicationProperties.getBaseUrl(UrlMode.CANONICAL) + '/rest/api/2/myself'
def request = trustedRequestFactory.createTrustedRequest(Request.MethodType.GET, url)

def host = new URIBuilder(url).host
request.addTrustedTokenAuthentication(host)

def responseBody = request.execute()

def currentUser = new JsonSlurper().parseText(responseBody) as Map

currentUser

/*
   responseBody is a JSON string that looks like:

  {
    "self": "http://localhost:8080/jira/rest/api/2/user?username=admin",
    "key": "admin",
    "name": "admin",
    "emailAddress": "admin@admin.com",
    "avatarUrls": {
      "48x48": "https://www.gravatar.com/avatar/64e1b8d34f425d19e1ee2ea7236d3028?d=mm&s=48",
      "24x24": "https://www.gravatar.com/avatar/64e1b8d34f425d19e1ee2ea7236d3028?d=mm&s=24",
      "16x16": "https://www.gravatar.com/avatar/64e1b8d34f425d19e1ee2ea7236d3028?d=mm&s=16",
      "32x32": "https://www.gravatar.com/avatar/64e1b8d34f425d19e1ee2ea7236d3028?d=mm&s=32"
    },
    "displayName": "Mr Admin",
    "active": true,
    "timeZone": "Europe/London",
    "locale": "en_GB",
    "groups": {
      "size": 4,
      "items": [
      ]
    },
    "applicationRoles": {
      "size": 2,
      "items": [
      ]
    },
    "expand": "groups,applicationRoles"
  }
*/
```

