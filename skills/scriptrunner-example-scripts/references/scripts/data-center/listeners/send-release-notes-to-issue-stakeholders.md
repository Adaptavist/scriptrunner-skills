# Send Release Notes to Issue Stakeholders

- Platform: data-center
- Feature: listeners
- Tags: automate, issue, email, reporting
- Language: groovy
- Doc ID: example-dataCenter-send-release-notes-issue-stakeholders-onPrem
- Source: https://examples.scriptrunner.io/scripts/send-release-notes-issue-stakeholders-onPrem

## Overview

Send a list of issues in the release version to their reporters, assignees, or custom field members (issue stakeholders).
Each stakeholder receives a release note of issues they are involved in.

## Example

As a project manager, I want stakeholders to be informed once a new version is released.
I can configure this script to send a customisable email to the reporters of each issue.

## Good to Know

* This script requires [*Email This issue plugin*](https://marketplace.atlassian.com/apps/4977/email-this-issue).
* Associate this script with the `VersionReleasedEvent` event listener.
* Build you own email template using *Email This Issue's* Template editor.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.event.project.VersionReleaseEvent
import com.atlassian.jira.bc.issue.search.SearchService
import com.atlassian.jira.web.bean.PagerFilter
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.metainf.jira.plugin.emailissue.api.EmailService
import com.metainf.jira.plugin.emailissue.api.EmailDefinitionApi
import com.metainf.jira.plugin.emailissue.action.EmailOptions
import org.apache.log4j.Level

log.setLevel(Level.INFO)

@WithPlugin("com.metainf.jira.plugin.emailissue")

@PluginModule EmailService emailService

// Get the released version from the associated event
final version = (event as VersionReleaseEvent).version
// Name of the template to use
final templateName = 'Release Notes - per reporter'

//Get reference to Jira API
def issueManager = ComponentAccessor.issueManager
def user = ComponentAccessor.jiraAuthenticationContext.loggedInUser
def searchService = ComponentAccessor.getComponent(SearchService)

// Find issues for the version being released
def jqlString = "fixVersion = ${version.id} ORDER BY issuetype, priority DESC, key ASC"
def parseResult = searchService.parseQuery(user, jqlString)
if (!parseResult.valid) {
    log.error("Invalid JQL: ${jqlString}")
    return
}

def searchResult = searchService.search(user, parseResult.query, PagerFilter.unlimitedFilter)
def issuesInVersion = searchResult.results.collect { issueManager.getIssueObject(it.id) }
log.info("Issues in version " + issuesInVersion)

// Group the issues by reporter
def issuesByReporter = issuesInVersion.groupBy { issue ->
    issue.reporter
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

