# Raw XML Module Built-In Script

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Fragments
- Doc ID: doc-sr4js-6a34449c-52b2-46ab-a907-59354d6643fd-834ecb015de36a61
- Source: https://docs.adaptavist.com/sr4js/latest/features#fragments--en#raw-xml-module-built-in-script--en

All of the UI Fragment built-in scripts produce XML that is similar to, but not interchangeable with, XML found in a [plugin descriptor](https://developer.atlassian.com/confdev/confluence-plugin-guide/writing-confluence-plugins/creating-your-plugin-descriptor). You will notice that, for usability reasons, the forms do not provide all the possible configuration elements available in plugins. For example, the web item built-in script form does not give you the option to provide a tooltip for the web item link or a velocity context provider.

You can work around this limitation by using the XML provided by the other UI Fragment built-in scripts and then adding to it using the raw XML module built-in script:

1.  Go to ScriptRunner > UI Fragments and select a fragment that's closest to the Raw XML module fragment that you want to create (for example a Web item or a Web panel).
2.  Fill out the UI Fragment. Make sure the fragment has as many of the details you require as possible.
3.  Select Preview to get the required XML.
    
    Warning: Do not select the Add button.
    
4.  Copy the XML.
5.  Go to Script Runner > UI Fragments > RAW XML module and paste in the raw XML you copied in the step above.
6.  Optional: Give your fragment a name.
7.  Make modifications to the raw XML as required.
8.  Select Add.

## Examples

### Add a tooltip

As a simple example, we want to add a button to the top navigation bar, as described on our [Fragments Tutorial](https://docs.adaptavist.com/sr4js/latest/features/fragments/fragments-tutorial#create-a-simple-web-item-add-a-button-to-top-navigation-bar-that-links-to-a-website--en) page. We want to do more than what this tutorial describes as we want to also add a tooltip to the button. To do so we would do the following:

1.  Follow steps 1 to 11 for the [Create a simple web item](https://docs.adaptavist.com/sr4js/latest/features/fragments/fragments-tutorial#create-a-simple-web-item-add-a-button-to-top-navigation-bar-that-links-to-a-website--en) tutorial.
2.  Select Preview.
    
    Warning: Do not select the Add button.
    
3.  Copy the raw XML that is provided.
4.  Go to ScriptRunner > UI Fragments > Raw XML module and paste in the raw XML you copied in the step above.
5.  Add the following line to your script:
    
    ```
    <tooltip>Click here to go to the Great Adventure Website</tooltip>
    ```
    
    So our final script would look as follows:
    
    Tip: If you always want this fragment to display you can remove the `condition` block.
    
    ```
    <web-item key='great-adventure-web' name='ScriptRunner generated web item - great-adventure-web' section='system.top.navigation.bar' weight='110'>
        <label>Great Adventure Website</label>
        <condition class='com.onresolve.scriptrunner.fragments.JiraScriptRunnerCondition'>
            <param name='£trackingParameters' value='{"scriptName":"com.onresolve.scriptrunner.canned.jira.fragments.CustomWebItem"}' />
            <param name='£fragmentParameters' value='{"id":"820fe068-76fc-473b-9ce0-311055398a9d"}' />
            <param name='conditionConfig'><![CDATA[{"parameters":{},"script":"true","scriptPath":null}]]></param>
        </condition>
        <styleClass> great-adventure-web </styleClass>
        <link linkId='great-adventure-web'>https://www.adaptavist.com/?_=1</link>
        <tooltip>Click here to go to the Great Adventure Website</tooltip>
    </web-item>
    ```
    
6.  Select Add.
    
    The tooltip appears as follows:
    

### Use multiple items

You can use this built-in script to make multiple modifications that belong as a single unit in a single script, which you can enable and disable at once.

The XML below allows you to create the following structure, which consists of:

-   A drop-down menu in the top navigation bar
-   A web section activated by that menu item, which has a heading
-   Two simple web items

```
<web-item key='toppy' name='ScriptRunner generated web item - toppy' section='system.top.navigation.bar' weight='70'>
    <label>Toppy</label>
    <link linkId='toppy'></link>
</web-item>
 
<web-section key='top-menu-section' name='ScriptRunner generated web item - top-menu-section' location='toppy' weight='70'>
    <label>Subby</label>
    <param name='lazy' value='true' />
</web-section>
 
<web-item key='x-other' name='ScriptRunner generated web item - x-other' section='toppy/top-menu-section' weight='1'>
    <label>Sub-menu item</label>
    <link linkId='x-other'>/</link>
</web-item>
 
<web-item key='y-other' name='ScriptRunner generated web item - y-other' section='toppy/top-menu-section' weight='1'>
    <label>Another menu item</label>
    <link linkId='y-other'>/</link>
</web-item>
```

Note: You will note that the above XML is not technically correct as it does not have a root element, but in this case, a root element will be automatically added for you.
