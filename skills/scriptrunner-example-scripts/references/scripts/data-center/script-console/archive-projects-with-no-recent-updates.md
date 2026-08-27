# Archive Projects with no Recent Updates

- Platform: data-center
- Feature: script-console
- Tags: automate, project
- Language: groovy
- Doc ID: example-dataCenter-archive-not-recently-updated-projects-onPrem
- Source: https://examples.scriptrunner.io/scripts/archive-not-recently-updated-projects-onPrem

## Overview

Archive all projects in which no issues have been created or updated in the last 365 days. Use this script as a
one-off action using the Script Console, or schedule it as a regular clean up a task using the Jobs feature.

## Example

As an administrator, I want to ensure my Jira instance is efficient and uncluttered. One way to do this is to set up
a monthly scheduled job that archives all projects that have been inactive for over a year.

## Good to Know

* The criteria used by this script, "Tickets not created or updated in the last 365 days" can be easily changed as
  it's in the JQL format.

## Script

```groovy
import com.atlassian.jira.bc.issue.search.SearchService
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.project.archiving.ArchivedProjectService
import org.apache.log4j.Level
import org.apache.log4j.Logger

def projectManager = ComponentAccessor.projectManager
def user = ComponentAccessor.jiraAuthenticationContext.loggedInUser
def searchService = ComponentAccessor.getComponent(SearchService)
def archivedProjectService = ComponentAccessor.getComponent(ArchivedProjectService)

def log = Logger.getLogger(getClass())
log.setLevel(Level.DEBUG)

def projectsToArchive = projectManager.projects.findAll { project ->
    // JQL criteria to search within projects. If it returns anything, the project DOESN'T get archived
    def jqlSearch = "project in (${project.key})  AND (updated > -365d OR created > -365d)"
    def parseResult = searchService.parseQuery(user, jqlSearch)

    if (!parseResult.valid) {
        log.warn("The JQL '${jqlSearch}' is not valid. Parse result: ${parseResult.errors}")
        return false
    }

    searchService.searchCount(user, parseResult.query) == 0
}

projectsToArchive.each { project ->
    def validationResult = archivedProjectService.validateArchiveProject(user, project.key)
    if (validationResult.valid) {
        archivedProjectService.archiveProject(validationResult)
        log.debug("Project ${project.key} has been archived")
    } else {
        log.warn("Project ${project.key} could not be archived: ${validationResult.errorCollection}")
    }
}
```

