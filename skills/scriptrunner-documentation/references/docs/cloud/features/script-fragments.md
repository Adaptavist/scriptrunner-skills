# Script Fragments

- Platform: cloud
- Space: SR4JC
- Hierarchy: features
- Doc ID: doc-sr4jc-101629070
- Source: https://docs.adaptavist.com/sr4jc/latest/features/script-fragments

![](/sr4jc/files/latest/101629070/403866190/1/1751971063000/sr-migrate+%281%29.png)

**Migrating from ScriptRunner for Jira Server/DC to Cloud?** **Learn more in our** **[Feature Parity](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/feature-parity-and-script-alternatives#ui-fragments)** **overview.**

## Before you start

[![](/sr4jc/files/latest/101629070/230982590/1/1707305678000/learning+icon.jpg)](https://developer.atlassian.com/server/framework/atlassian-sdk/web-panel-plugin-module/)

Visit Atlassian's documentation to learn more about web panels.

  

[![](/sr4jc/files/latest/101629070/230982589/1/1707305731000/training+icon.jpg)](https://www.youtube.com/watch?v=B3w3X2DHRYE)

Don't know where to start? Take a look at some Script Fragment demos.

[shortcut Atlassian Documentation](https://developer.atlassian.com/server/framework/atlassian-sdk/web-panel-plugin-module/)

  

[shortcut Demo Videos](https://www.youtube.com/watch?v=B3w3X2DHRYE)

  

What are Script Fragments?

ScriptRunner’s Script Fragments feature allows you to customize your Jira UI by adding buttons or displaying web content on a page.

## How to use Script Fragments

You can use the Script Fragments feature to add web panels to a Jira work item. The web panels that are shown within the Jira work item UI enable you to display external content from within your Jira instance. This is very useful if you have content relevant to your Jira work items in an external system and you want to bring this content straight into your Jira work items. 

You can use web panels to display additional information on the current wiki page, Jira work item, or to add HTML snippets to parts of a page. For example, you can display your system's status page so your JSD users don’t have to leave Jira. You can also use Script Fragments to show scripted content, such as buttons, with which users can interact. An example of this might include [using a Script Fragment to display a scripted button that searches Confluence](https://www.youtube.com/watch?v=1WdCDhY2OXw) for the title of the Jira work item. 

Due to certain limitations, no more than two fragments can be displayed in a single location.

Create a Script Fragment

1.  Navigate to **ScriptRunner > Script Fragments**.  
    Depending on whether or not you have already created script fragments, you are presented with either a landing screen or a list of previously created script fragments.
2.  Click **Create Script Fragment** from the initial landing screen if none have been previously created.![](/sr4jc/files/latest/101629070/261685630/1/1717404330000/get+started+with+script+fragments.jpeg)  
    **_OR_**  
    Click **Create Script Fragment** highlighted above the previously created list.  
    ![](/sr4jc/files/latest/101629070/523764282/1/1774017804000/create+script+fragment.png)  
    The _Create Script Fragment_ screen displays, as highlighted below:  
    ![](/sr4jc/files/latest/101629070/523764281/1/1774018129000/create++fragment.png)  
      
    
3.  Select the relevant space from the **Spaces** drop down list.
4.  Select the type of fragment you would like to add from the **Fragment type** drop down list.
5.  Select the location where the script fragment will appear.
    
6.  Select the **Source** drop down list and choose from:
    
    -   The **Single URL** option to link a webpage to your web item, displaying it in a pop-up box where the web panel is located.
        
    -   The **Separate HTML, CSS, JS URLs** option to inject a HTML URL, CSS and JavaScript into your button.
        
7.  If you’ve selected the **Single URL** option, add your target URL
    
8.  If you’ve selected the **Separate HTML, CSS, JS URLs** option, add your HTML URL, CSS URL and JavaScript URL to the web panel.
    
9.  Click **Save**.
    

The HTML, CSS and Javascript need to be hosted somewhere that Jira can access. We recommend using [CodePen](https://codepen.io/) for the hosting. It’s also important to note that the hosting must serve up the matching content-type header for each file.

You should be aware that you may need to purchase the Pro version of CodePen in order to use this as a host. As a workaround, you could use [codesandbox](https://codesandbox.io/ "https://codesandbox.io/") and create a static template. From there, create the JS, CSS and HTML files, access Script Fragments and complete the corresponding text boxes by using the [codesandbox](https://codesandbox.io/ "https://codesandbox.io/") URL followed by /`fileName.js` (JS) /`fileName.css` (CSS) /`fileName.html` (HTML).

## Edit a Script Fragment

1.  Navigate to **ScriptRunner > Script Fragments**. A list of all script fragments is shown.
    
2.  Click **Edit** on the **Actions** ellipsis of the script fragment you wish to edit.
    
3.  **(Optional)** Click **Delete** for your chosen script fragment via the **Actions** ellipsis if required.
4.  Edit the fields as required. When all changes have been made, click **Save**. You can also click **Revert** to undo those changes.
    
5.  Click **Save** after all changes are complete. You can also click the **Delete** button and confirm when prompted.

### Web Panel Display with External Resource

![Web Panel Display with External Resource example.](/sr4jc/files/latest/101629070/101630025/1/1602108385000/web-fragment-external-resource.png)

### Web Panel Display with Specified HtmlCssJs Resources

![Web Panel Display with Specified HtmlCssJs Resources example.](/sr4jc/files/latest/101629070/101630024/1/1602108385000/web-fragment-htmlCssJs-resources.png)
