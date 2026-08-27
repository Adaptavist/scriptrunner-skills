# Convert Custom Field Data into Version Objects

- Platform: data-center
- Feature: script-console
- Tags: automate, issue
- Language: groovy
- Doc ID: example-dataCenter-create-versions-from-custom-field-onPrem
- Source: https://examples.scriptrunner.io/scripts/create-versions-from-custom-field-onPrem

## Overview

When working in Jira, you are often dealing with messy data imported from a legacy system or other external data source in a way that is difficult to query.
Transforming this data with scripts is a powerful way to make it easier to find the required issues.

## Example

I'm a developer, and my build system is automatically importing version information into a plain text custom field in Jira.
This plain text field contains a lot of information I'd like to query on (like the release date and the version number); however, it can't easily be parsed with normal JQL.

ScriptRunner has a function that can query issues by their Fix Version's release date. Converting these plain text values into versions in the project would allow me to query them efficiently.

This script takes all the issues in an example project, parses the value in the External System Version field, creates a version in the project with the appropriate release date, and updates each issue to have the correct Fix Version.

This script was demonstrated in our webinar [Groovy Scripting for ScriptRunner](http://bit.ly/groovy_scripting_webinar).

## Good to Know

* This script assumes a version of the format "com.example.whatsit.a4e7e26c4c7ab74be8f13900add1e44.2008-09-20T19:33:23.100.1.0"
* There may be multiple versions that are comma-separated, as in
"com.example.whatsit.a4e7e26c4c7ab74be8f13900add1e44.2008-09-20T19:33:23.100.1.0,com.example.whatsit.a13e726c4cbu7t4be8f13900add1e44.2008-09-21T19:33:23.100.1.1"
* We have [a CSV with some sample issue data](https://drive.google.com/file/d/13qIbyaHr6TV4T-FmUqLSnOMaodaaes3j/view), which you can download and import into your Jira instance.

## Script

```groovy
import com.atlassian.jira.bc.issue.search.SearchService
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.jql.parser.JqlQueryParser
import com.atlassian.jira.web.bean.PagerFilter

import java.time.LocalDateTime
import java.time.ZoneId
import java.time.format.DateTimeFormatter

final PROJECT_KEY = "WEBI"
final CUSTOM_FIELD_NAME = "External System Version"

def issueService = ComponentAccessor.issueService
def projectManager = ComponentAccessor.projectManager
def versionManager = ComponentAccessor.versionManager

def project = projectManager.getProjectByCurrentKey(PROJECT_KEY)
def loggedInUser = ComponentAccessor.jiraAuthenticationContext.loggedInUser

def searchService = ComponentAccessor.getComponent(SearchService)
def jqlQueryParser = ComponentAccessor.getComponent(JqlQueryParser)
def query = jqlQueryParser.parseQuery("project = $PROJECT_KEY and '$CUSTOM_FIELD_NAME' is not EMPTY")
def searchResults = searchService.search(loggedInUser, query, PagerFilter.unlimitedFilter)

def customFieldManager = ComponentAccessor.customFieldManager
def externalSystemVersionField = customFieldManager.getCustomFieldObjectsByName(CUSTOM_FIELD_NAME).first()

final datePattern = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss")

searchResults.results.each { issue ->
    log.debug "Looking at issue ${issue.key}"
    def importedVersion = issue.getCustomFieldValue(externalSystemVersionField).toString()

    def roughVersions = importedVersion.tokenize(',')
    def realVersions = roughVersions.collect { roughVersion ->
        def parts = roughVersion.tokenize('.')
        def dateString = parts[4]
        def versionName = parts[5..7].join('.')
        log.debug "Trying to create version $versionName with date string $dateString"

        def releaseDate = LocalDateTime.parse(dateString, datePattern).atZone(ZoneId.systemDefault())
        def priorVersions = project.versions.toList().findAll {
            this.compareVersions(it.name, versionName) < 0
        }.sort {
            this.compareVersions(it.name, versionName)
        }

        Long afterVersionId = priorVersions.empty ? -1L : priorVersions.last().id
        project.versions.find { it.name == versionName } ?: versionManager.createVersion(
            versionName,
            null,
            Date.from(releaseDate.toInstant()),
            "",
            project.id,
            afterVersionId,
            true
        )
    }

    Long[] fixVersionIds = realVersions*.id
    def inputParameters = issueService.newIssueInputParameters().setFixVersionIds(fixVersionIds)

    def validationResult = issueService.validateUpdate(loggedInUser, issue.id, inputParameters)
    if (validationResult.valid) {
        def updateResult = issueService.update(loggedInUser, validationResult)
        if (updateResult.valid) {
            log.debug "Successfully updated issue ${issue.key}"
        } else {
            log.error "Failed to update $issue.key"
            log.error updateResult.errorCollection*.errorMessages
        }
    }
}

/**
 * Compare two version strings as a java.util.Comparator
 * @param version1
 * @param version2
 * @return
 */
Integer compareVersions(String version1, String version2) {
    def parts1 = version1.tokenize('.')*.toInteger()
    def parts2 = version2.tokenize('.')*.toInteger()
    if (parts1[0] == parts2[0]) {
        if (parts1[1] == parts2[1]) {
            return parts1[2] - parts2[2]
        }
        return parts1[1] - parts2[1]
    }
    parts1[0] - parts2[0]
}
```

