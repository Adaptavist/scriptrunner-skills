# Web Resource

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Fragments
- Doc ID: doc-sr4c-12b6f0a7-d06f-41cd-9b87-abc42072a4c7-fc9fc87119c23c6b
- Source: https://docs.adaptavist.com/sr4c/latest/features#fragments--en#web-resource--en

Using web resources, you can include JavaScript and CSS resources in certain contexts, like blog posts or the editor.

You can read more about web resource modules for [Confluence](https://developer.atlassian.com/confdev/confluence-plugin-guide/confluence-plugin-module-types/web-resource-module).

## Setup

Starting with Confluence Version 9, it is no longer possible to configure a custom Web Resource directory for storing your resource files (such as custom JavaScript or css files).

All Web Resources should now be kept in `web-resources/com.onresolve.conluence.groovy.groovyrunner`. This path is located in the Confluence Shared home directory if you have a shared home directory configured (such as when using clustered configuration). Otherwise it will be in the default home directory. For more information on shared home directory configuration please refer to [Atlassian documentation](https://confluence.atlassian.com/doc/confluence-home-and-other-important-directories-590259707.html).

## Examples

### Modifying CSS

This is an example to modify the CSS only on blogposts.

1.  Create a resource: `test-resources/red-blogposts.css`.
    1.  Create the `test-resources` folder within the `web-resources/com.onresolve.confluence.groovy.groovyrunner` directory.
    2.  Create a file named `red-blogposts.css`.
    3.  Edit that file in a text editor.
    4.  Enter the following contents:
        
        ```
        body {
            color: red !important;
        }
        ```
        
2.  Go to Administration > Fragments > Create Fragment.
3.  Select Install Web Resource.
4.  Configure the form to look like this:
    
5.  Click Add.
    
    Note: If you get an error, make sure you created the `test-resources` sub-folder.
    
6.  Create a new blog post.
    
    Your blog post will look like this:
    

### Further Examples

-   A more complicated example would be to wire up the buttons of a custom [dialog](https://docs.adaptavist.com/sr4c/latest/features/fragments/web-item) using a JavaScript resource
-   [Manipulating the Planning Board UI](https://community.atlassian.com/t5/Agile-articles/Adding-column-information-to-planning-boards/ba-p/619186)
