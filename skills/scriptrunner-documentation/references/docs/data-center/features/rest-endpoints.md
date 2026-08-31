# REST Endpoints

- Platform: data-center
- Space: SR4JS
- Hierarchy: features
- Doc ID: doc-sr4js-443374222
- Source: https://docs.adaptavist.com/sr4js/latest/features/rest-endpoints

![](/sr4js/files/latest/443374222/443374221/1/1759243094000/sr-icon-cloud.png)

**Migrating to Jira Cloud? This feature is not available in Cloud as Jira Cloud does not offer custom endpoints. Check out our** **[Cloud Feature Parity documentation](https://docs.adaptavist.com/display/_PK/SR4JC/feature-parity#rest-end-points)** **for more details.**

## What are REST Endpoints?

Use Groovy scripts to define REST endpoints allowing you to integrate with external systems and exchange data. An endpoint is a URL that runs a script. ScriptRunner _REST Endpoints_ allows you to create custom endpoints to suit your needs. 

## How to use REST Endpoints

REST endpoints are configured programmatically. You can define REST endpoints in ScriptRunner to:

-   Use in dashboard gadgets.
    
-   Receive information from external systems.
    
-   Plug gaps in the official REST API.
    
-   Allow all your XHRs to proxy through to other systems.
    

For example, you want to show a custom popup [dialog](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-item#dialogs) to your users if they click a button in your Jira instance. To do this, you could create a rest endpoint that returns HTML to build the custom dialog and then use that with a custom web item to display the dialog to your users when they click a custom button within your Jira instance.

Alternatively, you may want to create a REST endpoint to receive information from an external system. For example, you have an external system you use to log all new cars in your showroom. You want to be able to call the endpoint and have ScriptRunner add a new custom field option for each new car added to the external system. 

The REST Endpoint page in ScriptRunner shows a list of all available endpoints, here you can edit, disable, and delete previously configured endpoints and create new ones.

## Before you Start

![](/sr4js/files/latest/443374222/443374215/1/1759243094000/Copy+of+sr-icon-mortar-board.png)

See our Introduction to Atlassian Java API module to learn about using the Java API documentation.

  

![](/sr4js/files/latest/443374222/443374214/1/1759243094000/sr-icon-brain-cog-pink.png)

Creating your own REST endpoint can be tricky. Before starting make sure you understand what the REST API is and how to use it.

[Java API Training](https://docs.adaptavist.com/sr4js/latest/training/course-introduction-to-scripting-in-scriptrunner-for-jira-data-center-server/2-3-video-introduction-to-atlassian-java-api)

  

[shortcut REST API Handbook](https://developer.wordpress.org/rest-api/)

  

## Adding a REST Endpoint

Use the following REST endpoint example to examine the different parts of the script:

This script is compatible with ScriptRunner version 10.x and above.

```
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.json.JsonBuilder
import groovy.transform.BaseScript

import jakarta.ws.rs.core.MultivaluedMap
import jakarta.ws.rs.core.Response

@BaseScript CustomEndpointDelegate delegate 

doSomething( 
    httpMethod: "GET", groups: ["jira-administrators"] 
) { MultivaluedMap queryParams, String body -> 
    return Response.ok(new JsonBuilder([abc: 42]).toString()).build() 
}
```

**Line 8:** This line makes methods in your script recognizable as endpoints, which is required.

**Line 10:** The name of the REST endpoint, which forms part of the URL. In this example, it is `doSomething`.

**Line 11:** This line configures the endpoint and determines which HTTP _verb_ to handle and what groups to allow.

**Line 12:** This line contains parameters that are provided to your method body.

**Line 13:** The body of your method, where you will return a [`jakarta.ws.rs.core.Response`](https://jakarta.ee/specifications/restful-ws/3.0/apidocs/jakarta/ws/rs/core/response) object.

This script is compatible with ScriptRunner versions 8.x to 9.x.

```
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.json.JsonBuilder
import groovy.transform.BaseScript

import javax.ws.rs.core.MultivaluedMap
import javax.ws.rs.core.Response

@BaseScript CustomEndpointDelegate delegate 

doSomething( 
    httpMethod: "GET", groups: ["jira-administrators"] 
) { MultivaluedMap queryParams, String body -> 
    return Response.ok(new JsonBuilder([abc: 42]).toString()).build() 
}
```

**Line 8:** This line makes methods in your script recognizable as endpoints, which is required.

**Line 10:** The name of the REST endpoint, which forms part of the URL. In this example, it is `doSomething`.

**Line 11:** This line configures the endpoint and determines which HTTP _verb_ to handle and what groups to allow.

**Line 12:** This line contains parameters that are provided to your method body.

**Line 13:** The body of your method, where you will return a [`javax.ws.rs.core.Response`](http://docs.oracle.com/javaee/7/api/javax/ws/rs/core/Response.html) object.

  

You can add this REST endpoint to the list of configured endpoints as an inline script or by copying into a file and adding that file as a script file. To test this endpoint, type this text into your browser:

```
<jira_base_url>/rest/scriptrunner/latest/custom/doSomething
```

Notice the last part of the text is the name `doSomething` which corresponds with the name of the closure.

Alternatively, you could type this into the command line utility:

-   Again, notice the name `doSomething` in each command.
    
-   `admin:admin` corresponds to a username and password.
    

```
curl -u admin:admin <jira_base_url>/rest/scriptrunner/latest/custom/doSomething
{"abc":42}
```

If you are using a file, you can change the response. You may need to select the **Scan** button on the _REST Endpoints_ page before calls to the endpoint return the new response. See the section on Script Root Scanning below.

## Configuration

The general format of a method defining a REST endpoint is:

```
methodName (Map configuration, Closure closure)
```

For the configuration, only the following options are supported:

 

Key

Value

httpMethod

Choose one of:  `GET`,  `POST`,  `PUT`,  `DELETE`

groups

One or more groups. If the requesting user is in any of the groups, the request is allowed.

Either or both of these can be omitted. If you omit the groups attribute, the endpoint will be available to unauthenticated users.

Use these parameters for the closure:

  

Parameter

Type

Description

[`MultivaluedMap`](http://docs.oracle.com/javaee/7/api/javax/ws/rs/core/MultivaluedMap.html)

queryParams

This corresponds to the URL parameters.

`String`

Content

This is the body of the request for  `httpMethod`  (`POST`,  `PUT`, etc.).

[`HttpServletRequest`](http://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletRequest.html)

Request

This returns the requesting user for the instance.

You can use any of these forms for your closure:

```
something() { MultivaluedMap queryParams ->
something() { MultivaluedMap queryParams, String body ->
something() { MultivaluedMap queryParams, String body, HttpServletRequest request ->

something() { MultivaluedMap queryParams, HttpServletRequest request->
```

The contents of your closure depends on what you need access to.

Where the closure signature contains the `body` variable, the request input stream is read before your closure is executed, and the read data is passed to the closure in the `body`.

The request input stream can only be read once. If you want to avoid the request input stream from being read before your code executes, for instance if you are [reading file uploads](https://library.adaptavist.com/entity/file-upload-to-rest-endpoint), use the final form of the closure: 

```
something() { MultivaluedMap queryParams, HttpServletRequest request->
```

### Access Request URL

Sometimes you may need to use the URL path after your method name. In the following example, you want to retrieve  `/foo/bar`:

```
<base_url>/rest/scriptrunner/latest/custom/doSomething/foo/bar
```

Use the 3-parameter form of the closure definition and call the  `getAdditionalPath`  method from the base class.

For example:

```
doSomething() { MultivaluedMap queryParams, String body, HttpServletRequest request ->

    def extraPath = getAdditionalPath(request)
    // extraPath will contain /foo/bar when called as above
}
```

In previous versions, an  `extraPath`  variable was used in the scripts. However, this is not thread-safe. Use the method above.

## Script Root Scanning

As well as manually adding scripts or files via the UI, ScriptRunner scans your script roots for scripts that contain REST endpoints and automatically register them. To enable the scanning, set the property  `plugin.rest.scripts.package`  to a comma-delimited list of packages. For example:

```
-Dplugin.rest.scripts.package=com.acme.rest
```

On plugin enablement, scripts/classes under this package are scanned and registered if the scripts contain the following line:

```
@BaseScript CustomEndpointDelegate delegate
```

### Package Declarations and File Paths

Your REST Endpoint's code must begin with a package declaration that matches the package configured in the system property. Likewise, the file path in your script root must match that package declaration as well.

For example, if your `plugin.rest.scripts.package`  system property is `com.acme.rest` and you want to create a custom REST Endpoint with a file named MyCustomRestEndpoint.groovy, then:

1.  The first line of the MyCustomRestEndpoint.groovy file should be `package com.acme.rest` .
2.  The file should have a line like `@BaseScript CustomEndpointDelegate delegate`  as normal.
3.  The path to the file within your script root should be com/acme/rest/MyCustomRestEndpoint.groovy .

Subpackages should be okay, so long as the sub-directory matches the package. For example, you might put the file in `com/acme/rest/widgets` so long as your package declaration is `com.acme.rest.widgets` in the top line of the file.

If you are receiving unexpected HTTP 500 errors when trying to access your REST Endpoints that were added through Script Root Scanning, check your package declaration. Case sensitivity may be an issue as well, depending on your filesystem.
