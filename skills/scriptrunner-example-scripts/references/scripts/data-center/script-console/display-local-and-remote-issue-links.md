# Display Local and Remote Issue Links

- Platform: data-center
- Feature: script-console
- Tags: reporting, issue
- Language: groovy
- Doc ID: example-dataCenter-display-issue-links-onPrem
- Source: https://examples.scriptrunner.io/scripts/display-issue-links-onPrem

## Overview

Issues can be linked to other issues in the Jira instance (local links) or linked to external resources (remote links).
With this script, you can get a summary of the links of an issue (local and remote).

## Example

As a developer, I make extensive use of issue links: linking issues together as well as linking to remote resources.
I can use this script to get a quick summary of the links of an issue (local and remote), identify the link I'm interested in and navigate to it.

## Description

#### Overview

Issues can be linked to other issues in the Jira instance (local links) or linked to external resources (remote links).
With this script, you can get a summary of the links of an issue (local and remote).

#### Example

As a developer, I make extensive use of issue links: linking issues together as well as linking to remote resources.
I can use this script to get a quick summary of the links of an issue (local and remote), identify the link I'm interested in and navigate to it.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.config.properties.APKeys
import com.atlassian.jira.issue.link.RemoteIssueLinkManager

// Get the components
def issueManager = ComponentAccessor.issueManager
def issueLinkManager = ComponentAccessor.issueLinkManager
def remoteIssueLinkManager = ComponentAccessor.getComponent(RemoteIssueLinkManager)

// Define the params to get an issue and filter the issue links by type
final issueKey = 'TEST-1'
final issueLinkTypeName = 'Blocks'

// Get the issue
def issue = issueManager.getIssueByCurrentKey(issueKey)

// Get the issue links to other issues
def issueLinks = issueLinkManager.getOutwardLinks(issue.id)
def filteredLinks = issueLinks.findAll { it.issueLinkType.name == issueLinkTypeName }

// Collect the HTML links pointing to the linked issues
def baseUrl = ComponentAccessor.applicationProperties.getString(APKeys.JIRA_BASEURL)
def linkedIssuesHtmlLinks = filteredLinks.collect { issueLink ->
    def issueUrl = "${baseUrl}/${issueLink.destinationObject.key}"
    "<a href='${issueUrl}'>${issueLink.destinationObject.key}</a>"
}

// Collect the HTML links pointing to the remote links
def remoteLinks = remoteIssueLinkManager.getRemoteIssueLinksForIssue(issue)
def remoteLinksHtml = remoteLinks.collect { remoteLink ->
    "<a href='${remoteLink.url}'>${remoteLink.title}</a>"
}

// Display the links
"""<p>Issue links:</p>
<ul>
    ${linkedIssuesHtmlLinks.collect { "<li>${it}</li>" }.join('\n')}
</ul>
<p>Remote links:</p>
<ul>
    ${remoteLinksHtml.collect { "<li>${it}</li>" }.join('\n')}
</ul>"""
```

