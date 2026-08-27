# Migration Best Practices and Supporting Technical Information

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: migration > rewrite-scripts-for-cloud-guide
- Doc ID: doc-sr4cc-419662244
- Source: https://docs.adaptavist.com/sr4cc/latest/migration/rewrite-scripts-for-cloud-guide/migration-best-practices-and-supporting-technical-information

## Best practices and tips for migrating to ScriptRunner for Confluence Cloud

When migrating to or working with ScriptRunner for Confluence Cloud, keep these best practices and tips in mind. They apply to various use cases and can help streamline your scripting process.

### Understand REST API responses

To understand how space values are represented in REST responses create a test space and run the following script with your new space key.

```
def space = Spaces.getByKey("YourSpaceKey")
println(space)
space
```

Analyze the response to understand data structure and field representations.

### Simplify scripts for Cloud

When converting scripts from ScriptRunner for Confluence Server/Data Center to ScriptRunner for Confluence Cloud, you may find that many complex objects can be omitted. Server/Data Center scripts often use complex Java methods. In Cloud, these can often be replaced by straightforward REST calls with structured body parameters.

### User execution context

In Confluence Cloud, scripts generally cannot be executed as another user, except for the ScriptRunner add-on user. While you can pass user account IDs as parameters to certain REST calls, the calls themselves will execute as either the initiating user or the ScriptRunner add-on user.

### Authentication headers

You do not need to manually define REST request authentication headers in ScriptRunner for Confluence Cloud scripts. These headers are automatically configured. Scripts will execute as the user who triggers the script or as the ScriptRunner add-on user. This execution context is easily controlled through a drop-down menu within the ScriptRunner script configuration UI.

## Commonly used Atlassian Java API endpoints and their Cloud equivalents 

This table maps some of the most commonly used Atlassian Java APIs (in ScriptRunner for Confluence Server/Data Center) to the closest Atlassian REST API endpoints (ScriptRunner for Confluence Cloud) to guide you in script conversions.

-   The latest version of the Confluence Cloud platform REST API is [version 2](https://developer.atlassian.com/cloud/confluence/rest/v2/intro/#about). [Version 1](https://developer.atlassian.com/cloud/confluence/rest/v1/intro/#auth) and 2 of the API offer the same collection of operations. However, version 2 provides support for the [Atlassian Document Format](https://developer.atlassian.com/cloud/jira/platform/apis/document/structure/)(ADF) and is continuously being enhanced. 
-   The REST API may not provide direct equivalents for all Java API functionalities. In such cases, consider using a combination of available endpoints or re-evaluating the script's logic to fit within the cloud's constraints.
-   Always refer to the official [Confluence Cloud REST API documentation](https://developer.atlassian.com/cloud/confluence/rest/v2/intro/#about) for the most up-to-date information on available endpoints and their usage.

  

Functionality

Java API (Data Center)

REST API (Cloud)

**Add Attachment**

`AttachmentManager` (e.g., `addAttachment(Page page, Attachment attachment)`)

Check out the REST API for [add attachment here](https://developer.atlassian.com/cloud/confluence/rest/v1/api-group-content---attachments/#api-wiki-rest-api-content-id-child-attachment-post).

**Add Comment**

`CommentManager` (e.g., `addComment(Comment comment)`)

Check out the REST API for [add comment here](https://developer.atlassian.com/cloud/confluence/rest/v2/api-group-comment/#api-inline-comments-post).

**Add Labels**

`LabelManager` (e.g., `addLabel(ContentEntity entity, Label label)`)

Check out the REST API for [add label here](https://developer.atlassian.com/cloud/confluence/rest/v1/api-group-content-labels/#api-wiki-rest-api-content-id-label-post).

**Create Page**

`PageManager` (e.g., `saveContentEntity(ContentEntity)`)

Check out the REST API for [create page here](https://developer.atlassian.com/cloud/confluence/rest/v2/api-group-page/#api-pages-post).

**Create Space**

`SpaceManager` (e.g., `saveSpace(Space space)`)

Check out the REST API for [create space here](https://developer.atlassian.com/cloud/confluence/rest/v1/api-group-space/#api-wiki-rest-api-space-post).

**Delete Page**

`PageManager` (e.g., `removePage(Page page)`)

Check out the REST API for [delete page here](https://developer.atlassian.com/cloud/confluence/rest/v2/api-group-page/#api-pages-id-delete).

**Retrieve Attachments**

`AttachmentManager` (e.g., `getAttachments(Page page)`)

Check out the REST API for [retrieve attachments here](https://developer.atlassian.com/cloud/confluence/rest/v2/api-group-attachment/#api-pages-id-attachments-get).

**Retrieve Comments**

`CommentManager` (e.g., `getComments(Page page)`)

Check out the REST API for [retrieve comments here](https://developer.atlassian.com/cloud/confluence/rest/v2/api-group-comment/#api-pages-id-inline-comments-get).

**Retrieve Labels**

`LabelManager` (e.g., `getLabels(ContentEntity entity)`)

Check out the REST API for [retrieve labels here](https://developer.atlassian.com/cloud/confluence/rest/v2/api-group-label/#api-pages-id-labels-get).

**Retrieve Page Content**

`PageManager` (e.g., `getPage(long pageId)`)

Check out the REST API for [retrieve page content here](https://developer.atlassian.com/cloud/confluence/rest/v2/api-group-page/#api-pages-id-get).

**Retrieve Space Information**

`SpaceManager` (e.g., `getSpace(String spaceKey)`)

Check out the REST API for [retrieve space information here](https://developer.atlassian.com/cloud/confluence/rest/v2/api-group-space/#api-spaces-id-get).

**Update Page**

`PageManager` (e.g., `saveContentEntity(ContentEntity)`)

Check out the REST API for [update page here](https://developer.atlassian.com/cloud/confluence/rest/v2/api-group-page/#api-pages-id-put).

## Common listener events availability

Check out the [Event Listener Parity](https://docs.adaptavist.com/sr4cc/latest/migration/feature-parity/confluence-events-parity) documentation so you can learn about events in ScriptRunner for Confluence Server/Data Center and their availability in Cloud. More detail on what ScriptRunner can do with the supported Cloud events can be found on our [Script Listeners](https://docs.adaptavist.com/display/_PK/SR4CC/script-listeners) page.

## Common operations

Here we have listed some common operations required in ScriptRunner for Confluence Cloud scripts. Switch between the tabs to show the Cloud or Server/Data Center scripts. These operations can be used for many use cases. 

#### **Update page content**

```
import com.atlassian.confluence.pages.PageManager
import com.atlassian.confluence.pages.Page
import com.atlassian.sal.api.component.ComponentLocator
import com.atlassian.confluence.core.DefaultSaveContext

// Retrieve the PageManager component
def pageManager = ComponentLocator.getComponent(PageManager)

// Define the page ID of the page you want to update
def pageId = 123456 // Replace with the actual page ID

// Retrieve the page using the page ID
def page = pageManager.getPage(pageId)

if (page) {
    // Update the page content
    def newContent = """
        <h1>Updated Content</h1>
        <p>This is the new content for the page.</p>
    """
    page.setBodyAsString(newContent)

    // Save the updated page
    pageManager.saveContentEntity(page, new DefaultSaveContext(true, true, true))

    return "Page content updated successfully."
} else {
    return "Page not found."
}
```

```
// Define the page ID and the new content
def pageId = 256475137 // Replace with the actual page ID
def newContent = """
    <h1>Updated Content</h1>
    <p>This is the new content for the page.</p>
"""


// Retrieve the existing page to get the current version
def page = get("/wiki/api/v2/pages/${pageId}").asObject(Map)
def currentVersion = page.body.version.number
println(page.body.title)
// Prepare the updated page data
def updatedPageData = [
    id: pageId,
    title: page.body.title,
    status: "current",
    version: [
        number: currentVersion + 1
    ],
    body: [
        storage: [
            value: newContent,
            representation: 'storage'
        ]
    ]
]

// Update the page content
def updateResponse = put("/wiki/api/v2/pages/${pageId}")
.header("Content-Type", "application/json")
.body(updatedPageData)
.asObject(Map)

if (updateResponse.status == 200) {
    return "Page content updated successfully."
} else {
    return "Failed to update page content: ${updateResponse.status}"
}
```

#### **Create a new page**

```
import com.atlassian.confluence.pages.Page
import com.atlassian.confluence.pages.PageManager
import com.atlassian.confluence.spaces.SpaceManager
import com.atlassian.sal.api.component.ComponentLocator
import com.atlassian.confluence.core.DefaultSaveContext

// Retrieve the PageManager and SpaceManager components
def pageManager = ComponentLocator.getComponent(PageManager)
def spaceManager = ComponentLocator.getComponent(SpaceManager)

// Define the space key where the page will be created
def spaceKey = 'EXAMPLE' // Replace with the actual space key

// Retrieve the space object using the space key
def space = spaceManager.getSpace(spaceKey)

if (space) {
    // Create a new page object
    def newPage = new Page()
    newPage.setSpace(space)
    newPage.setTitle('New Page Title') // Set the title of the new page
    newPage.setBodyAsString("""
        <h1>Welcome to the New Page</h1>
        <p>This is the content of the new page.</p>
    """) // Set the content of the new page

    // Save the new page
    pageManager.saveContentEntity(page, new DefaultSaveContext(true, true, true))

    return "New page created successfully with ID: ${newPage.id}"
} else {
    return "Space not found."
}
```

```
def space = Spaces.getByKey("your space key") // Replace with the actual space key
def pageTitle = 'New Page Title'
def pageContent = """
    <h1>Welcome to the New Page</h1>
    <p>This is the content of the new page.</p>
"""

// Prepare the new page data
def newPageData = [
    type: 'page',
    title: pageTitle,
    spaceId: space.id,
    body: [
        storage: [
            value: pageContent,
            representation: 'storage'
        ]
    ]
]

def createdPage = post("/wiki/api/v2/pages")
.header("Content-Type", "application/json")
.body(newPageData)
.asObject(Map)

if (createdPage.status == 200) {
    return "Page created successfully."
} else {
    return "Failed to create page: ${createdPage.status}"
}
```

#### **Add labels to a page**

```
import com.atlassian.confluence.labels.LabelManager
import com.atlassian.confluence.pages.PageManager
import com.atlassian.confluence.labels.Label
import com.atlassian.sal.api.component.ComponentLocator

// Retrieve the LabelManager and PageManager components
def labelManager = ComponentLocator.getComponent(LabelManager)
def pageManager = ComponentLocator.getComponent(PageManager)

// Define the page ID and the labels to add
def pageId = 123456 // Replace with the actual page ID
def labels = ['label1', 'label2'] // Replace with your desired labels

// Retrieve the page using the page ID
def page = pageManager.getPage(pageId)

if (page) {
    // Add each label to the page
    labels.each { labelName ->
        def label = new Label(labelName)
        labelManager.addLabel(page, label)
    }
    return "Labels added successfully to the page."
} else {
    return "Page not found."
}
```

```
def page = Pages.getById(196721) //replace with your actual page id
page.addLabels("label-here1", "label-here2")
```

## Other resources

-   [Rewriting Scripts](https://docs.adaptavist.com/sr4cc/latest/migration/rewrite-scripts-for-cloud-guide)
-   [Prepare to Migrate Script](https://docs.adaptavist.com/sr4cc/latest/migration/rewrite-scripts-for-cloud-guide/prepare-to-migrate-scripts)
-   [Adapt scripts for Confluence Cloud](https://docs.adaptavist.com/sr4cc/latest/migration/rewrite-scripts-for-cloud-guide/adapt-scripts-for-confluence-cloud)
-   [Feature Parity](https://docs.adaptavist.com/sr4cc/latest/migration/feature-parity)
-   [Event Listener Parity](https://docs.adaptavist.com/sr4cc/latest/migration/feature-parity/confluence-events-parity)
