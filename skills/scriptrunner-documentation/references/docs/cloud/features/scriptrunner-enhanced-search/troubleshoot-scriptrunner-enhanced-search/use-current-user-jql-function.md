# Use currentUser JQL Function

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > scriptrunner-enhanced-search > troubleshoot-scriptrunner-enhanced-search
- Doc ID: doc-sr4jc-566298273
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/troubleshoot-scriptrunner-enhanced-search/use-currentuser-jql-function

[currentUser](https://support.atlassian.com/jira-software-cloud/docs/jql-functions/#:~:text=created%20%3E%20currentLogin\(\)-,currentUser) is a native JQL function from Atlassian used to perform searches based on the currently logged in user. However, if you use `currentUser`inside of an Enhanced Search function, the query returns results for the owner of the filter not the user currently viewing the filter. 

If you want the filter to by dynamic, switching the user based on who is viewing the filter, you have two options:

-   Move `currentUser` outside of the Enhanced Search function.

Native JQL Function

Modified for Enhanced Search

linkedIssuesOf("assignee = currentUser90")

linkedIssuesOf(“assignee = <accountId of filter owner>”)

linkedIssuesOf(“query”) and assignee = currentUser()

This shows the function moved outside of the query.

-   Put `currentUser` in a separate filter and refer to it inside of the Enhanced Search function. 

  

  

linkedIssuesOf("assignee = currentUser90")

filter 1: assignee = currentUser()

filter 2:  linkedIssuesOf(“filter= filter1”)
