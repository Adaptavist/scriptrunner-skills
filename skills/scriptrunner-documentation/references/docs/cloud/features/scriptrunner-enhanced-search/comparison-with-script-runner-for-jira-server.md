# Comparison with ScriptRunner for Jira Server

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > scriptrunner-enhanced-search
- Doc ID: doc-sr4jc-103678012
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/comparison-with-scriptrunner-for-jira-server

Migrating to Cloud?

For more details, or if you are migrating to Cloud, refer to the [Platform Differences between ScriptRunner for Jira Server/DC and Jira Cloud](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/platform-differences-between-scriptrunner-for-jira-server-dc-and-jira-cloud) and [Feature Parity and Script Alternatives](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/feature-parity-and-script-alternatives) sections within our [ScriptRunner Migration to Cloud](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud) section. For JQL functions and Keywords to work, you **must** complete an [initial synchronisation](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/jql-keywords-synchronization) after migrating.

Although you may be familiar with advanced queries in the [Jira Server](https://docs.adaptavist.com/sr4js/latest) version of ScriptRunner, the Cloud infrastructure differs and, therefore, some queries are not available or are implemented differently. Even if you have a good understanding of [JQL Functions from Jira Server](https://docs.adaptavist.com/x/8SvtCQ), it's worth noting that some of the concepts here are a little different.

As it is not possible to integrate directly into the standard search functionality that Jira Cloud provides, the [ScriptRunner Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search) functionality provides the ability to run advanced JQL functions in your Jira filters in a similar way to ScriptRunner for Jira Server. You can read more details on the differences in the [JQL Query Comparison](#id-.ComparisonwithScriptRunnerforJiraServervCurrent-JQLcomparison) information.

It is not possible in Jira Cloud for an add-on to alter the results of a JQL search either during or after a search is being performed.

## Differences

-   If you want to use a custom field, you can use either field key customfield\_10500 or field name e.g. 'StoryPoints'. Custom field names are likely to have spaces, which can’t be parsed. If so, remove the spaces. It’s not case-sensitive but use camel-case for maximum readability. If your field names have any other punctuation you must use the format customfield\_10500.
    
-   When you specify regular expressions, you don’t have to escape backslash characters. Example: write \\d+ instead of \\\\d+
    

## Unsupported functions

Compared to ScriptRunner for Jira Server, we cannot deliver the functions described below.

### myProjects/recentProjects

We are not able to support queries that are based on user-specific data.

### aggregateExpression

At this time we are not implementing this function.

## JQL query comparison

The table below contains equivalent JQL queries from ScriptRunner for Jira Server and Jira Cloud. Differences between the two systems are highlighted.

Jira Server JQL

Jira Cloud JQL

Description

```
issueFunction in hasComments(3)
```

```
numberOfComments = 3
```

Issues have exactly 3 comments

```
issueFunction in hasComments('+5')
```

```
numberOfComments > 5
```

Issues have more than 5 comments

```
issueFunction in hasComments('-5')
```

```
numberOfComments < 5
```

Issues have less than 5 comments

```
issueFunction in commented("after -7d")
```

```
lastCommentedDate > startOfDay("-7d")
```

Issues with comments added within the last 7 days

```
issueFunction in commented("on 2012/12/31")
```

```
commentedOn = '2012-12-31'
```

Issues with comments created on 31st December 2012

```
issueFunction in commented("by jbloggs")
```

```
commentedBy = 5f8eddaaf162650070bce0fb
```

Issues with comments authored by user jbloggs via the user account ID

```
issueFunction in commented('by currentUser()')
```

```
commentedBy = currentUser()
```

Issues with comments authored by the current logged in user

```
issueFunction in commented("before startOfWeek()")
```

```
firstCommentedDate < startOfWeek()
```

Issues with comments added before the start of this week

```
issueFunction in commented('after startOfMonth(-1) before endOfMonth(-1) by currentUser()')
```

```
lastCommentedDate > startOfMonth('-1') AND lastCommentedDate < endOfMonth('-1') AND commentedBy = currentUser()
```

Issues with comments added after the start of last month and comments added before the end of last month and comments authored by the current user

```
issueFunction in commented('inGroup jira-users')
```

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

Issues with comments by a user in the jira-users group

```
issueFunction in commented('inRole Administrators')
```

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

Issues with comments by a user with the Administrators role

```
issueFunction in lastComment('by jbloggs')
```

```
lastCommentBy = 5f8eddaaf162650070bce0fb
```

Issues with the most recent comment authored by user jbloggs via the user account ID

```
issueFunction in lastComment('after startOfWeek()')
```

```
lastCommentedDate > startOfWeek()
```

Issues with the most recent comment created since the start of the week

```
issueFunction in lastComment('before 2016-01-01')
```

```
lastCommentedDate < '2016-01-01'
```

Issues with the most recent comment created before 1st January 2016

```
issueFunction in lastComment('on 2015-02-01')
```

```
lastCommentedDate = '2015-02-01'
```

Issues with the most recent comment created on the 14th February 2015

```
issueFunction in lastComment('inRole Developers')
```

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

Issues with the most recent comment authored by a user with the Developers role

```
issueFunction in lastComment('inGroup jira-administrators')
```

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

Issues with the most recent comment authored by a user in the jira-administrators group

```
issueFunction in lastUpdated('by asmith')
```

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

Issues that were updated most recently by user asmith

```
issueFunction in lastUpdated('inRole Administrators')
```

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

Issues that were updated most recently by a user with the Administrators role

```
issueFunction in lastUpdated('inGroup jira-software-users')
```

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

Issues that were updated most recently by a user in the jira-software-users group

```
issueFunction in hasAttachments()
```

```
numberOfAttachments > 0
```

Issues that have attachments

not available

```
numberOfAttachments > 10
```

Issues that have at least 10 attachments

```
issueFunction in hasAttachments("docx")
```

```
attachmentType = "docx"
```

Issues that have attachments with the 'docx' file extension

```
issueFunction in fileAttached('after -4w')
```

```
lastAttachmentDate > startOfDay('-4w')
```

Issues that have attachments uploaded since 4 weeks ago

```
issueFunction in fileAttached('before lastLogin()')
```

```
firstAttachmentDate < lastLogin()
```

Issues that have attachments uploaded before the current users last login

```
issueFunction in fileAttached('on startOfWeek()')
```

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

Issues that have attachments uploaded at the start of the week

```
issueFunction in fileAttached('by jbloggs')
```

```
fileAttachedBy = 5f8eddaaf162650070bce0fb
```

Issues that have attachments uploaded by user jbloggs via the user account ID

```
issueFunction in workLogged('inRole Developers')
```

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

Issues that have work logged against them by a user with the Developers role

```
issueFunction in workLogged('inGroup service-desk-users')
```

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

Issues that have work logged against them by a user in the service-desk-users group

```
issueFunction in workLogged('by jsmith')
```

provided by Jira: `worklogAuthor = 5f8eddaaf162650070bce0fb`

Issues that have work logged by user jsmith via the user account ID

```
issueFunction in workLogged('on 2011-06-30')
```

provided by Jira: `worklogDate = 2011-06-30`

Issues that have work logged on the 30th June 2011

```
issueFunction in workLogged('after startOfWeek()')
```

provided by Jira: `worklogDate > startOfWeek()`

Issues that have work logged since the start of this week

```
issueFunction in workLogged('before startOfMonth()')
```

provided by Jira: `worklogDate < startOfMonth()`

Issues that have work logged before the start of this month

```
issueFunction in dateCompare(subquery, date comparison expression)
```

Both versions of ScriptRunner use JQL Functions. However, this feature has been implemented as [Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search) within ScriptRunner for Jira Cloud.

See [ScriptRunner Enhanced Search JQL Functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions) for more information

```
issueFunction in hasSubtasks()
```

```
numberOfSubtasks > 0
```

Issues that have subtasks

not available

```
numberOfSubtasks >= 10
```

Issues that more than or equal to 10 subtasks

```
issueFunction in subtasksOf(subquery)
```

Both versions of ScriptRunner use JQL Functions. However, this feature has been implemented as [Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search) within ScriptRunner for Jira Cloud.

See [ScriptRunner Enhanced Search JQL Functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions) for more information

```
issueFunction in childrenOf(subquery)
```

Both versions of ScriptRunner use JQL Functions. However, this feature has been implemented as [Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search) within ScriptRunner for Jira Cloud.

See [ScriptRunner Enhanced Search JQL Functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions) for more information

```
issueFunction in parentsOf(subquery)
```

Both versions of ScriptRunner use JQL Functions. However, this feature has been implemented as [Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search) within ScriptRunner for Jira Cloud.

See [ScriptRunner Enhanced Search JQL Functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions) for more information

```
issueFunction in hasLinks()
```

```
numberOfLinks > 0
```

Issues that have links to other issues

```
not available
```

```
numberOfLinks = 5
```

Issues that have 5 links to other issues

```
issueFunction in linkedIssuesOf(subquery)
```

Both versions of ScriptRunner use JQL Functions. However, this feature has been implemented as [Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search) within ScriptRunner for Jira Cloud.

See [ScriptRunner Enhanced Search JQL Functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions) for more information

```
issueFunction in epicsOf(subquery)
```

Both versions of ScriptRunner use JQL Functions. However, this feature has been implemented as [Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search) within ScriptRunner for Jira Cloud.

Can be achieved using [linkedIssuesOf](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions)

```
issueFunction in issuesInEpics(subquery)
```

Both versions of ScriptRunner use JQL Functions. However, this feature has been implemented as [Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search) within ScriptRunner for Jira Cloud.

[issuesInEpics](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions) that match the subquery

```
issueFunction in linkedIssuesOfRecursive(subquery, linkName)
```

Both versions of ScriptRunner use JQL Functions. However, this feature has been implemented as [Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search) within ScriptRunner for Jira Cloud.

See [JQL Functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords) for more information

```
issueFunction in linkedIssuesOfRecursiveLimited(subquery, depth, linkName)
```

Both versions of ScriptRunner use JQL Functions. However, this feature has been implemented as [Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search) within ScriptRunner for Jira Cloud.

See [ScriptRunner Enhanced Search JQL Functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions) for more information

```
issueFunction in linkedIssuesOfRemote(remoteLink, searchTerm)
```

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

Issues with remote links that match the search term

```
issueFunction in expression(Subquery, expression)
```

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

See [ScriptRunner Enhanced Search JQL Functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions) for more information

```
project in projectMatch(regularExpression)
```

Both versions of ScriptRunner use JQL Functions. However, this feature has been implemented as [Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search) within ScriptRunner for Jira Cloud.

See [ScriptRunner Enhanced Search JQL Functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions) for more information

```
fixVersion in versionMatch(regularExpression)
```

Both versions of ScriptRunner use JQL Functions. However, this feature has been implemented as [Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search) within ScriptRunner for Jira Cloud.

See [ScriptRunner Enhanced Search JQL Functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions) for more information

```
component in componentMatch(regularExpression)
```

Both versions of ScriptRunner use JQL Functions. However, this feature has been implemented as [Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search) within ScriptRunner for Jira Cloud.

See [ScriptRunner Enhanced Search JQL Functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions) for more information

```
issueFunction in issueFieldMatch(subquery, fieldName, regularExpression)
```

Both versions of ScriptRunner use JQL Functions. However, this feature has been implemented as [Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search) within ScriptRunner for Jira Cloud.

See [ScriptRunner Enhanced Search JQL Functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions) for more information

```
issueFunction in issueFieldExactMatch(subquery, fieldName, regularExpression)
```

Both versions of ScriptRunner use JQL Functions. However, this feature has been implemented as [Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search) within ScriptRunner for Jira Cloud.

See [ScriptRunner Enhanced Search JQL Functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions) for more information

```
issueFunction in recentProjects()
```

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

Issues in the current user’s recently view projects. See [ScriptRunner Enhanced Search JQL Functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions).

```
issueFunction in myProjects()
```

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

Issues in the current user’s projects. See [ScriptRunner Enhanced Search JQL Functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions).

```
issueFunction in aggregateExpression()
```

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

See [ScriptRunner Enhanced Search JQL Functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions) for more information

```
fixVersion in earliestUnreleasedVersionByReleaseDate(projectKey)
```

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

Issues with a fixVersion that matches the unreleased version with the earliest release date

```
issueFunction in addedAfterSprintStart(boardName, sprintName)
```

Both versions of ScriptRunner use JQL Functions. However, this feature has been implemented as [Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search) within ScriptRunner for Jira Cloud.

Issues that were added to a sprint after it started. See [ScriptRunner Enhanced Search JQL Functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions).

```
issueFunction in removedAfterSprintStart(boardName, sprintName)
```

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

Issues that were removed from a sprint after it started

```
issueFunction in incompleteInSprint(boardName, sprintName)
```

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

Issues that were not completed in a sprint

```
issueFunction in completeInSprint(boardName, sprintName)
```

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

Issues that were completed in a sprint

```
issueFunction in nextSprint(boardName)
```

Both versions of ScriptRunner use JQL Functions. However, this feature has been implemented as [Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search) within ScriptRunner for Jira Cloud.

Issues that are in the next sprint for a given Agile board. See [ScriptRunner Enhanced Search JQL Functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions).

```
issueFunction in previousSprint(boardName)
```

Both versions of ScriptRunner use JQL Functions. However, this feature has been implemented as [Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search) within ScriptRunner for Jira Cloud.

Issues that are in the previous sprint for a given Agile board. See [ScriptRunner Enhanced Search JQL Functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions).

```
issueFunction in inSprint(boardName, sprintName)
```

Both versions of ScriptRunner use JQL Functions. However, this feature has been implemented as [Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search) within ScriptRunner for Jira Cloud.

Issues that are in a given sprint. See [ScriptRunner Enhanced Search JQL Functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions).
