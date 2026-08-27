# Send Notifications to Service Desk Customers upon Their Released Requests

- Platform: data-center
- Feature: listeners
- Tags: automate, issue, email, reporting
- Language: groovy
- Doc ID: example-dataCenter-send-email-service-desk-customers-version-released-onPrem
- Source: https://examples.scriptrunner.io/scripts/send-email-service-desk-customers-version-released-onPrem

## Overview

Send notifications to Service Desk (SD) Customers when their requests are released. Recipients (the customers) receive a
list of SD requests they reported when the linked Story or Bug issues are released in the version.

## Example

As a product support engineer, I want customers who reported a problem or improvement for the software to get notified
once a version of the software which adresses their request is released.

## Good to Know

* This script requires [*Email This issue plugin*](https://marketplace.atlassian.com/apps/4977/email-this-issue).
* Associate this script with the `VersionReleasedEvent` event listener.
* Build you own email template using *Email This Issue's* Template editor.

## Script

```groovy
import com.atlassian.jira.event.project.VersionReleaseEvent
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.link.IssueLinkManager
import com.atlassian.jira.issue.Issue
import com.atlassian.jira.bc.issue.search.SearchService
import com.atlassian.jira.user.ApplicationUser
import com.atlassian.jira.web.bean.PagerFilter
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.metainf.jira.plugin.emailissue.api.EmailService
import com.metainf.jira.plugin.emailissue.api.EmailDefinitionApi
import com.metainf.jira.plugin.emailissue.action.EmailOptions
import org.apache.log4j.Level

@WithPlugin("com.metainf.jira.plugin.emailissue")

@PluginModule
EmailService emailService

log.setLevel(Level.INFO)

// Get the released version from the associated event
final version = (event as VersionReleaseEvent).version
final projectKey = 'TEST'
// Name of the template to use
final templateName = 'Release Notes - per customer'

//Get reference to Jira API
def issueManager = ComponentAccessor.issueManager
def user = ComponentAccessor.jiraAuthenticationContext.loggedInUser
def searchService = ComponentAccessor.getComponent(SearchService)
def issueLinkManager = ComponentAccessor.getComponent(IssueLinkManager)

// Find customer requests linked to development issues which have been released
def jqlString = "project = ${projectKey} AND issueFunction in linkedIssuesOf('fixVersion = ${version.name}', 'is caused by') ORDER BY issuetype, priority DESC, key ASC"
def parseResult = searchService.parseQuery(user, jqlString)
if (!parseResult.valid) {
    log.error("Invalid JQL: ${jqlString}")
    return
}

def searchResult = searchService.search(user, parseResult.query, PagerFilter.unlimitedFilter)
def issuesInVersion = searchResult.issues.collect {
    issueManager.getIssueObject(it.id)
}
log.info("Issues in version: ${issuesInVersion}")

def issuesByReporter = ([:] as Map<ApplicationUser, List<Issue>>)
// Find the related dev issue and add it to the collection.
issuesInVersion.each { issue ->
    issuesByReporter[issue.reporter] = (issuesByReporter[issue.reporter]) ? issuesByReporter[issue.reporter] : ([] as List<Issue>)

    def outwardLinks = issueLinkManager.getOutwardLinks(issue.id)
    def causesLinks = outwardLinks.findAll { it.issueLinkType.outward == 'causes' }

    issuesByReporter[issue.reporter].addAll(causesLinks*.sourceObject as Collection<Issue>)
}
log.info("Issues by reporter: ${issuesByReporter}")

// Loop through the reporters and send the list of their issues to them
issuesByReporter.each { reporter, reporterIssues ->
    if (!reporterIssues) {
        return
    }

    // Recipient is the reporter only, but other stakeholders could also receive the emails
    def recipientsTo = [reporter.emailAddress]
    // Compose parameters for Email This Issue
    def email = new EmailDefinitionApi()
    email.to = recipientsTo
    email.emailOptions = new EmailOptions()
    email.emailOptions.emailFormat = 'html'
    email.emailTemplate = templateName

    // Payload is a key-value pair to populate email templates
    def payload = [issues: reporterIssues, version: version, reporter: reporter]
    email.payload = payload

    // Send the email
    try {
        emailService.sendEmail(email)
    } catch (Exception e) {
        log.error("An exception was thrown: ${e.message}")
    }
}
```

