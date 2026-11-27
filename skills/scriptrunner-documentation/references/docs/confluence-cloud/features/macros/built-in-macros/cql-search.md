# CQL Search

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: Features > Macros > Built-In Macros
- Doc ID: doc-sr4cc-e2acaae7-92ed-42bd-a140-b9e3e6224819-24da930fe9c77d65
- Source: https://docs.adaptavist.com/sr4cc/latest/features/macros/built-in-macros/cql-search

Instructions for the CQL Search macro.

Add the CQL Search macro to a Confluence page. If you provide the CQL query, the macro executes the search and returns the results as links to pages. This macro is useful for showing the results of complex queries on pages, labels, and other Confluence content.

Tip: For more information about using CQL, check out the [CQL guide](../../cql-script-jobs/cql-guide.md).

To use this macro, follow these steps:

1.  Open the Confluence page you want to use in edit mode.
    
2.  Select Insert and then Other Macros.
    
3.  Type CQL in the search bar, and select CQL Search.
    
4.  Enter the CQL statement you want to search in CQL and how many results you want to see in Max results.
    
5.  Select Preview to preview the query.
    
6.  Select Save to complete the macro.
    

## Example

In this example, we will add links to the meeting notes from the Meeting Notes space to a Meetings Guide page in the New Starter Guide space.

1.  Open the Meetings Guide page in the New Starter Guide space.
2.  Search for the CQL Search macro from the Other Macros menu.
3.  Enter the CQL query. Since we want to include every page in the space, we use the CQL query `space = meeting`.
4.  Specify 50 for Max results.
    1.  You can see how many results to expect in the CQL field after entering a valid query.
5.  Click Save

Results

In edit mode, the CQL Search macro looks like this:

Once you Publish or Save the page, it looks like this:

Note the Prev and Next buttons to navigate the results.
