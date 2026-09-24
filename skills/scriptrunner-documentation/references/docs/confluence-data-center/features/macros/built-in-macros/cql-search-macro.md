# CQL Search Macro

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Macros > Built-In Macros
- Doc ID: doc-sr4c-77195b44-1e7d-40cf-b916-836d10b6ee93-f9781a9713f61d20
- Source: https://docs.adaptavist.com/sr4c/latest/features#macros--en#built-in-macros--en#cql-search-macro--en

You can add the CQL Search macro to a Confluence page. If you provide the CQL query, the macro executes the search and returns the results as links to pages.

The macro is useful to show the results of complex queries on pages, labels, and other Confluence content.

Tip: For more information about using CQL, check out [CQL Guide](https://docs.adaptavist.com/sr4c/latest/get-started/cql-guide).

## Enable and disable the macro

Even though you cannot edit the CQL Search macro, you can enable and disable it.

Navigate to General Configuration > ScriptRunner > Macros, and then select the Actions menu.

From there, you can either enable or disable the macro. If you disable it, it cannot be added to pages in your Confluence instance.

## Walkthrough

Watch our video to see the CQL Search macro in action.

[Media](https://player.vimeo.com/video/680469792?h=4227ca9531)

## Use the macro on a Confluence page

To use this macro, follow these steps:

1.  Open the Confluence page you want to work with and go into edit mode.
2.  Select Insert and then Other Macros.
    
3.  When you search CQL in the search bar, CQL Search appears. Select it.
4.  Enter the CQL statement you want to search in CQL and how many results you want to see in Max Results.
    
5.  Select Preview to preview the query.
6.  Select Insert to complete the macro.

## Example

In this example, we will add links to meeting notes from the _Meeting Notes_ space to a _Meetings Guide_ page in the _New Starter Guide_ space..

1.  Open the _Meetings Guide_ page in the _New Starter Guide_ space.
2.  Seach for the CQL Search macro from the Other Macros menu.
3.  Enter the CQL query. Since we want to include every page in the space, we use the CQL query `space = meeting`.
4.  Leave Max Results blank so it adds all pages.
    
5.  Select Insert.

In edit mode, the CQL Search macro looks like this:

Once you Publish or Save the page, it looks like this:

Note the Prev and Next buttons to navigate results.
