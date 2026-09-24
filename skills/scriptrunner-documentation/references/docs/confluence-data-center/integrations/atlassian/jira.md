# Jira

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Integrations > Atlassian
- Doc ID: doc-sr4c-1ba0f02d-ff3b-41af-87e9-4ce937e33ee7-36aea508725528b9
- Source: https://docs.adaptavist.com/sr4c/latest/integrations#atlassian--en#jira--en

If you have a Jira instance linked to your Confluence instance, it is possible to interact with it using Jira's REST API.

These examples make the requests on behalf of the current user. Check out the [Making Requests as Another User](https://docs.adaptavist.com/sr4c/latest/integrations/atlassian/connect-to-atlassian-via-app-links) section for other ways of making the request.

Also, see the examples of integrating Confluence from the Jira perspective.

## Creating a Jira Project

This example utilizes [Event Listeners](https://docs.adaptavist.com/sr4c/latest/features/event-listeners) and hooks up the `SpaceCreateEvent`, responding to it by creating a project in Jira.

```
import com.atlassian.applinks.api.ApplicationLinkService
import com.atlassian.applinks.api.application.jira.JiraApplicationType
import com.atlassian.confluence.event.events.space.SpaceCreateEvent
import com.atlassian.sal.api.component.ComponentLocator
import com.atlassian.sal.api.net.Response
import com.atlassian.sal.api.net.ResponseException
import com.atlassian.sal.api.net.ResponseHandler
import groovy.json.JsonBuilder

import static com.atlassian.sal.api.net.Request.MethodType.POST

def appLinkService = ComponentLocator.getComponent(ApplicationLinkService)
def appLink = appLinkService.getPrimaryApplicationLink(JiraApplicationType) // <1>
def applicationLinkRequestFactory = appLink.createAuthenticatedRequestFactory()

def event = event as SpaceCreateEvent
def space = event.space

def input = new JsonBuilder([ // <2>
    projectTypeKey    : "business",
    projectTemplateKey: "com.atlassian.jira-core-project-templates:jira-core-task-management",
    name              : space.name,
    key               : space.key,
    lead              : event.space.creator.name,
]).toString()

def request = applicationLinkRequestFactory.createRequest(POST, "/rest/api/2/project")
    .addHeader("Content-Type", "application/json")
    .setEntity(input)

request.execute(new ResponseHandler<Response>() { // <3>
    @Override
    void handle(Response response) throws ResponseException {
        if (response.statusCode != 201) {
            log.error("Creating jira project failed: ${response.responseBodyAsString}")
        }
    }
})
```

Line 14: Retrieves the primary Jira application link

Line 20: The project parameters

Line 32: Executes the request

Tip: See [interacting with Jira projects via REST API](https://docs.atlassian.com/software/jira/docs/api/REST/7.12.0/?_ga=2.212368020.1671141826.1558033166-1225216217.1555505967#api/2/project) for more examples.

## Creating a Jira issue

The script below is an example of creating an issue and can be used via the Script Console, Event Listeners, etc.

```
import com.atlassian.applinks.api.ApplicationLinkService
import com.atlassian.applinks.api.application.jira.JiraApplicationType
import com.atlassian.sal.api.component.ComponentLocator
import com.atlassian.sal.api.net.Response
import com.atlassian.sal.api.net.ResponseException
import com.atlassian.sal.api.net.ResponseHandler
import groovy.json.JsonBuilder

import static com.atlassian.sal.api.net.Request.MethodType.POST

def appLinkService = ComponentLocator.getComponent(ApplicationLinkService)
def appLink = appLinkService.getPrimaryApplicationLink(JiraApplicationType) // <1>
def applicationLinkRequestFactory = appLink.createAuthenticatedRequestFactory()

def body = new JsonBuilder([
    fields: [ // <2>
              project    : [key: "PROJECT_KEY"],
              summary    : "Perform a release",
              description: "Build and deploy a release",
              issuetype  : [name: "Story"]
    ]
]).toString()

def request = applicationLinkRequestFactory.createRequest(POST, "/rest/api/2/issue")
    .addHeader("Content-Type", "application/json")
    .setEntity(body)

request.execute(new ResponseHandler<Response>() { // <3>
    @Override
    void handle(Response response) throws ResponseException {
        if (response.statusCode != 201) {
            log.error("Creating Jira issue failed: ${response.responseBodyAsString}")
        }
    }
})
```

Line 13: Retrieves the primary Jira application link

Line 17: Specify values for the issue's fields here

Line 29: Executes the request

Tip: See [interacting with Jira issues via REST API](https://docs.atlassian.com/software/jira/docs/api/REST/7.12.0/?_ga=2.212368020.1671141826.1558033166-1225216217.1555505967#api/2/issue) for more examples.
