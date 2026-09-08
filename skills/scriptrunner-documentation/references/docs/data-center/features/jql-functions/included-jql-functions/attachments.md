# Attachments

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > jql-functions > included-jql-functions
- Doc ID: doc-sr4js-101624201
- Source: https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/attachments

## hasAttachments

You will need to reindex before you can use this function.

Find all issues on your instance with attachments.

```
hasAttachments()
```

Optionally, you can use the first argument to specify the attachment file extension.

```
hasAttachments([file extension])
```

You can also use an additional argument to specify the number of attachments.

```
hasAttachments([file extension], [number of attachments])
```

  

**Examples**

As a system administrator I am in charge of creating new users on our instance. For a new user to be created, the request must have a PDF approval form attached. I want to create a filter to only see new user request tickets that have a PDF of a new user request approval form attached. 

```
issueFunction in hasAttachments("pdf")
```

I want to only see tickets that have exactly 7 attachments of type PDF

```
issueFunction in hasAttachments("pdf", "7")
```

I want to only see tickets that have more than 3 attachments of type PDF

```
issueFunction in hasAttachments("pdf", "+3")
```

I want to only see tickets that have less than 5 attachments of type PDF

```
issueFunction in hasAttachments("pdf", "-5")
```

If I want to filter by number of attachments but I do not want to specify the attachment type, I can use an empty string as the first argument. The following will filter tickets with more than 5 attachments of any type

```
issueFunction in hasAttachments("", "+5")
```

## fileAttached

You will need to reindex before you can use this function.

Find issues by attributes of their attachments. 

```
fileAttached(attachment query)
```

The following predicates are supported:

Name 

Argument Type

by - attached by this user

username or user function, eg currentUser()

after - attached after date

date or date expression, or date function, eg startOfDay(), lastLogin()

before - attached before date

date or date expression, or date function eg startOfDay(), lastLogin()

on - attached on date

date or date expression, or date function

Using standard JQL functions as an argument type is supported.

**Example**

I am in charge of uploading invoices as attachments to tickets in our finance project. I spot a mistake in my spreadsheet and I want to find all tickets I have added invoices to in the past week so I can delete and re-attach all invoices.

```
issueFunction in fileAttached("after -1w by currentUser()")
```
