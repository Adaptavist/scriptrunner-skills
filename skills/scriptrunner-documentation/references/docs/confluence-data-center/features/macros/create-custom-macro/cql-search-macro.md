# CQL Search Macro

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Macros > Create Custom Macro
- Doc ID: doc-sr4c-0f8959a4-ad55-4754-a7c0-9e8cf7a6002f-1d46f5b6d9b4a616
- Source: https://docs.adaptavist.com/sr4c/latest/features#macros--en#create-custom-macro--en#cql-search-macro--en

A CQL Search macro allows you to enter Confluence Query Language (CQL).

You can use the built-in [CQL Search Macro](https://docs.adaptavist.com/sr4c/latest/features/macros/create-custom-macro/cql-search-macro) macro for this, or you can create a custom macro that autofills the fields.

Follow these steps to create a CQL Search macro that finds pages with Confluence in the title in the demonstration space.

1.  Select the Create Macro button on the Macro page.
    
2.  Select Custom Script Macro.
3.  Set the following fields:
    
    -   Key: custom-cql-search
        
    -   Name: CQL REST Search
        
    -   Description: Runs a CQL search and displays matching pages
        
    -   Body Type: Rich text
        
    -   Output Type: Block
        
4.  Select the \+ Parameter button and set the following fields on the form that appears:
    -   Parameter Type: string
    -   Name: cql
    -   Label: CQL
    -   Tick the checkbox for Required
        
        Note: The Description and Default fields are not required here.
        
5.  Select the \+ Parameter button and set the following fields on the form that appears:
    -   Parameter Type: int
    -   Name: maxresults
    -   Label: Max Results
    -   Tick the checkbox for Required
        
        Note: The Description and Default fields are not required here.
        
6.  Enter the following code in the Macro Code field: 
    
    ```
    import com.atlassian.confluence.api.model.Expansion
    import com.atlassian.confluence.api.model.content.Content
    import com.atlassian.confluence.api.model.pagination.PageResponse
    import com.atlassian.confluence.api.model.pagination.SimplePageRequest
    import com.atlassian.confluence.api.model.search.SearchContext
    import com.atlassian.confluence.api.service.search.CQLSearchService
    import com.atlassian.confluence.xhtml.api.XhtmlContent
    import com.onresolve.scriptrunner.runner.ScriptRunnerImpl
    import groovy.xml.MarkupBuilder
    
    def cqlSearchService = ScriptRunnerImpl.getOsgiService(CQLSearchService)
    def xhtmlContent = ScriptRunnerImpl.getOsgiService(XhtmlContent)
    def maxResults = parameters.maxResults as Integer ?: 10
    
    def cqlQuery = parameters.cql as String
    
    def pageRequest = new SimplePageRequest(0, maxResults)
    def searchResult = cqlSearchService.searchContent(cqlQuery, SearchContext.builder().build(), pageRequest, Expansion.combine("space")) as PageResponse<Content>
    
    def writer = new StringWriter()
    def builder = new MarkupBuilder(writer)
    
    if (searchResult.size()) {
        builder.table {
            tbody {
                tr {
                    th { p("Title") }
                    th { p("Space") }
                }
                searchResult.results.each { content ->
                    tr {
                        td {
                            p {
                                "ac:link" {
                                    "ri:page"("ri:content-title": content.title, "ri:space-key": content.space.key)
                                }
                            }
                        }
                        td { p(content.space.name) }
                    }
                }
            }
        }
    
        if (searchResult.respondsTo("totalSize")) { // confl 5.8+
            builder.p("Showing ${Math.min(maxResults, searchResult.totalSize())} of ${searchResult.totalSize()}")
        }
    } else {
        builder.p("No results")
    }
    
    def view = xhtmlContent.convertStorageToView(writer.toString(), context)
    view
    ```
    
7.  Skip the Macro Javascript Code, Macro CSS Style, and Lazy Loaded fields.
8.  Click Add.
9.  You can see your new macro when the Macro page loads.Now you can take all ordinary macro actions.

## Result

When the macro is used on a page, it looks like the following image:
