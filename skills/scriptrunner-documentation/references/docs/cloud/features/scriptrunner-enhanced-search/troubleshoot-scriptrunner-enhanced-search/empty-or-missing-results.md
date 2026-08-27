# Empty or Missing Results

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > scriptrunner-enhanced-search > troubleshoot-scriptrunner-enhanced-search
- Doc ID: doc-sr4jc-513345627
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/troubleshoot-scriptrunner-enhanced-search/empty-or-missing-results

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

It's good practice to avoid tweaking permissions for the Add-On User, as this can cause many functions to not work as expected. This is particularly the case when restricting permissions. The add-on user is the user created for the add-on (ie, ScriptRunner or Enhanced Search), which has the permissions granted for the add-on. The add-on user should have the same account ID for all instances.

## How to avoid empty or missing results

Search queries often return no results because the filters applied are too narrow or unintentionally restrictive. The following steps can help you design queries that return the results you expect, without becoming overly broad.

Steps

Details

Broaden filters incrementally

If a query returns no results:

-   Remove one condition at a time to identify which filter is excluding results.
-   Start with a broad query, confirm it returns results, then add filters gradually.

Account for empty or unset fields

Some issues may not have values set for certain fields.

-   If you filter on fields such as assignee, due date, or custom fields, consider whether those fields might be empty.
    
-   Use `OR field IS EMPTY` where appropriate.
    

Example: `assignee = currentUser() OR assignee IS EMPTY`

Verify field usage and Jira changes

Jira Cloud evolves over time, and some fields behave differently or are deprecated.

-   Confirm you are using the correct fields (for example, `Parent` instead of `Epic Link`).
    
-   Validate field names against your Jira instance, especially after migrations or configuration changes.
    

Check logical operators

Logical operators can narrow results more than intended.

-   Multiple `AND` conditions require _all_ criteria to be true.
    
-   Consider whether some conditions should be combined with `OR` instead.
    

Example: `(status = "In Progress" OR status = "To Do") AND project = ES`

Test without Enhanced Search functions

If a query includes Enhanced Search functions:

-   Test the inner JQL independently to confirm it returns results.
    
-   Once validated, reintroduce the function.
    

This helps determine whether the issue is caused by filtering logic or function behavior.

Use preview and saved filter checks

-   Preview queries before saving them as shared filters.
-   If a saved filter returns fewer results than expected, check whether background sync delays or timeouts may be involved.
