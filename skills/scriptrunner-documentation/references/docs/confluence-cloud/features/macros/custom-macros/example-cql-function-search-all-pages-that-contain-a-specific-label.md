# Example: CQL Function Search all pages that contain a specific label

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: Features > Macros > Custom Macros
- Doc ID: doc-sr4cc-57d38df4-fd80-4a7d-930e-a94b0b5b823a-d8a4563e42d7e8d6
- Source: https://docs.adaptavist.com/sr4cc/latest/features/macros/custom-macros#example-cql-function-search-all-pages-that-contain-a-specific-label--en

Note: In ScriptRunner for Confluence Data Center, you can create custom CQL Functions that perform advanced searches for content in Confluence. Although this exact functionality in Cloud does not exist, you can create a custom macro that performs the same way by including code and macro parameters. For more information, check out:

-   [Feature Parity Documentation](../../../migration/feature-parity.md)
-   [Data Center Documentation for CQL Functions](https://docs.adaptavist.com/sr4cc/latest/migration/feature-parity#feature-parity-cql-functions--en)

To set up a custom macro that searches all pages that contain a specific label, follow these steps:

1.  Select Create Custom Macro.
2.  Fill out the fields that appear:
    
    1.  Macro Name: CQL Function - Search for label
    2.  Description: Use this macro to search all pages that contain a specific label
    3.  Enabled (radio button): Select _Enabled_.
    4.  Body Type: _None_.
    5.  Output Type: _Block_
    6.  Script to Execute: Enter the script for the macro here.
    
    ```
    import com.atlassian.confluence.rest.clientv1.model.ContentArray
     
    def label = parameters.get("label")
    if (!(label instanceof String)) {
     return "Please provide a valid label to search for."
    }
    def cql = "label=${label}"
    def searchResult = get("/wiki/rest/api/content/search")
            .queryString("cql", cql)
            .asObject(ContentArray).body
     
    if (!searchResult || !searchResult.results) {
     return "No pages found with label '${label}'."
    }
     
    def contents = searchResult.results
    def nextUrl = searchResult._links?.next
     
    while (nextUrl) {
     def nextContents = get("/wiki${nextUrl}").asObject(ContentArray).body
        contents += nextContents.results
        nextUrl = nextContents._links?.next
    }
     
    def pages = contents.findAll { it.type == "page" }
     
    if (pages.isEmpty()) {
     return "<p>No pages found with label '${label}'.</p>"
    }
     
    def html = new StringBuilder("<ul>")
    pages.each { page ->
     def link = "/wiki${page._links.webui}"
        html.append("<li><a href=\"${link}\">${page.title}</a></li>")
    }
    html.append("</ul>")
     
    return html.toString()
    ```
    
3.  Select Add Parameter.
    
    1.  Type: string
    2.  Name: label
    3.  Description: Enter the label to search for pages.
    4.  Required: Check.
    5.  Hidden: Do not check.
    6.  Select Add.
    
4.  Select Save.

You can now use this macro on a Confluence page. When you add the macro to a page, here is what appears:

For this example, we'll search for the `documentation` label. Here is the result:

Tip: For help with using the macro, check out the _Use Macros_ section of the [Macros](../../macros.md) documentation.
