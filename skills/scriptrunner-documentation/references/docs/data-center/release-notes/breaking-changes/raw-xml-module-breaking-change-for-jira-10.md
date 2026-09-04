# Raw XML Module Breaking Change for Jira 10

- Platform: data-center
- Space: SR4JS
- Hierarchy: release-notes > breaking-changes
- Doc ID: doc-sr4js-280527071
- Source: https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes/raw-xml-module-breaking-change-for-jira-10

The raw XML format for `condition class` and `provider class` has changed with [Jira 10.0](https://docs.adaptavist.com/sr4js/latest/get-started/update-scriptrunner/compatibility-with-jira). The formats previously generated from the _Preview_ button for each of these built-in fragment scripts are no longer valid:

-   [Web Item](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-item)
-   [Web Panel](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-panel)
-   [Web Section](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-section)
-   [Web Item Provider](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-item-provider-built-in-script)

If you previously created a fragment using the raw XML generated from the _Preview_ button, you will have to manually update it to the new format for your fragment to function correctly. On this page, find the following information about this breaking change:

-   [Examples of the old Raw XML format](#id-.RawXMLModuleBreakingChangeforJira10v9.x-examples)
-   [Find the broken raw XML fragments](#id-.RawXMLModuleBreakingChangeforJira10v9.x-find)
-   [Fix the broken raw XML fragments](#id-.RawXMLModuleBreakingChangeforJira10v9.x-fix)
-   [Fix a broken raw XML fragment for a web item provider](#id-.RawXMLModuleBreakingChangeforJira10v9.x-provider)

Summary

Fragment XML conditions and web panel class scripts are now provided via XML parameters and are no longer directly set as the condition class element attribute or web panel class element attribute value. You can use this guide to help you convert your scripts to the new fragment XML parameters format.

## Examples of the old Raw XML format

Below are examples of raw XML scripts that will no longer work and will need updating.

### `Web Items`

Inline script: 

```
<web-item key='test-key' name='ScriptRunner generated web item - test-key' section='system.top.navigation.bar' weight='1'>
  <label>Test</label>
  <condition class='script:def myVar = 123&#10;true'>
    <param name='£trackingParameters' value='{"scriptName":"com.onresolve.scriptrunner.canned.jira.fragments.CustomWebItem"}' />
    <param name='£fragmentParameters' value='{"id":"37b363fb-5d35-496f-9a7f-459621740bb7"}' />
  </condition>
  <styleClass> test-key </styleClass>
  <link linkId='test-key'>https://www.google.com?_=1</link>
</web-item>
```

Script file: 

```
<web-item key='test-key' name='ScriptRunner generated web item - test-key' section='system.top.navigation.bar' weight='1'>
  <label>Test</label>
  <condition class='myConditions/fooCondition.groovy'>
    <param name='£trackingParameters' value='{"scriptName":"com.onresolve.scriptrunner.canned.jira.fragments.CustomWebItem"}' />
    <param name='£fragmentParameters' value='{"id":"37b363fb-5d35-496f-9a7f-459621740bb7"}' />
  </condition>
  <styleClass> test-key </styleClass>
  <link linkId='test-key'>https://www.google.com?_=1</link>
</web-item>
```

### `Web Panels   `

Inline script: 

```
<web-panel key='test-one' name='ScriptRunner generated web panel - test-one' location='atl.header' weight='1' class='script:writer.write("My web panel HTML content")'>
  <label>Test Panel</label>
  <condition class='script:true'>
    <param name='£trackingParameters' value='{"scriptName":"com.onresolve.scriptrunner.canned.jira.fragments.CustomWebPanel"}' />
    <param name='£fragmentParameters' value='{"id":"9c79e82f-aba8-41c0-8ff7-1a6c147e8f1e"}' />
  </condition>
  <param name='lazy' value='true' />
</web-panel>
```

Script file: 

```
<web-panel key='test-one' name='ScriptRunner generated web panel - test-one' location='atl.header' weight='1' class='myPanels/myPanelScript.groovy'>
  <label>Test Panel</label>
  <condition class='myConditions/fooCondition.groovy'>
    <param name='£trackingParameters' value='{"scriptName":"com.onresolve.scriptrunner.canned.jira.fragments.CustomWebPanel"}' />
    <param name='£fragmentParameters' value='{"id":"9c79e82f-aba8-41c0-8ff7-1a6c147e8f1e"}' />
  </condition>
  <param name='lazy' value='true' />
</web-panel>
```

### `Web Item Provider`

```
<web-item-provider key='test-key' name='ScriptRunner generated web item provider - test-key' section='find_link/active-issues' class='script:import com.atlassian.plugin.web.api.model.WebFragmentBuilder&#10; &#10; ["Foo", "Bar"].collect {&#10;     new WebFragmentBuilder(50).&#10;         id("sample-web-item-${it.toLowerCase()}").&#10;         label("$it Sample Web Item").&#10;         title("$it Sample Web Item Title").&#10;         styleClass("").&#10;         webItem("").&#10;         url("/").&#10;         build()&#10;}' />
```

  

  

## Find the broken raw XML fragments

After you upgrade ScriptRunner for Jira and you still have the outdated raw XML fragments, ScriptRunner for Jira shows errors in the logs when ScriptRunner is enabled. Each error starts with this message: 

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

In most cases, the fragments that will break do so because they were originally copied from the output of our built-in fragment scripts, such as the Custom Web Item, Show a Web Panel, and Create a Custom Web Section.

We suggest these steps to fix broken raw XML fragments: 

Back up XML

Before you start updating XML, we suggest backing up the previous raw XML so that you can refer back to it if you are unable to get the new format working in the same way. This will help ScriptRunner Support if you need help creating the new raw XML format.

1.  Extract the XML for a broken fragment to a notepad or open it in a new tab.
2.  Open the UI fragment built-in script that correlates to your broken raw XML: 
    -   [Custom Web Item](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-item)
    -   [Show a Web Panel](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-panel)
    -   [Create a Custom Web Section](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-section)
3.  Fill in the details of the form with the values from the XML
4.  If you had a Condition or web-panel Provider class script configured with an inline Groovy script or file path, see the examples below for instructions on how to convert them.
5.  Click the **P****review** button to generate the new format XML.

See below for detailed examples for each type of UI fragment.

### Example: Fix a broken raw XML fragment in a web item

Let's say that you have the following web item script in your instances with the broken raw XML format: 

```
<web-item key='test-key' name='ScriptRunner generated web item - test-key' section='system.top.navigation.bar' weight='1'>
  <label>Test</label>
  <condition class='script:def myVar = 123&#10;true'>
    <param name='£trackingParameters' value='{"scriptName":"com.onresolve.scriptrunner.canned.jira.fragments.CustomWebItem"}' />
    <param name='£fragmentParameters' value='{"id":"37b363fb-5d35-496f-9a7f-459621740bb7"}' />
  </condition>
  <styleClass> test-key </styleClass>
  <link linkId='test-key'>https://www.google.com?_=1</link>
</web-item>
```

Follow these steps to fix it:

**Step 1: Fill out a form and get the new XML**

1.  Navigate to **General Configuration** > _ScriptRunner_ > **UI Fragments** > **Create UI Fragment** > **Custom Web Item** since this is a web item.
2.  Fill out the form that appears: 
    1.  **Name**: Take the name value text from the XML minus the "`ScriptRunner generated web item -` " text (line 1 in the above XML). e.g: test-key
    2.  **What section should this go in**: Take the section value from the XML (line 1 in the above XML)
    3.  **Key**: Take the `key` value from the XML (line 1 from the above XML). e.g:  `test-key`
    4.  **Menu** **Text**: Take the `label` value from the XML (line 2 from the above XML). e.g:  `Test`
    5.  **Weight**: Take the `weight` value from the XML (line 1 from the above XML). e.g:  `1`
    6.  **Condition**: See the _Step 3: Add your condition script back to the XML_ section below. We will do this after the rest of this task, so leave it blank for now.
        
        If you had a file path like \`path/to/my/groovy/file.groovy\` for your old XML condition instead of an inline script, you can simply add the file path as the condition form fields value from the file tab now and skip step 3
        
    7.  **Do What:** Leave this as the default.
        
        If you know that your current raw XML was used to create a button that shows a dialog or a flag, choose the related option from the drop-down. All this field does is modify the `styleclass` output which you can add later as well. 
        
    8.  **Link**: Take the `link` value from the XML (line 8 from the above XML). `[https://www.google.com](https://www.google.com)` 
3.  Click the **Preview** button to generate the new XML.

**Step 2: Add the missing extra elements**

1.  Copy the XML to a notepad. 
2.  Double-check the new XML against your old XML to make sure that the `<styleclass>` is the same. If not, alter your new XML to match.
3.  Add any extra elements to the new XML that you had in your previous one.   
    For example, if you added a tooltip like <tooltip>My tool tip</tooltip>, you can add that back. 

**Step 3: Add your condition script back to the XML**

Your condition script can be in two different formats. Pick the section that matches your condition script format: 

-   [Inline scripts](#id-.RawXMLModuleBreakingChangeforJira10v9.x-inlinescr)
-   [Script files](#id-.RawXMLModuleBreakingChangeforJira10v9.x-scriptfiles)

**Inline scripts**: If your broken XML used an inline script condition, meaning the script showed as a string that started with `script:`  
For example, the old raw XML condition class value for an inline script would have looked similar to this:

```
   <condition class='script:def myVar = 123&#10;true'>
     <param name='£trackingParameters' value='{"scriptName":"com.onresolve.scriptrunner.canned.jira.fragments.CustomWebItem"}' />
    <param name='£fragmentParameters' value='{"id":"37b363fb-5d35-496f-9a7f-459621740bb7"}' />
  </condition>
```

Make sure you have your new XML, and then follow these steps to migrate your condition script: 

1.  Take the old XML inline script value, for example: 'script:def test = 1&#10;true' and use our **converter script** to alter it to the new format.
    
    Converter script...
    
    1.  Open the ScriptRunner **Console**.
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
    4.  Click **Run**.
    5.  Copy the output from the **Result** tab exactly, including the outer double quotes.
    6.  Use that as the value for the "`script": property within the` conditionConfig  or the `panelClassConfig XML parameter element.` 
        
    
2.  Find the `<param name='conditionConfig'` element in the new XML. 
3.  Find the `{"parameters":{},"script":"true","scriptPath":null}` value within the element from step 2. 
4.  Go to the `"script":"true"` part of your **new** **XML** and replace th`e "true"` with the **exact value that was output from the converter script in step 1**.

The final converted web item fragment's raw XML would look like this: 

```
<web-item key='test-key' name='ScriptRunner generated web item - test-key' section='system.top.navigation.bar' weight='1'>
  <label>Test</label>
  <condition class='com.onresolve.scriptrunner.fragments.JiraScriptRunnerCondition'>
    <param name='£trackingParameters' value='{"scriptName":"com.onresolve.scriptrunner.canned.jira.fragments.CustomWebItem"}' />
    <param name='£fragmentParameters' value='{"id":"050e4160-09f6-46cb-ac50-a07a87022d1b"}' />
    <param name='conditionConfig'><![CDATA[{"parameters":{},"script":"def myVar = 123\ntrue","scriptPath":null}]]></param>
  </condition>
  <styleClass> test-key </styleClass>
  <link linkId='test-key'>https://www.google.com?_=1</link>
</web-item>
```

**Script files**: If your broken XML used a file path to a script instead of an inline script, you will add your script path as the value for the `"scriptPath"` section.

For example, the old raw XML condition class value for a script path would have looked like this: 

```
  <condition class='path/to/my/groovy/file.groovy'>
    <param name='£trackingParameters' value='{"scriptName":"com.onresolve.scriptrunner.canned.jira.fragments.CustomWebItem"}' />
    <param name='£fragmentParameters' value='{"id":"37b363fb-5d35-496f-9a7f-459621740bb7"}' />
  </condition>
```

The new XML would look like this: 

```
<web-item key='test-key' name='ScriptRunner generated web item - test-key' section='system.top.navigation.bar' weight='1'>
  <label>Test</label>
  <condition class='com.onresolve.scriptrunner.fragments.JiraScriptRunnerCondition'>
    <param name='£trackingParameters' value='{"scriptName":"com.onresolve.scriptrunner.canned.jira.fragments.CustomWebItem"}' />
    <param name='£fragmentParameters' value='{"id":"45a0ebf6-7858-42fc-ace2-265770db0dbd"}' />
    <param name='conditionConfig'><![CDATA[{"parameters":{},"script":null,"scriptPath":"path/to/my/groovy/file.groovy"}]]></param>
  </condition>
  <styleClass> test-key </styleClass>
  <link linkId='test-key'>https://www.google.com?_=1</link>
</web-item>
```

Remember to use double quotes (`""`) around the file path.

### Example: Fix a broken raw XML fragment in a web section

The process for migrating web sections is the same as for web items. Follow these steps: 

1.  Fill out the **Create a Custom web section** form, referring to the old broken raw XML for the form field values.
2.  Click the preview button to get the new XML.  
    
3.  Add the missing extra elements shown in [Add the missing extra elements](#id-.RawXMLModuleBreakingChangeforJira10v9.x-extraelements) in the web item steps above.  
    
4.  Add the condition back to the XML (remember to use the **converter script** to convert your inline scripts to the new format). 
    
    Converter script...
    
    1.  Open the ScriptRunner **Console**.
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
    4.  Click **Run**.
    5.  Copy the output from the **Result** tab exactly, including the outer double quotes.
    6.  Use that as the value for the "`script": property within the` conditionConfig  or the `panelClassConfig XML parameter element.` 
        
    

For more details, check the _[Example: Fix a broken raw XML fragment in a web item](#id-.RawXMLModuleBreakingChangeforJira10v9.x-webitem)_ section.

### Example: Fix a broken raw XML fragment in a web panel

Let's say that you have the following web panel script in your instances with the broken raw XML format: 

```
<web-panel key='test-one' name='ScriptRunner generated web panel - test-one' location='atl.header' weight='1' class='script:writer.write("My web panel HTML content")'>
  <label>Test Panel</label>
  <condition class='script:true'>
    <param name='£trackingParameters' value='{"scriptName":"com.onresolve.scriptrunner.canned.jira.fragments.CustomWebPanel"}' />
    <param name='£fragmentParameters' value='{"id":"9c79e82f-aba8-41c0-8ff7-1a6c147e8f1e"}' />
  </condition>
  <param name='lazy' value='true' />
</web-panel>
```

The process for migrating a web panel's raw XML is the same as for web items when migrating the _conditions_ element, but also requires one extra step to migrate the web panel provider class.

For more details on migrating the condition script element, check the _[Example: Fix a broken raw XML fragment in a web item](#id-.RawXMLModuleBreakingChangeforJira10v9.x-webitem)_ section.

Follow these additional steps to migrate the provider class script: 

**Step 1: Fill out a form and get the new XML**

1.  Navigate to **General Configuration > ScriptRunner > UI Fragments > Create UI Fragment > Show a web panel**.
2.  Fill out the fields that appear, as you did for the web item. (Web Panels use \`**location**\` in place of the web items \`**section**\`).
    
    If you had a file path like \`path/to/my/groovy/file.groovy\` for your old XML web-panel class value instead of an inline script, you can simply add the file path as the **Provider Class/Script** form fields value from the file tab now and skip step 4
    
    The Provider Class/Script
    
    Please review the following information closely. It differs from the web item process.
    
    -   When filling out the "Show a web panel" form for the **Provider Class/Script** field, use the following template script to get the new XML. We will replace this later.
        
        ```
writer.write("Hello world!")
```
        
    -   The web panel provider class script migration is similar to conditions, but your script needs to be placed within the parameters of our new `context-provider` block. 
        
3.  Click the **Preview** button to generate the new XML. It will look similar to this: 
    
    ```
<web-panel key='test-one' name='ScriptRunner generated web panel - test-one' location='atl.header' weight='1' class='com.onresolve.scriptrunner.fragments.ScriptWebPanel'>
  <label>Test Panel</label>
  <condition class='com.onresolve.scriptrunner.fragments.JiraScriptRunnerCondition'>
    <param name='£trackingParameters' value='{"scriptName":"com.onresolve.scriptrunner.canned.jira.fragments.CustomWebPanel"}' />
    <param name='£fragmentParameters' value='{"id":"60b8111b-a3b5-424f-aec2-de6e481a2b73"}' />
    <param name='conditionConfig'><![CDATA[{"parameters":{},"script":"true","scriptPath":null}]]></param>
  </condition>
  <context-provider class='com.onresolve.scriptrunner.fragments.ScriptRunnerContextProvider'>
    <param name='panelClassConfig'><![CDATA[{"parameters":{},"script":"writer.write(\"Hello world!\")","scriptPath":null}]]></param>
  </context-provider>
  <param name='lazy' value='true' />
</web-panel>
```
    

**Step 2: Add the missing extra elements**

Please follow the steps shown in [Add the missing extra elements](#id-.RawXMLModuleBreakingChangeforJira10v9.x-extraelements) in the web item steps above.

**Step 3: Add your condition script back to the XML**

Please follow the steps shown in [Add your condition script back to the XML](#id-.RawXMLModuleBreakingChangeforJira10v9.x-conditionscript) in the web item steps above.

**Step 4: Fix the provider class script.**

Please review these steps closely. It differs from the web item process.

1.  Find the `panelClassConfig` line in the new XML and look for the parameters section that looks like this:
    
    ```
{"parameters":{},"script":"writer.write(\"Hello world!\")","scriptPath":null}
```
    
2.  Determine which kind of script your provider class script is and follow the steps: 

**Inline scripts**:

1.  1.  Take the old XML inline script value for the web-panel class attribute, for example: `'script:writer.write("This is HTML that my web panel generates!")'` and use this **converter script** to alter it to the new format.
        
        Converter script...
        
        1.  Open the ScriptRunner **Console**.
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
        4.  Click **Run**.
        5.  Copy the output from the **Result** tab exactly, including the outer double quotes.
        6.  Use that as the value for the "`script": property within the` conditionConfig  or the `panelClassConfig XML parameter element.` 
            
        
    2.  Find the `<param name='panelClassConfig'` element in the new XML. 
    3.  Find the `{"parameters":{},"script":"writer.write(\"Hello world!\") ","scriptPath":null}` value in the new XML. 
    4.  Find the `"script":"writer.write(\"Hello world!\") "` part of your **new** **XML** and replace th`e "writer.write(\"Hello world!\") " part` with the **exact value that was output from the converter script it step 1**.  
        
        The new converted XML moves the script to a new context-provider section. The final converted XML would look like this:
        
        ```
<web-panel key='test-one' name='ScriptRunner generated web panel - test-one' location='atl.header' weight='1' class='com.onresolve.scriptrunner.fragments.ScriptWebPanel'>
  <label>Test Panel</label>
  <condition class='com.onresolve.scriptrunner.fragments.JiraScriptRunnerCondition'>
    <param name='£trackingParameters' value='{"scriptName":"com.onresolve.scriptrunner.canned.jira.fragments.CustomWebPanel"}' />
    <param name='£fragmentParameters' value='{"id":"60b8111b-a3b5-424f-aec2-de6e481a2b73"}' />
    <param name='conditionConfig'><![CDATA[{"parameters":{},"script":"true","scriptPath":null}]]></param>
  </condition>
  <context-provider class='com.onresolve.scriptrunner.fragments.ScriptRunnerContextProvider'>
    <param name='panelClassConfig'><![CDATA[{"parameters":{},"script":"writer.write(\"My web panel HTML content\")","scriptPath":null}]]></param>
  </context-provider>
  <param name='lazy' value='true' />
</web-panel>
```
        

**Script files**:

1.  1.  If your broken XML used a file path to a script instead of an inline script, you will add your script path as the value for the `"scriptPath"` section.  
        The old XML web panel class attribute would have looked similar to this:
        
        ```
<web-panel key='test-one' name='ScriptRunner generated web panel - test-one' location='atl.header' weight='1' class='path/to/my/groovy/file.groovy'>
```
        
        The new converted XML moves the scriptPath to a new context-provider section, and therefore, the converted XML would look like this:
        
        ```
<web-panel key='test-one' name='ScriptRunner generated web panel - test-one' location='atl.header' weight='1' class='com.onresolve.scriptrunner.fragments.ScriptWebPanel'>
  <label>Test Panel</label>
  <condition class='com.onresolve.scriptrunner.fragments.JiraScriptRunnerCondition'>
    <param name='£trackingParameters' value='{"scriptName":"com.onresolve.scriptrunner.canned.jira.fragments.CustomWebPanel"}' />
    <param name='£fragmentParameters' value='{"id":"a5791370-0152-46a0-8536-51dd62c9281a"}' />
    <param name='conditionConfig'><![CDATA[{"parameters":{},"script":"true","scriptPath":null}]]></param>
  </condition>
  <context-provider class='com.onresolve.scriptrunner.fragments.ScriptRunnerContextProvider'>
    <param name='panelClassConfig'><![CDATA[{"parameters":{},"script":null,"scriptPath":"path/to/my/groovy/file.groovy"}]]></param>
  </context-provider>
  <param name='lazy' value='true' />
</web-panel>
```
        

### **Example: Fix a broken raw XML fragment for a web item provider**

When migrating an old Raw XML configuration for a Custom Web Item provider to the new format, you have to move the \`web-item-provider\` class attribute value to the new `providerClassConfig` param. For example:

Let's say this is an old Raw XML configuration similar to the below:

```
<web-item-provider key='test-key' name='ScriptRunner generated web item provider - test-key' section='find_link/active-issues' class='script:import com.atlassian.plugin.web.api.model.WebFragmentBuilder&#10; &#10; ["Foo", "Bar"].collect {&#10;     new WebFragmentBuilder(50).&#10;         id("sample-web-item-${it.toLowerCase()}").&#10;         label("$it Sample Web Item").&#10;         title("$it Sample Web Item Title").&#10;         styleClass("").&#10;         webItem("").&#10;         url("/").&#10;         build()&#10;}' />
```

To convert the above:

Use the following as your template for the new raw XML template:

```
<web-item-provider key='test-key' name='ScriptRunner generated web item provider - test-key' section='find_link/active-issues' class='com.onresolve.scriptrunner.fragments.ScriptWebItemProvider'>
  <param name='providerClassConfig'><![CDATA[{"parameters":{},"script":"PUT THE CONVETED SCRIPT IN HERE","scriptPath":null}]]></param>
</web-item-provider>
```

  

If the value for your old XML class attribute starts with "script:" :

1.  Find the **key** attribute in your old raw XML and use the same value for the same attribute in the above new raw XML template.
2.  Find the **section** attribute in your old raw XML and use the same value for the same attribute in the above new raw XML template.
3.  Take the class attribute value. e.g. the **'script:the script content'** part in for example **class='script:the script content'**
    1.  Use this **converter script** to alter it to the new format.
        
        Converter script...
        
        1.  Open the ScriptRunner **Console**.
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
        4.  Click **Run**.
        5.  Copy the output from the **Result** tab exactly, including the outer double quotes.
        6.  Use that as the value for the "`script": property within the` conditionConfig  or the `panelClassConfig XML parameter element.` 
            
        
    2.  Find the `<param name='providerClassConfig'` element in the new XML template above. 
    3.  Find the `{"parameters":{},"script":"PUT THE CONVETED SCRIPT IN HERE","scriptPath":null}` text on the same line. 
    4.  Find the `"script":"PUT THE CONVETED SCRIPT IN HERE"` and replace th`e` `"PUT THE CONVETED SCRIPT IN HERE"` `part` with the **exact value that was output from the converter script it step 3**.

  

If the value for your old XML class attribute is a path to a file; For example: **class='path/to/my/groovy/file.groovy'**

1.  Open the [Web Item Provider](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-item-provider-built-in-script) built-in script form
2.  Fill out the form details
    1.  **Name**: Take the name value text from the old XML
    2.  **What section should this go in**: Take the section value from the old XML
    3.  **Key**: Take the `key` value from the XML. e.g:  `test-key`
3.  Click the File tab on the **Provider class/script** field and add your old file path as the value
    
4.  Click preview to generate the new Raw XML format that can be used to define a web item provider as a raw XML configuration
