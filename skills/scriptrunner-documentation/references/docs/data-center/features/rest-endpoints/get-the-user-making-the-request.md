# Get the User Making the Request

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > REST endpoints
- Doc ID: doc-sr4js-922b47b2-4108-417c-9038-a74490549e7d-2456b7355a401936
- Source: https://docs.adaptavist.com/sr4js/latest/features#rest-endpoints--en#get-the-user-making-the-request--en

Use `com.atlassian.sal.api.user.UserManager` to get the current user from the http request.

## ScriptRunner 10.x +

This script is compatible with ScriptRunner version 10.x and above.

```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.sal.api.user.UserManager
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.json.JsonBuilder
import groovy.transform.BaseScript

import jakarta.servlet.http.HttpServletRequest
import jakarta.ws.rs.core.Response

@BaseScript CustomEndpointDelegate delegate

getCurrentUser { queryParams, body, HttpServletRequest request ->
    def userManager = ComponentAccessor.getOSGiComponentInstanceOfType(UserManager)
    def userProfile = userManager.getRemoteUser(request)
    Response.ok(new JsonBuilder([currentUser: userProfile?.username]).toString()).build()
}
```

## ScriptRunner 9.x

This script is compatible with ScriptRunner version 9.x.

```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.sal.api.user.UserManager
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.json.JsonBuilder
import groovy.transform.BaseScript

import javax.servlet.http.HttpServletRequest
import javax.ws.rs.core.Response

@BaseScript CustomEndpointDelegate delegate

getCurrentUser { queryParams, body, HttpServletRequest request ->
    def userManager = ComponentAccessor.getOSGiComponentInstanceOfType(UserManager)
    def userProfile = userManager.getRemoteUser(request)
    Response.ok(new JsonBuilder([currentUser: userProfile?.username]).toString()).build()
}
```

## ScriptRunner 8.x

This script is compatible with ScriptRunner version 8.x.

```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.sal.api.user.UserManager
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.json.JsonBuilder
import groovy.transform.BaseScript

import javax.servlet.http.HttpServletRequest
import javax.ws.rs.core.Response

@BaseScript CustomEndpointDelegate delegate

getCurrentUser { queryParams, body, HttpServletRequest request ->
    def userManager = ComponentAccessor.getOSGiComponentInstanceOfType(UserManager)
    def userProfile = userManager.getRemoteUser(request)
    return Response.ok(new JsonBuilder([currentUser: userProfile?.username]).toString()).build()
}
```
