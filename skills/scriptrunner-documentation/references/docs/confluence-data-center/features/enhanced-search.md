# Enhanced Search

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features
- Doc ID: doc-sr4c-c44511c5-0717-4f31-b71e-fd6bda296c1b-fb4fa43c80df535b
- Source: https://docs.adaptavist.com/sr4c/latest/features#enhanced-search--en

Using Enhanced Search, you can search your content using CQL without calling Atlassian's Confluence REST API.

Tip: For help with CQL, visit [CQL Guide](https://docs.adaptavist.com/sr4c/latest/get-started/cql-guide).

To perform a search, follow these steps:

1.  Open the _Enhanced Search_ screen in one of the following ways:
    
    -   Within your Confluence instance, click on the binocular icon in the _Confluence header bar_.
    -   Click the Take me there link on the message displayed on Confluence's Advanced Search page.
    
    Tip: Customize Enhanced Search
    
    You can now [Show/Hide the Enhanced Search Binocular Icon](https://docs.adaptavist.com/sr4c/latest/get-started/settings/show-or-hide-the-enhanced-search-binocular-icon) and [Show/Hide Enhanced Search Section Messages](https://docs.adaptavist.com/sr4c/latest/get-started/settings/show-or-hide-enhanced-search-section-messages).
    
2.  Enter your CQL query in the search bar.
    
    Tip: CQL autocomplete for ScriptRunner for Confluence is available he
    
    CQL autocomplete will dynamically show you components of CQL (field, operator, and function) while you type your query.
    
    CQL autocomplete is contextual, so once you start typing, only components that are valid for CQL rules and are relevant to your Confluence instance appear. For example, if you have a field of `title`, the only operators that are ones that work with that field.
    
    CQL autocomplete results are limited to 20, so while you may see autocomplete results quickly, you might have to type more to get the results you want.
    
3.  Click the Search button to view your results.
    
    Two things can happen here:
    
    -   Invalid CQL query: An error message is displayed that provides information about the error within your query. You can rewrite your query now.
    -   Valid CQL query: The _Results_ table is displayed, showing all of the content that matches your query. You can click the link in the _Title_ column to access the content returned by the search.
    
    Note: If there are more than 100 matches, the table displays the first 100 results, and you can scroll through additional pages of the table to view more results.
    

## Examples

To learn more about different types of CQL queries, visit the [Types of CQL Queries](https://docs.adaptavist.com/sr4c/latest/features/enhanced-search#basic-cql-query--en) section of the _CQL Guide_. For the following examples, we will use different constructions of CQL queries to find the following content:

-   Title contains CQL
-   Content type is page
-   Text contains help for functions
-   Space is ScriptRunner for Confluence

By the end of the example, we will have a list of pages in the ScriptRunner for Confluence documentation that have help for CQL functions.

### Basic CQL query

To start, we're going to search for content that contains CQL by searching with a basic CQL query of `title ~ CQL`, which means the title contains "CQL."

As you can see, this returned a lot of content, including pages. In the next example, we will narrow in our search results.

### Combined CQL query

Since we want to narrow in our search results, we are going to add to our CQL query. `title ~ CQL AND type = page` means we are looking for a title that contains CQL, and the content type is a page.

Now we have narrowed our search results to only pages that have CQL in the title, but we can narrow in our search further by looking for help with functions.

### Multiple CQL queries

To search the text on our pages, we are going to add in a second CQL statement. `(title ~ CQL AND type = page) AND (text ~ "help with functions")` will search the instance for pages with CQL in the title that also contain text to help with functions. We enclose each statement with parenthesis so the search looks for all of the statements.

Now, the search results contain the information you want, but from different spaces. Add one final CQL query to determine your space: `(title ~ CQL AND type = page) AND (text ~ "help with functions")` `AND (space = SR4C).`

Now you have pages in a certain space that help you with CQL functions.
