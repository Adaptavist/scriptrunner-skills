# CQL Guide

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: features > cql-script-jobs
- Doc ID: doc-sr4cc-272762768
- Source: https://docs.adaptavist.com/sr4cc/latest/features/cql-script-jobs/cql-guide

You can use Confluence Query Language (CQL) to [perform advanced searches](https://developer.atlassian.com/cloud/confluence/advanced-searching-using-cql/) on [CQL Script Jobs](https://docs.adaptavist.com/sr4cc/latest/features/cql-script-jobs). Advanced searches allow you to use structured queries to search for content in Confluence Cloud.

A CQL query is similar to a JQL query in Jira. 

You can use [CQL Script Jobs](https://docs.adaptavist.com/sr4cc/latest/features/cql-script-jobs) to run a CQL query on a specified schedule. Each time it is run, the query returns a number of pages, and then the job is performed on those returned pages based on the code written. For instance, a CQL script job could change the returned pages by adding comments or deleting attachments, but you could also use the results to fetch a list of child pages.

## Components of CQL

Now that you've seen CQL in use in ScriptRunner for Confluence Cloud, let's learn about what exactly a CQL query is. To perform a basic CQL query, you'll need the three parts: 

-   [Field](https://developer.atlassian.com/cloud/confluence/cql-fields/): Represents an indexed property of content in Confluence Cloud.
    
-   [Operator](https://developer.atlassian.com/cloud/confluence/cql-operators/): One or more symbols or words which compares the value of the field (on its left) with one or more functions (on its right). 
    
-   [Function](https://developer.atlassian.com/cloud/confluence/cql-functions/): The value you want to search for.
    
    -   If it is a system-defined value like RecentlyViewedSpace, it does not need quotation marks.
        
    -   If it is a user-defined value, like the name of a space or label, you need quotation marks (eg. "demonstration space").
        
    -   If it is an Atlassian reserved [character](https://developer.atlassian.com/cloud/confluence/cql-functions/#reserved-characters) or [word](https://developer.atlassian.com/cloud/confluence/cql-functions/#reserved-words), it needs quotation marks (eg. "$", "before", "having"). 
    -   You can add () onto the end of a function to determine specifics about the function, like `endOfDay("-1d"``)`.
        

CQL queries return all types of Confluence Cloud content including pages, blog posts, comments, and attachments.

## Types of CQL queries

### Basic CQL query

Putting those three components together, you would get a formula like `field = function/value`.

To search for a specific label in your Confluence Cloud instances, use the field _label_ followed by the operator and the value you want to search for. If you want to search for the label test, use label = "test". Remember to use quotation marks since it's a user-defined value. 

Other examples of basic CQL queries: 

-   `space = "DS"`: Return all pages, blog posts, comments, or attachments contained within the DS space
    
-   `siteSearch ~ "start a discussion"`: Return all pages that contain the phrase "start a discussion"
    
-   `creator = currentUse``r()`: Return all content created by the currently logged in user
    
-   `created > endOfDay("-1d"`): Find content created since the end of yesterday
-   `mention in (vburton,ssaban,ewong``)`: Find all content that mentions either _vburton_ or _ssaban_ or _ewong_

### Combined CQL query

You can add [CQL keywords](https://developer.atlassian.com/cloud/confluence/cql-keywords/) to combine CQL queries, so you would get a formula like `field = "value" AND field = "value"`. This allows you to to search for more complex things.

These are example steps for using a combined CQL query: 

1.  Use the previous example of _label = "test"_ 
    
2.  Add an operator of _AND_ to search for a second statement to search for a label of users, _label = "users"_.
    

Now, you have `label = "test" AND label = "users"`, which will return any content that has both of the users and test labels. 

Other examples of combined CQL queries: 

-   `space = "DS" AND type = page`: Return all pages within the _DS_ space
-   `space = KEY AND type = page AND creator = username`: Return all pages in a particular space that were created by a specific user

### Multiple CQL queries 

You can add [CQL keywords](https://developer.atlassian.com/cloud/confluence/cql-keywords/) and order of operations to combine CQL queries, so you would get a formula like `(field = "value" AND field = "value") OR (field = "value")`.

These are the example steps for using multiple CQL queries: 

1.  Use the previous example of label = "test" AND label = "users"
    
2.  Add a statement for the title "Development Work" without needing that space to have the labels of "test" and "users."
    

Now, you have `(label = "test" AND label = "users") OR (title = "Development Work")`, which returns any content that has both of the users and test labels or the title is _Development Work_.

Other examples of multiple CQL queries: 

-   `(label = "internal" OR label = "secret") OR (space = "internal")`: This returns content with the internal and secret labels or content in the _Internal_ space.
-   `(lastModified < startOfYear() AND creator = vburton) OR (lastModified < startOfYear() AND contributor = vburton)`: This returns content last modified before the start of the current year created by the _vburton_ user or content last modified before the start of the current year and the user _vburton_ contributed to it.  

## Atlassian CQL resources

Information from the following Atlassian materials were used to help create this page. To find out more information about CQL, visit one of the following resources:

-   [Advanced Searching Using CQL](https://developer.atlassian.com/cloud/confluence/advanced-searching-using-cql/): "The instructions on this page describe how to define and execute a search using the advanced search capabilities of the Confluence Cloud REST API." 
    
-   [CQL Field References](https://developer.atlassian.com/cloud/confluence/cql-fields/): This resource contains a list of supported fields (the first part of a basic CQL query). It also lists supported operators and functions for each field, along with examples. 
    
-   [CQL Function References](https://developer.atlassian.com/cloud/confluence/cql-functions/): This resource contains a list of supported functions (the final part of a basic CQL query). It also lists supported operators and fields for each function, along with examples.
    
-   [CQL Keywords References](https://developer.atlassian.com/cloud/confluence/cql-keywords/): This resource explains what keywords (AND, OR, NOT, ORDER BY) are and how to use them in CQL, along with examples. 
    
-   [CQL Operators Reference](https://developer.atlassian.com/cloud/confluence/cql-operators/): This resource contains a list of supported operators (the middle part of a basic CQL query), along with examples. 
    
-   [Performing Text Searches Using CQL](https://developer.atlassian.com/cloud/confluence/performing-text-searches-using-cql/): "This page provides information on how to perform text searches. It applies to advanced searches when used with the CONTAINS operator."
