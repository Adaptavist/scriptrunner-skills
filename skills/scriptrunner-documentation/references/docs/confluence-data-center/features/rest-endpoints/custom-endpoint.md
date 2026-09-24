# Custom Endpoint

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > REST Endpoints
- Doc ID: doc-sr4c-f2e4286c-6534-42b9-867d-5fd3bd29a3fc-66af0b32e65d008e
- Source: https://docs.adaptavist.com/sr4c/latest/features#rest-endpoints--en#custom-endpoint--en

Instructions for creating a custom REST endpoint.

Follow this task to create a custom REST endpoint:

1.  Select the Cog icon, and then select General Configuration.
2.  Scroll to the _ScriptRunner_ section in the left-hand navigation, and then select REST Endpoints.
3.  Select Add a New Item, and then select the _Custom Endpoint_

Use the following REST endpoint example to examine the different parts of the script:

```
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.json.JsonBuilder
import groovy.transform.BaseScript

import javax.ws.rs.core.MultivaluedMap
import javax.ws.rs.core.Response

@BaseScript CustomEndpointDelegate delegate // <1>

doSomething( // <2>
    httpMethod: "GET", groups: ["confluence-administrators"] // <3>
) { MultivaluedMap queryParams, String body -> // <4>
    Response.ok(new JsonBuilder([abc: 42]).toString()).build() // <5>
}
```

Line 8: This line makes methods in your script recognizable as endpoints, which is required.

Line 10: The name of the REST endpoint, which forms part of the URL. In this example, it is `doSomething`.

Line 11: This line configures the endpoint and determines which HTTP _verb_ to handle and what group to allow.

Line 12: This line contains parameters that are provided to your method body.

Line 13: The body of your method, where you will return a [javax.ws.rs.core.Response](http://docs.oracle.com/javaee/7/api/javax/ws/rs/core/Response.html) object.

You can add this REST endpoint to the list of configured endpoints as an inline script or by copying into a file and adding that file as a script file. To test this endpoint, type this text into your browser:

Note: Notice the last part of the text is the name `doSomething`.

```
<confluence_base_url>/rest/scriptrunner/latest/custom/doSomething
```

Alternatively, you could type this into the command line utility:

Note:

-   Again, notice the name `doSomething` in each command.
-   `admin:admin` corresponds to a username and password.

```
curl -u admin:admin <confluence_base_url>/rest/scriptrunner/latest/custom/doSomething
{"abc":42}
```

If you are using a file, you can change the response. You may need to select the Scan button on the _REST Endpoints_ page before calls to the endpoint return the new response. See the section on [Script Root Scanning](https://docs.adaptavist.com/sr4c/latest/features/rest-endpoints#rest-endpoints--en__script-root-scanning).

## Configuration

The general format of a method defining a REST endpoint is:

```
methodName (Map configuration, Closure closure)
```

For the configuration, only the following options are supported:

| Key | Value |
| --- | --- |
| httpMethod | Choose one of: `GET`, `POST`, `PUT`, `DELETE` |
| groups | One or more groups. If the requesting user is in any of the groups, the request is allowed. |

Note: Either or both of these can be omitted. If you omit the groups attribute, the endpoint will be available to unauthenticated users.

Use these parameters for the closure:

| Parameter | Type | Description |
| --- | --- | --- |
| [MultivaluedMap](http://docs.oracle.com/javaee/7/api/javax/ws/rs/core/MultivaluedMap.html) | queryParams | This corresponds to the URL parameters. |
| `String` | Content | This is the body of the request for `httpMethod` ( `POST`, `PUT`, etc.). |
| [HttpServletRequest](http://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletRequest.html) | Request | This returns the requesting user for the instance. |

You can use any of these forms for your closure:

```
something() { MultivaluedMap queryParams ->
something() { MultivaluedMap queryParams, String body ->
something() { MultivaluedMap queryParams, String body, HttpServletRequest request ->
```

The contents of your closure depends on what you need access to.

### Access Request URL

Sometimes you may need to use the URL path after your method name. In the following example, you want to retrieve `/foo/bar`:

```
<base_url>/rest/scriptrunner/latest/custom/doSomething/foo/bar
```

Use the 3-parameter form of the closure definition and call the `getAdditionalPath` method from the base class.

For example:

```
doSomething() { MultivaluedMap queryParams, String body, HttpServletRequest request ->
 
 def extraPath = getAdditionalPath(request)
 // extraPath will contain /foo/bar when called as above
}
```

Warning: In previous versions, an `extraPath` variable was used in the scripts. However, this is not thread-safe. Use the method above.
