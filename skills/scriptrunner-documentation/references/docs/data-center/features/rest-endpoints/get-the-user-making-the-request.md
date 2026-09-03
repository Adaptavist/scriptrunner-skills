# Get the User Making the Request

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > rest-endpoints
- Doc ID: doc-sr4js-443374257
- Source: https://docs.adaptavist.com/sr4js/latest/features/rest-endpoints/get-the-user-making-the-request

Use `com.atlassian.sal.api.user.UserManager` to get the current user from the http request.

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
