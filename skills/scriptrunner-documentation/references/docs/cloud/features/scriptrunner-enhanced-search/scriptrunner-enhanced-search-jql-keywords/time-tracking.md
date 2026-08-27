# Time Tracking

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > scriptrunner-enhanced-search > scriptrunner-enhanced-search-jql-keywords
- Doc ID: doc-sr4jc-313196633
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords/time-tracking

In ScriptRunner Enhanced Search for Jira Cloud, time tracking JQL keywords expand upon Jira's native capabilities, allowing you to perform more complex and detailed queries related to time tracking. These enhanced keywords enable teams to better analyze and manage time spent, remaining estimates, and work logs.

These keywords help teams analyze time usage, identify bottlenecks, and improve project planning by focusing on logged, estimated, and remaining work.

## commentedOn

This keyword can be used to find issues that had a comment made on them on a particular date.

```
commentedOn = '2016-02-14' AND project = VALENTINE
project = APOLLO AND component = 'Lunar Lander' AND commentedOn in ('1969-07-20', '1969-07-21')
```

The commentedOn keyword can be used with the following operators: `in`, `not in`, `!=` AND `=`

## `firstAttachmentDate`

Find issues based on the date the first attachment was added:

```
project = STORAGE AND firstAttachmentDate < now()
project = STORAGE AND firstAttachmentDate >= '2016-04-01'
project = STORAGE AND firstAttachmentDate = '2000-01-01'
```

Relative date functions can be used as well as regular numeric comparison operators.

## firstCommentedDate

The firstCommentedDate keyword can be used to search for issues based on the date of the first comment.

```
created > startOfDay() AND firstCommentedDate = now()
priority = High AND firstCommentedDate < startOfWeek()
```

This keyword can be used with the [JQL relative date functions](https://confluence.atlassian.com/jirasoftwarecloud/advanced-searching-functions-reference-764478342.html) and also the numeric comparison operators.

## lastAttachmentDate

The lastAttachmentDate keyword can be used to find issues based on the date that the most recent attachment was added:

```
project = STORAGE AND lastAttachmentDate > startOfMonth()
```

In the same way as _firstAttachmentDate_, this keyword can use the numeric comparison operators and the relative date JQL functions.

## lastCommentBy

This keyword can be used to search for issues based on the user who made the most recent comment. You must provide a accountID:

```
reporter = '012345-678912-34567-891011' AND lastCommentBy = currentUser()
assignee = currentUser() AND lastCommentBy in ('012345-678912-34567-891011', '012345-678912-34567-891012')
```

This keyword can be used with the following operators: `=`, `!=`, `in` and `not in`

## `lastCommentedDate`

The lastCommentedDate keyword can be used to search for issues based on the date of most recent comment.

```
assignee = currentUser() AND lastCommentedDate < startOfMonth()
status = 'In Progress' AND lastCommentedDate = '2016-10-14'
```

This keyword can be used with the JQL relative date functions and also the numeric comparison operators.
