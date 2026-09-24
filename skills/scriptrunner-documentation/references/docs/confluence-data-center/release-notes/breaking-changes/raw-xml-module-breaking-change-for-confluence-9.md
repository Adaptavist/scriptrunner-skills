# Raw XML Module Breaking Change for Confluence 9

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Release Notes > Breaking changes
- Doc ID: doc-sr4c-84fa3256-ecb4-4923-82bd-4ecaa8fdd643-29f62f81a1c8dbd1
- Source: https://docs.adaptavist.com/sr4c/latest/release-notes/breaking-changes#raw-xml-module-breaking-change-for-confluence-9--en

Information about errors, symptoms, and solutions related to using a Raw XML module to generate fragments in Confluence 9.

The raw XML format for `condition class` and `provider class` has changed with [Confluence 9.0.0](https://docs.adaptavist.com/sr4c/latest/get-started/update/compatibility-with-confluence). The formats previously generated from the _Preview_ button for each of these built-in fragment scripts are no longer valid:

-   [Web Item](https://docs.adaptavist.com/sr4c/latest/features/fragments/web-item)
-   [Web Panel](https://docs.adaptavist.com/sr4c/latest/features/fragments/web-panel)
-   [Web Section](https://docs.adaptavist.com/sr4c/latest/features/fragments/web-section)

If you previously created a fragment using the raw XML generated from the _Preview_ button, you will have to manually update it to the new format for your fragment to function correctly. On this page, find the following information about this breaking change:

-   [Examples of the old Raw XML format](https://docs.adaptavist.com/sr4c/latest/release-notes/breaking-changes#examples-of-the-old-raw-xml-format--en)
-   [Find the broken raw XML fragments](https://docs.adaptavist.com/sr4c/latest/release-notes/breaking-changes#find-the-broken-raw-xml-fragments--en)
-   [Fix the broken raw XML fragments](https://docs.adaptavist.com/sr4c/latest/release-notes/breaking-changes#fix-the-broken-raw-xml-fragments--en)

Note: Summary

Fragment XML conditions and web panel class scripts are now provided via XML parameters and are no longer directly set as the condition class element attribute or web panel class element attribute value. You can use this guide to help you convert your scripts to the new fragment XML parameters format.

## Examples of the old Raw XML format

Below are examples of raw XML scripts that will no longer work and will need updating.

### `Web Items`

Inline script:

```
<web-item key='test-key' name='ScriptRunner generated web item - test-key' section='system.header/spaces-menu' weight='1'>
    <label>Test</label>
    <condition class='myConditions/fooCondition.groovy'>
        <param name='£trackingParameters' value='{"scriptName":"com.onresolve.scriptrunner.canned.confluence.fragments.CustomWebItem"}' />
        <param name='£fragmentParameters' value='{"id":"9a4f29fb-4c4d-42b6-a602-b327606ba772"}' />
    </condition>
    <styleClass> test-key </styleClass>
    <link linkId='test-key'>https://www.google.com?_=1</link>
</web-item>
```

Script file:

```
<web-item key='test-key' name='ScriptRunner generated web item - test-key' section='system.header/spaces-menu' weight='1'>
    <label>Test</label>
    <condition class='myConditions/fooCondition.groovy'>
        <param name='£trackingParameters' value='{"scriptName":"com.onresolve.scriptrunner.canned.confluence.fragments.CustomWebItem"}' />
        <param name='£fragmentParameters' value='{"id":"9a4f29fb-4c4d-42b6-a602-b327606ba772"}' />
    </condition>
    <styleClass> test-key </styleClass>
    <link linkId='test-key'>https://www.google.com?_=1</link>
</web-item>
```

### `Web Panels`

Inline script:

```
<web-panel key='test-one' name='ScriptRunner generated web panel - test-one' location='atl.confluence.header' weight='1' class='myPanels/myPanelScript.groovy'>
    <label>Test Panel</label>
    <condition class='myConditions/fooCondition.groovy'>
        <param name='£trackingParameters' value='{"scriptName":"com.onresolve.scriptrunner.canned.confluence.fragments.CustomWebPanel"}' />
        <param name='£fragmentParameters' value='{"id":"eb7436cc-6ca9-4519-8c9b-cb94f68eb562"}' />
    </condition>
    <param name='lazy' value='true' />
</web-panel>
```

Script file:

```
<web-panel key='test-one' name='ScriptRunner generated web panel - test-one' location='atl.confluence.header' weight='1' class='myPanels/myPanelScript.groovy'>
    <label>Test Panel</label>
    <condition class='myConditions/fooCondition.groovy'>
        <param name='£trackingParameters' value='{"scriptName":"com.onresolve.scriptrunner.canned.confluence.fragments.CustomWebPanel"}' />
        <param name='£fragmentParameters' value='{"id":"eb7436cc-6ca9-4519-8c9b-cb94f68eb562"}' />
    </condition>
    <param name='lazy' value='true' />
</web-panel>
```

## Find the broken raw XML fragments

After you upgrade ScriptRunner for Confluence and you still have the outdated raw XML fragments, ScriptRunner for Confluence shows errors in the logs when ScriptRunner is enabled. Each error starts with this message:

```
Execution of Fragment script failed with error
```

Then the error message describes why it failed and gives a link to where you can edit the failing fragment.

```
Edit the broken fragment here: <URL Link to edit the broken fragment>
```

The broken raw XML fragments will still show as active in the ScriptRunner UI fragments page, but they will not be functional.

## Fix the broken raw XML fragments

Use the log output to find which raw XML fragments need to be fixed. Every time you edit or create a fragment, all fragments are re-registered, so you will see the log error messages every time you make changes until all invalid fragments have been fixed.

Tip: In most cases, the fragments that will break do so because they were originally copied from the output of our built-in fragment scripts, such as the Custom Web Item, Show a Web Panel, and Create a Custom Web Section.

We suggest these steps to fix broken raw XML fragments:

Warning: Back up XML

Before you start updating XML, we suggest backing up the previous raw XML so that you can refer back to it if you are unable to get the new format working in the same way. This will help ScriptRunner Support if you need help creating the new raw XML format.

1.  Extract the XML for a broken fragment to a notepad or open it in a new tab.
2.  Open the UI fragment built-in script that correlates to your broken raw XML:
    
    -   [Custom Web Item](https://docs.adaptavist.com/sr4c/latest/features/fragments/web-item)
    -   [Show a Web Panel](https://docs.adaptavist.com/sr4c/latest/features/fragments/web-panel)
    -   [Create a Custom Web Section](https://docs.adaptavist.com/sr4c/latest/features/fragments/web-section)
    
3.  Fill in the details of the form with the values from the XML
4.  If you had a Condition or web-panel Provider class script configured with an inline Groovy script or file path, see the examples below for instructions on how to convert them.
5.  Click the Preview button to generate the new format XML.

See below for detailed examples for each type of UI fragment.

### Example: Fix a broken raw XML fragment in a web item

Let's say that you have the following web item script in your instances with the broken raw XML format:

```
<web-item key='test-key' name='ScriptRunner generated web item - test-key' section='system.header/spaces-menu' weight='1'>
  <label>Test</label>
  <condition class='script:def test = 1&#10;true'>
    <param name='£trackingParameters' value='{"scriptName":"com.onresolve.scriptrunner.canned.confluence.fragments.CustomWebItem"}' />
    <param name='£fragmentParameters' value='{"id":"9a4f29fb-4c4d-42b6-a602-b327606ba772"}' />
  </condition>
  <styleClass> test-key </styleClass>
  <link linkId='test-key'>https://www.google.com?_=1</link>
</web-item>
```

Follow these steps to fix it:

1.  Fill out a form and get the new XML.
    1.  Navigate to General Configuration > ScriptRunner > UI Fragments > Create UI Fragment > Custom Web Item since this is a web item.
    2.  Fill out the form that appears:
        
        -   Name: Take the name value text from the XML minus the " `ScriptRunner generated web item -` " text (line 1 in the above XML). e.g: test-key
        -   What section should this go in: Take the section value from the XML (line 1 in the above XML)
        -   Key: Take the `key` value from the XML (line 1 from the above XML). e.g: `test-key`
        -   Menu Text: Take the `label` value from the XML (line 2 from the above XML). e.g: `Test`
        -   Weight: Take the `weight` value from the XML (line 1 from the above XML). e.g: `1`
        -   Condition: See the _Step 3: Add your condition script back to the XML_ section below. We will do this after the rest of this task, so leave it blank for now.
        -   Do What: Leave this as the default.
            
            Tip: If you know that your current raw XML was used to create a button that shows a dialog or a flag, choose the related option from the drop-down. All this field does is modify the `styleclass` output which you can add later as well.
            
        -   Link: Take the `link` value from the XML (line 8 from the above XML). `<https://www.google.com>`
        
    3.  Click the Preview button to generate the new XML.
2.  Add the missing extra elements.
    1.  Copy the XML to a notepad.
    2.  Double-check the new XML against your old XML to make sure that the `<styleclass>` is the same. If not, alter your new XML to match.
    3.  Add any extra elements to the new XML that you had in your previous one.
        
        For example, if you added a tooltip like <tooltip>My tool tip</tooltip>, you can add that back.
        
3.  Add your condition script back to the XML.
    
    Your condition script can be in two different formats. Pick the section that matches your condition script format:
    
    -   [Inline scripts](https://docs.adaptavist.com/sr4c/latest/release-notes/breaking-changes/raw-xml-module-breaking-change-for-confluence-9#example-fix-a-broken-raw-xml-fragment-in-a-web-item--en__p-2684)
    -   [Script files](https://docs.adaptavist.com/sr4c/latest/release-notes/breaking-changes/raw-xml-module-breaking-change-for-confluence-9#example-fix-a-broken-raw-xml-fragment-in-a-web-item--en__p-2778)
    
    Inline scripts: If your broken XML used an inline script condition, meaning the script showed as a string that started with `script:` For example, the old raw XML condition class value for an inline script would have looked similar to this:
    
    ```
    <condition class='script:def test = 1&#10;true'>
        <param name='£trackingParameters' value='{"scriptName":"com.onresolve.scriptrunner.canned.confluence.fragments.CustomWebItem"}' />
        <param name='£fragmentParameters' value='{"id":"cd7e529b-57c9-47d9-ad64-23a814412d74"}' />
    </condition>
    ```
    
    Make sure you have your new XML, and then follow these steps to migrate your condition script:
    
    1.  Take the old XML inline script value, for example: 'script:def test = 1&#10;true' and use our converter script to alter it to the new format.
        
        Converter script...
        
        1.  Open the ScriptRunner Console.
        2.  Paste the following script into the console script area. 
            
            ```
            import groovy.json.JsonOutput
            import org.apache.commons.lang.StringEscapeUtils
             
            def scriptStringToConvert = 'script:def test = "hello"&#10;&#10;context.space != null &amp;&amp; context.user.name == &apos;admin&apos;'
             
            def xmlToJsonEscapedString(String xmlString) {
             if(xmlString.startsWith('script:')) {
                    xmlString = xmlString.replaceFirst('script:', '')
                }
             def unescapedXmlString = StringEscapeUtils.unescapeXml(xmlString)
                JsonOutput.toJson(unescapedXmlString)
            }
             
            "<pre>" + xmlToJsonEscapedString(scriptStringToConvert) + "</pre>"
            ```
            
        3.  Set the value of the `scriptStringToConvert` variable to the exact value from your XML.
        4.  Click Run.
        5.  Copy the output from the Result tab exactly, including the outer double quotes.
        6.  Use that as the value for the " `script"`: property within the `conditionConfig` or the `panelClassConfig` XML parameter element.
    2.  Find the `<param name='conditionConfig'` element in the new XML.
    3.  Find the `{"parameters":{},"script":"true","scriptPath":null}` value within the element from step 2.
    4.  Go to the `"script":"true"` part of your new XML and replace th `e "true"` with the exact value that was output from the converter script in step 1.
    
    The final converted web item fragment's raw XML would look like this:
    
    ```
    <web-item key='test-key' name='ScriptRunner generated web item - test-key' section='system.header/spaces-menu' weight='1'>
      <label>Test</label>
      <condition class='com.onresolve.scriptrunner.fragments.ConfluenceScriptRunnerCondition'>
        <param name='£trackingParameters' value='{"scriptName":"com.onresolve.scriptrunner.canned.confluence.fragments.CustomWebItem"}' />
        <param name='£fragmentParameters' value='{"id":"234193d0-7ed4-43a6-84c3-7ce1ee2ce72f"}' />
        <param name='conditionConfig'><![CDATA[{"parameters":{},"script":"def test = 1
    true","scriptPath":null}]]></param>
      </condition>
      <styleClass> test-key </styleClass>
      <link linkId='test-key'>http://www.google.com?_=1</link>
    </web-item>
    ```
    
    Script files: If your broken XML used a file path to a script instead of an inline script, you will add your script path as the value for the `"scriptPath"` section.
    
    For example, the old raw XML condition class value for a script path would have looked like this:
    
    ```
    <condition class='path/to/my/groovy/file.groovy'>
        <param name='£trackingParameters' value='{"scriptName":"com.onresolve.scriptrunner.canned.confluence.fragments.CustomWebItem"}' />
        <param name='£fragmentParameters' value='{"id":"cd7e529b-57c9-47d9-ad64-23a814412d74"}' />
    </condition>
    ```
    
    The new XML would look like this:
    
    ```
    <web-item key='test-key' name='ScriptRunner generated web item - test-key' section='system.header/spaces-menu' weight='1'>
      <label>Test</label>
      <condition class='com.onresolve.scriptrunner.fragments.ConfluenceScriptRunnerCondition'>
        <param name='£trackingParameters' value='{"scriptName":"com.onresolve.scriptrunner.canned.confluence.fragments.CustomWebItem"}' />
        <param name='£fragmentParameters' value='{"id":"234193d0-7ed4-43a6-84c3-7ce1ee2ce72f"}' />
        <param name='conditionConfig'><![CDATA[{"parameters":{},"script":null,"scriptPath":"path/to/my/groovy/file.groovy"}]]></param>
      </condition>
      <styleClass> test-key </styleClass>
      <link linkId='test-key'>http://www.google.com?_=1</link>
    </web-item>
    ```
    
    Tip: Remember to use double quotes ( `""`) around the file path.
    

### Example: Fix a broken raw XML fragment in a web section

The process for migrating web sections is the same as for web items. Follow these steps:

1.  Fill out the Create a Custom web section form, referring to the old broken raw XML for the form field values.
2.  Click the Preview button to get the new XML.
3.  Add the missing extra elements shown in [Add the missing extra elements](https://docs.adaptavist.com/sr4c/latest/release-notes/breaking-changes/raw-xml-module-breaking-change-for-confluence-9#example-fix-a-broken-raw-xml-fragment-in-a-web-item--en__step-2645) in the web item steps above.
4.  Add the condition back to the XML (remember to use the converter script to convert your inline scripts to the new format).
    
    Converter script...
    
    1.  Open the ScriptRunner Console.
    2.  Paste the following script into the console script area. 
        
        ```
        import groovy.json.JsonOutput
        import org.apache.commons.lang.StringEscapeUtils
         
        def scriptStringToConvert = 'script:def test = "hello"&#10;&#10;context.space != null &amp;&amp; context.user.name == &apos;admin&apos;'
         
        def xmlToJsonEscapedString(String xmlString) {
         if(xmlString.startsWith('script:')) {
                xmlString = xmlString.replaceFirst('script:', '')
            }
         def unescapedXmlString = StringEscapeUtils.unescapeXml(xmlString)
            JsonOutput.toJson(unescapedXmlString)
        }
         
        "<pre>" + xmlToJsonEscapedString(scriptStringToConvert) + "</pre>"
        ```
        
    3.  Set the value of the `scriptStringToConvert` variable to the exact value from your XML.
    4.  Click Run.
    5.  Copy the output from the Result tab exactly, including the outer double quotes.
    6.  Use that as the value for the " `script": property within the` `conditionConfig or the` `panelClassConfig XML parameter element.`
    

Tip: For more details, check the _[Example: Fix a broken raw XML fragment in a web item](https://docs.adaptavist.com/sr4c/latest/release-notes/breaking-changes/raw-xml-module-breaking-change-for-confluence-9#example-fix-a-broken-raw-xml-fragment-in-a-web-item--en)_ section.

### Example: Fix a broken raw XML fragment in a web panel

Let's say that you have the following web panel script in your instances with the broken raw XML format:

```
<web-panel key='test-one' name='ScriptRunner generated web panel - test-one' location='atl.confluence.header' weight='1' class='script:writer.write("This is HTML that my web panel generates!")'>
  <label>Test Panel</label>
  <condition class='script:true'>
    <param name='£trackingParameters' value='{"scriptName":"com.onresolve.scriptrunner.canned.confluence.fragments.CustomWebPanel"}' />
    <param name='£fragmentParameters' value='{"id":"eb7436cc-6ca9-4519-8c9b-cb94f68eb562"}' />
  </condition>
  <param name='lazy' value='true' />
</web-panel>
```

The process for migrating a web panel's raw XML is the same as for web items when migrating the _conditions_ element, but also requires one extra step to migrate the web panel provider class.

Tip: For more details on migrating the condition script element, check the _[Example: Fix a broken raw XML fragment in a web item](https://docs.adaptavist.com/sr4c/latest/release-notes/breaking-changes/raw-xml-module-breaking-change-for-confluence-9#example-fix-a-broken-raw-xml-fragment-in-a-web-item--en)_ section.

Follow these additional steps to migrate the provider class script:

#### Step 1: Fill out a form and get the new XML

1.  Navigate to General Configuration > ScriptRunner > UI Fragments > Create UI Fragment > Show a web panel.
2.  Fill out the fields that appear, as you did for the web item (Web Panels use `location` in place of the web items' `section`).
    
    Warning: The Provider Class/Script
    
    Please review the following information closely. It differs from the web item process
    
    1.  When filling out the _Show a web panel_ form for the Provider Class/Script field, use the following template script to get the new XML. We will replace this later.
        
        ```
        writer.write("Hello world!")
        ```
        
    2.  The web panel provider class script migration is similar to conditions, but your script needs to be placed within the parameters of our new `context-provider` block.
3.  Click the Preview button to generate the new XML. It will look similar to this:
    
    ```
    <web-panel key='test-one' name='ScriptRunner generated web panel - test-one' location='atl.confluence.header' weight='1' class='com.onresolve.scriptrunner.fragments.ScriptWebPanel'>
      <label>Test Panel</label>
      <condition class='com.onresolve.scriptrunner.fragments.ConfluenceScriptRunnerCondition'>
        <param name='£trackingParameters' value='{"scriptName":"com.onresolve.scriptrunner.canned.confluence.fragments.CustomWebPanel"}' />
        <param name='£fragmentParameters' value='{"id":"4bf6f413-f2d0-449b-b07a-4ebdff15d849"}' />
        <param name='conditionConfig'><![CDATA[{"parameters":{},"script":"true","scriptPath":null}]]></param>
      </condition>
      <context-provider class='com.onresolve.scriptrunner.fragments.ScriptRunnerContextProvider'>
        <param name='panelClassConfig'><![CDATA[{"parameters":{},"script":"writer.write(\"Hello world!\") ","scriptPath":null}]]></param>
      </context-provider>
      <param name='lazy' value='true' />
    </web-panel>
    ```
    

#### Step 2: Add the missing elements

Please follow the steps shown in [Add the missing extra elements](https://docs.adaptavist.com/sr4c/latest/release-notes/breaking-changes/raw-xml-module-breaking-change-for-confluence-9#example-fix-a-broken-raw-xml-fragment-in-a-web-item--en__step-2645) in the web item steps above.

#### Step 3: Add your condition script back to the XML

Please follow the steps shown in [Add your condition script back to the XML](https://docs.adaptavist.com/sr4c/latest/release-notes/breaking-changes/raw-xml-module-breaking-change-for-confluence-9#example-fix-a-broken-raw-xml-fragment-in-a-web-item--en) in the web item steps above.

#### Step 4: Fix the provider class script

Warning: Please review these steps closely. They differ from the web item process.

1.  Find the `panelClassConfig` line in the new XML and look for the parameters section that looks like this: 
    
    ```
    {"parameters":{},"script":"writer.write(\"Hello world!\")","scriptPath":null}
    ```
    
2.  Determine which kind of script your provider class script is and follow the steps:
    
    Inline scripts:
    
    1.  Take the old XML inline script value for the web-panel class attribute, for example: `'script:writer.write("This is HTML that my web panel generates!")'` and use this converter script to alter it to the new format.
        
        Converter script...
        
        1.  Open the ScriptRunner Console.
        2.  Paste the following script into the console script area.
            
            ```
            import groovy.json.JsonOutput
            import org.apache.commons.lang.StringEscapeUtils
             
            def scriptStringToConvert = 'script:def test = "hello"&#10;&#10;context.space != null &amp;&amp; context.user.name == &apos;admin&apos;'
             
            def xmlToJsonEscapedString(String xmlString) {
             if(xmlString.startsWith('script:')) {
                    xmlString = xmlString.replaceFirst('script:', '')
                }
             def unescapedXmlString = StringEscapeUtils.unescapeXml(xmlString)
                JsonOutput.toJson(unescapedXmlString)
            }
             
            "<pre>" + xmlToJsonEscapedString(scriptStringToConvert) + "</pre>"
            ```
            
        3.  Set the value of the `scriptStringToConvert` variable to the exact value from your XML.
        4.  Click Run.
        5.  Copy the output from the Result tab exactly, including the outer double quotes.
        6.  Use that as the value for the " `script": property within the` `conditionConfig or the` `panelClassConfig XML parameter element.`
    2.  Find the `<param name='panelClassConfig'` element in the new XML.
    3.  Find the `{"parameters":{},"script":"writer.write(\"Hello world!\") ","scriptPath":null}` value in the new XML.
    4.  Find the `"script":"writer.write(\"Hello world!\") "` part of your new XML and replace th `e "writer.write(\"Hello world!\") " part` with the exact value that was output from the converter script it Step 1.
    
    The new converted XML moves the script to a new context-provider section. The final converted XML would look like this:
    
    ```
    <web-panel key='test-one' name='ScriptRunner generated web panel - test-one' location='atl.confluence.header' weight='1' class='com.onresolve.scriptrunner.fragments.ScriptWebPanel'>
      <label>Test Panel</label>
      <condition class='com.onresolve.scriptrunner.fragments.ConfluenceScriptRunnerCondition'>
        <param name='£trackingParameters' value='{"scriptName":"com.onresolve.scriptrunner.canned.confluence.fragments.CustomWebPanel"}' />
        <param name='£fragmentParameters' value='{"id":"4bf6f413-f2d0-449b-b07a-4ebdff15d849"}' />
        <param name='conditionConfig'><![CDATA[{"parameters":{},"script":"true","scriptPath":null}]]></param>
      </condition>
      <context-provider class='com.onresolve.scriptrunner.fragments.ScriptRunnerContextProvider'>
        <param name='panelClassConfig'><![CDATA[{"parameters":{},"script":"writer.write(\"This is HTML that my web panel generates!\")","scriptPath":null}]]></param>
      </context-provider>
      <param name='lazy' value='true' />
    </web-panel>
    ```
    
    Script files:
    
    1.  If your broken XML used a file path to a script instead of an inline script, you will add your script path as the value for the `"scriptPath"` section. The old XML web panel class attribute would have looked similar to this: 
        
        ```
        <web-panel key='test-one' name='ScriptRunner generated web panel - test-one' location='atl.confluence.header' weight='1' class='path/to/my/groovy/file.groovy'>
        ```
        
        The new converted XML moves the scriptPath to a new context-provider section, and therefore, the converted XML would look like this:
        
        ```
        <web-panel key='test-one' name='ScriptRunner generated web panel - test-one' location='atl.confluence.header' weight='1' class='com.onresolve.scriptrunner.fragments.ScriptWebPanel'>
          <label>Test Panel</label>
          <condition class='com.onresolve.scriptrunner.fragments.ConfluenceScriptRunnerCondition'>
            <param name='£trackingParameters' value='{"scriptName":"com.onresolve.scriptrunner.canned.confluence.fragments.CustomWebPanel"}' />
            <param name='£fragmentParameters' value='{"id":"4bf6f413-f2d0-449b-b07a-4ebdff15d849"}' />
            <param name='conditionConfig'><![CDATA[{"parameters":{},"script":"true","scriptPath":null}]]></param>
          </condition>
          <context-provider class='com.onresolve.scriptrunner.fragments.ScriptRunnerContextProvider'>
            <param name='panelClassConfig'><![CDATA[{"parameters":{},"script":null,"scriptPath":"path/to/my/groovy/file.groovy"}]]></param>
          </context-provider>
          <param name='lazy' value='true' />
        </web-panel>
        ```
