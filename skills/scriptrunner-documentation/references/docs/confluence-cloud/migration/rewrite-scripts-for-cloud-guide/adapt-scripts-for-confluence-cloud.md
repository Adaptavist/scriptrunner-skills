# Adapt Scripts for Confluence Cloud

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: migration > rewrite-scripts-for-cloud-guide
- Doc ID: doc-sr4cc-419662228
- Source: https://docs.adaptavist.com/sr4cc/latest/migration/rewrite-scripts-for-cloud-guide/adapt-scripts-for-confluence-cloud

Before you start migrating your scripts, it's crucial to understand how scripts work in Confluence Cloud and the key differences from Server/Data Center. The following steps will guide you through understanding how scripts work in Confluence Cloud, enabling you to effectively rewrite your scripts.

## Step one: Review imports and dependencies

Examine your scripts for any imported external libraries. These libraries can introduce additional complexity when migrating to Confluence Cloud. In addition you should identify plugins that the scripts rely on.

Determine if these libraries/plugins are supported or available in the Cloud environment. If they are not available you should identify alternative approaches or built-in functionalities in Confluence Cloud that can replace them.

## Step two: Analyze API calls

Identify any API calls within your scripts, especially those that interact with Confluence's internal APIs. Since Confluence Cloud relies on REST APIs, you'll need to adapt these calls to use the appropriate cloud-based endpoints. Use the following tips to effectively analyze API calls:

1.  **List existing API calls**:
    -   Compile a list of API calls in your Server/Data Center scripts.
    -   Include calls to Confluence's internal APIs and any external applications.
    -   Verify the purpose of each API call by checking the [Atlassian Confluence REST API](https://developer.atlassian.com/cloud/confluence/rest/v2/intro/#about) documentation or using [Migration Tools](#id-.AdaptScriptsforConfluenceCloudvCurrent-tools).
2.  **Understand API endpoints**:
    -   Familiarize yourself with the Atlassian [Confluence REST API in Cloud](https://developer.atlassian.com/cloud/confluence/rest/v2/intro/#about).
    -   Determine which API endpoints are required to replicate the functionality of your existing scripts. This may include endpoints for creating, updating, or retrieving pages, managing spaces, handling user data, and more.
    -   Pay attention to the request types (GET, POST, PUT, DELETE), path parameters, query parameters and request body.
3.  **Consider permissions**:
    -   Ensure that the API calls respect Confluence's permission schemes. The user making the API request must have the necessary permissions to perform the action, such as creating pages or editing space settings.
4.  **Implement proper authorization**:
    -   Confluence Cloud APIs typically use OAuth 2.0 for authorization. You'll need to manage tokens and ensure that your requests include the appropriate authorization headers.

For more details on APIs see the [Best Practices and Supporting Technical Information](https://docs.adaptavist.com/sr4cc/latest/migration/rewrite-scripts-for-cloud-guide/migration-best-practices-and-supporting-technical-information) page.

## Step three: Understand and apply basic operations

It's important to understand the basic operations in Confluence Cloud's API before you migrate your scripts. This understanding will form the foundation for successfully adapting your existing scripts and ensuring they function correctly in the new environment.

### Create a page

There are two scripts in this section, one is for Data Center and the other is for Cloud. Both scripts could be run from the Script Console in each product, and they both create a page in Confluence by copying the content of an existing page.

You can see that both need to create a new object to represent the page. In the DC script, this is a [Page](https://docs.atlassian.com/ConfluenceServer/javadoc/7.12.0/com/atlassian/confluence/pages/Page.html) object. In the Cloud script, this is a list of [Map](https://docs.oracle.com/javase/8/docs/api/java/util/Map.html) objects that matches the Cloud REST API data specification for pages.

Both also need to make a call to save the new page. In the DC script, this is a call to the [PageManager#saveContentEntity](https://docs.atlassian.com/ConfluenceServer/javadoc/7.12.0/com/atlassian/confluence/core/ContentEntityManager.html#saveContentEntity-com.atlassian.confluence.core.ContentEntityObject-com.atlassian.confluence.core.ContentEntityObject-com.atlassian.confluence.core.SaveContext-) method. In the Cloud script, this is a call to the `post`  method, specifying the path to the [Content REST API](https://developer.atlassian.com/cloud/confluence/rest/api-group-content/#api-api-content-post).

```
import com.atlassian.confluence.core.DefaultSaveContext
import com.atlassian.confluence.pages.Page
import com.atlassian.confluence.pages.PageManager
import com.atlassian.confluence.spaces.Space
import com.atlassian.confluence.spaces.SpaceManager
import com.atlassian.sal.api.component.ComponentLocator

def pageManager = ComponentLocator.getComponent(PageManager)
def spaceManager = ComponentLocator.getComponent(SpaceManager)

// Specify all the required parameters
def spaceKey = "DS"
def parentTitle = "Welcome to Confluence"
def pageTitle = "New Page"
def sourcePageId = 65556 // change out for source page ID

Space space = spaceManager.getSpace(spaceKey)
def parent = pageManager.getPage(spaceKey, parentTitle)

// Get the source page
def sourcePage = pageManager.getPage(sourcePageId) //Notably, you could use the source page's ID and title to get the page instead

// Specify details of the new page
def page = new Page()
page.with{
    setTitle(pageTitle)
    setSpace(space)
    setBodyContent(sourcePage.bodyContent)
    setParentPage(parent)
}
parent.addChild(page)

// create Confluence page
pageManager.saveContentEntity(page, DefaultSaveContext.DEFAULT)
return "New page ${page.title} created with id ${page.id}"
```

```
// Specify all the required parameters
def sourcePageId = "<SourcePageIDHere>"
def parentPageId = "<ParentPageIDHere>"
def pageTitle = "<Page Title Here>"
def spaceKey = "<Space Key Here>"
  
// Get the content of the source page
def template = get("/wiki/rest/api/content/${sourcePageId}?expand=body.storage")
    .asObject(Map)
    .body
  
// Specify the body of the rest request
def body = [
    type: "page",
    title: pageTitle,
    space: [
        key: spaceKey
    ],
    ancestors: [[
        id: parentPageId
    ]],
    body: template.body
]
  
//create confluence (cloud) page
def createPageResult = post("/wiki/rest/api/content")
    .header("Content-Type", "application/json")
    .body(body)
    .asObject(Map)
 
assert createPageResult.status == 200
```

Notice in the Cloud script you don't use Service or Manager classes, but the REST API. Check out the [Cloud](https://developer.atlassian.com/cloud/confluence/rest/#api-content-post) and [Server](https://docs.atlassian.com/ConfluenceServer/javadoc/7.9.1/com/atlassian/confluence/core/ContentEntityManager.html?_ga=2.247268487.2062596853.1626098560-742945084.1620663288&_gac=1.79689190.1624649510.Cj0KCQjw_dWGBhDAARIsAMcYuJxr5FogI1q0GxtIV4snOyGMlYZkd15mW2DBp-4ZiQ51B6aYrNhqPaYaAsYZEALw_wcB#saveContentEntity-com.atlassian.confluence.core.ContentEntityObject-com.atlassian.confluence.core.ContentEntityObject-com.atlassian.confluence.core.SaveContext-) documentation for more information.

Assertions for response codes print out the response body and relevant information. A good pattern is to use `assert resp.status == 200` (replace 200 with the correct response code). Successful APIs call may respond with 204, others with 200, 201, or 303 depending on the API in use.

## Step four: Leverage Unirest in ScriptRunner for Confluence Cloud

When working with ScriptRunner for Confluence Cloud, the Unirest library is a powerful tool for making HTTP requests to interact with Confluence's REST API and other web services. It's important to understand how to use Unirest effectively within ScriptRunner scripts to perform actions like retrieving, creating, or updating Confluence pages. Below we describe how to use Unirest in ScriptRunner for Confluence Cloud:

-   **Unirest library**: Unirest is a lightweight HTTP library that simplifies making HTTP requests in Java and Groovy. We recommend you research the ScriptRunner for Confluence Cloud style for writing HTTP calls using the Unirest library. This library is auto-imported into scripts, allowing you to directly use methods like `get()`, `put()`, and `post()` as documented in [Unirest's documentation](https://kong.github.io/unirest-java/requests/) without additional import statements.
-   **Example scripts**: Review the available [Example Scripts](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-confluence) on the ScriptRunner website and within the Script Console in your Confluence Cloud instance. These examples provide insights into the style and code structure for common use cases.

By following these steps, you'll be well-prepared to rewrite your Server/Data Center scripts for Confluence Cloud, ensuring a smooth transition and maintaining the desired functionality in the new environment.

## Step five: Test your scripts, API calls and integrations

-   **Test real scenarios**: Use the [test environment](https://docs.adaptavist.com/sr4cc/latest/migration/rewrite-scripts-for-cloud-guide/prepare-to-migrate-scripts) to simulate real scenarios and workflows that your scripts will encounter in production. This includes testing API calls, integrations with other applications, and handling various data inputs and outputs.
-   **Monitor performance and behavior**: Pay attention to how your scripts perform in the test environment. Monitor for any performance bottlenecks, unexpected behaviors, or errors that need to be addressed before going live.

By creating a test environment you can identify and resolve issues early, reducing the likelihood of disruptions in your production environment.

### Logging

Logging in scripts is very helpful when debugging. In Cloud scripts, anything printed to `stdout` using `println`, or using a `[logger.info](http://logger.info)('message')` call will be available in the [Script Logs](https://docs.adaptavist.com/sr4cc/latest/features/logging/script-logs) page, and in the execution history of script listeners and script jobs. As noted above, usage of assertions can also help debugging and diagnosing the behaviour of scripts.

## Step six: Migrate to production

The final step is to deploy the scripts in the production environment.

This is a manual process, so each script must be copied manually from the test environment to production environment (note that custom field IDs change per environment). Usually this process is scheduled outside working hours to reduce impact in service and needs to be heavily coordinated with the rest of the teams.

## Other resources

-   [Feature Parity](https://docs.adaptavist.com/sr4cc/latest/migration/feature-parity)
-   [Rewriting Scripts](https://docs.adaptavist.com/sr4cc/latest/migration/rewrite-scripts-for-cloud-guide)
-   [Prepare to Migrate Scripts](https://docs.adaptavist.com/sr4cc/latest/migration/rewrite-scripts-for-cloud-guide/prepare-to-migrate-scripts)
-   [Migration Best Practices and Supporting Technical Information](https://docs.adaptavist.com/sr4cc/latest/migration/rewrite-scripts-for-cloud-guide/migration-best-practices-and-supporting-technical-information)
