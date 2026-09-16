# Use currentUser JQL Function

- Platform: cloud
- Space: SR4JC
- Hierarchy: Features > ScriptRunner Enhanced Search > Troubleshoot ScriptRunner Enhanced Search
- Doc ID: doc-sr4jc-51b212ae-9ab1-4df9-967a-937b74f031e0-4a1c7addb1482770
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search#troubleshoot-scriptrunner-enhanced-search--en#use-currentuser-jql-function--en

[currentUser](https://support.atlassian.com/jira-software-cloud/docs/jql-functions/#:~:text=created%20%3E%20currentLogin\(\)-,currentUser) is a native JQL function from Atlassian used to perform searches based on the currently logged in user. However, if you use `currentUser`inside of an Enhanced Search function, the query returns results for the owner of the filter not the user currently viewing the filter.

If you want the filter to by dynamic, switching the user based on who is viewing the filter, you have two options:

-   Move `currentUser` outside of the Enhanced Search function.

<table class="table" id="use-currentuser-jql-function--en__generated-table-id-1"><caption></caption><colgroup><col><col></colgroup><thead class="thead"><tr class="row"><th class="entry" id="use-currentuser-jql-function--en__generated-table-id-1__entry__1">Native JQL Function</th><th class="entry" id="use-currentuser-jql-function--en__generated-table-id-1__entry__2">Modified for Enhanced Search</th></tr></thead><tbody class="tbody"><tr class="row"><td class="entry" headers="use-currentuser-jql-function--en__generated-table-id-1__entry__1 use-currentuser-jql-function--en__generated-table-id-1__entry__2 " rowspan="2">linkedIssuesOf("assignee = currentUser90")</td><td class="entry" headers="use-currentuser-jql-function--en__generated-table-id-1__entry__1 use-currentuser-jql-function--en__generated-table-id-1__entry__2 ">linkedIssuesOf("assignee = &lt;accountId of filter owner&gt;")</td></tr><tr class="row"><td class="entry" headers="use-currentuser-jql-function--en__generated-table-id-1__entry__1 use-currentuser-jql-function--en__generated-table-id-1__entry__2 "><p class="p">linkedIssuesOf("query") and assignee = currentUser()</p>&#10;              <p class="p">This shows the function moved outside of the query.</p></td></tr></tbody></table>

-   Put `currentUser` in a separate filter and refer to it inside of the Enhanced Search function.

|  |  |
| --- | --- |
| linkedIssuesOf("assignee = currentUser90") | filter 1: assignee = currentUser()<br>filter 2: linkedIssuesOf("filter= filter1") |
