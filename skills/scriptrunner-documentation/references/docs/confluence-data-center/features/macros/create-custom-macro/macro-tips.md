# Macro Tips

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Macros > Create Custom Macro
- Doc ID: doc-sr4c-96a95199-475b-4807-8142-3d3bcf3e67dc-733b1a54aea74a7c
- Source: https://docs.adaptavist.com/sr4c/latest/features#macros--en#create-custom-macro--en#macro-tips--en

This is a macro that displays the latest version of each Atlassian product.

Because it makes calls to the Atlassian Marketplace REST API, it takes a couple of seconds to complete.

Follow these steps to configure this macro:

1.  Select the Create Macro button on the Macro page.
2.  Select Custom Script Macro.
3.  Set the following fields:
    
    -   Key: atl-versions
    -   Name: Atlassian Versions
    -   Description: Displays the latest version of each Atlassian product
    -   Body Type: None
    -   Output Type: Block
    
4.  Skip the +Parameter section.
5.  Enter the following code in the Macro Code field:
    
    ```
    import com.atlassian.confluence.xhtml.api.XhtmlContent
    import com.atlassian.sal.api.component.ComponentLocator
    import groovy.xml.MarkupBuilder
    import groovyx.net.http.ContentType
    import groovyx.net.http.HTTPBuilder
    import groovyx.net.http.Method
    
    def httpBuilder = new HTTPBuilder("https://marketplace.atlassian.com")
    def xhtmlContent = ComponentLocator.getComponent(XhtmlContent)
    
    def rt = httpBuilder.request(Method.GET, ContentType.JSON) {
        uri.path = "/rest/1.0/applications"
    }
    
    List<Map> apps = rt.applications
    
    def writer = new StringWriter()
    def builder = new MarkupBuilder(writer)
    
    builder.table {
        tbody {
            tr {
                th { p("App") }
                th { p("Latest version") }
            }
    
            apps.sort { it.order }.each { app ->
                rt = httpBuilder.request(Method.GET, ContentType.JSON) {
                    uri.path = "/rest/1.0/applications/${app.key}"
                }
    
                tr {
                    td { p(app.name) }
                    td { p(rt.versions.isEmpty() ? "No Versions Found" : rt.versions.first().version) }
                }
            }
        }
    }
    
    xhtmlContent.convertStorageToView(writer.toString(), context)
    ```
    
6.  Skip the Macro Javascript Code, Macro CSS Style fields.
7.  Tick the Lazy Loaded checkbox.
8.  Click Add.
9.  You can see your new macro when the Macro page loads.
    

## Result

When the macro is used on a page, it looks like the following image:
