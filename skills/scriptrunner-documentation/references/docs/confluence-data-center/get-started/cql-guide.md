# CQL Guide

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Get Started
- Doc ID: doc-sr4c-081c7cf1-879e-4a0e-8dbf-b7061a47baa2-cbf7440e22176dc7
- Source: https://docs.adaptavist.com/sr4c/latest/get-started#cql-guide--en

You can use Confluence Query Language (CQL) to [perform advanced searches](https://developer.atlassian.com/server/confluence/advanced-searching-using-cql/). Advanced searches allow you to use structured queries to search for content in Confluence.

Note: A CQL query is similar to a JQL query in Jira.

Here are some examples of CQL queries in use in ScriptRunner for Confluence:

|  |  |
| --- | --- |
| CQL in [Enhanced Search](https://docs.adaptavist.com/sr4c/latest/features/enhanced-search)<br>Use Enhanced Search to search your Confluence instance using CQL. | CQL in ScriptRunner for Confluence<br>You'll find CQL fields throughout the provided scripts in ScriptRunner for Confluence. This example is from [Prune Old Versions Job](https://docs.adaptavist.com/sr4c/latest/features/jobs/built-in-jobs/prune-old-versions-job) job. |

## Components of CQL

Now that you've seen CQL in use in ScriptRunner for Confluence, let's learn about what exactly a CQL query is. To perform a basic CQL query, you'll need the three parts:

-   [Field](https://developer.atlassian.com/server/confluence/cql-field-reference/): Represents an indexed property of content in Confluence.
-   [Operator](https://developer.atlassian.com/server/confluence/cql-operators-reference/): One or more symbols or words which compares the value of the field (on its left) with one or more functions (on its right).
-   [Function](https://developer.atlassian.com/server/confluence/cql-function-reference/): The value you want to search for.
    -   If it is a system-defined value like RecentlyViewedSpace, it does not need quotation marks.
    -   If it is a user-defined value, like the name of a space or label, you need quotation marks (eg. "demonstration space").
    -   If it is an Atlassian reserved [character](https://developer.atlassian.com/server/confluence/cql-function-reference/#reserved-characters) or [word](https://developer.atlassian.com/server/confluence/cql-function-reference/#reserved-words), it needs quotation marks (eg. "$", "before", "having").
    -   You can add () onto the end of a function to determine specifics about the function, like `endOfDay("-1d"``)`.

Note: CQL queries return all types of Confluence content including pages, blog posts, comments, images, and attachments.

## CQL Autocomplete

CQL autocomplete is available in [Enhanced Search](https://docs.adaptavist.com/sr4c/latest/features/enhanced-search) and all built-in scripts, including:

Confluence Administration Built-In Scripts

-   [Add/Remove Watchers](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/add-or-remove-watchers)
-   [Bulk Delete Attachment Versions](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/bulk-delete-attachment-versions)
-   [Change Content Author](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/change-content-author)
-   [Update Macro](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/update-macro)
-   [XPath Search in Pages](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/xpath-search-in-pages)

Space Administration Built-In Scripts

-   [Add/Remove Watchers](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/add-or-remove-watchers)
-   [Bulk Delete Attachment Versions](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/bulk-delete-attachment-versions)
-   [Change Content Author](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts/change-content-author)

Jobs

-   [CQL Escalation Services](https://docs.adaptavist.com/sr4c/latest/features/jobs/built-in-jobs/cql-escalation-services)
-   [Old Content Notifier Job](https://docs.adaptavist.com/sr4c/latest/features/jobs/built-in-jobs/old-content-notifier-job)
-   [Prune Old Versions Job](https://docs.adaptavist.com/sr4c/latest/features/jobs/built-in-jobs/prune-old-versions-job)

Listeners

-   [Add/Remove Watchers Listener](https://docs.adaptavist.com/sr4c/latest/features/event-listeners/built-in-listeners/add-or-remove-watchers-listener)

CQL autocomplete will dynamically show you components of CQL (field, operator, and function) while you type your query.

CQL autocomplete is contextual, so once you start typing, only components that are valid for CQL rules and are relevant to your Confluence instance appear. For example, if you have a field of `title`, the only operators that are ones that work with that field.

CQL autocomplete results are limited to 20, so while you may see autocomplete results quickly, you might have to type more to get the results you want.

## Types of CQL queries

### Basic CQL query

Putting those three components together, you would get a formula like `field = function/value`.

To search for a specific label in your Confluence instances, use the field _label_ followed by the operator and the value you want to search for. If you want to search for the label test, use label = "test". Remember to use quotation marks since it's a user-defined value. Here is that query used in Enhanced Search:

Other examples of basic CQL queries:

-   `space = "DS"`: Return all pages, blog posts, comments, or attachments contained within the DS space
-   `siteSearch ~ "start a discussion"`: Return all pages that contain the phrase "start a discussion
-   `creator = currentUser`: Return all content created by the currently logged in user
-   `created > endOfDay("-1d"`): Find content created since the end of yesterday
-   `mention in (vburton,ssaban,ewong``)`: Find all content that mentions either _vburton_ or _ssaban_ or _ewong_

### Combined CQL query

You can add [CQL keywords](https://developer.atlassian.com/server/confluence/cql-keywords-reference/) to combine CQL queries, so you would get a formula like `field = "value" AND field = "value"`. This allows you to to search for more complex things.

These are example steps for using a combined CQL query:

1.  Use the previous example of _label = "test"_
2.  Add an operator of _AND_ to search for a second statement to search for a label of users, _label = "users"_.

Now, you have `label = "test" AND label = "users"`, which will return any content that has both of the users and test labels. Here, you can see the combined CQL query in use in Enhanced Search:

Other examples of combined CQL queries:

-   `space = "DS" AND type = page`: Return all pages within the _DS_ space
-   `space = KEY AND type = page AND creator = username`: Return all pages in a particular space that were created by a specific user

### Multiple CQL queries

You can add [CQL keywords](https://developer.atlassian.com/server/confluence/cql-keywords-reference/) and order of operations to combine CQL queries, so you would get a formula like `(field = "value" AND field = "value") OR (field = "value")`.

These are the example steps for using multiple CQL queries:

1.  Use the previous example of label = "test" AND label = "users"
2.  Add a statement for the title "Development Work" without needing that space to have the labels of "test" and "users."

Now, you have `(label = "test" AND label = "users") OR (title = "Development Work")`, which returns any content that has both of the users and test labels or the title is _Development Work_. Here, you can see the multiple CQL queries in use in Enhanced Search:

Other examples of multiple CQL queries:

-   `(label = "internal" OR label = "secret") OR (space = "internal")`: This returns content with the internal and secret labels or content in the _Internal_ space.
-   `(lastModified < startOfYear() AND creator = vburton) OR (lastModified < startOfYear() AND contributor = vburton)`: This returns content last modified before the start of the current year created by the _vburton_ user or content last modified before the start of the current year and the user _vburton_ contributed to it.

Tip: Example

To see an example using all different CQL constructions to search documentation for specific content, please visit [Enhanced Search CQL Examples](https://docs.adaptavist.com/sr4c/latest/features/enhanced-search).

#### Customizing CQL Fields

Use custom search fields to add useful indexes to Confluence's search to find content that meets specific criteria. Custom search fields expand the capabilities of your CQL search. You can expand your CQL search capabilities outside of Confluence's [standard CQL fields](https://developer.atlassian.com/server/confluence/cql-field-reference/) by creating custom search fields. This feature allows you to create specific fields that help you track and maintain your instance of Confluence, which makes using CQL easier. To find out how to create and use custom search fields, visit [Custom Search Fields](https://docs.adaptavist.com/sr4c/latest/features/custom-search-fields). For example, you could create NumberOfComments to track community engagement of a certain page. To learn how to do this, visit [Custom Search Field Examples](https://docs.adaptavist.com/sr4c/latest/features/custom-search-fields/custom-search-field-examples).

## Customizing CQL Functions

Using custom CQL functions in ScriptRunner for Confluence allows you to create and share custom CQL functions (values) with your users in order to empower their search. For example, you could set a function to encompass all content with labels in your instance. For a large instance, this query could include multiple CQL queries that could get complicated very fast. Creating this custom function would allow your users to use that and perform a basic CQL query, like `pages = AllAttachments`. For help with this, visit [CQL Functions](https://docs.adaptavist.com/sr4c/latest/features/cql-functions) and [Custom CQL Functions](https://docs.adaptavist.com/sr4c/latest/features/cql-functions/custom-cql-functions)

## Customize and maintain Confluence content using CQL

You can also use CQL to help you maintain your instance. Using CQL Escalation Services Job, you can use the results of a CQL query performed in the script in the code that is also in the script. The job takes the results, plugs them into the code, and applies the action of the code. For example, you can add a comment specified by the code to outdated pages identified by the CQL. For help with this, visit [CQL Escalation Services](https://docs.adaptavist.com/sr4c/latest/features/jobs/built-in-jobs/cql-escalation-services).

Using the CQL Search macro, you can provide CQL search results as links to pages. These links would appear on a Confluence pages. For example, you could link to individual scheduled events on a homepage. For help with this, watch the video on [CQL Search Macro](https://docs.adaptavist.com/sr4c/latest/features/macros/create-custom-macro/cql-search-macro).

## Atlassian CQL resources

Information from the following Atlassian materials were used to help create this page. To find out more information about CQL, visit one of the following resources:

-   [Advanced Searching Using CQL](https://developer.atlassian.com/server/confluence/advanced-searching-using-cql/): "The instructions on this page describe how to define and execute a search using the advanced search capabilities of the Confluence REST API."
-   [CQL Field References](https://developer.atlassian.com/server/confluence/cql-field-reference/): This resource contains a list of supported fields (the first part of a basic CQL query). It also lists supported operators and functions for each field, along with examples.
-   [CQL Function References](https://developer.atlassian.com/server/confluence/cql-function-reference/): This resource contains a list of supported functions (the final part of a basic CQL query). It also lists supported operators and fields for each function, along with examples.
-   [CQL Keywords References](https://developer.atlassian.com/server/confluence/cql-keywords-reference/): This resource explains what keywords (AND, OR, NOT, ORDER BY) are and how to use them in CQL, along with examples.
-   [CQL Operators Reference](https://developer.atlassian.com/server/confluence/cql-operators-reference/): This resource contains a list of supported operators (the middle part of a basic CQL query), along with examples.
-   [Performing Text Searches Using CQL](https://developer.atlassian.com/server/confluence/performing-text-searches-using-cql/): "This page provides information on how to perform text searches. It applies to [advanced searches](https://developer.atlassian.com/server/confluence/performing-text-searches-using-cql) when used with the [CONTAINS](https://developer.atlassian.com/server/confluence/performing-text-searches-using-cql/#contains) operator."
