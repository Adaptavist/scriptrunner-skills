# JQL Functions

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features
- Doc ID: doc-sr4js-5dac0602-c201-4e0f-bfde-58401f02b0a2-789f4fcf2f19b1e4
- Source: https://docs.adaptavist.com/sr4js/latest/features#jql-functions--en

|  |  |
| --- | --- |
|  | Migrating to Jira Cloud? This feature has partial parity in Cloud.<br>[Cloud Feature Parity documentation](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/scriptrunner-migration-to-cloud/feature-parity-and-script-alternatives#jql-functions--en) |

Use ScriptRunner JQL functions to extend Jira's built-in capabilities, allowing you to conduct more granular searches, and obtain more detailed information about what is happening in your instance and projects.

## How to use ScriptRunner JQL Functions

There are two ways to use ScriptRunner JQL functions:

-   Use one of our 40+ [out-of-the-box ScriptRunner JQL functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions) (available to all users).
-   Create [custom JQL functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/custom-jql-functions) using Groovy without having to learn the Atlassian SDK (administrators only).

You can use ScriptRunner JQL functions anywhere you are able to use Jira JQL functions. These include: as part of a JQL search in the Jira Issue Navigator ( _Advanced_ and _Basic_ view), in gadgets, or within your own custom scripts.

Below are just some examples of how you can use ScriptRunner JQL functions:

-   Use [epicsOf](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#find-epics-of-a-subquery-epicsof--en) to query on epic links, such as finding all epics that have unresolved stories.
-   Use [issuesInEpics](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#find-issues-in-epics-issuesinepics--en) to find all stories for open epics in a project, and then look specifically at the status of issues, such as 'in progress.'
-   Use [linkedIssuesOf](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#find-linked-issues-of-a-subquery-linkedissuesof--en) to return linked issues, such as all unresolved issues that are blocked by open issues.
-   Use [parentsOf](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/sub-tasks#find-all-parents-of-issues-specified-by-a-subquery-parentsof--en) to return the parents of issues that you specify in a subquery.
-   Use [hasLinkType](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#find-issues-with-specific-link-types-haslinktype--en) to see which issues which are blockers in a project.

## ScriptRunner JQL AI

If you're not sure where to start with JQL Functions or are in need of a quick search filter, try our JQL AI. Simply type in what you would like to search for and our AI tool will provide you with your search in JQL format.

Note: This JQL AI is a standalone feature and is not embedded into the ScriptRunner app.

[Media](https://leap.scriptrunnerhq.com/)

Note: Disclaimer

This tool is AI-powered and we cannot guarantee the accuracy of the content generated. If you spot something that doesn't look right, please use the feedback buttons at the bottom of this page to let us know. For the best experience, please use this tool on a desktop.

In addition, we advise you to verify the search queries before using them elsewhere (for example, in a script).

## Using ScriptRunner JQL Functions in the Issue Navigator (all users)

Tip: What is issueFunction?

The `issueFunction` field comes built-in with ScriptRunner and allows you to run most ScriptRunner JQL functions. Find out more on the [JQL Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial) page.

### Issue Navigator Basic view

You can use JQL functions in the _Basic_ view of the issue navigator. To access ScriptRunner JQL functions:

1.  Select the More drop-down option, then issueFunction.
    
2.  Click Add Function.
    
    The _Add ScriptRunner JQL Function_ dialog appears.
    
3.  Start typing a search, or scroll through the on-screen options, and select the JQL function you require from the Function drop-down.
    
    The _Add ScriptRunner JQL Function_ screen updates to show all required fields for the selected function.
    
4.  Fill in all required fields and click Add Function.
    

Note: You can add multiple ScriptRunner JQL functions in the _Basic_ view. When multiple functions are added the AND operator is used. You can also switch freely between the _Basic_ and _Advanced_ views.

### Issue Navigator Advanced view

Use JQL functions in the _Advanced_ view of the issue navigator. JQL functions that operate on issues are used by entering `issueFunction in` or `issueFunction not in`, and then the function name.

The drop-down shows suggestions along with any required or optional arguments.

## See all configured functions (administrator users)

Find JQL Functions within ScriptRunner in the _Administration_ area by clicking the JQL Functions tab. Alternatively, click JQL Functions from the left-hand menu.

The _JQL Function_ page displays a list of all available ScriptRunner JQL functions registered and enabled on your instance, along with performance and execution history. You can also check out the [Included JQL Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions) page for a summary of all available functions.

## Before you Start

|  |  |
| --- | --- |
|  | See our JQL Functions tutorial to learn more about what a JQL function is and how you can utilize them in your instance.<br>[JQL Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial) |
|  | Don't know where to start? Read our blog on the top 10 ScriptRunner JQL functions and download a handy reference guide.<br>[Top 10 JQL Functions](https://www.adaptavist.com/blog/top-10-most-commonly-used-jira-query-language-functions) |
