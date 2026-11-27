# Script Fragments

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: Features
- Doc ID: doc-sr4cc-d784ac47-d4bd-43f0-973f-8d36b9ca3529-06406df0e84cb114
- Source: https://docs.adaptavist.com/sr4cc/latest/features/script-fragments

Script Fragments allow you to customize your Confluence instance. Learn about the two types and their functionality.

There are two types of fragments that you can use to customize your Confluence instance:

-   [Web item fragments](https://docs.adaptavist.com/sr4cc/latest/features/script-fragments#web-item-fragments--en)
-   [Web panel fragments](https://docs.adaptavist.com/sr4cc/latest/features/script-fragments#web-panel-fragments--en)

## Web item fragments

Using ScriptRunner for Confluence Cloud, you can add a button to a specific location in the UI. When users select ScriptRunner Action, a popup with the button appears.

Here is an example of a simple button directing users to more information in the Confluence Cloud UI:

### Use cases

You could use custom buttons in a number of ways; here are a few ideas to get you started:

-   Direct users to a login or documentation page
-   Open a Jira instance with project information related to the Confluence page, like the open tasks of a development team
-   Redirect users to another location within Confluence
-   Give users a link to more resource information.

### Create a web item fragment

Follow these steps to create a custom button appearing in the More menu, for your Confluence instance:

1.  Navigate to ScriptRunner and select More > Script Fragments.
    
2.  Select Spaces where you want the button to appear.
3.  Select WebItem for Fragment Type.
4.  Select the Source, either _Single URL_ or _Separate HTML, CSS, JS URLs_.
    
    What option you select depends on how you do your web development. If you put your plain text, styling, and functionality into a single code file, choose _Single URL_. If you have code for HTML for text, CSS for style, and JS for functionality, select _Separate HTML, CSS, JS URLs._
    
    When you select your Source choice, different URL options appear.
    
5.  Choose the next step based on your Source choice:
    
    -   If you chose _Single URL_, a URL field appears. Enter where you want your button to navigate to.
    -   If you chose _Separate HTML, CSS, JS URLs_, fields appear for each required URL, which are HTML URL, CSS URL, and JS URL.
        
        Tip: To use this option, each file must be hosted at a URL accessible to your instance. See the [Host URLs for Script Fragments](https://docs.adaptavist.com/sr4cc/latest/features/script-fragments#host-urls-for-script-fragments--en) section at the bottom of this page.
        
    
6.  Select Save Changes.

Here is an example of the web item form filled out:

Your custom button now appears in the spaces you specified.

## Web panel fragments

The web panel script fragments can be used to add HTML snippets to parts of a page so you can display additional information.

Here is an example of a web panel display with an external source:

### Use cases

You could use custom web panels in a number of ways, here are a few ideas to get you started:

-   Add a banner to a documentation site to alert users of an important feature update
-   Add resource information to a Confluence page.

### Create a web panel script fragment

Follow these steps to create a custom web panel in the header of your Confluence instance:

Note: The Connect _Footer_ location was [deprecated](https://developer.atlassian.com/cloud/confluence/extension-point-locations/#web-panel) April 30, 2025 and is not supported in Forge.

1.  Navigate to ScriptRunner and select More > Script Fragments.
    
2.  Select Spaces where you want the panel to appear.
3.  Select WebPanel in the Fragment Type field.
4.  Select the Source, either _Single URL_ or _Separate HTML, CSS, JS URLs_.
5.  What option you select depends on how you do your web development.
    
    If you put your plain text, styling, and functionality in a single code file, choose Single URL. If you have code for HTML for text, CSS for style, and JS for functionality, select _Separate HTML, CSS, JS URLs._
    
    Result: When you select your Source choice, different URL options appear.
    
6.  Choose the next step based on your Source choice:
    
    -   If you chose _Single URL_, a URL field appears. Enter the URL of the content you want in your panel, and the content appears in the panel as it does at that URL.
    -   If you chose _Separate HTML, CSS, JS URLs_, fields appear for each required URL, which are HTML URL, CSS URL, and JS URL. This creates a more custom panel.
    
    Tip: To use this option, you must have each file hosted at a URL accessible to your instance. See the [Host URLS for Script Fragments](https://docs.adaptavist.com/sr4cc/latest/features/script-fragments#host-urls-for-script-fragments--en) section at the bottom of this page.
    
7.  Select Add Fragment.

Your custom web panel is now available.

Here is an example of the web panel form filled out:

## Host URLs for script fragments

The HTML, CSS and JavaScript need to be hosted somewhere that Confluence Cloud servers can access with no authentication. We recommend using [CodePen](https://codepen.io/) for the hosting. It's also important to note that the hosting must serve the correct content-type header for each file.

You should be aware that you may need to purchase the Pro version of CodePen in order to use this as a host. As a workaround, you could use [codesandbox](https://codesandbox.io/) and create a static template. From there, create the JS, CSS and HTML files, access Script Fragments and complete the corresponding text boxes by using the [codesandbox](https://codesandbox.io/) URL followed by `/fileName.js` (JS) `/fileName.css` (CSS) `/fileName.html` (HTML).

Warning: There is a known issue with using [codesandbox.io](http://codesandbox.io/) for hosting that we are working to resolve.

## Adaptavist Bridge

The Adaptavist bridge is a JavaScript library that allows the script to do two things:

-   Get space and page information
-   Use [Confluence REST APIs](https://developer.atlassian.com/cloud/confluence/rest/v2/intro/#about)

Learn more about what it is and how to use it with the [Adaptavist Bridge documentation](https://docs.adaptavist.com/sr4cc/latest/features/script-fragments/adaptavist-bridge).

## Limitations

Functionality could be limited for security issues. If there is a security issue in code, the fragment will not render or redirect the user.

## More resources

Visit the following Atlassian documentation pages to learn more about fragments:

-   [Web items](https://developer.atlassian.com/cloud/confluence/modules/web-item/)
-   [Web panels](https://developer.atlassian.com/cloud/confluence/modules/web-panel/).
