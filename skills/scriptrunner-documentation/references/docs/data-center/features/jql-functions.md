# JQL Functions

- Platform: data-center
- Space: SR4JS
- Hierarchy: features
- Doc ID: doc-sr4js-442886313
- Source: https://docs.adaptavist.com/sr4js/latest/features/jql-functions

![](/sr4js/files/latest/442886313/441364784/1/1750863586000/sr-icon-cloud.png)

**Migrating to Jira Cloud? This feature has partial parity in Cloud. Check out our [Cloud Feature Parity documentation](https://docs.adaptavist.com/display/_PK/SR4JC/feature-parity#jql-functions) for more details.**

Use ScriptRunner JQL functions to extend Jira's built-in capabilities, allowing you to conduct more granular searches, and obtain more detailed information about what is happening in your instance and projects.

## How to use ScriptRunner JQL Functions

There are two ways to use ScriptRunner JQL functions: 

-   Use one of our 40+ [out-of-the-box ScriptRunner JQL functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions) (available to all users).
-   Create [custom JQL functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/custom-jql-functions) using Groovy without having to learn the Atlassian SDK (administrators only).

You can use ScriptRunner JQL functions anywhere you are able to use Jira JQL functions. These include: as part of a JQL search in the Jira Issue Navigator (_Advanced_ and _Basic_ view), in gadgets, or within your own custom scripts. 

Below are just some examples of how you can use ScriptRunner JQL functions:

-   Use [epicsOf](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#id-.IssueLinksv9.x-epicsOf) to query on epic links, such as finding all epics that have unresolved stories.
-   Use [issuesInEpics](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#id-.IssueLinksv9.x-issuesInEpics) to find all stories for open epics in a project, and then look specifically at the status of issues, such as ‘in progress.’
    
-   Use [linkedIssuesOf](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#id-.IssueLinksv9.x-linkedissuesof) to return linked issues, such as all unresolved issues that are blocked by open issues. 
-   Use [parentsOf](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/sub-tasks#id-.Subtasksv9.x-parents) to return the parents of issues that you specify in a subquery.
-   Use [hasLinkType](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#id-.IssueLinksv9.x-haslinktype) to see which issues which are blockers in a project. 

## ScriptRunner JQL AI

If you're not sure where to start with JQL Functions or are in need of a quick search filter, try our JQL AI. Simply type in what you would like to search for and our AI tool will provide you with your search in JQL format. 

This JQL AI is a standalone feature and is not embedded into the ScriptRunner app.

&amp;amp;amp;lt;p&amp;amp;amp;gt;&amp;amp;amp;lt;br/&amp;amp;amp;gt;&amp;amp;amp;lt;/p&amp;amp;amp;gt;

Disclaimer

This tool is AI-powered and we cannot guarantee the accuracy of the content generated. If you spot something that doesn't look right, please use the feedback buttons at the bottom of this page to let us know. For the best experience, please use this tool on a desktop.

In addition, we advise you to verify the search queries before using them elsewhere (for example, in a script).

Using ScriptRunner JQL Functions in the Issue Navigator (all users)

What is issueFunction?

The `issueFunction` field comes built-in with ScriptRunner and allows you to run most ScriptRunner JQL functions. Find out more on the [JQL Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function) page.

### Issue Navigator _Basic_ view

You can use JQL functions in the _Basic_ view of the issue navigator. To access ScriptRunner JQL functions:

1.  Select the **More** drop-down option, then **issueFunction**.  
    ![Image showing issueFunction being selected](/sr4js/files/latest/442886313/442886322/1/1758746681000/JQL_select_issue_function.png)
2.  Click **Add Function**.  
    ![Image showing Add function being selected](/sr4js/files/latest/442886313/442886345/1/1758746682000/JQL_select_add_function.png)  
    The _Add ScriptRunner JQL Function_ dialog appears.
3.  Start typing a search, or scroll through the on-screen options, and select the JQL function you require from the **Function** drop-down.   
    The _Add ScriptRunner JQL Function_ screen updates to show all required fields for the selected function.
4.  Fill in all required fields and click **Add Function**.  
    ![Image showing example function](/sr4js/files/latest/442886313/442886334/1/1758746681000/JQL_add_function.png)

You can add multiple ScriptRunner JQL functions in the _Basic_ view. When multiple functions are added the AND operator is used. You can also switch freely between the _Basic_ and _Advanced_ views.

### Issue Navigator _Advanced_ view

Use JQL functions in the _Advanced_ view of the issue navigator. JQL functions that operate on issues are used by entering `issueFunction in` or `issueFunction not in`, and then the function name.

The drop-down shows suggestions along with any required or optional arguments.

![](/sr4js/files/latest/442886313/442886314/1/1758746678000/2022-02-08_11-14-30+%281%29.gif)

## See all configured functions (administrator users)

Find JQL Functions within ScriptRunner in the _Administration_ area by clicking the **JQL Functions** tab. Alternatively, click **JQL Functions** from the left-hand menu.

The _JQL Function_ page displays a list of all available ScriptRunner JQL functions registered and enabled on your instance, along with performance and execution history. You can also check out the [Included JQL Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions) page for a summary of all available functions. 

![Image of JQL Functions screen](/sr4js/files/latest/442886313/442886335/1/1758746681000/JQL_functions.png)

## Before you Start

![](/sr4js/files/latest/442886313/442886351/1/1758746683000/Copy+of+sr-icon-mortar-board.png)

See our JQL Functions tutorial to learn more about what a JQL function is and how you can utilize them in your instance.

  

![](/sr4js/files/latest/442886313/442886350/1/1758746683000/sr-icon-search.png)

Don't know where to start? Read our blog on the top 10 ScriptRunner JQL functions and download a handy reference guide. 

JQL Functions Tutorial

  

[shortcut Top 10 JQL Functions](https://www.adaptavist.com/blog/top-10-most-commonly-used-jira-query-language-functions)
