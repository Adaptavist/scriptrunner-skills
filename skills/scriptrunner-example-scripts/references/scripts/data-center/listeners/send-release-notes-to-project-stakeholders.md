# Send Release Notes to Project Stakeholders

- Platform: data-center
- Feature: listeners
- Tags: automate, issue, email, reporting
- Language: groovy
- Doc ID: example-dataCenter-send-release-notes-project-stakeholders-onPrem
- Source: https://examples.scriptrunner.io/scripts/send-release-notes-project-stakeholders-onPrem

## Overview

Send release notes to interested project stakeholders once a new version is released.

## Example

As a project manager, I want stakeholders to be informed one a new version is released.
I can configure this script to send a customisable email to members of a project role once a version is released.

## Good to Know

* This script requires [*Email This issue plugin*](https://marketplace.atlassian.com/apps/4977/email-this-issue).
* Associate this script with the `VersionReleasedEvent` event listener.
* Build you own email template using *Email This Issue's* Template editor.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.event.project.VersionReleaseEvent
import com.atlassian.jira.security.roles.ProjectRoleManager
import com.atlassian.jira.bc.issue.search.SearchService
import com.atlassian.jira.web.bean.PagerFilter
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.metainf.jira.plugin.emailissue.api.EmailService
import com.metainf.jira.plugin.emailissue.api.EmailDefinitionApi
import com.metainf.jira.plugin.emailissue.action.EmailOptions

@WithPlugin("com.metainf.jira.plugin.emailissue")

@PluginModule EmailService emailService

// Get the released version from the associated event
final version = (event as VersionReleaseEvent).version
final project = version.project
//Name of the template to use
final templateName = "Release Notes"
//Role send notification to
final projectRoleToNotify = 'Administrators'

//Get reference to Jira API
def projectRoleManager = ComponentAccessor.getComponent(ProjectRoleManager)
def issueManager = ComponentAccessor.issueManager
def user = ComponentAccessor.jiraAuthenticationContext.loggedInUser
def searchService = ComponentAccessor.getComponent(SearchService)

// Determine the project role members to send email to
def projectRole = projectRoleManager.getProjectRole(projectRoleToNotify)
def recipientsTo = projectRoleManager.getProjectRoleActors(projectRole, project).users*.emailAddress

// Find issues for the version being released
def jqlString = "fixVersion = ${version.id} ORDER BY issuetype, priority DESC, key ASC"
def parseResult = searchService.parseQuery(user, jqlString)
if (!parseResult.valid) {
    log.error("Invalid JQL: ${jqlString}")
    return
}

def searchResult = searchService.search(user, parseResult.query, PagerFilter.unlimitedFilter)
def issuesInVersion = searchResult.results.collect { issueManager.getIssueObject(it.id) }

// Compose parameters for Email This Issue
def email = new EmailDefinitionApi()
email.to = recipientsTo
email.emailOptions = new EmailOptions()
email.emailOptions.emailFormat = 'html'
email.emailTemplate = templateName

// Payload is a key-value pair to populate email templates
def payload = [issues: issuesInVersion, version: version]
email.payload = payload

// Send the email
try {
    emailService.sendEmail(email)
} catch (Exception e) {
    log.error("An exception was thrown: ${e.message}")
}
```

