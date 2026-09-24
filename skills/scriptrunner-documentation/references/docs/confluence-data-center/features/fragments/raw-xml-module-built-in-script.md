# Raw XML Module Built-In Script

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Fragments
- Doc ID: doc-sr4c-333d8adb-db16-42aa-bf31-45f8a0af977d-9ee579dc07f51034
- Source: https://docs.adaptavist.com/sr4c/latest/features#fragments--en#raw-xml-module-built-in-script--en

Find information on working around XML limitations here.

All of the built-in scripts produce XML that is similar, but not interchangeable with, XML found in the[plugin descriptor](https://developer.atlassian.com/confdev/confluence-plugin-guide/writing-confluence-plugins/creating-your-plugin-descriptor). You will notice that, for usability reasons, the forms do not include all the possible configuration elements available in plugins. For example, the web item script does not give you the option to provide a tooltip for the web item link, a velocity context provider, or an icon URL.

You can work around this limitation by using _Raw_ _XML Module Item_ by following these steps:

1.  Get the required XML from one of the other fragment scripts by filling out the form, then clicking the Preview button.
    
    Warning: Do not click the Save/Update button.
    
2.  Copy the XML into the _Raw XML Module_ script.
3.  Make modifications as required.

## Example

If you wanted to show a Google button with a tooltip that only shows on personal Confluence spaces, follow these steps:

1.  Fill out the custom web item form.
    1.  Navigate to General Configurationr > ScriptRunner > UI Fragments > Custom Web Item.
    2.  Fill out the form with the following content:
        
        1.  Name: custom-web-item
        2.  What Section Should This Go In: system.header/left
        3.  Key: custom-web-item
        4.  Menu Text: Google something
        5.  Weight: 70
        6.  Condition: 
            
            ```
            context.space && context.space.isPersonal()
            ```
            
        7.  Do What: Navigate to a link
        8.  Link: [https://www.google.com](https://www.google.com/)
        
    3.  Click Preview.
        
        The following XML is generated:
        
2.  Copy the XML.
3.  Fill out the raw XML module form:
    1.  Navigate to General Configuration > ScriptRunner > UI Fragments > Raw XML Module Item.
    2.  Enter a Name like custom-web-item with added tooltip.
    3.  Enter the XML you copied for the XML field.
        
    4.  Make the following modifications to the XML:
        
        1.  Remove lines 4 and 5: 
            
            ```
            <param name='£trackingParameters' value='{"scriptName":"com.onresolve.scriptrunner.canned.confluence.fragments.CustomWebItem"}' />
            <param name='£fragmentParameters' value='{"id":"590d3bd9-54b6-4550-aa66-c2279100b6b1"}' />
            ```
            
        2.  Remove line 8: 
            
            ```
            <styleClass> custom-web-item </styleClass>
            ```
            
        3.  Add the following code after `</link>`: 
            
            ```
            <tooltip>Click here to Google something</tooltip>
            ```
            
        
        The modified XML should look like this:
        
    5.  Click Add.

This is how the button and tooltip will appear in your Confluence instance:
