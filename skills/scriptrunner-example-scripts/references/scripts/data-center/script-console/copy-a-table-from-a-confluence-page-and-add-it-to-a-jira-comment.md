# Copy a Table From a Confluence Page and Add it to a Jira Comment

- Platform: data-center
- Feature: script-console
- Tags: integrate
- Language: groovy
- Doc ID: example-dataCenter-copy-table-from-confluence-page-and-add-it-to-a-jira-comment-onPrem
- Source: https://examples.scriptrunner.io/scripts/copy-table-from-confluence-page-and-add-it-to-a-jira-comment-onPrem

## Overview

This script makes a REST request to the Confluence page, filters the HTML result returned and stores in it a map. It then
iterates through the map and passes the value into a Jira table using the wiki format.

## Example

I am a Project Administrator and I have a Confluence page with some tables. I would like to directly copy those tables 
and add them to a comment on a Jira issue. The problem is that I can't directly copy the table from Confluence and paste
it in Jira because the format used in Confluence is not compatible with Jira and the table will not be displayed as
expected. This script helps me to solve this requirement.

## Good to Know

For this script to work, you need to ensure that Jira instance you are using is linked to Confluence. For more information
on this please visit this [Atlassian Documentation](https://confluence.atlassian.com/applinks/link-atlassian-applications-to-work-together-785449117.html).

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
import groovy.json.JsonSlurper
import org.jsoup.Jsoup

//Set the Issue Key where you want to pass the table to
final def issueKey = '<ISSUE_KEY>'

//Set the ID of the Confluence page
final def confluencePageID = '<CONFLUENCE_PAGE_ID>'

static ApplicationLink getPrimaryConfluenceLink() {
    final def applicationLinkService = ComponentLocator.getComponent(ApplicationLinkService)
    final def confLink = applicationLinkService.getPrimaryApplicationLink(ConfluenceApplicationType)
    confLink
}

def issueManager = ComponentAccessor.issueManager
def commentManager = ComponentAccessor.commentManager
def loggedInUser = ComponentAccessor.jiraAuthenticationContext.loggedInUser

def issue = issueManager.getIssueObject(issueKey)
def authenticatedRequestFactory = primaryConfluenceLink.createImpersonatingAuthenticatedRequestFactory()

def writer = new StringBuilder()
def result = new StringBuilder()

def responseHandler_GET = new ResponseHandler<Response>()  {
    @Override
    void handle(Response response) throws ResponseException {
        if (response.statusCode == HttpURLConnection.HTTP_OK) {
            def output = new JsonSlurper().parseText(response.responseBodyAsString)['body']['view']['value']
            writer.append("${output}\n")
        } else {
            throw new Exception(response.responseBodyAsString)
        }
    }
}

authenticatedRequestFactory
        .createRequest(Request.MethodType.GET, "/rest/api/content/${confluencePageID}?type=page&expand=body.view,version.number")
        .addHeader('Content-Type', 'application/json')
        .execute(responseHandler_GET)

def output = tableToJson(writer.toString())

output.each { Map.Entry entry ->
    if (entry.key == 'Head') {
        def head = output[entry.key.toString()] as List
        result.append("|||${head[0]}|||${head[1]}|||${head[2]}|||\n")
    } else {
        def body = output[entry.key.toString()] as List
        result.append("|${body[0]}|${body[1]}|${body[2]}|\n")
    }
}

commentManager.create(issue, loggedInUser, result.toString(), false)

static tableToJson(String source) {
    def doc = Jsoup.parse(source)
    def jsonMap = [:] as Map<String, List>
    def count = 0

    doc.select('table').each { table ->
        table.select('tr').each { row ->
            def ths = row.select('th')
            def tds = row.select('td')

            if (ths) {
                def author = ths.first().ownText()
                def comment = ths.get(1).ownText()
                def group = ths.last().ownText()
                jsonMap.put('Head', [author, comment, group])
            }
            if (tds) {
                def author = tds.first().ownText()
                def comment = tds.get(1).ownText()
                def group = tds.last().ownText()
                jsonMap.put("Body${++count}".toString(), [author, comment, group])
            }
        }
    }
    jsonMap
}
```

