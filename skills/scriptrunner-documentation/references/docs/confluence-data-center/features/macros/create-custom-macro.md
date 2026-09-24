# Create Custom Macro

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Macros
- Doc ID: doc-sr4c-4f195503-5b2d-4aa4-bf23-6ddd95672c76-588896f980f04929
- Source: https://docs.adaptavist.com/sr4c/latest/features#macros--en#create-custom-macro--en

Script macros allow you to include dynamic content.

Note: Custom CSS disabled by default

As recommended by [Atlassian](https://confluence.atlassian.com/doc/styling-confluence-with-css-166528400.html), custom CSS for macros is disabled by default.To enable this feature, navigate to the Settings options and toggle the associated option.

## Create a Custom Macro

Follow these steps to create a custom macro:

1.  1.  Select the Cog icon, and then select General Configuration.
        
    2.  Scroll to the _ScriptRunner_ section in the left-hand navigation, and then select Macros.
        
    3.  Select the Create Macro button.
        
    4.  Select the Custom Script Macro link.
        
    5.  Fill out the following fields:
        
        -   Key: Enter a unique key for your macro.
        -   Name: Enter a name for your macro.
        -   Description: Enter a description for your macro. This appears in the macro window.
        -   Body Type: Use _None,_ _Plain Text,_ or _Rich Text_ to type in the body of the macro.
            
            CAUTION: If you choose _Rich Text_, you'll want the script to return some HTML. As noted [here](https://docs.adaptavist.com/sr4c/latest/features/macros/create-custom-macro/security-and-best-practices), use Groovy's [Markup Builder](http://groovy-lang.org/processing-xml.html#_markupbuilder) and sanitize any input you get from the users, such as macro parameters.
            
            ```
            import groovy.xml.MarkupBuilder def writer = new StringWriter() def builder = new MarkupBuilder(writer) builder.strong(body) writer.toString()
            ```
            
        -   Output Type: Use _Block_ or _Inline_ to change the layout flow of the macro.
        -   Parameters: If you choose to add a parameter, select \+ Parameter.The following fields appear:
            1.  Choose your Parameter Type.
            2.  Enter your parameter Name.
            3.  Enter your parameter Label.
            4.  Enter your parameter Description.
            5.  Enter the parameter Default.
            6.  Check Required or leave it blank if the parameter is optional.
        -   Macro Code: Use to change the content of the macro.
            
        -   Macro JavaScript Code (optional): Use to change the behaviors of the macro.
            
        -   Macro CSS Style (optional): Use to change the style of the macro.
            
            Note: If you use the _File_ tab here, the script directory in your home directory (or the directory you use for the CSS) needs to be set up as a web resource directory. See [Web Resource](https://docs.adaptavist.com/sr4c/latest/features/fragments/web-resource) for more information.
            
        -   Lazy Loaded: Check this box if the macro takes a few seconds to load.
            
            Note: Lazy Loaded Macro
            
            If you have a macro that takes more than a second or so to run, consider checking the _Lazy Loaded_ box. The _Lazy Loaded_ box means that the rendering of the page is not delayed until the macro has executed. Instead, the traditional "spinning gears" icon appears, and the macro content is loaded asynchronously via Representational State Transfer (REST). For an example of a macro that needs Lazy Loaded, check out the [Macro Tips](https://docs.adaptavist.com/sr4c/latest/features/macros/create-custom-macro/macro-tips) example.
            
    6.  Select Add.
    
    Tip: Your custom macro appears in the macro list.
    

## Use a Custom Macro

You can choose your custom macro when you open a Confluence editor (like _Create a Page_) in the macro browser.

1.  Select the macro browser, and then select Other Macros.
    
2.  Find your macro in the list, and click on it.
    
3.  Enter any required information in the window that appears.
    
    Tip: If you already had the editor open, you need to shift-refresh after editing macros definitions.
    
4.  Select Insert.

The macro appears where you are working. For example, _Test Custom Macro_ appears on the _Testing_ page.

## Use Binding Variables

Your script has access to the following binding variables, without the need for them to be declared:

-   `parameters`: A `Map<String, String>` for accessing user-provided macro parameters. The map's keys are the parameter keys, so to get the `color` parameter use `parameters.color`.
    
-   `body`: The body of the macro. The value is `null` if there is no body.
    
-   `context`: A [ConversionContext](https://docs.atlassian.com/atlassian-confluence/6.3.3/com/atlassian/confluence/content/render/xhtml/ConversionContext.html) contains information about the current page and output device type (desktop, mobile). Use this for methods of [XhtmlContent](https://docs.atlassian.com/atlassian-confluence/6.0.5/com/atlassian/confluence/xhtml/api/XhtmlContent.html).
    

For an example of a macro that uses binding variables, check out [Create a Macro with Parameters](https://docs.adaptavist.com/sr4c/latest/features/macros/create-custom-macro/create-a-macro-with-parameters).

## Further reading

For more information about custom macros, check out the following documentation:

-   [Security and Best Practices](https://docs.adaptavist.com/sr4c/latest/features/macros/create-custom-macro/security-and-best-practices)
-   [Reuse Existing Macros](https://docs.adaptavist.com/sr4c/latest/features/macros/create-custom-macro/reuse-existing-macros)
-   [Create a Macro with Parameters](https://docs.adaptavist.com/sr4c/latest/features/macros/create-custom-macro/create-a-macro-with-parameters)
-   [CQL Search Macro](https://docs.adaptavist.com/sr4c/latest/features/macros/create-custom-macro/cql-search-macro)
-   [Display SQL Results from an External Database](https://docs.adaptavist.com/sr4c/latest/features/macros/create-custom-macro/display-sql-results-from-an-external-database)
-   [Macro Tips](https://docs.adaptavist.com/sr4c/latest/features/macros/create-custom-macro/macro-tips)
