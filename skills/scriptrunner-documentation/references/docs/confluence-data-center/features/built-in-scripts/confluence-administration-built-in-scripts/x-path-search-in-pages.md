# XPath Search in Pages

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Built-In Scripts > Confluence Administration Built-In Scripts
- Doc ID: doc-sr4c-993ad002-b023-4b10-b6f6-0a3ddd756aeb-fe9de112ee0eb3aa
- Source: https://docs.adaptavist.com/sr4c/latest/features#built-in-scripts--en#confluence-administration-built-in-scripts--en#xpath-search-in-pages--en

This is an advanced built-in script. Use _XPath Search in Pages_ to search each page's source using the provided XPath expression.

_XPath Search in Pages_ is more powerful than the built-in Confluence search, especially when it comes to identifying hidden structural problems in your content. But that power comes at the cost of speed and efficiency. It is best only to run this built-in script on a single space. It takes about 1.5 seconds to search a space with 2,500 pages.

Tip: To use _XPath Search in Pages_, you should be reasonably familiar with the Confluence XHTML storage format, and/or be prepared to examine a page's source with the [Confluence Source Editor](https://marketplace.atlassian.com/apps/1210722/confluence-source-editor?tab=overview&hosting=server) in order to work out what expression you need.

## Run the script

Follow these steps to run the built-in script:

1.  Navigate to General Configuration > ScriptRunner > Built-in Scripts.
2.  Select XPath Search in Pages.
3.  Enter a CQL Query to select the content you want to work with.
    
    Tip:
    
    -   CQL autocomplete is available for this field. Start typing to see possible CQL statements.
    -   For help with CQL, visit [CQL Guide](https://docs.adaptavist.com/sr4c/latest/get-started/cql-guide).
    -   Select Show Examples to see examples of CQL statements.
    
4.  Enter the expression in Xpath Query.
    
    Select Show Examples for common expressions to use with this built-in script.
    
5.  Select Run.
    

Once you run the script, the Result appears.

## Example

### Search for pages with images in a certain space

You could use this script if you require a high degree of control over the presentation of your wiki pages, and you want to make sure everything is correct. You could run the following script to see all pages with images:

1.  Navigate to General Configuration > ScriptRunner > Built-in Scripts.
2.  Select XPath Search in Pages.
3.  For CQL Query, enter type = page AND space = DS to select all of the pages in the _Demonstration Space_.
4.  Enter //ac:image or select Pages with images from Show Examples for the Xpath Query.
    
5.  Select Run.

The script returns the pages with images in the _Demonstration Space_. Each page appears as a link.

### Search for pages with nested macros

You can use two built-in examples to search for all pages with macros nested inside of other macros. For example, this search returns those pages if you use Mosaic: Content Formatting Macros and Templates to nest formatting macros inside of division macros. You can use the generated list to help with your [migration](https://docs.adaptavist.com/sr4c/latest/migration/migrating-to-or-from-cloud/migrate-from-scriptrunner-for-confluence-server-to-cloud).

1.  Navigate to General Configuration > ScriptRunner > Built-in Scripts.
2.  Select XPath Search in Pages.
3.  Choose Select all pages for CQL Query.
4.  Choose Pages with nested macros for Xpath Query.
    
5.  Select Run.

A list of links is generated.
