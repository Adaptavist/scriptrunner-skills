# Atlassian

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Integrations
- Doc ID: doc-sr4c-d0485e97-a670-4974-9af9-ec47629fc9a9-7314151bc672066c
- Source: https://docs.adaptavist.com/sr4c/latest/integrations#atlassian--en

There are several cases for making an HTTP request from a host application to another Atlassian application.

For example:

-   Create a Confluence space when a Jira project is created
-   Automatically create Confluence pages for certain types of issues
-   Create release notes when a Jira version is released
-   Automatically decline a _pull request_ when the associated Jira issue is closed as _Won't Fix_

Typically these are done through calls to the REST API of the other application, or to a _script endpoint_. However, you can also use _remote control_ to do the same thing.

Which approach you use depends on the specifics of the task in hand.

-   [Interacting with other applications via app links](https://docs.adaptavist.com/sr4c/latest/integrations/atlassian/connect-to-atlassian-via-app-links)
-   [Using remote control](https://docs.adaptavist.com/sr4c/latest/integrations/atlassian/remote-control)
