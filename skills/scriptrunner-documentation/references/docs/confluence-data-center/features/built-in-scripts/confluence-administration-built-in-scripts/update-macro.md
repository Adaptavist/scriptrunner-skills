# Update Macro

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Built-In Scripts > Confluence Administration Built-In Scripts
- Doc ID: doc-sr4c-31ac9b15-e74b-4d85-9352-06a5cccc3a22-6cfc96ad22d8222e
- Source: https://docs.adaptavist.com/sr4c/latest/features#built-in-scripts--en#confluence-administration-built-in-scripts--en#update-macro--en

You can use this script to update macro parameters in bulk. This script updates every selected parameter of the selected macro in pages found by the CQL query.

Warning: This is a powerful script. We recommend "spot testing" this script on a sample page using CQL (e.g. title = "My Macro Update Test Page") to make sure you're getting the parameter updates you want. There are known parameters that are not currently supported.

For more information on performance, check out [Update Macro Performance](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/update-macro).

Note: This script does not currently work on macros located in comments.

## Different ways to run Update Macro

You can use the script in several different ways by using combinations of the fields. The following three sections guide you through using the script in different ways:

### Use Parameter and Value Fields

1.  Navigate to General Configuration > ScriptRunner > Built-in Scripts.
2.  Select Update Macro.
3.  Enter a CQL Query to find pages or blogs where you want the parameter updates to take place.
    
    Tip: CQL tips
    
    -   CQL autocomplete is available on this field. Start typing to see possible CQL statements.
    -   See the [CQL Guide](https://docs.adaptavist.com/sr4c/latest/get-started/cql-guide) for help with CQL.
    -   Click Show Examples to reveal more CQL examples.
    
    Once you enter a CQL Query, the _Macro_ field appears.
    
4.  Use the Macro dropdown to select the macro you want to work with.
    
    Once you select a macro, the _Macro Parameter(s)_ field appears.
    
5.  In Macro Parameter(s), add which parameters you want to update.
    
    CAUTION: The parameters that are available are the ones that correspond with the selected macro.
    
    When you select your parameters, the corresponding fields appear.
    
6.  Enter your new parameter values in these fields.
    
    For example, _CQL_ and _Max Results_ appear when you select CQL and Max Results for the _CQL Search_ macro.
    
7.  For the Notifications checkbox, choose if you want to send a notification to users when updating the macro.
    
    If Notifications is not checked, watchers of the page do not receive an email notification that the macro has been updated.
    
8.  Select Run.
    
    You can select Preview instead of Run to view changes before implementing them.
    
    Once you select Run, the results of the script appear.
    

### Use the Code Transform Field

1.  Navigate to General Configuration > ScriptRunner > Built-in Scripts.
2.  Select Update Macro.
3.  Enter a CQL Query to find pages or blogs where you want the parameter updates to take place.
    
    Tip: CQL tips
    
    -   CQL autocomplete is available on this field. Start typing to see possible CQL statements.
    -   See the [CQL Guide](https://docs.adaptavist.com/sr4c/latest/get-started/cql-guide) for help with CQL.
    -   Click Show Examples to reveal more CQL examples.
    
    Once you enter a CQL Query, the _Macro_ field appears.
    
4.  Use the Macro dropdown to select the macro you want to work with.
    
    Once you select a macro, the _Macro Parameter(s)_ field appears.
    
5.  For the Notifications checkbox, choose if you want to send a notification to users when updating the macro.
    
    If Notifications is not checked, watchers of the page do not receive an email notification that the macro has been updated.
    
6.  Enter code in Code Transform if you want to manipulate the macro changes further.
    
    Note: You can use Example Scripts for code to Update Macro Body and Update URL Parameter.
    
7.  Select Run.
    
    You can select Preview instead of Run to view changes before implementing them.
    
    Once you select Run, the Result of the script appears.
    

### Use Parameter, Value, and Code Transform Fields

1.  Navigate to General Configuration > ScriptRunner > Built-in Scripts.
2.  Select Update Macro.
3.  Enter a CQL Query to find pages or blogs where you want the parameter updates to take place.
    
    Tip: CQL tips
    
    -   CQL autocomplete is available on this field. Start typing to see possible CQL statements.
    -   See the [CQL Guide](https://docs.adaptavist.com/sr4c/latest/get-started/cql-guide) for help with CQL.
    -   Click Show Examples to reveal more CQL examples.
    
    Once you enter a CQL Query, the _Macro_ field appears.
    
4.  Use the Macro dropdown to select the macro you want to work with.
    
    Once you select a macro, the _Macro Parameter(s)_ field appears.
    
5.  In Macro Parameter(s), add which parameters you want to update.
    
    CAUTION: The parameters that are available are the ones that correspond with the selected macro.
    
    When you select your parameters, the corresponding fields appear.
    
6.  Enter your new parameter values in these fields.
    
    For example, _CQL_ and _Max Results_ appear when you select CQL and Max Results for the CQL Search macro.
    
7.  For the Notifications checkbox, choose if you want to send a notification to users when updating the macro.
    
    If Notifications is not checked, watchers of the page do not receive an email notification that the macro has been updated.
    
8.  Enter code in Code Transform if you want to manipulate the macro changes further.
    
    Note: You can use Example Scripts for code to Update Macro Body and Update URL Parameter.
    
9.  Select Run.
    
    You can select Preview instead of Run to view changes before implementing them.
    
    Once you select Run, the Result of the script appears.
    

## Examples

### Make Table of Contents consistent

Using the built-in Confluence macro _[Table of Contents](https://confluence.atlassian.com/doc/table-of-contents-macro-182682099.html)_ , you can organize page content and skip directly to the information you're looking for. You can use the _Update Macro_ built-in script to make the table of contents (TOCs) consistent across the Confluence instance.

In this example of the _Update Macro_ script, we update the Maximum Heading Level to for all TOC macros in a specific space. The Maximum Heading Level number is used to limit the headings displayed within the table of contents. For example, 2 will list headings up to h2.

1.  Navigate toBuilt-in Scripts > Update Macro.
2.  Enter the space you want to update for CQL Query.
    
    For example, you could enter space = ds to work with a demonstration space.
    
3.  Enter Table of Contents for the Macro.
4.  Enter Maximum Heading Level for Macro Parameter(s).
5.  Enter 2 for Maximum Heading Level.
6.  Select Run or Preview.
    
    Selecting Preview gives you a list of pages that will have an updated TOC, but does not update them.
    

Once you run the script, all TOCs in the Confluence instances will contain heading levels 1 and 2.

### Update Code Snippets with a New Version

Using the Mibex Software's Include Bitbucket for Confluence macro, you can provide a branch or tag name from a linked Bitbucket repository to display a specific version of a file.

We use the _Include Bitbucket for Confluence_ macro to display code snippets in our documentation. In this example of the _Update Macro_ script, we replace the tag parameters in pages found by the CQL query containing the _Include Bitbucket for Confluence_ macro to 6.16.0.

CAUTION: We update the parameter whenever we put out a new version of ScriptRunner for Confluence because our code snippets often change.

1.  Navigate toBuilt-in Scripts > Update Macro.
2.  Enter the space you want to update for CQL Query.
    
    For example, you could enter space = ds to work with a demonstration space.
    
3.  Enter Bitbucket File for the Macro.
4.  Enter Git Branch/Tag for Macro Parameter(s).
5.  Enter 6.16.0 for Git Branch/Tag.
6.  Select Run or Preview.
    
    Selecting Preview gives you a list of all pages that will have an updated code snippet.
    

Once you run the script, all code snippets from the linked repository are updated.

### Update Markdown Macro with a New Body or URL Using the Code Transform Field

Using ScriptRunner's _[Markdown](https://docs.adaptavist.com/sr4c/latest/features/macros/built-in-macros/markdown)_ macro, you can insert your own markdown inline tags or render them from a URL. Typically, you would want to include markdown from a Gist or a repository in Github or BitBucket.

In this example, we change your _Markdown_ macro's URL to point to a new path but we do not completely replace the current parameter. We also update the body of the macro to something new. By using a few lines of code within the Code Transform field of _Update Macro_, you accomplish both of these goals.

1.  Navigate toBuilt-in Scripts > Update Macro.
2.  Enter the space you want to update for CQL Query.
    
    For example, you could enter space = ds to work with a demonstration space.
    
3.  Enter Markdown for Macro.
4.  Choose if you would like to update the _Macro Body_ or the _URL Parameter_.
    
    -   For _Macro Body_, follow these steps:
        1.  Select Example Scripts and then select Update Macro Body to paste the code into Code Transform.
            
            The code appears like this:
            
            ```
            import com.atlassian.confluence.content.render.xhtml.definition.PlainTextMacroBody
            import com.atlassian.confluence.xhtml.api.MacroDefinition
            
            macroTransform = { MacroDefinition macro ->
                macro.setBody(new PlainTextMacroBody('<p><b>New body text</b></p>'))
                macro
            }
            ```
            
        2.  Update the portion of the code to the new body text.
            
            For example, `<p><b>New body text</b></p>` could be updated to `<p><b>This is your Markdown</b></b></p>`.
            
    -   For _URL Parameter_, follow these steps:
        1.  Select Example Scripts and then select Update URL Parameter to paste the code into Code Transform.
            
            The code appears like this:
            
            ```
            import com.atlassian.confluence.xhtml.api.MacroDefinition
            
            macroTransform = { MacroDefinition macro ->
                def url = macro.parameters.url
                if (url) {
                    setMacroParameter(macro, 'url', url.replace('http', 'https'))
                }
                macro
            }
            ```
            
        2.  Update the portion of the code to the new URL.
            
            For example, to replace GitHub with Bitbucket, ``url.replace(`http`, `https`))`` could be updated to ``url.replace(`github`, `bitbucket`))``.
            
    
5.  Select Run or Preview.
    
    Selecting Preview gives you a list of all pages that will have an updated Markdown macro.
    

Once you run the script, all markdown in the selected pages are updated.
