# Web Resource

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > fragments
- Doc ID: doc-sr4js-281117533
- Source: https://docs.adaptavist.com/sr4js/latest/features/fragments/web-resource

Web resources allow you to include JavaScript and CSS resources into certain _contexts_, for example:

-   in Jira - the view issue page, or admin pages
    
-   in Confluence - blogposts or the editor
    

You can read more about web resource modules for [Jira](https://developer.atlassian.com/jiradev/jira-platform/building-jira-add-ons/jira-plugins2-overview/jira-plugin-module-types/web-resource-plugin-module) and [Confluence](https://developer.atlassian.com/confdev/confluence-plugin-guide/confluence-plugin-module-types/web-resource-module).

## Setup

Starting with Jira 10, it is no longer possible to configure a custom Web Resource directory for storing your resource files (such as custom JavaScript or css files).

All Web Resources should now be kept in `web-resources/com.onresolve.jira.groovy.groovyrunner`. This path is located in the Jira **Shared home** directory if you have a shared home directory configured (such as when using clustered configuration). Otherwise, it will be in the default home directory. For more information on shared home directory configuration please refer to [Atlassian documentation](https://confluence.atlassian.com/adminjiraserver/jira-application-home-directory-938847746.html).

## Modifying CSS

Let's take as an example the task of modifying the CSS only on the _view issue_ page. A better example would be to wire up the buttons of a [custom dialog](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-item) using a JavaScript resource but let's start simple.

1.  Create a resource: `test-resources/red-text.css`.
    
    1.  Create the `test-resources` folder within the `web-resources/com.onresolve.jira.groovy.groovyrunner` directory.
        
    2.  Create a file named `red-text.css`.
        
    3.  Edit that file in a text editor.
        
    4.  Enter the following contents:
        
        ```
body {
    color: red !important;
}
```
        
2.  From ScriptRunner select **Fragments > Create Fragment >** **Install web resource**.
3.  Configure the form as follows:  
    ![](/sr4js/files/latest/281117533/284328847/1/1725292778000/Web_resources_red_2.png)
4.  Select **Add**. 
    
    If you get an error, make sure you created the `test-resources` sub-folder.
    
5.  Go to an existing issue and it should appear as follows:  
    ![](/sr4js/files/latest/281117533/284328848/1/1725292778000/Web_resources_red_1.png)
