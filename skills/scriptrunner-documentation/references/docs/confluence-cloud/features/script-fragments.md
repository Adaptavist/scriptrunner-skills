# Script Fragments

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: features
- Doc ID: doc-sr4cc-112151212
- Source: https://docs.adaptavist.com/sr4cc/latest/features/script-fragments

There are two types of fragments that you can use to customize your Confluence instance: 

-   [Web item fragments](#id-.ScriptFragmentsvCurrent-ite)
-   [Web panel fragments](#id-.ScriptFragmentsvCurrent-panel)

## Web item fragments

Using ScriptRunner for Confluence Cloud, you can add a button to a specific location in the UI. When users select **ScriptRunner Action**, a popup with the button appears. 

Here is an example of a simple button directing users to more information in the Confluence Cloud UI: 

![](/sr4cc/files/latest/112151212/326079115/1/1739478239000/button.png)

### Use cases

You could use custom buttons in a number of ways, here are a few ideas to get you started: 

-   Direct users to a log in or documentation page
-   Open a Jira instance with project information related to the Confluence page, like the open tasks of a devlopement team
-   Redirect users to another location within Confluence
-   Give users a link to more resource information

### Create a web item fragment

Follow these steps to create a custom button for your Confluence instance: 

1.  Navigate to _ScriptRunner_ and select **Script Fragments**.  
    ![](/sr4cc/files/latest/112151212/537854834/1/1769187988000/script-fragments.png)
2.  Select **Spaces** where you want the button to appear. 
    
3.  Select _WebItem_ for **Fragment Type.**
    
4.  Enter the **Location**, which is where you want the button to appear on the page. Your options are:
    1.  _Sidebar Link_ appears on the lefthand side navigation:  
        ![](/sr4cc/files/latest/112151212/326079120/1/1739314441000/sidebar-link.png)
    2.  _Page Button_ appears on the upper righthand toolbar:   
        ![](/sr4cc/files/latest/112151212/326079121/1/1739314419000/page-button.png)
    3.  _More Button Primary_, _More Button Secondary_, and _More Button Tertiary_ appear once you open the More (![](/sr4cc/files/latest/112151212/326079123/1/1739314227000/moremenu.png)) menu.  
        ![](/sr4cc/files/latest/112151212/326079122/1/1739314391000/more-button-secondary.png)  
        
5.  Select the **Source**, either _Single URL_ or _Separate HTML, CSS, JS URLs_.  
    What option you select depends on how you do your web development. If you put your plain text, styling, and functionality in one code file, choose Single URL. If you have code for HTML for text, CSS for style, and JS for functionality, select _Separate HTML, CSS, JS URLs._   
    _**Result**_: When you select your **Source** choice, different URL options appear.   
    
6.  Choose the next step based on your **Source** choice:
    -   If you chose _Single URL_, a URL field appears. Enter where you want your button to navigate to. 
    -   If you chose _Separate HTML, CSS, JS URLs_, fields appear for each required URL, which are **HTML URL**, **CSS URL**, and **JS URL**.  
        
        To use this option, you must have each file hosted at a URL accessible to your instance. See the [Host URLs for Script Fragments](#id-.ScriptFragmentsvCurrent-hosted) section at the bottom of this page.
        
          
        
7.  Select **Save Changes**.  
    
    Here is an example of the web item form filled out: 
    
    ![](/sr4cc/files/latest/112151212/326079113/1/1739478793000/web-item-fields.png)
    

Your custom button now appears in the spaces you specified. 

## Web panel fragments

The web panel script fragments can be used to add HTML snippets to parts of a page so you can display additional information.

Here is an example of a web panel display with an external source:  

![](/sr4cc/files/latest/112151212/326079128/1/1739219187000/usecase1.png)

### Use cases

You could use custom web panels in a number of ways, here are a few ideas to get you started: 

-   Add a banner to a documentation site to alert users of an important feature update
-   Add resource information to a Confluence page

### Create a web panel script fragment

Follow these steps to create a custom web panel for your Confluence instance: 

1.  1.  Navigate to _ScriptRunner_ and select **Script Fragments**.  
        ![](/sr4cc/files/latest/112151212/537854834/1/1769187988000/script-fragments.png)
2.  Select **Spaces** where you want the panel to appear. 
    
3.  Select _WebPanel_ **Fragment Type**. 
    
4.  Enter the **Location**, which is where you want the panel to appear on the page. Your options are: 
    
    1.  _Header_ appears at the top of the page.  
        ![](/sr4cc/files/latest/112151212/326079118/1/1739316030000/header.png)
    2.  _Footer_ appears at the bottom of the page.  
        ![](/sr4cc/files/latest/112151212/326079117/1/1739316107000/footer.png)
5.  Select the **Source**, either _Single URL_ or _Separate HTML, CSS, JS URLs_.
6.  What option you select depends on how you do your web development. If you put your plain text, styling, and functionality in one code file, choose Single URL. If you have code for HTML for text, CSS for style, and JS for functionality, select _Separate HTML, CSS, JS URLs.  
    __**Result**_: When you select your **Source** choice, different URL options appear. 
7.  Choose the next step based on your **Source** choice:  
    -   If you chose _Single URL_, a URL field appears. Enter the URL of the content you want in your panel, and the content appears in the panel as it does at that URL.
    -   If you chose _Separate HTML, CSS, JS URLs_, fields appear for each required URL, which are **HTML URL**, **CSS URL**, and **JS URL**. This creates a more custom panel.
        
        To use this option, you must have each file hosted at a URL accessible to your instance. See the [Host URLS for Script Fragments](#id-.ScriptFragmentsvCurrent-hosted) section at the bottom of this page.
        
8.  Select **Save Changes**.
    
    Here is an example of the web panel form filled out: 
    
    ![](/sr4cc/files/latest/112151212/326079114/1/1739478758000/web-panel-fields.png)
    
      
    

Your custom web panel is now in the spaces you specified. 

## Host URLs for script fragments

The HTML, CSS and Javascript need to be hosted somewhere that Confluence Cloud servers can access with no authentication. We recommend using [CodePen](https://codepen.io/) for the hosting. It’s also important to note that the hosting must serve up the matching content-type header for each file.

You should be aware that you may need to purchase the Pro version of CodePen in order to use this as a host. As a workaround, you could use [codesandbox](https://codesandbox.io/ "https://codesandbox.io/") and create a static template. From there, create the JS, CSS and HTML files, access Script Fragments and complete the corresponding text boxes by using the [codesandbox](https://codesandbox.io/ "https://codesandbox.io/") URL followed by `/fileName.js` (JS) `/fileName.css` (CSS) `/fileName.html` (HTML). 

There is a known issue with using [codesandbox.io](http://codesandbox.io/) for hosting that we are working to resolve.

## Adaptavist Bridge

The Adaptavist bridge is a Javascript library that allows the script to do two things:  

-   Get space and page information
-   Use [Confluence REST APIs](https://developer.atlassian.com/cloud/confluence/rest/v2/intro/#about)

Learn more about what it is and how to use it with the [Adaptavist Bridge documentation](https://docs.adaptavist.com/sr4cc/latest/features/script-fragments/adaptavist-bridge). 

## Limitations

Functionality could be limited for security issues. If there is a security issue in code, the fragment will not render or redirect the user.

## More resources

Visit the following Atlassian documentation pages to learn more about fragments: 

-   [Web items](https://developer.atlassian.com/cloud/confluence/modules/web-item/)
-   [Web panels](https://developer.atlassian.com/cloud/confluence/modules/web-panel/)
