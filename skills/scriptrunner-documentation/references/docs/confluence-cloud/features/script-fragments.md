# Script Fragments

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: Features
- Doc ID: doc-sr4cc-866c1d11-4c53-4968-bfe0-3bbe2ab1af03-06406df0e84cb114
- Source: https://docs.adaptavist.com/sr4cc/latest/features/script-fragments

Script Fragments allow you to customize your Confluence instance. Learn about the two types and thier functionality.

There are two types of fragments that you can use to customize your Confluence instance:

-   [Web item fragments](https://docs.adaptavist.com/sr4cc/latest/features/script-fragments#web-item-fragments--en)
-   [Web panel fragments](https://docs.adaptavist.com/sr4cc/latest/features/script-fragments#web-panel-fragments--en)

## Web item fragments

Using ScriptRunner for Confluence Cloud, you can add a button to a specific location in the UI. When users select ScriptRunner Action, a popup with the button appears.

Here is an example of a simple button directing users to more information in the Confluence Cloud UI:

### Use cases

You could use custom buttons in a number of ways, here are a few ideas to get you started:

-   Direct users to a log in or documentation page
-   Open a Jira instance with project information related to the Confluence page, like the open tasks of a devlopement team
-   Redirect users to another location within Confluence
-   Give users a link to more resource information

### Create a web item fragment

Follow these steps to create a custom button for your Confluence instance:

1.  Navigate to _ScriptRunner_ and select Script Fragments.
    
2.  Select Spaces where you want the button to appear.
3.  Select WebItem for _Fragment Type_.
4.  Enter the Location, which is where you want the button to appear on the page.
    
    Your options are:
    
    -   _Sidebar Link_: appears on the lefthand side navigation.
    -   _More Button Primary_
    -   _More Button Secondary_
    -   More Button Tertiary
5.  Select the Source, either _Single URL_ or _Separate HTML, CSS, JS URLs_.
    
    What option you select depends on how you do your web development. If you put your plain text, styling, and functionality in one code file, choose Single URL. If you have code for HTML for text, CSS for style, and JS for functionality, select _Separate HTML, CSS, JS URLs._
    
    When you select your Source choice, different URL options appear.
    
6.  Choose the next step based on your Source choice:
    
    -   If you chose _Single URL_, a URL field appears. Enter where you want your button to navigate to.
    -   If you chose _Separate HTML, CSS, JS URLs_, fields appear for each required URL, which are HTML URL, CSS URL, and JS URL.
        
        Tip: To use this option, you must have each file hosted at a URL accessible to your instance. See the [Host URLs for Script Fragments](https://docs.adaptavist.com/sr4cc/latest/features/script-fragments#host-urls-for-script-fragments--en) section at the bottom of this page.
        
    
7.  Select Save Changes.

Here is an example of the web item form filled out:

Your custom button now appears in the spaces you specified.

## Web panel fragments

The web panel script fragments can be used to add HTML snippets to parts of a page so you can display additional information.

Here is an example of a web panel display with an external source:

### Use cases

You could use custom web panels in a number of ways, here are a few ideas to get you started:

-   Add a banner to a documentation site to alert users of an important feature update
-   Add resource information to a Confluence page

### Create a web panel script fragment

Follow these steps to create a custom web panel for your Confluence instance:

1.  Navigate to _ScriptRunner_ and select Script Fragments.
    
2.  Select Spaces where you want the panel to appear.
3.  Select _WebPanel_ Fragment Type.
4.  Enter the Location, which is where you want the panel to appear on the page.
    
    Your options are:
    
    1.  _Header_ appears at the top of the page.
    2.  _Footer_ appears at the bottom of the page.
    
5.  Select the Source, either _Single URL_ or _Separate HTML, CSS, JS URLs_.
6.  What option you select depends on how you do your web development.
    
    If you put your plain text, styling, and functionality in one code file, choose Single URL. If you have code for HTML for text, CSS for style, and JS for functionality, select _Separate HTML, CSS, JS URLs._
    
    Result _: When you select your Source choice, different URL options appear._
    
7.  Choose the next step based on your Source choice:
    
    -   If you chose _Single URL_, a URL field appears. Enter the URL of the content you want in your panel, and the content appears in the panel as it does at that URL.
    -   If you chose _Separate HTML, CSS, JS URLs_, fields appear for each required URL, which are HTML URL, CSS URL, and JS URL. This creates a more custom panel.
    
    Tip: To use this option, you must have each file hosted at a URL accessible to your instance. See the [Host URLS for Script Fragments](https://docs.adaptavist.com/sr4cc/latest/features/script-fragments#host-urls-for-script-fragments--en) section at the bottom of this page.
    
8.  Select Save Changes.

Note:

Here is an example of the web panel form filled out:

Your custom web panel is now in the spaces you specified.

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
-   [Web panels](https://developer.atlassian.com/cloud/confluence/modules/web-panel/)
