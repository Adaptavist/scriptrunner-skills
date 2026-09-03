# Comments

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > jql-functions > included-jql-functions
- Doc ID: doc-sr4js-441364595
- Source: https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/comments

This page provides information on functions used to search for issues with comments or attributes of comments:

## Find issues with comments (`hasComments`)

Use `hasComments()` to find issues with comments:

```
issueFunction in hasComments()
```

### `hasComments` examples

You can find all issues with comments, as shown above. Alternatively, you can find issues with a specific number of comments. 

For example, if we want to find issues with exactly three comments:

```
issueFunction in hasComments(3)
```

If we want to find issues with more than five comments:

```
issueFunction in hasComments('+5')
```

If we want to find issues with less than three comments:

```
issueFunction in hasComments('-3')
```

## Find issues by attributes of their comments (commented)

Use commented() to find issues by attributes of their comments:

```
commented("comment query")
```

### Supported arguments

Using standard JQL functions as an argument type is supported.

The following arguments are supported when writing your `commented()` query:

-   `on` date  
    For example `"on 2025/03/28"`.
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
-   `roleLevel`  
    For example `"roleLevel Administrators"`.
-   `groupLevel`  
    For example `"groupLevel jira-administrators"`.
-   `visibility`  
    For example `"visibility internal"` or `"visibility external"`.

Do not confuse `roleLevel` and `inRole`. `roleLevel` is the security level applied to a comment, `inRole` refers to the role(s) of the person making the comment.

### Passing date and time

The following date and time formats are supported in your arguments:  

-   yyyy/MM/dd HH:mm  
    For example `"after '2025/03/25 11:30'"`.
-   yyyy-MM-dd HH:mm  
    For example `"after '2025-03-25 11:30'"`.
-   yyyy/MM/dd  
    For example `"after 2025/03/25"`.
-   yyyy-MM-dd  
    For example `"after 2025-03-25"`.
-   Period format  
    For example `"after -5d"`.
-   Date function`   `For example `"after startOfMonth()"` or `"after` `endOfMonth()"` or `"before startOfDay()"` or `"before lastLogin()"` etc.

When adding a date and time to your argument make sure you wrap the date and time in single quotes. For example:

```
issueFunction in commented("before '2025/03/25 11:30'")
```

  

#### Timezones

When adding time to your JQL query, be aware that it follows the system's timezone. This is important because if your timezone differs from the system's, the time recorded for comments will still be in the system's timezone. For accurate searches, ensure the time in your query matches the system's timezone, not your local time.

### `commented` examples

If we want to find issues that have been commented on recently:

```
issueFunction in commented("after -7d")

or

issueFunction in commented("after 2025/03/30")
```

If we want to find issues commented by someone with the username _admin_ within the last 4 weeks:

```
issueFunction in commented("after -4w by admin")
```

If we want to find issues that have a comments visible only to those in the _Developers_ role:

```
issueFunction in commented("roleLevel Developers")
```

If we want to find Jira Service Management issues that have internal comments:

```
issueFunction in commented("visibility internal")
```

If we want to find Jira Service Management issues that have external comments by someone with the username _admin_:

```
issueFunction in commented("by admin visibility external")
```

If you move your project from Jira Software to Jira Service Management you might see inconsistent results for this function. To avoid inconsistent results, we recommend you do a full reindex.

If we want to find issues commented in the current month by the current user:

```
issueFunction in commented('after startOfMonth() by currentUser()')
```

If we want to find issues commented in the previous calendar month by the current user:

```
issueFunction in commented('after startOfMonth(-1) before endOfMonth(-1) by currentUser()')
```

## Find issues by attributes of their last comment (`lastComment`)

Use `lastComment()` to find issues by attributes of their last comment:

```
issueFunction in lastComment("comment query")
```

`lastComment()` is similar to `commented` but is restricted to searching only the last comment for every issue. See above for details of [supported arguments](#id-.Commentsv9.x-arguments) and [passing date and time](#id-.Commentsv9.x-date).

This function can be very useful for support workflows, where you want to ensure that customer comments are dealt with in a timely manner.

### `lastcomment` examples

If we want to find all issues in a specific project where the last comment was not by someone in the _Developers_ role:

```
project = FOO and issueFunction not in lastComment("inRole Developers")
```

If we want to find issues where the last comment was made by someone with the _Users_ role, **AND** it was not made by someone also in the _Developer_ role, **AND** it was made more than 4 hours ago:

```
issueFunction in lastComment("inRole Users before -4h") && issueFunction not in lastComment("inRole Developers")
```

Performance Characteristics

There are different factors that make up the overall time taken for this query:

-   The total number of comments in the system.
    
    -   On a low-spec machine:
        -   ~400ms for 350,000 comments
        -   ~1.2 seconds for 1 million comments
    -   Higher-spec machines may perform better
-   Query result size:
    
    -   Queries matching many comments (e.g., hundreds of thousands) may take several seconds
    -   More specific queries generally perform faster

Additional AND or OR clauses with this query don't significantly affect its performance.

  

* * *

## Related content

-   [JQL Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions)
-   [Included JQL Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions)
-   [JQL Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial)
