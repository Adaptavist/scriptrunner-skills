# Calculations

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > jql-functions > included-jql-functions
- Doc ID: doc-sr4js-442887225
- Source: https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/calculations

This page provides information on functions used to perform calculations:

## Compare attributes of fields (`expression`)

Use `expression()` to compare attributes of system duration and date fields, and any numeric, date, or datetime custom fields:

```
issueFunction in expression("subquery", "expression")
```

For example, you may want to use this function to find issues that have more time spent on them than what was originally estimated. 

### Supported fields

This function supports the following fields in your expression:

This is not an extensive list of supported fields. If you are using an unsupported field, you will receive an error message telling you it is unsupported.

-   Duration field types:
    -   Time spent (`timeSpent`)
    -   Original estimate (`originalEstimate`)
    -   Remaining estimate (`remainingEstimate`)
-   Date field types:
    -   Created (`created`)
    -   Due (`due`)
    -   Last viewed (`lastViewed`)
    -   Resolved (`resolved`)
    -   Updated (`updated`)
-   Number field types:  
    -   Votes (`votes`)
    -   Work ratio (`workRatio`)
-   Custom fields:
    -   Date picker (`CustomFieldName`)
    -   Date time picker (`CustomFieldName`)
    -   Number field (`CustomFieldName`)
-   User fields:
    -   Creator (`creator`)
    -   Reporter (`reporter`)
    -   Assignee (`assignee`)

### **Supported functions**

You can use all of the _Date_ and _User_ [functions](https://confluence.atlassian.com/jirasoftwareserver072/advanced-searching-functions-reference-829057413.html), for example, `now()`, `startOfDay()`, and anywhere you use a date.

Some arguments will need to be quoted. For example, if you want to say one week before the start of the month you would write `startOfMonth('-1w').`

### `expression` examples

There are many possibilities with this function, below we provide some common examples:

#### Work logged vs time spent examples

We want to find any issues where more work was logged than originally estimated:

```
issueFunction in expression("", "timespent > originalestimate")
```

This can also be achieved using plain JQL (`workratio > 1) h`owever with plain JQL you can not find issues which are _likely_ to exceed their estimate.

We want to find all issues on track to exceed their work estimate:

```
issueFunction in expression("", "timespent + remainingestimate > originalestimate")
```

We want to narrow down the filter by adding a subquery. We use the `resolution is empty` subquery, to filter out issues that have been completed:

```
issueFunction in expression("resolution = empty", "timespent + remainingestimate > originalestimate")
```

We want to find any issues where the time spent exceeded the original estimate by more than 5 working days (normalised for timetracking, so > 40 hours work logged):

```
issueFunction in expression("", "timespent > originalestimate + 5*wd")
```

Use `5*d` or `5*wd` and not `5d` as in `dateCompare`. The syntax is different.

Notes on time tracking

A "day" can mean different things in different contexts. When comparing dates, we normally think in terms of the difference between two dates being 24 hour days. However, when comparing estimate fields, a day is normally thought of as an 8-hour working day, or what the Jira time tracking is configured to be. Similarly, a week usually consists of 5 working days.

If you want to compare estimates adjusted for time tracking, you need to explicitly specify either working day units:

-   **wd -** Number of milliseconds in a working day (according to your specification in **Admin > Time tracking**).
-   **ww -** Number of days in a working week multiplied by the wd value.

Alternatively, if you are comparing time tracking fields with non-time tracking fields, for example **remaining effort** and **due date**, you need to use the `fromTimeTracking` function.

For example, if we want to search for issues which are going to miss their due date based on their remaining estimate, we would use the following:

```
issueFunction in expression("resolution is empty", "now() + fromTimeTracking(remainingestimate) > duedate")
```

When you specify an estimate of 3 days, Jira stores that internally as 24 hours (when wd is set to 8, wd\*3), and renders it as 3 days for estimate fields. The `fromTimeTracking` function converts that to 72 hours (24\*3) so it can be used to manipulate and compare with other dates.

#### Custom field examples

Custom field names

Custom field names are likely to have spaces, which can’t be parsed. If your custom field name has spaces, remove them when referencing this custom field with this function. It’s not case-sensitive but use camel-case for maximum readability. If your field names have any other punctuation you must use the format customfield\_12345.

You can only use custom fields that have a configured searcher, as, for performance reasons, we only retrieve values from the Lucene index. The standard searchers are supported, searchers supplied by plugins will not work.

We want to find issues which have a certain ROI (return on investment) value. To do this we want to show issues who's story points (max 3) divided by business value (max 100) is more than 50:

```
issueFunction in expression("", "StoryPoints / BusinessValue > 50")
```

We want to show all issues created by the team on behalf of a customer. To do this we want to find issues where the _creator_ is not equal to the _reporter:_

```
issueFunction in expression("", "creator != reporter")
```

We want to find issues that are due on the same day they were created:

```
issueFunction in expression("", "created.clearTime() == dueDate")
```

We want to find issues with a specific due date:

```
issueFunction in expression("", "dueDate == date('2018-05-10')")
```

Use **date** function when you need to compare date in expression. The function takes date as `string` and returns a timestamp. To get the desired result use **clearTime** with Jira fields such as _created_ or _updated_ to remove time if you wish to use `==` operator with **date** function.

We want to find issues that have a high ratio of votes to complexity (assuming _Complexity_ is a numeric field):

```
issueFunction in expression("", "votes / Complexity > 100")
```

#### Conversions

Fields are passed to your expression with certain types, so you can do arithmetic and comparison:

-   **Durations, such as time tracking, or where you have used the Duration searcher:** Provided as a Long value of the number of milliseconds.
-   **DatesA java.sql:** Timestamp object. Where there is no time component such as with due date, the time portion will be set to midnight on that date. You can use the `.clearTime()` method to clear the time portion for `==` comparisons with other dates.
-   **Users:** A String containing the user key. This is sufficient as they are just used for equality comparisons.

In addition you can add a date field to a duration and get a new date.

## Summarise data in fields (`aggregateExpression`)

Use `aggregateExpression()`  to perform calculations and display summary data based on the issues in your current filter or query. This function allow you to aggregate values across multiple issues, giving you valuable insights at a glance.

```
issueFunction in aggregateExpression("Label", "Expression")
```

### aggregateExpression examples

We want to see the total time estimate for all issues in the SSP project:

```
project = SSP and issueFunction in aggregateExpression("Total Estimate for all Issues", "originalEstimate.sum()")
```

  

![Image of search results](/sr4js/files/latest/442887225/441364556/1/1742307064000/Aggregate_expression_1.jpg)

We want to see the total story point estimate for all issues in the SSP project:

```
project = SSP and issueFunction in aggregateExpression("Total Story Point Estimate for all Issues", "storypoints.sum()")
```

![Image of search results](/sr4js/files/latest/442887225/441364553/1/1742310573000/Aggregate_expression_4.jpg)

Multiple values

You can choose to display multiple values as follows:

```
issueFunction in aggregateExpression("Label 1", "Expression 1","Label 2", "Expression 2",...)
```

 For example, we want to show all remaining work and the initial estimate for all issues in the SSP project:

```
project = SSP and issueFunction in aggregateExpression("Total Estimate for all Issues", "originalEstimate.sum()", "Remaining work", "remainingEstimate.sum()")
```

![Image of search results](/sr4js/files/latest/442887225/441364555/2/1758792990000/Aggregate_expression_3.jpg)

#### Further examples

The below table details further examples that summarise data. You can use the following examples with `aggregateExpression()`, as shown above:

Label

Expression

Total time spent on these issues

timespent.sum()

Average original estimate of these issues

originalestimate.average()

Average work ratio

workratio.average()

Note: Will display as a decimal (e.g. 0.12 rather than 12%)

Total remaining work

remainingEstimate.sum()

Tracking error

(originalEstimate.sum() - timeSpent.sum()) / remainingEstimate.sum()

Number of issues in this list created by a user

reporter.count('username')

Simple breakdown of reporter but you’re probably better off using a pie chart as this is not displayed nicely at the moment

reporter.countBy{it}

  

* * *

## Related content

-   [Match Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/match-functions)
-   [Included JQL Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions)
-   [JQL Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial)
