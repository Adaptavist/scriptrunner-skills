# Date

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > jql-functions > included-jql-functions
- Doc ID: doc-sr4js-441364692
- Source: https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/date

This page provides information on functions used to search for issues by date:

## Compare dates on an issue (`dateCompare`)

Use `dateCompare` to compare dates on an issue:

```
issueFunction in dateCompare("Subquery", "date comparison expression")
```

Supported operators

The comparison operators available in this function are `<`, `>`, `<=`, `>=`, `=`. The use of the "`!=`" operator when using the `dateCompare` function is only supported on ScriptRunner for Jira Cloud. However, you can achieve the same result by using "`=`" and negating the JQL clause itself in ScriptRunner for Jira Server/DC.

### Supported date fields

The following date fields are supported by this function:

-   `created`
-   `dueDate`
-   `resolutionDate`
-   `firstCommented`. This is a hidden ScriptRunner field for the `dateCompare` JQL that gets the date of the first comment on an issue. 
-   `lastCommented`. This is a hidden ScriptRunner field for the `dateCompare` JQL that gets the date of the last comment on an issue. 
-   **Date picker** custom fields
-   **Date Time Picker** custom fields

Custom field names

When using the `dateCompare()` function, custom fields with multiple words (such as _Delivery Date_) do not require quotation marks in the date comparison expression. The function recognizes these multi-word field names without additional formatting. For example:

```
issueFunction in dateCompare("", "resolutionDate > Delivery Date")
```

### Examples

We want to find all issues that were resolved later than their due date:

```
issueFunction in dateCompare("", "resolutionDate > dueDate")
```

Time windows

You can use time windows on either side of your expression. For example, to find issues resolved before or up to one week after their due date:

```
issueFunction in dateCompare("", "resolutionDate < dueDate +1w")
```

We want to find issues that were resolved within two weeks of creation:

```
issueFunction in dateCompare("", "created +2w > resolutionDate ")
```

We want to find issues that have not been commented on within one week of creation:

```
issueFunction in dateCompare("", "created +1w < firstCommented ")
```

We want to find issues that were resolved after their chosen delivery date:

In this example, _Delivery Date_ is a **Date Picker** custom field.

```
issueFunction in dateCompare("", "resolutionDate > Delivery Date")
```

We want to find issues that were resolved on their chosen delivery date:

```
issueFunction in dateCompare("", "resolutionDate = Delivery Date")
```

#### Performance

Performance will be impacted by the number of issues that have both fields in the date comparison expression. If this is a very high number of issues (greater than 50k) you can filter some out with a subquery, for example:

```
issueFunction in dateCompare("project in myProjects()", "resolutionDate > dueDate")
```

## Find issues by the user who last updated them (`lastUpdated`)

Use lastUpdated() to find issues by the user who last updated them:

```
issueFunction in lastUpdated("user query")
```

This function includes the following actions when searching for issues:

-   Edits
    
-   State changes
    
-   Adding/removing links, labels etc.
    
-   Commenting
    

### Supported arguments

The following arguments are supported when writing your user query:

-   `by` username or user function   
    For example `"by admin"` or `"by currentUser()"`.
-   `inRole` role  
    For example `"inRole Administrators"`.
-   `inGroup` group  
    For example `"inGroup jira-administrators"`.

### Example

We want to find all issues that were last updated by members of the _Administrators_ role:

```
issueFunction in lastUpdated('inRole Administrators')
```

  

* * *

## Related content

-   [JQL Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions)
-   [Included JQL Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions)
-   [JQL Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial)
