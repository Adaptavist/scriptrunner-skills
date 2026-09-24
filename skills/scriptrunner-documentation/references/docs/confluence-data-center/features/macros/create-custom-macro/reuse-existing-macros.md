# Reuse Existing Macros

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Macros > Create Custom Macro
- Doc ID: doc-sr4c-32f941c3-308b-462e-b5ea-9b6dc70a9994-c09b5cef6a7159af
- Source: https://docs.adaptavist.com/sr4c/latest/features#macros--en#create-custom-macro--en#reuse-existing-macros--en

Some existing macros have many complex parameters, and you may want to get some standardization over their usage. Script macros provide an easy way to standardize parameters.

For example, the _Table of Contents_ macro has many parameters. Use the following task as an example of re-using existing macro parameters:

1.  In a sample page, configure the _Table of Contents_ macro parameters like you would want your users to.
2.  View the storage format of the page.
    
    Note: To view the storage format, you need the [Confluence Source Editor plugin](https://marketplace.atlassian.com/plugins/com.atlassian.confluence.plugins.editor.confluence-source-editor/server/overview) .
    
3.  Copy the macro XHTML from the storage format, which should look similar to the following image:
    
4.  Create a new script macro with no body and no parameters.
5.  Add script to the macro, which should look similar to the following code:
    
    ```
    import com.atlassian.confluence.xhtml.api.XhtmlContent
    import com.atlassian.sal.api.component.ComponentLocator
    
    def xhtmlContent = ComponentLocator.getComponent(XhtmlContent)
    
    xhtmlContent.convertStorageToView("""
      <ac:structured-macro ac:name="toc" ac:schema-version="1">
        <ac:parameter ac:name="maxLevel">3</ac:parameter>
        <ac:parameter ac:name="indent">12px</ac:parameter>
        <ac:parameter ac:name="class">my-class</ac:parameter>
        <ac:parameter ac:name="printable">false</ac:parameter>
      </ac:structured-macro>
    """, context)
    ```
    
    Tip: You must use the `convertStorageToView` method, as shown in the example code, to convert from storage format to HTML.
    

When you finish this task, the new macro uses the _Table of Contents_ macro parameters.

For an example, view the [Include All Child Pages](https://docs.adaptavist.com/sr4c/latest/features/macros/create-custom-macro/reuse-existing-macros/include-all-child-pages) example.
