# Compatibility with Jira

- Platform: data-center
- Space: SR4JS
- Hierarchy: get-started > update-scriptrunner
- Doc ID: doc-sr4js-443373524
- Source: https://docs.adaptavist.com/sr4js/latest/get-started/update-scriptrunner/compatibility-with-jira

This page details ScriptRunner compatibility with major Jira versions. We recommend you check this page if you plan on upgrading your Jira instance. 

## Jira 11

### Compatibility with Jira 11

Only those versions marked as compatible in the [Atlassian Marketplace](https://marketplace.atlassian.com/apps/6820/scriptrunner-for-jira/version-history) will work with Jira 11. If you have successfully completed the Jira 9 to 10 upgrade, the transition to Jira 11 should be relatively smooth. For further guidance, see Atlassian's [Jira 11 release notes](https://confluence.atlassian.com/jirasoftware/jira-software-11-0-x-release-notes-1587939582.html) and [upgrade notes](https://confluence.atlassian.com/jirasoftware/jira-software-11-1-x-upgrade-notes-1627193825.html). The information on this page is focused on the areas of change likely to affect your scripts.

#### OpenSearch compatibility exception

Atlassian introduced a new [OpenSearch opt-in feature](https://confluence.atlassian.com/jirasoftware/jira-software-11-0-x-release-notes-1587939582.html#JiraSoftware11.0.xreleasenotes-opensearch-eap) in Jira 11. ScriptRunner for Jira is not currently compatible with this feature. To maintain ScriptRunner functionality, we recommend that you **do not opt into OpenSearch**. We are working on compatibility and will provide an update when support becomes available.

#### Script functionality

Some of your scripts **may** fail if you upgrade without modifications. The major areas of change are listed below and on the [breaking changes](https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes#version10) page.

#### Breaking changes

There are some key breaking changes you should be aware of when upgrading to Jira 11:

-   **`TrustedRequestFactory` removed in Jira 11**: `com.atlassian.sal.api.net.TrustedRequestFactory` has been removed and will no longer work. Instead, use the HAPI class `com.adaptavist.hapi.platform.oauth.OAuthRequestSigner` to construct HTTP requests. See our [Work with OAuthRequestSigner](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-oauthrequestsigner) HAPI documentation for examples. 
-   **Search API upgrade**: Several methods from the current API have been removed.
    
-   **Spring and Jakarta update**: Jira has upgraded to Spring 6.x and Jakarta EE 10.
    
-   **jQuery update**: Jira has upgraded to jQuery 3 from version 2.
    

Scripts using upgraded or removed APIs may fail. For full details on all breaking changes and guidance on updating your scripts, see the [breaking changes](https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes#version10) documentation.

### Upgrading your instance

If you do not have a staging environment, we recommend you invest the time into creating one. You should be able to reliably clone your production instance to the staging environment, so you can test plugins and upgrades.

We recommend you use the following strategy when upgrading your instance:

1.  Make changes to remove all deprecated code while you are using Jira 10. You can check for deprecated code using the [Script Registry](https://docs.adaptavist.com/sr4js/latest/features/script-registry).
    
    If you remove deprecated code then your code has the best chance of working unchanged with Jira 10. Deprecated code shows as a warning.
    
    ![](/sr4js/files/latest/443373524/443373520/1/1758798505000/Additional+Issues+Warning.png)
    
2.  Make sure your staging instance is up to date with your production instance.
3.  Upgrade your **staging instance** to Jira 10.
4.  Use the [Script Registry](https://docs.adaptavist.com/sr4js/latest/features/script-registry) to make sure you don’t have any type-checking errors. 
    
    -   If you do have any type-checking errors, make the appropriate updates and test your new script. See the [breaking changes](https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes#version10) page to see if any errors relate to breaking changes. 
        
5.  Record any changes if needed.
    
6.  Once you're happy with your staging instance you can upgrade your production instance and apply any recorded changes. 
    
    When upgrading your production instance that contains inline scripts, manual adjustments are required where necessary. To update script files, you can modify your _Scripts Directory_, typically by merging changes from a branch.
    

### Anything else?

Did we miss something important that script authors should take into account when upgrading? Please [let us know](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/21).

If it’s likely to affect more than a couple of users we will add it to this documentation.

## Jira 10

### Compatibility with Jira 10

Only those versions marked as compatible in the [Atlassian Marketplace](https://marketplace.atlassian.com/apps/6820/scriptrunner-for-jira/version-history) will work with Jira 10. If you have successfully completed the Jira 8 to 9 upgrade, the transition to Jira 10 should be relatively smooth. For further guidance, see Atlassian's [Jira 10 release notes](https://confluence.atlassian.com/jirasoftware/jira-software-10-0-x-release-notes-1416825224.html) and [upgrade notes](https://confluence.atlassian.com/jirasoftware/jira-software-10-0-x-upgrade-notes-1431241649.html). The information on this page is focused on the areas of change likely to affect your scripts.

#### Script functionality

Some of your scripts **may** fail if you upgrade without modifications. The major areas of change are listed below and on the [breaking changes](https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes#version9) page.

#### Breaking changes

There are some key breaking changes you should be aware of when upgrading to Jira 10:

-   [Raw XML Module Breaking Change for Jira 10](https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes/raw-xml-module-breaking-change-for-jira-10)
-   [Web Resource Breaking Change for Jira 10](https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes/web-resource-breaking-change-for-jira-10)
-   [Web Panel Breaking Change/Deprecation for Jira 10](https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes/web-panel-breaking-change-deprecation-for-jira-10)
-   Third-party library/API removal
-   JDK has been updated. The minimum supported version of the JDK is now JDK 17. 

See the [breaking changes](https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes#version9) page for the details of all breaking changes related to this upgrade. 

### Upgrading your instance

If you do not have a staging environment, we recommend you invest the time into creating one. You should be able to reliably clone your production instance to the staging environment, so you can test plugins and upgrades.

We recommend you use the following strategy when upgrading your instance:

1.  Make changes to remove all deprecated code while you are using Jira 9. You can check for deprecated code using the [Script Registry](https://docs.adaptavist.com/sr4js/latest/features/script-registry).
    
    If you remove deprecated code then your code has the best chance of working unchanged with Jira 10. Deprecated code shows as a warning.
    
    ![](/sr4js/files/latest/443373524/443373520/1/1758798505000/Additional+Issues+Warning.png)
    
2.  Make sure your staging instance is up to date with your production instance.
3.  Upgrade your **staging instance** to Jira 10.
4.  Use the [Script Registry](https://docs.adaptavist.com/sr4js/latest/features/script-registry) to make sure you don’t have any type-checking errors. 
    
    -   If you do have any type-checking errors, make the appropriate updates and test your new script. See the [breaking changes](https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes#version9) page to see if any errors relate to breaking changes. 
        
5.  Record any changes if needed.
    
6.  Once you're happy with your staging instance you can upgrade your production instance and apply any recorded changes. 
    
    When upgrading your production instance that contains inline scripts, manual adjustments are required where necessary. To update script files, you can modify your _Scripts Directory_, typically by merging changes from a branch.
    

### Anything else?

Did we miss something important that script authors should take into account when upgrading? Please [let us know](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/21).

If it’s likely to affect more than a couple of users we will add it to this documentation.

## Jira 9

### Compatibility with Jira 9

Only those versions marked as compatible in the [Atlassian Marketplace](https://marketplace.atlassian.com/apps/6820/scriptrunner-for-jira/version-history) will work with Jira 9.

Some of your scripts **may** fail if you upgrade without modifications.

If you have been through the Jira 7 → 8 upgrade you have little to fear in upgrading to Jira 9.

You may not need to make any changes to your own scripts. The major areas of change are listed below.

For further reference, see Atlassian's [Preparing for Jira 9](https://confluence.atlassian.com/jiracore/preparing-for-jira-9-0-1115661092.html) documentation. The information here is focused on the areas of change likely to affect script writers.

Filter for scripts needing your attention in the [Script Registry](https://docs.adaptavist.com/sr4js/latest/features/script-registry) to quickly review all your code.

### Upgrades and staging Environments

If you do not have a staging environment you should invest the time it takes to create one. You should be able to reliably clone your production instance to the staging environment, so you can test plugins and upgrades.

A good strategy to follow is to:

1.  Make changes to remove all deprecated code while you are using Jira 8. If you remove deprecated code then your code has the best chance of working unchanged with Jira 9.
    
    Deprecated code is shown as a warning.
    
    ![](/sr4js/files/latest/443373524/443373520/1/1758798505000/Additional+Issues+Warning.png)
    
2.  Upgrade your staging instance to Jira 9.
    
3.  Use the script registry to make sure you don’t have any type checking errors, and **T****est.**
    
4.  Record changes, if needed.
    
5.  When upgrading your production instance using inline scripts some changes are necessary. For files, you can update your _Scripts Directory_, e.g. by merging from a branch.
    

### Changes to Jira Java API

There are some noticeable changes to the Jira Java API, as listed below:

Removed in Jira 9

Jira 9 Alternative

`com.atlassian.jira.util.JiraUtils.loadComponent(*)`

`ComponentManager.getInstance().loadComponent(Class, Collection)`

`com.atlassian.jira.user.util.UserUtil`.`getUserByName(String)`

`ComponentAccessor.userManager.getUserByName(String)`

`com.atlassian.jira.user.util.UserUtil`.`getUserByName(String)`

`ComponentAccessor.userManager.getUserByKey(String)`

`com.atlassian.jira.user.util.UserUtil.getUser(String)`

`ComponentAccessor.UserManager.userByName(String)`

`com.atlassian.jira.user.util.UserUtil.getGroupObject(String)`

`ComponentAccessor.groupManager.getGroup(String)`

`com.atlassian.jira.config.constantsManager.getStatusObjects()`

`ComponentAccessor.constantsManager.getStatuses()`

`com.atlassian.jira.config.constantsManager.getResolutionObjects()`

`ComponentAccessor.constantsManager.getResolutions()`

`com.atlassian.jira.config.constantsManager.getPriorityObjects()`

`ComponentAccessor.constantsManager.getPriorities()`

`com.atlassian.jira.config.constantsManager.getIssueTypeObject(String)`

`ComponentAccessor.constantsManager.getIssueType(String)`

### Anything else?

Did we miss something important that script authors should take into account when upgrading? Please [let us know](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/21).

If it’s likely to affect more than a couple of users we will add it to this documentation.

## Jira 8

### Compatibility with Jira 8

Only those versions marked as compatible in the [Atlassian Marketplace](https://marketplace.atlassian.com/apps/6820/scriptrunner-for-jira/version-history) will work with Jira 8.

Some of your scripts **may** fail if you upgrade without modifications.

If you have been through the Jira 6 → 7 upgrade you have little to fear in upgrading to Jira 8

You may well not need to make any changes to your own scripts. There is a guide to the major areas of change below.

For further reference you can use view [Preparing for Jira 8](https://confluence.atlassian.com/adminjira/preparing-for-jira-8-0-955171967.html). The information here is focused on the areas of change likely to affect script writers.

Use the [Script Registry](https://docs.adaptavist.com/sr4js/latest/features/script-registry) to quickly review all your code.

### Upgrades and staging Environments

If you do not have a staging environment you should invest the time it takes to create one. You should be able to reliably clone your production instance to the staging environment, so you can test plugins and upgrades.

A good strategy to follow is to

-   make changes now to remove all deprecated code, while you are using Jira 7. Deprecations are shown with a yellow warning. If you do that your code has the best chance of working unchanged with Jira 8.
    
    ![A warning in the Additional Issue Actions section.](/sr4js/files/latest/443373524/443373521/1/1758798506000/type-checked-condition-depr+%285%29.png)
-   once the deprecated code has been fixed, upgrade your staging instance to Jira 8
    
-   use the script registry to make sure you don’t have any type checking errors, and **test**
    
-   if you need to make changes, record what they are
    
-   when you upgrade your production instance, if you are using inline scripts, you will need to make the same changes. For files, you can update your scripts directory, e.g. by merging from a branch
    

### Changes to Search API

There are some methods renamed in the [search API](https://confluence.atlassian.com/adminjira/lucene-upgrade-955171970.html).

The one most likely to have impact is that `com.atlassian.jira.issue.search.SearchResults#getIssues` has been renamed to `getResults`.

Example - you have a simple script that executes a JQL query, and does something with the first _page_ of issues returned.

```
import com.atlassian.jira.bc.issue.search.SearchService
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.jql.parser.JqlQueryParser
import com.atlassian.jira.web.bean.PagerFilter

def searchService = ComponentAccessor.getComponent(SearchService)
def user = ComponentAccessor.getJiraAuthenticationContext().getLoggedInUser()
def queryParser = ComponentAccessor.getComponent(JqlQueryParser)

def query = queryParser.parseQuery("project = JRA and resolution is empty")
def search = searchService.search(user, query, new PagerFilter())

search.issues.each {
    // do something with each issue
}
```

In Jira 8, the last part should be rewritten:

```
search.results.each {
    // do something with each issue
}
```

```
issues
```

### ComponentManager has been moved

You should have stopped using `ComponentManager` when upgrading from Jira 6 → 7, but if you didn’t your scripts would continue to work, albeit you would see a _deprecation_ warning in the script editor.

If using `componentManager` provided as a variable to your script, you don’t need to make any changes.

If you haven’t already done this, follow the step of migrating to `ComponentAccessor` which should have been done when upgrading to Jira 7.

If you insist on using `ComponentManager` replace any imports:

```
import com.atlassian.jira.ComponentManager
```

with

```
import com.atlassian.jira.component.pico.ComponentManager
```

### Anything else?

Did we miss something important that script authors should take into account when upgrading? Please [let us know](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/21).

If it’s likely to affect more than a couple of users we will add it to this documentation.

## Jira 7

### Compatibility with Jira 7

ScriptRunner releases 4.2.x and above are compatible with Jira 7, not below.

Your scripts **will** fail if you upgrade without modifications.

You will need to make some changes to your scripts to make them work with Jira 7’s API. There is a guide to the major areas of change below.

Use this guide in conjunction with [Preparing for Jira 7](https://developer.atlassian.com/jiradev/latest-updates/preparing-for-jira-7-0), and specifically the [API changes](https://developer.atlassian.com/jiradev/latest-updates/preparing-for-jira-7-0/jira-7-0-api-changes). This guide is focused on the areas of change likely to affect script writers.

Use the [script registry](https://docs.adaptavist.com/sr4js/latest/features/script-registry) to quickly review all your code.

### Upgrades and staging Environments

If you do not have a staging environment you should invest the time it takes to create one. You should be able to reliably clone your production instance to the staging environment, so you can test plugins and upgrades.

A good strategy to follow is to

-   make changes now to remove all deprecated code, while you are using Jira 6.3 or 6.4. Deprecations are shown with a yellow warning. If you do that your code has the best chance of working unchanged with Jira 7.
    
    ![A warning in the Additional Issue Actions section.](/sr4js/files/latest/443373524/443373523/1/1758798506000/type-checked-condition-depr+%284%29.png)
-   once the deprecated code has been fixed, upgrade your staging instance to Jira 7
    
-   use the script registry to make sure you don’t have any type checking errors, and **test**
    
-   if you need to make changes, record what they are
    
-   when you upgrade your production instance, if you are using inline scripts, you will need to make the same changes. For files, you can update your scripts directory, e.g. by merging from a branch
    

### Removal of ComponentManager methods

`ComponentManager` methods [have been removed](https://developer.atlassian.com/jiradev/latest-updates/preparing-for-jira-7-0/jira-7-0-api-changes#JIRA7.0-APIchanges-ApiCleanup). Typically these have been used to get at Jira managers and services, even though they have been deprecated for several years.

Where previously you used any of these constructs:

```
import com.atlassian.jira.ComponentManager
import com.atlassian.jira.bc.project.ProjectService

def commentManager = ComponentManager.instance.commentManager
// or
def commentManager = ComponentManager.getInstance().getCommentManager()
// or
def commentManager = ComponentManager.getCommentManager()

// getting some other type of service
def projectService = ComponentManager.getInstance().getComponentInstanceOfType(ProjectService)
```

now you should use:

```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.bc.project.ProjectService

def commentManager = ComponentAccessor.commentManager

def projectService = ComponentAccessor.getComponent(ProjectService)
```

### User replaced with ApplicationUser

Most methods that took or return a `User` have been [replaced](https://developer.atlassian.com/jiradev/latest-updates/preparing-for-jira-7-0/jira-7-0-api-changes#JIRA7.0-APIchanges-ApiApplicationUser) with a `ApplicationUser`.

You will notice this if you have statically typed a `User`, example:

![A Static Type Checking error in the Script field.](/sr4js/files/latest/443373524/443373522/1/1758798506000/get-logged-in-user+%281%29.png)

In this case the solution is to use dynamic typing (and remove the redundant `import`):

```
import com.atlassian.jira.component.ComponentAccessor

def authContext = ComponentAccessor.jiraAuthenticationContext
def user = authContext.getLoggedInUser()
```

The method that you pass the _user_ object to will also have been changed to use an `ApplicationUser`. In future, refrain from static typing objects (except for [fields](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/static-type-checking)).

### GenericValues removed

All methods that returned a GenericValue have been removed.

Previously, `issue.priority` would have returned a GenericValue, and you should have been using `issue.priorityObject`.

In Jira 7, `issue.priority` returns a `Priority` object, and getPriorityObject() has been deprecated.

So if you have done nothing since Jira 4, your code may now be perfectly correct. If you have have attempted to keep up with the deprecations, you should now revert back to getPriority().

An exception would be if you were expecting a GenericValue, eg:

```
issue.priority.get("name") == "High"
```

This will no longer work, you should change it to:

```
issue.priority.name == "High"
```

### Issue interface

Some methods on `com.atlassian.jira.issue.MutableIssue` have been renamed. Previously, `setComponents` used GenericValues. However, the API was changed to use component objects instead. GenericValues were subsequently removed, so specifying "Objects" in the method name was no longer necessary.

`setComponents(Collection<org.ofbiz.core.entity.GenericValue> components)` has been removed, and `setComponentObjects(Collection<ProjectComponent> components)` has been renamed to `setComponent`.

### Create Project

The `validateCreateProject` where you specify all the parameters has been replaced by:

```
ProjectService.CreateProjectValidationResult validateCreateProject(ApplicationUser user, @Nonnull ProjectCreationData data)
```
