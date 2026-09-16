# Attachments

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > JQL Functions > Included JQL Functions
- Doc ID: doc-sr4js-c436ac86-0c38-4147-9993-cf6ddb9cfcc6-76f4c1cca58014f0
- Source: https://docs.adaptavist.com/sr4js/latest/features#jql-functions--en#included-jql-functions--en#attachments--en

## hasAttachments

CAUTION: You will need to reindex before you can use this function.

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

### Examples

As a system administrator I am in charge of creating new users on our instance. For a new user to be created, the request must have a PDF approval form attached. I want to create a filter to only see new user request tickets that have a PDF of a new user request approval form attached.

```
issueFunction in hasAttachments("pdf")
```

I want to only see tickets that have exactly seven attachments of type PDF

```
issueFunction in hasAttachments("pdf", "7")
```

I want to only see tickets that have more than three attachments of type PDF

```
issueFunction in hasAttachments("pdf", "+3")
```

I want to only see tickets that have less than five attachments of type PDF

```
issueFunction in hasAttachments("pdf", "-5")
```

If I want to filter by number of attachments but I do not want to specify the attachment type, I can use an empty string as the first argument. The following will filter tickets with more than five attachments of any type

```
issueFunction in hasAttachments("", "+5")
```

## fileAttached

CAUTION: You will need to reindex before you can use this function.

Find issues by attributes of their attachments.

```
fileAttached(attachment query)
```

The following predicates are supported:

<table class="table" id="fileattached--en__generated-table-id-1"><caption></caption><colgroup><col><col></colgroup><thead class="thead"><tr class="row"><th class="entry" id="fileattached--en__generated-table-id-1__entry__1" rowspan="1" colspan="1">Name </th><th class="entry" id="fileattached--en__generated-table-id-1__entry__2" rowspan="1" colspan="1">Argument Type</th></tr></thead><tbody class="tbody"><tr class="row"><td class="entry" headers="fileattached--en__generated-table-id-1__entry__1 fileattached--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">by - attached by this user</td><td class="entry" headers="fileattached--en__generated-table-id-1__entry__1 fileattached--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">username or user function, eg currentUser()</td></tr><tr class="row"><td class="entry" headers="fileattached--en__generated-table-id-1__entry__1 fileattached--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">after - attached after date</td><td class="entry" headers="fileattached--en__generated-table-id-1__entry__1 fileattached--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">date or date expression, or date function, eg startOfDay(), lastLogin()</td></tr><tr class="row"><td class="entry" headers="fileattached--en__generated-table-id-1__entry__1 fileattached--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">before - attached before date</td><td class="entry" headers="fileattached--en__generated-table-id-1__entry__1 fileattached--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">date or date expression, or date function eg startOfDay(), lastLogin()</td></tr><tr class="row"><td class="entry" headers="fileattached--en__generated-table-id-1__entry__1 fileattached--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">on - attached on date</td><td class="entry" headers="fileattached--en__generated-table-id-1__entry__1 fileattached--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">date or date expression, or date function</td></tr></tbody></table>

Tip: Using standard JQL functions as an argument type is supported.

### Example

I am in charge of uploading invoices as attachments to tickets in our finance project. I spot a mistake in my spreadsheet and I want to find all tickets I have added invoices to in the past week so I can delete and re-attach all invoices.

```
issueFunction in fileAttached("after -1w by currentUser()")
```
