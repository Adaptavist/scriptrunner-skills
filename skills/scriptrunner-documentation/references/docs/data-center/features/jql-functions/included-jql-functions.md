# Included JQL Functions

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > jql-functions
- Doc ID: doc-sr4js-442886659
- Source: https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions

ScriptRunner provides a large number of out-of-the-box JQL functions. Unlike most of ScriptRunner features, these included functions are available to all users on an instance, not just administrators.

ScriptRunner JQL AI

If you're not sure where to start with JQL Functions or are in need of a quick search filter, try our [ScriptRunner JQL AI](https://docs.adaptavist.com/sr4js/latest/features/jql-functions#sr-jql-ai). 

If you would like to view JQL functions by category, see the following pages:

-   [Attachments](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/attachments)
-   [Calculations](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/calculations)
-   [Comments](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/comments)
-   [Date](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/date)
-   [Issue Links](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links)
-   [Match Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/match-functions)
-   [Portfolio](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/portfolio)
-   [Projects](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/projects)
-   [Sprint](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/sprint)
-   [Sub-tasks](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/sub-tasks)  
    
-   [User Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/user-functions)
-   [Versions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/versions)
-   [Worklogs](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/worklogs)  
    

If you would like to view all available JQL functions, see the following table:

The links in the table below lead to category pages, where you can find information on the JQL function, examples, supported operators, and performance considerations.

Fields, operators, and functions

Fields are required to form a search clause and are typically followed by an operator and then a function or a value. Most ScriptRunner JQL functions are preceded by the issueFunction field, however, some ScriptRunner JQL functions are preceded by other fields (as shown in the table below). In a clause that includes a ScriptRunner JQL function the operator must always be `in` or `not in` (for example `issueFucntion **in** hasLinks("Blocks")`).

For more information on fields, functions and operators check out the [JQL Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial).

  

JQL Function

Description

Field Prefix

`[addedAfterSprintStart](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/sprint#addedAfterSprintStart)`

Show issues that were added to the named board after the named sprint started (or all active sprints if a second argument is not provided).

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`

`[aggregateExpression](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/calculations#aggregateExpression)`

Calculate a summary or aggregate data point.

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`

`[archivedVersions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/versions#archivedVersions)`

Return issues with versions that have been archived.

`[component](https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-fields-reference-939938743.html?_ga=2.120961743.653490247.1683619460-1501883802.1680605612#Advancedsearchingfieldsreference-ComponentComponent)`

`[commented](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/comments#commented)`

Find issues by querying on comments, for example, when, by which user, etc.

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`

`[completeInSprint](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/sprint#completeInSprint)`

Show complete issues in the named sprint for the specified board (or all active sprints if a second argument is not provided).

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`  

`[componentMatch](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/match-functions#componentMatch)`

Match the component name by regular expression.

`[component](https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-fields-reference-939938743.html?_ga=2.120961743.653490247.1683619460-1501883802.1680605612#Advancedsearchingfieldsreference-ComponentComponent)`

`[dateCompare](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/date#dateCompare)`

Compare two dates on the same issue.

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`  

`[earliestUnreleasedVersionByReleaseDate](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/versions#earliestUnreleasedVersionByReleaseDate)`

Return issues with an unreleased version set that is next due for release.

`[fixVersion](https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-fields-reference-939938743.html?_ga=2.120961743.653490247.1683619460-1501883802.1680605612#Advancedsearchingfieldsreference-FixVersionfixVersionFixversion)`

`[epicsOf](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#epicsOf)`

Find epics of issues returned by the subquery.

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`

`[expression](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/calculations#expression)`

Use complex date, estimate, or numeric expression to compare attributes of fields. 

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`

`[fileAttached](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/attachments#fileattached)`

Find issues by querying on attachments, for example, when, by which user, etc.

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`

`[hasAttachments](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/attachments#hasattachments)`

Return issues with attachments. You can optionally specify file types or the number of attachments.

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`

`[hasComments](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/comments#hasComments)`

Get issues with comments or with the specified number of comments.

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`

`[hasLinks](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#hasLinks)`

Find issues with links.

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`

`[hasLinkType](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#hasLinkType)`

Find issues with the specified link type.

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`

`[hasRemoteLinks](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#hasRemoteLinks)`

Find issues with links to remote content.

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`  

`[hasSubtasks](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/sub-tasks#hasSubtasks)`

Find issues with subtasks.

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`

`[inactiveUsers](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/user-functions#inactiveUsers)`

Return issues with a user field containing inactive users.

`[assignee](https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-fields-reference-939938743.html?_ga=2.120961743.653490247.1683619460-1501883802.1680605612#Advancedsearchingfieldsreference-AssigneeAssignee)`

`[incompleteInSprint](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/sprint#incompleteInSprint)`

Return issues that are incomplete in the specified sprint.

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`

`[issueFieldExactMatch](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/match-functions#issueFieldExactMatch)`

Match an issue field by exact string value.

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`

`[issueFieldMatch](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/match-functions#issueFieldMatch)`

Match an issue field by regular expression.

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`

`[issuePickerField](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#issuePickerField)`

Find issues based on the issues selected in the specified Issue Picker field.

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`

`[issuesInEpics](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#issuesInEpics)`

Find issues linked to epics matched by the subquery.

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`

`[jiraUserPropertyEquals](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/user-functions#jiraUserPropertyEquals)`

Return active and inactive users with a matching property value.

`[assignee](https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-fields-reference-939938743.html?_ga=2.120961743.653490247.1683619460-1501883802.1680605612#Advancedsearchingfieldsreference-AssigneeAssignee)`

`[lastComment](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/comments#lastComment)`

Find issues by querying only on the last comment.

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`

`[lastUpdated](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/date#lastUpdated)`

Find issues by the last update, for example, when, by which user, etc.

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`

`[linkedIssuesOf](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#linkedIssuesOf)`

Find linked issues matched by the subquery.

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`

`[linkedIssuesOfRecursive](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#linkedIssuesOfRecursive)`

Find ALL recursively linked issues matched by the subquery.

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`

`[linkedIssuesOfRecursiveLimited](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#linkedIssuesOfRecursiveLimited)`

Find recursively linked issues matched by the subquery, restricted by traversal depth. 

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`

`[linkedIssuesOfRemote](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#linkedIssuesOfRemote)`

Return issues linked to the given remote link.

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`

`[linkedIssuesOfAll](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#linkedIssuesOfAll)`

Find linked issues matched by the subquery. Functionally the same as `linkedIssuesOf` except it also includes subtasks and epic links when no link type is specified.

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`

`[linkedIssuesOfAllRecursive](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#linkedIssuesOfAll)`

Find ALL recursively linked issues matched by the subquery. Functionally the same as `linkedIssuesOfRecursive` except it also includes  subtasks and epic links when no link type is specified.

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`

`[linkedIssuesOfAllRecursiveLimited](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#linkedIssuesOfAll)`

Find ALL recursively linked issues matched by the subquery, restricted by traversal depth. Functionally the same as `linkedIssuesOfRecursiveLimited` except it also includes  subtasks and epic links when no link type is specified.

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`

`[memberOfRole](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/user-functions#memberOfRole)`

Return issues where the value of a user field is a member of the given role.

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`  

`[myProjects](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/projects#myProjects)`

Return projects in which you are a member.

`[project](https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-fields-reference-939938743.html?_ga=2.120961743.653490247.1683619460-1501883802.1680605612#Advancedsearchingfieldsreference-ProjectProject)`

`[nextSprint](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/sprint#nextSprint)`

Return issues from the first unstarted sprint on the specified board.

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`

`[overdue](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/versions#overdue)`

Find issues by unreleased versions with release date in the past.

`[fixVersion](https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-fields-reference-939938743.html?_ga=2.120961743.653490247.1683619460-1501883802.1680605612#Advancedsearchingfieldsreference-FixVersionfixVersionFixversion)`

`[parentsOf](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/sub-tasks#parentsOf)`

Get the parents of issues matched by the subquery.

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`

`[portfolioChildrenOf](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/portfolio#portfolioChildrenOf)`

Get the portfolio/roadmaps child issues matched by the subquery.

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`  

`[portfolioParentsOf](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/portfolio#portfolioParentsOf)`

Get the portfolio/roadmaps parent issues matched by the subquery.

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`  

`[previousSprint](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/sprint#previousSprint)`

Return issues from the last completed sprint on this board.

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`

`[projectMatch](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/match-functions#projectMatch)`

Match the project name by regular expression.

`[project](https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-fields-reference-939938743.html?_ga=2.120961743.653490247.1683619460-1501883802.1680605612#Advancedsearchingfieldsreference-ProjectProject)`

`[projectsOfType](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/projects#projectsOfType)`

Find issues in projects of a particular type.

`[project](https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-fields-reference-939938743.html?_ga=2.120961743.653490247.1683619460-1501883802.1680605612#Advancedsearchingfieldsreference-ProjectProject)`

`[recentProjects](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/projects#recentProjects)`

Find projects in your recent history.

`[project](https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-fields-reference-939938743.html?_ga=2.120961743.653490247.1683619460-1501883802.1680605612#Advancedsearchingfieldsreference-ProjectProject)`

`[releaseDate](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/versions#releaseDate)`

Find issues by version release date.

`[fixVersion](https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-fields-reference-939938743.html?_ga=2.120961743.653490247.1683619460-1501883802.1680605612#Advancedsearchingfieldsreference-FixVersionfixVersionFixversion)`

`[removedAfterSprintStart](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/sprint#removedAfterSprintStart)`

Return issues removed from the sprint after the sprint start.

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`

`[startDate](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/versions#startDate)`

Find issues by version start date.

`[fixVersion](https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-fields-reference-939938743.html?_ga=2.120961743.653490247.1683619460-1501883802.1680605612#Advancedsearchingfieldsreference-FixVersionfixVersionFixversion)`

`[subtasksOf](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/sub-tasks#subtasksOf)`

Get the subtasks of issues matched by the subquery.

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`

`[versionMatch](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/match-functions#versionMatch)`

Match the version name by regular expression.

`[fixVersion](https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-fields-reference-939938743.html?_ga=2.120961743.653490247.1683619460-1501883802.1680605612#Advancedsearchingfieldsreference-FixVersionfixVersionFixversion)`

`[workLogged](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/worklogs#workLogged)`

Find issues by querying on worklogs, for example, when, by which user, etc.

`[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`
