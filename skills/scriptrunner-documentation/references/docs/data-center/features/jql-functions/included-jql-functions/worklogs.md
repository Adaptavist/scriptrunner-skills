# Worklogs

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > JQL Functions > Included JQL Functions
- Doc ID: doc-sr4js-3971d241-8bdb-45b8-8692-e15d7283aa85-3587af86e05a0240
- Source: https://docs.adaptavist.com/sr4js/latest/features#jql-functions--en#included-jql-functions--en#worklogs--en

## Find issues by querying on logged work (workLogged)

Use workLogged() to find issues by querying on logged work, for example, when, by which user, etc.

```
issueFunction in workLogged("worklog query")
```

### Supported arguments

The following arguments are supported when writing your logged work query:

-   `after` date
    
    For example `"after 2025/03/28"`.
    
-   `before` date
    
    For example `"before 2025/03/28"`.
    
-   `by` username or user function
    
    For example `"by admin"` or `"by currentUser()"`.
    
-   `inRole` role
    
    For example `"inRole Administrators"`.
    
-   `inGroup` group
    
    For example `"inGroup jira-administrators"`.
    

### Passing dates in your arguments

Warning: Results may be inconsistent when you pass date and time in your argument. This is due to the way Jira stores the date and times of the logged work. Where possible, we recommend you only pass a date in your argument to avoid incorrect results when running a search.

The following date formats are supported in your arguments:

-   `yyyy/MM/dd`
    
    For example `"after 2025/03/25"`.
    
-   `yyyy-MM-dd`
    
    For example `"after 2025-03-25"`.
    
-   Period format
    
    For example `"after -5d"`.
    
-   Date function
    
    For example `"after startOfMonth()"` or `"after endOfMonth()"` or `"before startOfDay()"` or `"before lastLogin()"` etc.
    

### workLogged examples

If we want to find issues with work logged by someone with the username _admin_ on the 28 March 2025, we would use the following:

```
issueFunction in workLogged("on 2025/03/28 by admin")
```

If we want to find all issues with logged work by members of the _Developers_ role in the previous calendar month, we would use the following:

```
issueFunction in workLogged("after startOfMonth(-1) before endOfMonth(-1) inRole Developers")
```

Note: If today is 1 April, this query would return all issues that had work logged on them by developers during the entire month of March.

If we want to find all issues with worked logged by someone with the username _admin_ anytime after 12:30 on the 25 March 2025, we would use the following:

Warning: Results may be inconsistent when you pass date and time in your argument. This is due to the way Jira stores the date and times of the logged work. Where possible, we recommend you only pass a date in your argument to avoid incorrect results when running a search.

```
issueFunction in workLogged("by admin after \"2025/03/25 12:30\"")
```

## Related content

-   [JQL Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions)
-   [Included JQL Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions)
-   [JQL Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial)
