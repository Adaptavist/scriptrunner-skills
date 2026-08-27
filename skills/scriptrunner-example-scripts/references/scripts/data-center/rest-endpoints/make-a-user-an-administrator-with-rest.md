# Make a User an Administrator with REST

- Platform: data-center
- Feature: rest-endpoints
- Tags: extend, issue
- Language: groovy
- Doc ID: example-dataCenter-make-user-admin-rest-onPrem
- Source: https://examples.scriptrunner.io/scripts/make-user-admin-rest-onPrem

## Overview

Using REST endpoints, this script adds the specified user as a member of the jira-administators group, giving them administrator permissions.
The API is called using the following URL:
jirabaseurl/rest/scriptrunner/latest/custom/addUserToJiraAdminsuserName?userName=thisuser

Will return different code depending the on the results:
- Code 200 indicates a successful result.
- Code 400 indicates a bad request
- Code 500 indicates the script has failed.

## Description

#### Overview

Using REST endpoints, this script adds the specified user as a member of the jira-administators group, giving them administrator permissions.
The API is called using the following URL:
jirabaseurl/rest/scriptrunner/latest/custom/addUserToJiraAdminsuserName?userName=thisuser

Will return different code depending the on the results:
- Code 200 indicates a successful result.
- Code 400 indicates a bad request
- Code 500 indicates the script has failed.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.json.JsonBuilder
import groovy.transform.BaseScript

import javax.servlet.http.HttpServletRequest
import javax.ws.rs.core.Response

@BaseScript CustomEndpointDelegate delegate

addUserToJiraAdmins(httpMethod: "GET", groups: ["jira-administrators"]) { queryParams, body, HttpServletRequest request ->
    def jiraAdminGroup = "jira-administrators"
    def groupManager = ComponentAccessor.groupManager
    def userName = request.getParameter("userName")
    def group = groupManager.getGroup(jiraAdminGroup)

    if (userName && group) {
        def user = ComponentAccessor.userManager.getUserByName(userName)
        if (!user) {
            return Response.status(Response.Status.BAD_REQUEST).entity(new JsonBuilder([user: userName, error: "user $userName does not exist"]).toString()).build()
        }
        if (!(user in groupManager.getUsersInGroup(group))) {
            groupManager.addUserToGroup(user, group)
            return Response.ok(new JsonBuilder([user: userName, group: jiraAdminGroup]).toString()).build()
        }
        return Response.status(Response.Status.BAD_REQUEST).entity(new JsonBuilder([user: userName, error: "user is already member of $jiraAdminGroup"]).toString()).build()
    }
    if (!group) {
        return Response.status(Response.Status.BAD_REQUEST).entity(new JsonBuilder([group: jiraAdminGroup, error: "group $jiraAdminGroup does not exist"]).toString()).build()
    }
    Response.status(Response.Status.BAD_REQUEST).entity(new JsonBuilder([error: "No value was given to the userName parameter"]).toString()).build()
}
```

