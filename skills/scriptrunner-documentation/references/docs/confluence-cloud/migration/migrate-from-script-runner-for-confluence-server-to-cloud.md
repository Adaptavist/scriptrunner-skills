# Migrate from ScriptRunner for Confluence Server to Cloud

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: migration
- Doc ID: doc-sr4cc-114205250
- Source: https://docs.adaptavist.com/sr4cc/latest/migration/migrate-from-scriptrunner-for-confluence-server-to-cloud

If you have any custom scripts, they will have to be rewritten in the migration.

The general approach to migrating a script from Server to Cloud is to analyze the purpose of the script, find the equivalent feature in Cloud (we have named them the same where possible), and rewrite the script. Interactions with APIs need to be replaced with calls to the appropriate REST APIs, and it is possible that alternatives may need to be found for dependencies that are not available for ScriptRunner Cloud.

## Creating a Page

For a concrete example, see the following two scripts which could be run from the Script Console. Both create a page in Confluence by copying the content of an existing page.

You can see that both need to create a new object to represent the page. In the DC script, this is a [Page](https://docs.atlassian.com/ConfluenceServer/javadoc/7.12.0/com/atlassian/confluence/pages/Page.html) object. In the Cloud script, this is a List of [Map](https://docs.oracle.com/javase/8/docs/api/java/util/Map.html) objects that matches the Cloud REST API data specification for pages.

Likewise, both need to make a call to save the new page. In the DC script, this is a call to the [PageManager#saveContentEntity](https://docs.atlassian.com/ConfluenceServer/javadoc/7.12.0/com/atlassian/confluence/core/ContentEntityManager.html#saveContentEntity-com.atlassian.confluence.core.ContentEntityObject-com.atlassian.confluence.core.ContentEntityObject-com.atlassian.confluence.core.SaveContext-) method. In the Cloud script, this is a call to the `post`  method, specifying the path to the [Content REST API](https://developer.atlassian.com/cloud/confluence/rest/api-group-content/#api-api-content-post).

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

Notice in the Cloud script you don't use Service or Manager classes, but the REST API. Check out the [Cloud](https://developer.atlassian.com/cloud/confluence/rest/#api-content-post) and [Server](https://docs.atlassian.com/ConfluenceServer/javadoc/7.9.1/com/atlassian/confluence/core/ContentEntityManager.html?_ga=2.247268487.2062596853.1626098560-742945084.1620663288&_gac=1.79689190.1624649510.Cj0KCQjw_dWGBhDAARIsAMcYuJxr5FogI1q0GxtIV4snOyGMlYZkd15mW2DBp-4ZiQ51B6aYrNhqPaYaAsYZEALw_wcB#saveContentEntity-com.atlassian.confluence.core.ContentEntityObject-com.atlassian.confluence.core.ContentEntityObject-com.atlassian.confluence.core.SaveContext-) documentation for more information.

Assertions for response codes print out the response body and relevant information. A good pattern is to use `assert resp.status == 200` (replace 200 with the correct response code). Successful APIs call may respond with 204, others with 200, 201, or 303 depending on the API in use.

## Logging

Logging in scripts is very helpful when debugging. In Cloud scripts, anything printed to `stdout` using `println`, or using a `[logger.info](http://logger.info)('message')` call will be available in the [Script Logs](https://docs.adaptavist.com/sr4cc/latest/features/logging/script-logs) page, and in the execution history of script listeners and script jobs. As noted above, usage of assertions can also help debugging and diagnosing the behaviour of scripts.

## Migration approach

Migration has three stages:  

1.  Analysis of the functionality of the existing scripts.
2.  Analysis of the APIs and ScriptRunner features that should be created
3.  The implementation of the new scripts

Each interaction with Confluence should be compared against the REST API docs and the ScriptRunner features. Some features of ScriptRunner for Confluence have not yet been implemented in the Cloud edition. Feature requests and suggestions are welcome in the [ScriptRunner Cloud support portal](https://productsupport.adaptavist.com/servicedesk/customer/portal/40).

The final task is to re-implement the relevant scripts using ScriptRunner for Confluence Cloud.

Please ask on [Atlassian Answers](https://community.atlassian.com/t5/tag/addon-com.onresolve.confluence.groovy.groovyrunner/tg-p) for any migration help. Be sure to mention Cloud or Server in your question.

## Pitfalls

### Asynchronous event processing

Asynchronous execution of functions and events means that any updates performed by scripts happen after the page loads for the user. The order of event processing is not preserved, so when multiple scripts are triggered from the same event the ordering is arbitrary and will likely not be consistent.

### Event triggering

Updates made in scripts cause events to be fired. This means that script listeners need to check values before updating them as the script may trigger due to a previous invocation of the same script.
