# Issue Management

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > scriptrunner-enhanced-search > scriptrunner-enhanced-search-jql-keywords
- Doc ID: doc-sr4jc-313196630
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords/issue-management

In ScriptRunner Enhanced Search for Jira Cloud, issue management JQL keywords are specialized terms used to perform advanced searches and manipulate issues efficiently. These keywords extend Jira’s native JQL functionality to provide more granular control over issue queries.

These keywords are especially useful when managing issues in complex projects, where relationships, hierarchies, and advanced attributes are critical. They significantly enhance Jira Cloud’s native search capabilities, enabling teams to execute more precise queries.

## commentedBy

The commentedBy keyword can be used to search for issues that have comments on them made by a particular user. You must specify an acccountID:

```
reporter = currentUser() AND commentedBy = '012345-678912-34567-891011'
```

This keyword can be used with the following operators: `in`, `not in`, `!=` AND `=`

## fileAttachedBy

This keyword can be used to find issues that have a file attached by a particular user. You must use the accountID of the user you are interested in.

```
reporter = currentUser() AND fileAttachedBy = "012345-678912-34567-891011"
```

This keyword can also be compared using the `!=`, `in` and `not in` operators.

## attachmentType

Search for issues that have a particular file type attached to them. File types are determined by the file extension. For example, a file called _screenshot.png_ has a file type of 'png'.

```
numberOfAttachments > 0 AND attachmentType = 'jpg'
issuetype = Invoice AND attachmentType in ('pdf', 'docx', 'xls')
```

This keyword can use the `=`, `!=`, `in` and `not in` operators.

## numberOfAttachments

Find issues that have a certain number of file attachments.

```
status = Closed AND numberOfAttachments > 3
```

This keyword can be used with numeric comparison operators.

## numberOfComments

The numberOfComments keyword can be used to find issues with a particular number of comments:

```
resolution = 'Wont Fix' AND numberOfComments > 0
```

This keyword can be used with the numeric comparison operators.

## numberOfLinks

Retrieve issues that have a certain number of issue links.

```
status = Open AND numberOfLinks = 3
```

Numeric comparison operators (>, <, !=, <=, >=, and =) can be used.  
  
numberOfLinks > 5 AND numberOfLinks <= 10

## numberOfSubtasks

The numberOfSubtasks keyword can be used to search for issues with a certain number of sub-tasks.

```
issuetype = Task AND numberOfSubtasks > 10
```

This keyword can also use the numeric comparison operators.
