# Script Fields

- Platform: data-center
- Space: SR4JS
- Hierarchy: features
- Doc ID: doc-sr4js-442888739
- Source: https://docs.adaptavist.com/sr4js/latest/features/script-fields

![](/sr4js/files/latest/442888739/441364754/1/1750863693000/sr-icon-cloud.png)

**Migrating to Jira Cloud? This feature has partial parity in Cloud. Check out our [Cloud Feature Parity documentation](https://docs.adaptavist.com/display/_PK/SR4JC/feature-parity#script-fields) for more details.**

## Before you start

![](/sr4js/files/latest/442888739/441364565/1/1742383748000/Copy+of+sr-icon-mortar-board.png)

See our training module to learn about setting up and using script fields.

  

![](/sr4js/files/latest/442888739/441364570/1/1742383748000/sr-icon-book.png)

Broaden your horizons by exploring the Example Scripts for script fields.

[Script Field Training](https://docs.adaptavist.com/sr4js/latest/training/course-introduction-to-scriptrunner-for-jira-data-center-server/1-4-video-using-script-fields-in-scriptrunner-for-jira-data-center-server)

  

[shortcut Example Scripts](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=script-fields&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=dataCenter)

## What are script fields?

_Script Fields_ are custom fields that dynamically calculate and display values based on built-in and custom scripts_._ They enable you to display information that would otherwise be unavailable for an issue by calculating or aggregating data from one or more existing fields.

## How to use script fields

You could use a script field to:

-   Pull in data from an external system (such as a connected database).
-   Show a value from a linked instance. 
-   Show a value calculated from the values of other issue fields.
-   Show a value calculated from the values of fields in other issues.

When writing a script, it's good practice to keep the scripts as simple as possible so as to reduce loading time. 

ScriptRunner _Script Fields_ are not available on the _Issue Detail_ view of scrum or kanban boards.

You cannot manually edit the value, or update the value of a script field as the value is calculated at the time an issue is displayed or updated (in exactly the same way as a custom field plugin). It is possible to search on these values, as explained below.

### Searchers

You can run a search on your script fields provided it has a _Searcher_ associated with it. 

A searcher is equivalent to the [**Search Template**](https://confluence.atlassian.com/adminjiraserver104/editing-or-deleting-custom-fields-1527942385.html#:~:text=field%20on%20issues.-,Search%20templates%2C,-which%C2%A0are%20responsible) that come default with custom fields. Built-in script fields are automatically given a searcher. For most custom script fields you have to add your own searcher by selecting the searcher field, selecting the appropriate search template, and performing a re-index.

![Image showing how to add a searcher](/sr4js/files/latest/442888739/441364558/1/1742473553000/Script_fields_searcher.jpg)

Make sure to choose the correct template before you create your field because once you have a searcher defined, it may require a full re-index to change it to another **Search Template** if the types are incompatible.

Be cautious when converting to the _Stattable_ version of indexers. _Stattable_ searchers can be used in gadgets. In instances with hundreds of thousands of possible unique string values, the memory demand of Jira increases and may run out if required to render gadgets for fields using these searchers. Therefore, you should only use these indexers if your script field generates a finite number of possible string values (several thousand should be okay).

## Available script fields

We have developed a number of built-in script fields for you to use in your Jira instance:

-   [Database picker](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/database-picker): Pick an item from a linked database. 
-   [Custom picker](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/custom-picker): Write your own picker, for example using a REST resource or a Jira object.
-   [Date of first transition](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/date-of-first-transition): Shows the date when the field first transitioned into a required state.
-   [Issue(s) picker](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/issue-picker):Select another issue, optionally constrained into a required state.
-   [Number of times In status](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/number-of-times-in-status): Show the number of times a given issue has been in the selected status.
-   [Show parent issue in hierarchy](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/show-parent-issue-in-hierarchy): Show an issue's parent issue where you define what _parent_ means. 
-   [Remote issue picker](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/remote-issue-picker): Select issue(s) from a linked Jira instance, optionally constrained by a JQL query.
-   [Time of last status change](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/time-of-last-status-change): Displays a timestamp of when the issue last had its status changed.
-   [LDAP picker](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/ldap-picker): Pick an LDAP record(s) from a predefined query.

We have also created a number of [custom script field examples](https://docs.adaptavist.com/sr4js/latest/features/script-fields/custom-script-field/custom-script-field-examples) you can use. 

## Create a script field

You can create some script fields through the **Add custom field** button on the _Custom fields_ page, however we recommend you create all of your script fields from within Scriptrunner. 

You can create a script field as follows:

1.  From **ScriptRunner**, select the **Fields** tab.
2.  Select **Create Script Field**.  
    ![](/sr4js/files/latest/442888739/442888764/1/1758746967000/Script_field.png)  
    
3.  Select the type of script field you want to add and continue to the relevant documentation page:  
    -   [Database picker](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/database-picker)  
        
    -   [Custom script field](https://docs.adaptavist.com/sr4js/latest/features/script-fields/custom-script-field)
    -   [Custom picker](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/custom-picker)
    -   [Date of first transition](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/date-of-first-transition)
    -   [Issue(s) picker](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/issue-picker)
    -   [Number of times In status](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/number-of-times-in-status)
    -   [Show parent issue in hierarchy](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/show-parent-issue-in-hierarchy)
    -   [Remote issue picker](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/remote-issue-picker)
    -   [Time of last status change](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/time-of-last-status-change)
    -   [LDAP picker](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/ldap-picker)

## Caching

The calculated value of a script field is cached for 10 seconds and we can cache up to 40,000 objects. If you refresh an issue and don't see a change, it may be because you're seeing the cached value. If you wait more than 10 seconds then it should reflect the updated value.

If your script relies on data from external system you can invalidate the cache altogether, although you should test first, particularly if you are doing things like running complex JQL queries. To disable the cache add the following line to your code:

```
enableCache = {-> false}
```

You can use any other variables to return a Boolean. You may have to do this if you are computing data from linked issues, however the indexed value should always be correct.

If your field relies on data outside its scope and you want to search on it, we recommend that you [write your own searcher](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/custom-jql-functions) (custom JQL).

## Performance and execution history

On the **Script Fields** page we provide _Performance_ and _History_ columns that display performance execution history records for custom script fields. 

Please note that performance and execution history records are **only available for custom script fields.** _Performance_ and _History_ will remain blank in the rows of custom fields created from built-in scripts.

  

* * *

## Related content

-   [Custom Script Field](https://docs.adaptavist.com/sr4js/latest/features/script-fields/custom-script-field)
-   [Custom Script Field Examples](https://docs.adaptavist.com/sr4js/latest/features/script-fields/custom-script-field/custom-script-field-examples)
-   [Built-In Script Fields](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields)
