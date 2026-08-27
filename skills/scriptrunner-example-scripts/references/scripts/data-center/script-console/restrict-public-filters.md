# Restrict Public Filters

- Platform: data-center
- Feature: script-console
- Tags: administer, system
- Language: groovy
- Doc ID: example-dataCenter-restrict-public-entities-onPrem
- Source: https://examples.scriptrunner.io/scripts/restrict-public-entities-onPrem

## Overview

Running this script from ScriptRunner Script Console controls the sharing permissions of publicly-visible entities such as JQL filters, dashboards and the user picker global permission. This means users who are not logged in can access these entities. You can restrict permissions with this script to make them private, or visible, only to users who are logged in.

## Example

I am a Jira admin and have used this script to forbid access to public dashboards and filters temporarily whilst I fix some bugs.

## Good to Know

By default, the FIX_MODE variable is set to false to display a preview of the changes that need to be made. Set the FIX_MODE variable to true to perform all the changes.

## Script

```groovy
import com.atlassian.jira.bc.JiraServiceContextImpl
import com.atlassian.jira.bc.filter.SearchRequestService
import com.atlassian.jira.bc.portal.PortalPageService
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.permission.GlobalPermissionKey
import com.atlassian.jira.permission.GlobalPermissionType
import com.atlassian.jira.portal.PortalPage
import com.atlassian.jira.sharing.SharePermissionImpl
import com.atlassian.jira.sharing.SharedEntity
import com.atlassian.jira.sharing.search.GlobalShareTypeSearchParameter
import com.atlassian.jira.sharing.search.SharedEntitySearchParametersBuilder
import com.atlassian.jira.sharing.type.ShareType
import com.atlassian.sal.api.ApplicationProperties
import com.atlassian.sal.api.UrlMode
import com.onresolve.scriptrunner.runner.ScriptRunnerImpl
import groovy.xml.MarkupBuilder

/**
 * Run this with FIX_MODE = false to report on any problems.
 * To rectify all the issues change to: FIX_MODE = true.
 */
final FIX_MODE = false

def searchRequestService = ComponentAccessor.getComponent(SearchRequestService)
def currentUser = ComponentAccessor.jiraAuthenticationContext.loggedInUser
def applicationProperties = ScriptRunnerImpl.getOsgiService(ApplicationProperties)
def portalPageService = ComponentAccessor.getComponent(PortalPageService)
def globalPermissionManager = ComponentAccessor.globalPermissionManager

def contextPath = applicationProperties.getBaseUrl(UrlMode.RELATIVE)

def writer = new StringWriter()
def markup = new MarkupBuilder(writer)

def serviceContext = new JiraServiceContextImpl(currentUser)
def searchParameters = new SharedEntitySearchParametersBuilder().setShareTypeParameter(GlobalShareTypeSearchParameter.GLOBAL_PARAMETER).toSearchParameters()

searchRequestService.validateForSearch(serviceContext, searchParameters)
assert !serviceContext.errorCollection.hasAnyErrors()

markup.h3('Filters')
def searchFilterResult = searchRequestService.search(serviceContext, searchParameters, 0, Integer.MAX_VALUE)
final authenticatedUserSharePerms = new SharedEntity.SharePermissions([
    new SharePermissionImpl(null, ShareType.Name.AUTHENTICATED, null, null)
] as Set)

if (!searchFilterResult.results) {
    markup.p('No publicly accessible filters found')
}
searchFilterResult.results.each { filter ->
    if (FIX_MODE) {
        filter.setPermissions(authenticatedUserSharePerms)

        def filterUpdateContext = new JiraServiceContextImpl(filter.owner)
        searchRequestService.updateFilter(filterUpdateContext, filter)
        if (filterUpdateContext.errorCollection.hasAnyErrors()) {
            log.warn("Error updating filter - possibly owner has been deleted. Just delete the filter. " + filterUpdateContext.errorCollection)
        }
    }
    markup.p {
        a(href: "$contextPath/issues/?filter=${filter.id}", target: '_blank', filter.name)
        i(' publicly accessible. ' + (FIX_MODE ? ' Fixed.' : ''))
    }
}

markup.h3('Dashboards')
def searchDashResults = portalPageService.search(serviceContext, searchParameters, 0, Integer.MAX_VALUE).results.findAll {
    !it.systemDefaultPortalPage
}

if (!searchDashResults) {
    markup.p('No publicly accessible dashboards found')
}
searchDashResults.each { dashboard ->
    if (dashboard.systemDefaultPortalPage) {
        // can't edit the system default dashboard
        return
    }
    if (FIX_MODE) {
        def updatedDashboard = new PortalPage.Builder().portalPage(dashboard).permissions(authenticatedUserSharePerms).build()
        portalPageService.updatePortalPageUnconditionally(serviceContext, currentUser, updatedDashboard)
    }
    markup.p {
        a(href: "$contextPath/secure/Dashboard.jspa?selectPageId=${dashboard.id}", target: '_blank', dashboard.name)
        i(' publicly accessible. ' + (FIX_MODE ? ' Fixed.' : ''))
    }
}

markup.h3('Global Permissions')
final GlobalPermissionType GPT_BROWSE_USERS = new GlobalPermissionType(GlobalPermissionKey.USER_PICKER.key, null, null, false)
if (globalPermissionManager.hasPermission(GlobalPermissionKey.USER_PICKER, null)) {
    if (FIX_MODE) {
        globalPermissionManager.removePermission(GPT_BROWSE_USERS, null)
    }
    markup.p {
        b('Browse Users')
        i(' is publicly accessible. ' + (FIX_MODE ? ' : Fixed' : ''))
    }
} else {
    markup.p('No problems with global permissions found')
}

writer.toString()
```

