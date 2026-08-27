# REST APIs

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: get-started > general-information
- Doc ID: doc-sr4cc-114204850
- Source: https://docs.adaptavist.com/sr4cc/latest/get-started/general-information/rest-apis

All interaction with Confluence Cloud must be through the provided [REST APIs](https://developer.atlassian.com/cloud/confluence/rest/). Atlassian provides comprehensive documentation, including [JSON Schema](http://json-schema.org/), for responses and request bodies that describe the JSON shape. For effective usage of ScriptRunner, it is important to understand how to interact with Confluence Cloud using the REST API.

When using REST APIs in ScriptRunner for Confluence Cloud, the editor uses autocomplete to help you write the code 

## Authentication and authorization

All REST API requests made from ScriptRunner perform as either the ScriptRunner add-on user or the user who initiated the action. The initiating user is the current user of the script console, which is the user that performed the action to cause an event to fire. Atlassian Connect add-ons must also register for [API scopes.](https://developer.atlassian.com/cloud/confluence/scopes/) API scopes work similarly to the permissions granted to iOS or Android apps. When installing, the Confluence administrator can see the scopes of any add-on requests. ScriptRunner requests all scopes so that the user can use whichever ones they want. However, there are restrictions on the APIs that are available to ScriptRunner.

-   No private APIs are available, only those specifically allowlisted by Atlassian
    
-   Scopes are documented for
    
    -   [Confluence Cloud](https://developer.atlassian.com/cloud/confluence/scopes/)
        
    -   [Confluence Server](https://developer.atlassian.com/server/confluence/confluence-server-rest-api/)
        

Authentication from user scripts is handled by an authentication proxy built into ScriptRunner. Each script invocation has a temporary authentication token to use to make requests into this proxy. The proxy then performs the necessary request, signing in to make the authenticated request to your Confluence instance. This way, authenticated requests happen transparently. Tokens that are handed to scripts are only valid for two minutes. Responses that come through the proxy have URLs modified to go through the proxy so that URLs in the JSON response can be used directly without manipulation.

## Unirest

The HTTP library provided by ScriptRunner is [Unirest](http://kong.github.io/unirest-java/). Unirest is a simple, lightweight library that makes interacting with REST APIs simple. It was chosen due to the minimal dependencies (based on Apache HTTP Client 4.5), flexibility (JSON mapping support is built-in and object mapping provided by Jackson), and the clarity of API.

Unirest, Unirest.get, Unirest.post, Unirest.put, Unirest.head, and Unirest.options are included in all scripts as import static, which means no imports are needed to make HTTP requests. The base URL to the ScriptRunner authentication proxy is filled in, along with the authentication headers, so making REST calls is as simple as copying and pasting from the [Confluence REST documentation](https://developer.atlassian.com/server/confluence/confluence-server-rest-api/).

For examples, please visit the [Script Console](https://docs.adaptavist.com/sr4cc/latest/features/script-console) page.

## Scopes

When installing the app, a list of permissions, or [scopes](https://developer.atlassian.com/server/confluence/confluence-oauth2-provider-api/#scopes), is presented that ScriptRunner for Confluence Cloud requires to run successfully. A list of the scopes required for each REST API endpoint that Confluence Cloud provides can be found [here](https://developer.atlassian.com/cloud/confluence/scopes/). Here is a detailed explanation of why we need each of those scopes:

-   **Act on a Confluence user's behalf, even when the user is offline**: Scripts can be configured to execute as either the app or the user who initiated that script. For example, if a user creates a page when a space is created, then the _created by_ is initiated by that user. Therefore, it makes sense to execute the listener as the user who triggered the event. This action ensures that each user's permissions are respected, and it provides a much clearer history of who's made changes to the issues in your system.
-   **Administer Confluence**: This scope allows you to create, update, and delete pages or spaces, etc., when running a script as the ScriptRunner add-on user.
-   **Administer Confluence projects**: This scope allows you to write scripts that execute as the ScriptRunner add-on user for creating, updating, or removing spaces, pages, etc. so that you don't need to grant those permissions to the rest of your user base.
-   **Delete Confluence data**: This scope is required to delete pages, spaces, etc. while running a script as the ScriptRunner add-on user.
-   **Write data to Confluence**: This scope is required to create pages, spaces, etc. while running a script as the ScriptRunner add-on user.
-   **Read Confluence data**: This scope is required to view pages, spaces, etc. while running a script as the ScriptRunner add-on user.
