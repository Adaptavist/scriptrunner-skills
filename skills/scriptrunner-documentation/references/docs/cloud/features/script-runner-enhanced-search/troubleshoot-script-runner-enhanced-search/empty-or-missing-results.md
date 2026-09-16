# Empty or Missing Results

- Platform: cloud
- Space: SR4JC
- Hierarchy: Features > ScriptRunner Enhanced Search > Troubleshoot ScriptRunner Enhanced Search
- Doc ID: doc-sr4jc-59a7fa4f-1515-43bd-a8cc-77f1c681bc50-da83f87e232df05f
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search#troubleshoot-scriptrunner-enhanced-search--en#empty-or-missing-results--en

In many cases, search queries that return empty or missing results can be caused by filters that are too narrow. However, consideration should also be given to Enhanced Search permissions, as outlined below.

## Permissions

Search results will be incorrect or missing if permissions are not granted to view:

-   Edit all issues (edit permission is required to store the additional metadata).
-   All comments, including those restricted to a particular group/role.
-   All worklogs, including those restricted to a particular group/role.

If worklogs and comments are restricted to a role, ensure the role is assigned to the group the Enhanced Search for Jira Cloud user belongs to under _Project Settings_.

-   Ensure you have access to the projects and issues you expect to see.
-   Remember that shared filters may return fewer results for users with more limited permissions.

Enhanced Search for Jira Cloud users can only see comments and worklogs from the following groups:

-   jira-core-users
-   jira-servicedesk-users
-   jira-software-users
-   jira-servicemanagement-users-<sitename>
-   jira-workmgmt-users-<sitename>
-   jira-software-users-<sitename>

It's good practice to avoid tweaking permissions for the Add-On User, as this can cause many functions to not work as expected. This is particularly the case when restricting permissions. The add-on user is the user created for the add-on (ie, ScriptRunner or Enhanced Search), which has the permissions granted for the add-on. The add-on user should have the same account ID for all instances.

## How to avoid empty or missing results

Search queries often return no results because the filters applied are too narrow or unintentionally restrictive. The following steps can help you design queries that return the results you expect, without becoming overly broad.

<table class="table" id="empty-or-missing-results--en__generated-table-id-1"><caption></caption><thead class="thead"><tr class="row"><th class="entry" id="empty-or-missing-results--en__generated-table-id-1__entry__1">Steps</th><th class="entry" id="empty-or-missing-results--en__generated-table-id-1__entry__2">Details</th></tr></thead><tbody class="tbody"><tr class="row"><td class="entry" headers="empty-or-missing-results--en__generated-table-id-1__entry__1 empty-or-missing-results--en__generated-table-id-1__entry__2 ">Broaden filters incrementally</td><td class="entry" headers="empty-or-missing-results--en__generated-table-id-1__entry__1 empty-or-missing-results--en__generated-table-id-1__entry__2 ">&#10;                            <p class="p">If a query returns no results:</p>&#10;                            <ul class="ul"><li class="li">Remove one condition at a time to identify which filter is excluding results.</li><li class="li">Start with a broad query, confirm it returns results, then add filters gradually.</li></ul>&#10;                        </td></tr><tr class="row"><td class="entry" headers="empty-or-missing-results--en__generated-table-id-1__entry__1 empty-or-missing-results--en__generated-table-id-1__entry__2 ">Account for empty or unset fields</td><td class="entry" headers="empty-or-missing-results--en__generated-table-id-1__entry__1 empty-or-missing-results--en__generated-table-id-1__entry__2 ">&#10;                            <p class="p">Some issues may not have values set for certain fields.</p>&#10;                            <ul class="ul"><li class="li">If you filter on fields such as assignee, due date, or custom fields, consider whether those fields might be empty.</li><li class="li">Use <code class="ph codeph">OR field IS EMPTY</code> where appropriate.</li></ul>&#10;                            <p class="p">Example: <code class="ph codeph">assignee = currentUser() OR assignee IS EMPTY</code>&#10;                            </p>&#10;                        </td></tr><tr class="row"><td class="entry" headers="empty-or-missing-results--en__generated-table-id-1__entry__1 empty-or-missing-results--en__generated-table-id-1__entry__2 ">Verify field usage and Jira changes</td><td class="entry" headers="empty-or-missing-results--en__generated-table-id-1__entry__1 empty-or-missing-results--en__generated-table-id-1__entry__2 ">&#10;                            <p class="p">Jira Cloud evolves over time, and some fields behave differently or are deprecated.</p>&#10;                            <ul class="ul"><li class="li">Confirm you are using the correct fields (for example, <code class="ph codeph">Parent </code> instead of <code class="ph codeph">Epic Link</code>).</li><li class="li">Validate field names against your Jira instance, especially after migrations or configuration changes.</li></ul>&#10;                        </td></tr><tr class="row"><td class="entry" headers="empty-or-missing-results--en__generated-table-id-1__entry__1 empty-or-missing-results--en__generated-table-id-1__entry__2 ">Check logical operators</td><td class="entry" headers="empty-or-missing-results--en__generated-table-id-1__entry__1 empty-or-missing-results--en__generated-table-id-1__entry__2 ">&#10;                            <p class="p">Logical operators can narrow results more than intended.</p>&#10;                            <ul class="ul"><li class="li">Multiple <code class="ph codeph">AND</code> conditions require <em class="ph i">all</em> criteria to be true.</li><li class="li">Consider whether some conditions should be combined with <code class="ph codeph">OR</code> instead.</li></ul>&#10;                            <p class="p">Example: <code class="ph codeph">(status = "In Progress" OR status = "To Do") AND project = ES</code>&#10;                            </p>&#10;                        </td></tr><tr class="row"><td class="entry" headers="empty-or-missing-results--en__generated-table-id-1__entry__1 empty-or-missing-results--en__generated-table-id-1__entry__2 ">Test without Enhanced Search functions</td><td class="entry" headers="empty-or-missing-results--en__generated-table-id-1__entry__1 empty-or-missing-results--en__generated-table-id-1__entry__2 ">&#10;                            <p class="p">If a query includes Enhanced Search functions:</p>&#10;                            <ul class="ul"><li class="li">Test the inner JQL independently to confirm it returns results.</li><li class="li">Once validated, reintroduce the function.</li></ul>&#10;                            <p class="p">This helps determine whether the issue is caused by filtering logic or function behavior.</p>&#10;                        </td></tr><tr class="row"><td class="entry" headers="empty-or-missing-results--en__generated-table-id-1__entry__1 empty-or-missing-results--en__generated-table-id-1__entry__2 ">Use preview and saved filter checks</td><td class="entry" headers="empty-or-missing-results--en__generated-table-id-1__entry__1 empty-or-missing-results--en__generated-table-id-1__entry__2 ">&#10;                            <ul class="ul"><li class="li">Preview queries before saving them as shared filters.</li><li class="li">If a saved filter returns fewer results than expected, check whether background sync delays or timeouts may be involved.</li></ul>&#10;                        </td></tr></tbody></table>
