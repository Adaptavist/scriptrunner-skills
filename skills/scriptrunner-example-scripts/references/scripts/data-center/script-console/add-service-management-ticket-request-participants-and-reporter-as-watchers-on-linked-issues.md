# Add Service Management Ticket Request Participants and Reporter as Watchers on Linked Issues

- Platform: data-center
- Feature: script-console
- Tags: automate, issue, user
- Language: groovy
- Doc ID: example-dataCenter-add-watchers-to-already-linked-issues-onPrem
- Source: https://examples.scriptrunner.io/scripts/add-watchers-to-already-linked-issues-onPrem

## Overview

Batch update issues returned by JQL to include all linked Service Management issues customers as watchers. Use this script to update a collection of non-Service Management issues to include all linked Service Management requests reporters and request participants as watchers. The non-Service Management issues must be inward linked to the Service Management issue using the specified link type.

## Example

I have a support management project and a public software development project. Many support requests have links to software project issues. I want to make sure each user watching or contributing to a service management request is added as a watcher on the linked software issue so they can follow issue progress.

## Description

#### Overview
Batch update issues returned by JQL to include all linked Service Management issues customers as watchers. Use this script to update a collection of non-Service Management issues to include all linked Service Management requests reporters and request participants as watchers. The non-Service Management issues must be inward linked to the Service Management issue using the specified link type.

#### Example
I have a support management project and a public software development project. Many support requests have links to software project issues. I want to make sure each user watching or contributing to a service management request is added as a watcher on the linked software issue so they can follow issue progress.

## Script

```groovy
import com.atlassian.jira.bc.issue.search.SearchService
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.link.IssueLinkTypeManager
import com.atlassian.jira.issue.search.SearchResults
import com.atlassian.jira.web.bean.PagerFilter
import com.atlassian.jira.issue.Issue
import com.atlassian.jira.user.ApplicationUser
import groovy.transform.Field

final projectKey = 'TEST'

final weeks = '1'

final issueLinkTypeName = 'Cause'

final PAGE_SIZE = 100 // limit JQL search to only retrieve 100 issues at a time

def searchService = ComponentAccessor.getComponentOfType(SearchService)
def issueLinkTypeManager = ComponentAccessor.getComponent(IssueLinkTypeManager)
def projectManager = ComponentAccessor.projectManager

@Field Set issuesUpdated = []

@Field def loggedInUser = ComponentAccessor.jiraAuthenticationContext.loggedInUser

def project = projectManager.getProjectByCurrentKey(projectKey)
assert project: "Could not find project with key $projectKey"

assert weeks: 'You must specify how many weeks back to search for issues to update'

def issueLinkType = issueLinkTypeManager.issueLinkTypes.findByName(issueLinkTypeName)
assert issueLinkType: "Could not find link type with name $issueLinkTypeName"

def jqlSearch = "project = ${project.key} and issueFunction in hasLinkType('${issueLinkType.name}') AND created >= endOfDay(-${weeks}w) AND status != Done AND level is EMPTY"

def parseResult = searchService.parseQuery(loggedInUser as ApplicationUser, jqlSearch)
if (!parseResult.valid) {
    log.error('Invalid query')
    return
}
def query = parseResult.query

def pagerFilter = PagerFilter.newPageAlignedFilter(0, PAGE_SIZE)
def searchResults = null
while (!searchResults || (searchResults as SearchResults).total > pagerFilter.start) {
    searchResults = searchService.search(loggedInUser as ApplicationUser, query, pagerFilter)
    searchResults.results.each {
        addWatchersFromLinkedIssues(it, issueLinkType.name)
    }
    pagerFilter.start += PAGE_SIZE
}

['updatedIssues': issuesUpdated]

void addWatchersFromLinkedIssues(Issue issue, String linkTypeName) {
    def requestParticipantsFieldName = 'Request participants'
    def watcherManager = ComponentAccessor.watcherManager
    def customFieldManager = ComponentAccessor.customFieldManager
    def requestParticipantsCF = customFieldManager.getCustomFieldObjectsByName(requestParticipantsFieldName).first()

    def linkedIssues = findInwardIssuesByLinkType(issue, linkTypeName)
    linkedIssues.each {
        def participants = it.getCustomFieldValue(requestParticipantsCF) as List
        def potentialWatchersToAdd = [] as Set<ApplicationUser>
        potentialWatchersToAdd.add(it.reporter)
        if (participants) {
            potentialWatchersToAdd.addAll(participants)
        }

        def currentWatcherCount = issue.watches
        def resultingIssue = null
        potentialWatchersToAdd.each { candidateWatcher ->
            resultingIssue = watcherManager.startWatching(candidateWatcher, issue.refresh())
        }
        if ((resultingIssue as Issue)?.watches > currentWatcherCount) {
            issuesUpdated << resultingIssue
        }
    }
}

List<Issue> findInwardIssuesByLinkType(Issue issue, String linkType) {
    def serviceDeskProjectTypeKey = 'service_desk'
    def issueLinkManager = ComponentAccessor.issueLinkManager
    def issues = issueLinkManager.getLinkCollection(issue, loggedInUser as ApplicationUser, true).getInwardIssues(linkType)

    issues.findAll { it.projectObject.projectTypeKey.key == serviceDeskProjectTypeKey }
}
```

