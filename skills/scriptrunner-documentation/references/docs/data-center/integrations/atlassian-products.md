# Atlassian Products

- Platform: data-center
- Space: SR4JS
- Hierarchy: integrations
- Doc ID: doc-sr4js-101624761
- Source: https://docs.adaptavist.com/sr4js/latest/integrations/atlassian-products

There are several cases for making an HTTP request from a host application to another Atlassian application, for example:

-   Create a Confluence space when a Jira project is created
    
-   Automatically create Confluence pages for certain types of issues
    
-   Create release notes when a Jira version is released
    
-   Automatically decline a _pull request_ when the associated Jira issue is closed as _Won’t Fix_
    

Typically these are done through calls to the REST API of the other application, or to a _script endpoint_. However, you can also use _remote control_ to do the same thing.

Which approach you use depends on the specifics of the task in hand.

-   [Interacting with other applications via app links](https://docs.adaptavist.com/sr4js/latest/integrations/atlassian-products/via-app-links)
    
-   [Using remote control](https://docs.adaptavist.com/sr4js/latest/integrations/atlassian-products/remote-control)
