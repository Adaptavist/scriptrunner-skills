# Date Functions

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > scriptrunner-enhanced-search > scriptrunner-enhanced-search-jql-functions > date-and-time-management
- Doc ID: doc-sr4jc-313196636
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/date-and-time-management/date-functions

You can use Date functions, for instance now(), startOfDay() etc, anywhere you would use a date. Supported functions include:

-   [now()](https://confluence.atlassian.com/jirasoftwarecloud/advanced-searching-functions-reference-764478342.html#Advancedsearching-functionsreference-nownow\(\))
    
-   [startOfDay()](https://confluence.atlassian.com/jirasoftwarecloud/advanced-searching-functions-reference-764478342.html#Advancedsearching-functionsreference-startOfDaystartOfDay\(\))
    
-   [startOfMonth()](https://confluence.atlassian.com/jirasoftwarecloud/advanced-searching-functions-reference-764478342.html#Advancedsearching-functionsreference-startOfMonth)
    
-   [startOfWeek()](https://confluence.atlassian.com/jirasoftwarecloud/advanced-searching-functions-reference-764478342.html#Advancedsearching-functionsreference-startOfWeek)
    
-   [startOfYear()](https://confluence.atlassian.com/jirasoftwarecloud/advanced-searching-functions-reference-764478342.html#Advancedsearching-functionsreference-startOfYear)
    
-   [endOfDay()](https://confluence.atlassian.com/jirasoftwarecloud/advanced-searching-functions-reference-764478342.html#Advancedsearching-functionsreference-endOfDay)
    
-   [endOfMonth()](https://confluence.atlassian.com/jirasoftwarecloud/advanced-searching-functions-reference-764478342.html#Advancedsearching-functionsreference-endOfMonth)
    
-   [endOfWeek()](https://confluence.atlassian.com/jirasoftwarecloud/advanced-searching-functions-reference-764478342.html#Advancedsearching-functionsreference-endOfWeek)
    
-   [endOfYear()](https://confluence.atlassian.com/jirasoftwarecloud/advanced-searching-functions-reference-764478342.html#Advancedsearching-functionsreference-endOfYear)
    

Some arguments will need to be quoted. For example, if you want to say one week before the start of the month, you would write `startOfMonth('-1w')`.

## Differences with ScriptRunner for Jira Server

You can read about the differences between ScriptRunner for Jira Server and Jira Cloud advanced JQL functions in the side-by-side comparison [here](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/comparison-with-scriptrunner-for-jira-server#id-.ComparisonwithScriptRunnerforJiraServervDraft-JQLQueryComparison). There is also a [Feature Parity and Script Alternatives](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/feature-parity-and-script-alternatives) table which outlines feature differences that includes JQL functions.

Functions `startOfWeek()` and `endOfWeek()` return Monday as the first day of the week and they take time in UTC. If you use Sunday instead of Monday, you can use -1d period modificator, e.g. `startOfWeek('-1d').`

## Time windows

Use time windows on both side of the expression. For example, if you needed to find issues resolved before or up to six days after their due date:

```
issueFunction in dateCompare("project = DEMO", "resolutiondate +1d < duedate +1w")
```

## Created and updated

Use `created` or `updated` to find issues based on when they were created or updated. For example, to find issues that were resolved within two weeks of creation, use:

```
issueFunction in dateCompare("project = DEMO", "created +2w > resolutiondate ")
```

## Datetime custom fields

Use date and datetime custom fields. For example:

```
issueFunction in dateCompare("project = DEMO", "resolutiondate > customfield_10500")
```

(where customfield\_10500 is the name of a 'date' custom field).

## Operators

### Equal to operator

Use the equality operator `=` to find issues that have been resolved on the same date that’s in a custom field:

```
issueFunction in dateCompare("project = DEMO", "resolutiondate = customfield_10500")
```

If your date contains time, equality operator won’t be useful. Use the clearTime() method described below.

### Greater than or equal to operator

Use the greater or equal operator `>=` to find issues that have been resolved on or after the same date that’s in a custom field:

```
issueFunction in dateCompare("project = DEMO", "resolutiondate >= customfield_10500")
```

### Smaller or equal to operator

Use the smaller or equal operator `⇐` to find issues that have been resolved on or before the same date that’s in a custom field:

```
issueFunction in dateCompare("project = DEMO", "resolutiondate <= customfield_10500")
```

### Not equal to operator

Use the not equal operator `!=` to find issues that have been resolved on a different date than that’s in a custom field:

```
issueFunction in dateCompare("project = DEMO", "resolutiondate != customfield_10500")
```

### Clear time operator

Use the `.clearTime()` method to get the date part of a `date` or `datetime` field. The date is converted to the user’s timezone, before the date is extracted:

```
issueFunction in dateCompare("project = DEMO", "customfield_10500.clearTime() = duedate.clearTime()")
```
