# Create a Confluence Page for Each Subtask of an Issue

- Platform: data-center
- Feature: script-console
- Tags: automate, issue
- Language: groovy
- Doc ID: example-dataCenter-create-confluence-page-for-issues-onPrem
- Source: https://examples.scriptrunner.io/scripts/create-confluence-page-for-issues-onPrem

## Overview

When working in Jira, often you want to continue a conversation about an issue on a corresponding Confluence page.
Having all data on a Confluence page can be helpful when defining specifications for a task, swarming on an incident, or any other collaborative action in your workflow.
Use this script to create a corresponding page, with hierarchy in place, for each sub-task of an issue in a Confluence space linked via application links.

## Example

I am a product manager with multiple projects in Jira.
I need each project to have a corresponding Confluence page to carry out more in-depth conversations.
These pages need to have a hierarchy in place for each sub-task of an issue in a Confluence space linked via application links.
I can use this script to automate the creation of the Confluence pages for each project.

## Good to Know

* Make sure the current user has write permissions on the target Confluence space.

## Script

```groovy
import com.atlassian.applinks.api.ApplicationLink
import com.atlassian.applinks.api.ApplicationLinkService
import com.atlassian.applinks.api.application.confluence.ConfluenceApplicationType
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.sal.api.component.ComponentLocator
import com.atlassian.sal.api.net.Request
import com.atlassian.sal.api.net.Response
import com.atlassian.sal.api.net.ResponseException
import com.atlassian.sal.api.net.ResponseHandler
import groovy.json.JsonBuilder
import groovy.json.JsonSlurper
import groovy.xml.MarkupBuilder

def key = 'TEST'
def issueKey = 'CWT-31'
def issueManager = ComponentAccessor.issueManager
def issue = issueManager.getIssueObject(issueKey)

def title = """${issue.key} - ${issue.summary}"""
def writer = new StringWriter()
def xml = new MarkupBuilder(writer)
// add more paragraphs etc
xml.h2("Example page")
xml.p("${issue.description}")
def parent = createConfluencePage(title, key, null, writer)

issue.subTaskObjects.find { subtask ->
    // write storage format using an XML builder
    def subtitle = """${subtask.key} - ${subtask.summary}"""
    def subwriter = new StringWriter()
    def subxml = new MarkupBuilder(subwriter)
    // add more paragraphs etc
    subxml.h2("Description")
    subxml.p("""${subtask.description}""")
    createConfluencePage(subtitle, key, parent, subwriter)
}

static ApplicationLink createPrimaryConfluenceLink() {
    def applicationLinkService = ComponentLocator.getComponent(ApplicationLinkService)
    final def conflLink = applicationLinkService.getPrimaryApplicationLink(ConfluenceApplicationType)
    conflLink
}

int createConfluencePage(pageTitle, spaceKey, parentPage, pageContent) {
    def confluenceLink = createPrimaryConfluenceLink()
    assert confluenceLink // must have a working app link set up
    def authenticatedRequestFactory = confluenceLink.createImpersonatingAuthenticatedRequestFactory()

    def params = [
        type : "page",
        title: pageTitle,
        space: [
            key: spaceKey // set the space key - or calculate it from the project or something
        ],
        body : [
            storage: [
                value         : pageContent.toString(),
                representation: "storage"
            ]
        ]
    ]
    if (parentPage != null) {
        params["ancestors"] = [parentPage].collect { [id: parentPage.toString()] }
    }
    log.warn(params.toString())
    def responseBody
    authenticatedRequestFactory
        .createRequest(Request.MethodType.POST, "rest/api/content")
        .addHeader("Content-Type", "application/json")
        .setRequestBody(new JsonBuilder(params).toString())
        .execute(new ResponseHandler<Response>() {
        @Override
        void handle(Response response) throws ResponseException {
            if (response.statusCode != HttpURLConnection.HTTP_OK) {
                throw new Exception(response.responseBodyAsString)
            } else {
                responseBody = new JsonSlurper().parseText(response.responseBodyAsString)
            }
        }
    })

    responseBody["id"] as Integer
}
```

