# Web Panel

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Fragments
- Doc ID: doc-sr4c-b289e83b-8636-4a52-80e6-3ccce8c95716-6b0869f64bb26b49
- Source: https://docs.adaptavist.com/sr4c/latest/features#fragments--en#web-panel--en

Web panels can be used to add HTML snippets to parts of a page. They could be used to display additional information on particular builds, plans, or the system navigation.

Web panels can be used to add HTML snippets to parts of a page. They could be used to display additional information on a particular build, a plan, or the system navigation. For more information, read up on [web panels](https://developer.atlassian.com/server/framework/atlassian-sdk/web-panel-plugin-module/) in the Atlassian documentation.

## Examples

### Deprecated Space Notification

You can inform editors that a certain Confluence space will be deprecated, so they should update a page in another space.

1.  Choose the Show a Web Panel fragment.
    
2.  Fill out the form:
    
    The Weight field is optional, and it only takes positive integers. Lower integers make the panel appear at the top of the section. If the field is blank, appears at the end of the section.
    
3.  Add a condition to restrict the web panel to a specific space by its name:
    
    ```
    context.space.name == "Demonstration Space"
    ```
    
4.  Add the following code to the Provider Class/Script field:
    
    ```
    writer.write("<div style='background-color: yellow; text-align: center'>" +
     "This space is going to be deprecrated. Please move" +
     " all content to the DOCS space</div>")
    ```
    
    The results of the above web panel look like this:
    
    Note: You must write to the provided `writer` object not just return a `string`.
    

## Conditions

Conditions are largely the same as for [web item conditions](https://docs.adaptavist.com/sr4c/latest/features/fragments/web-item).
