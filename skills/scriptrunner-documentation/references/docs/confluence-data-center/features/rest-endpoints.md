# REST Endpoints

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features
- Doc ID: doc-sr4c-6e7c84fb-9f37-4e27-85ff-8fb3463385d2-4d8d987052a0c43d
- Source: https://docs.adaptavist.com/sr4c/latest/features#rest-endpoints--en

An endpoint is a URL that runs a script. ScriptRunner _REST Endpoints_ will enable you to create custom endpoints tailored to your specific needs.

## What are REST Endpoints?

Use Groovy scripts to define REST endpoints, allowing you to integrate with external systems and exchange data. An endpoint is a URL that runs a script. ScriptRunner _REST Endpoints_ will enable you to create custom endpoints tailored to your specific needs.

## How to use REST Endpoints

REST endpoints are configured programmatically. You can define REST endpoints in ScriptRunner to:

-   Use in dashboard gadgets.
-   Receive information from external systems.
-   Plug gaps in the official REST API.
-   Allow all your XHRs to proxy through to other systems.

For example, you want to show a custom pop-up [dialog](https://docs.adaptavist.com/sr4c/latest/features/fragments/web-item) to your users if they click a button in your Confluence instance. To do this, you could create a rest endpoint that returns HTML to build the custom dialog and then use that with a custom web item to display the dialog to your users when they click a custom button within your Confluence instance.

Alternatively, you can create a REST endpoint to receive information from an external system. For example, you have an external system you use to log all new cars in your showroom. You want to be able to call the endpoint and have ScriptRunner add a new custom field option for each new car added to the external system.

The REST Endpoint page in ScriptRunner shows a list of all available endpoints. Here, you can edit, disable, and delete previously configured endpoints and create new ones

## Before you start

See our Introduction to Atlassian Java API module to learn about using the Java API documentation.

[Java API Training](../../data-center/training/course-introduction-to-scripting-in-script-runner-for-jira-d/2-3-video-introduction-to-atlassian-java-api.md)

Creating your own REST endpoint can be tricky. Before starting, make sure you understand what the REST API is and how to use it.

[REST API Handbook](https://developer.wordpress.org/rest-api/)

## Add a REST Endpoint

Follow these steps to create a custom REST endpoint:

1.  Select the Cog icon, and then select General Configuration.
2.  Scroll to the _ScriptRunner_ section in the left-hand navigation, and then select REST Endpoints.
3.  Select Add a New Item, and then select the _Custom Endpoint_

Use the following REST endpoint example to examine the different parts of the script:

```
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.json.JsonBuilder
import groovy.transform.BaseScript

import javax.ws.rs.core.MultivaluedMap
import javax.ws.rs.core.Response

@BaseScript CustomEndpointDelegate delegate // <1>

doSomething( // <2>
    httpMethod: "GET", groups: ["confluence-administrators"] // <3>
) { MultivaluedMap queryParams, String body -> // <4>
    Response.ok(new JsonBuilder([abc: 42]).toString()).build() // <5>
}
```

Line 8: This line makes methods in your script recognizable as endpoints, which is required.

Line 10: The name of the REST endpoint, which forms part of the URL. In this example, it is `doSomething`.

Line 11: This line configures the endpoint, determining which HTTP verb to handle and which groups to allow.

Line 12: This line contains parameters that are provided to your method body.

Line 13: The body of your method, where you will return a [`javax.ws.rs.core.Response`](http://docs.oracle.com/javaee/7/api/javax/ws/rs/core/Response.html) object.

You can add this REST endpoint to the list of configured endpoints by either using an inline script or copying it into a file and adding that file as a script. To test this endpoint, type this text into your browser:

```
<confluence_base_url>/rest/scriptrunner/latest/custom/doSomething
```

Note: Notice that the last part of the text is the name `doSomething`.

Alternatively, you could type this into the command line utility:

```
curl -u admin:admin <confluence_base_url>/rest/scriptrunner/latest/custom/doSomething
{"abc":42}
```

Note:

-   Again, notice the name `doSomething` in each command.
-   `admin:admin` corresponds to a username and password.

If you are using a file, you can change the response. You may need to select the Scan button on the _REST Endpoints_ page before calls to the endpoint return the new response. See the section on Script Root Scanning below.

## Configuration

The general format of a method defining a REST endpoint is:

```
methodName (Map configuration, Closure closure)
```

For the configuration, only the following options are supported:

|  |  |
| --- | --- |
| Key | Value |
| httpMethod | Choose one of: `GET`, `POST`, `PUT`, `DELETE` |
| groups | One or more groups. If the requesting user is in any of the groups, the request is allowed. |

Note: Either or both of these can be omitted. If you omit the groups attribute, the endpoint will be available to unauthenticated users.

Use these parameters for the closure:

| Parameter | Type | Description |
| --- | --- | --- |
| [`MultivaluedMap`](http://docs.oracle.com/javaee/7/api/javax/ws/rs/core/MultivaluedMap.html) | queryParams | This corresponds to the URL parameters. |
| `String` | Content | This is the body of the request for `httpMethod` (`POST`, `PUT`, etc.). |
| [`HttpServletRequest`](http://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletRequest.html) | Request | This returns the requesting user for the instance. |

You can use any of these forms for your closure:

```
something() { MultivaluedMap queryParams ->
something() { MultivaluedMap queryParams, String body ->
something() { MultivaluedMap queryParams, String body, HttpServletRequest request ->

something() { MultivaluedMap queryParams, HttpServletRequest request->
```

The contents of your closure depends on what you need access to.

Where the closure signature contains the `body` variable, the request input stream is read before your closure is executed, and the read data is passed to the closure in the `body`.

The request input stream can only be read once. If you want to avoid the request input stream from being read before your code executes, for instance if you are [reading file uploads](https://library.adaptavist.com/entity/file-upload-to-rest-endpoint), use the final form of the closure:

```
something() { MultivaluedMap queryParams, HttpServletRequest request->
```

## Access Request URL

Sometimes you may need to use the URL path after your method name. In the following example, you want to retrieve `/foo/bar`:

```
<base_url>/rest/scriptrunner/latest/custom/doSomething/foo/bar
```

Use the 3-parameter form of the closure definition and call the `getAdditionalPath` method from the base class.

For example:

```
doSomething() { MultivaluedMap queryParams, String body, HttpServletRequest request ->

    def extraPath = getAdditionalPath(request)
    // extraPath will contain /foo/bar when called as above
}
```

CAUTION: In previous versions, an `extraPath` variable was used in the scripts. However, this is not thread-safe. Use the method above.

## Script Root Scanning

As well as manually adding scripts or files via the UI, ScriptRunner scans your script roots for scripts that contain REST endpoints and automatically register them. To enable the scanning, set the property `plugin.rest.scripts.package` to a comma-delimited list of packages. For example:

```
-Dplugin.rest.scripts.package=com.acme.rest
```

On plugin enablement, scripts/classes under this package are scanned and registered if the scripts contain the following line:

```
@BaseScript CustomEndpointDelegate delegate
```

## Package Declarations and File Paths

Your REST Endpoint's code must begin with a package declaration that matches the package configured in the system property. Likewise, the file path in your script root must match that package declaration as well.

For example, if your `plugin.rest.scripts.package` system property is `com.acme.rest` and you want to create a custom REST Endpoint with a file named MyCustomRestEndpoint.groovy, then:

1.  The first line of the MyCustomRestEndpoint.groovy file should be `package com.acme.rest` .
2.  The file should have a line like `@BaseScript CustomEndpointDelegate delegate` as normal.
3.  The path to the file within your script root should be com/acme/rest/MyCustomRestEndpoint.groovy .

Subpackages should be okay, so long as the sub-directory matches the package. For example, you might put the file in `com/acme/rest/widgets` so long as your package declaration is `com.acme.rest.widgets` in the top line of the file.

If you are receiving unexpected HTTP 500 errors when trying to access your REST Endpoints that were added through Script Root Scanning, check your package declaration. Case sensitivity may be an issue as well, depending on your filesystem.

## Examples

### Create User

This example demonstrates plugging a gap in the official REST API.

```
import bucket.user.UserAccessor
import com.atlassian.sal.api.component.ComponentLocator
import com.atlassian.user.GroupManager
import com.atlassian.user.impl.DefaultUser
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.json.JsonBuilder
import groovy.transform.BaseScript
import com.fasterxml.jackson.databind.ObjectMapper

import javax.servlet.http.HttpServletRequest
import javax.ws.rs.core.MultivaluedMap
import javax.ws.rs.core.Response

import static com.atlassian.user.security.password.Credential.unencrypted

@BaseScript CustomEndpointDelegate delegate

def userAccessor = ComponentLocator.getComponent(UserAccessor)
def groupManager = ComponentLocator.getComponent(GroupManager)

user(
    httpMethod: "POST", groups: ["confluence-administrators"]
) { MultivaluedMap queryParams, String body ->

    def mapper = new ObjectMapper()
    def user = mapper.readValue(body, Map)
    assert user.username: 'must provide username'
    assert user.fullname: 'must provide fullname'
    assert user.email: 'must provide email'
    assert user.group: 'must provide group'
    assert user.password: 'must provide group'

    try {
        def newUser = new DefaultUser(user.username, user.fullname, user.email)
        // password ought to be encrypted but this is just an example
        userAccessor.createUser(newUser, unencrypted(user.password as String))
        userAccessor.addMembership(user.group, user.username)

    } catch (e) {
        return Response.serverError().entity([error: e.message]).build()
    }

    Response.created(new URI("/$user.username")).build()
}
```

Most of this code validates the JSON and query parameters that are passed to it. This validation ensures that all required fields for a user are present. The appropriate method on the `response` class sends the right status code. The status code is `500` (server error) if the user already exists. The status code is `200` (created) if the user is created.

To test, you could use the following code:

```
curl -v -X POST -H "Content-type: text/json" -u admin:admin --data "@user.json" \
    <confluence_base_url>/rest/scriptrunner/latest/custom/user
```

`user.json` is a text file that contains:

```
{
  "username": "newuser",
  "fullname": "New User",
  "email": "newuser@example.com",
  "group": "confluence-users",
  "password": "newuser"
}
```

You can have multiple methods with the same name in the same file, which is useful to do simple CRUD REST APIs.

An example:

```
POST /user - creates a user
PUT /user - updates a user
DELETE /user - deletes a user
GET /user - gets a user
```

### Get a User

This example demonstrates how to retrieve the user that was created in the previous example.

```
import bucket.user.UserAccessor
import com.atlassian.sal.api.component.ComponentLocator
import com.atlassian.user.GroupManager
import com.atlassian.user.impl.DefaultUser
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.json.JsonBuilder
import groovy.transform.BaseScript
import com.fasterxml.jackson.databind.ObjectMapper

import javax.servlet.http.HttpServletRequest
import javax.ws.rs.core.MultivaluedMap
import javax.ws.rs.core.Response

import static com.atlassian.user.security.password.Credential.unencrypted

@BaseScript CustomEndpointDelegate delegate

def userAccessor = ComponentLocator.getComponent(UserAccessor)
def groupManager = ComponentLocator.getComponent(GroupManager)

user(
    httpMethod: "POST", groups: ["confluence-administrators"]
) { MultivaluedMap queryParams, String body ->

    def mapper = new ObjectMapper()
    def user = mapper.readValue(body, Map)
    assert user.username: 'must provide username'
    assert user.fullname: 'must provide fullname'
    assert user.email: 'must provide email'
    assert user.group: 'must provide group'
    assert user.password: 'must provide group'

    try {
        def newUser = new DefaultUser(user.username, user.fullname, user.email)
        // password ought to be encrypted but this is just an example
        userAccessor.createUser(newUser, unencrypted(user.password as String))
        userAccessor.addMembership(user.group, user.username)

    } catch (e) {
        return Response.serverError().entity([error: e.message]).build()
    }

    Response.created(new URI("/$user.username")).build()
}
```

Note that when the previous user was created, you got the following header in the response:

```
Location: <confluence_base_url>/rest/scriptrunner/latest/custom/user/newuser
```

Then, use the `GET` user endpoint in the same script to retrieve the user from that location.

To retrieve the user, use the following command:

```
curl -X GET -u admin:admin <confluence_base_url>/rest/scriptrunner/latest/custom/user/newuser
```

Ensure that you use the appropriate method on the `Response` class to send the correct status code. The status code `500` (server error) is returned if the user does not exist. The status code is `200` (ok) to retrieve the user.

### Create Project Pages

This custom REST Endpoint allows you to create complex page structures automatically within Confluence. There are several different ways in which you can use this, including:

-   Using a custom button (Script Fragment > Custom Web Item) to allow users to trigger the action.
-   Calling the endpoint from another Atlassian application or 3rd party system, which allows you to create page structures within Confluence.

The following example is of a custom script fragment. This example is a starting point to help you implement your own custom solution. It is not a copy-paste solution.

Warning: When you implement your own version of this endpoint, evaluate security concerns, including:

-   Which groups should have access to the REST endpoint, and restrict as required.
-   Whether the user has the correct Confluence permissions for the work done by the REST endpoint. In its current state, the endpoint checks to ensure the calling user is in the _confluence-administrators_ or _confluence-users_ group. Additionally, it verifies that the calling user has view permissions on the parent page.

```
import com.atlassian.confluence.core.BodyContent
import com.atlassian.confluence.core.BodyType
import com.atlassian.confluence.core.DefaultSaveContext
import com.atlassian.confluence.core.service.NotAuthorizedException
import com.atlassian.confluence.pages.DuplicateDataRuntimeException
import com.atlassian.confluence.pages.Page
import com.atlassian.confluence.pages.PageManager
import com.atlassian.confluence.pages.templates.PageTemplate
import com.atlassian.confluence.pages.templates.PageTemplateManager
import com.atlassian.confluence.security.Permission
import com.atlassian.confluence.security.PermissionManager
import com.atlassian.confluence.spaces.Space
import com.atlassian.confluence.spaces.SpaceManager
import com.atlassian.confluence.user.AuthenticatedUserThreadLocal
import com.atlassian.sal.api.component.ComponentLocator
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.json.JsonOutput
import groovy.transform.BaseScript
import groovy.transform.Field

import javax.ws.rs.core.MultivaluedMap
import javax.ws.rs.core.Response

@Field SpaceManager spaceManager = ComponentLocator.getComponent(SpaceManager)
@Field PageManager pageManager = ComponentLocator.getComponent(PageManager)
@Field PermissionManager permissionManager = ComponentLocator.getComponent(PermissionManager)
@Field PageTemplateManager pageTemplateManager = ComponentLocator.getComponent(PageTemplateManager)

// The specified setup - Specify the page titles and hierarchy here
// This example setup contains one page with 2 child pages
// The template value takes the id of the template you want to use
def spec = [
    [
        title           : "Planning",
        templateName    : "template1",
        templateSpaceKey: "PS",
        page            : [
            [
                title           : "Review",
                templateName    : "template2",
                templateSpaceKey: "global-template"
            ],
            [
                title           : "Social",
                templateName    : "template1",
                templateSpaceKey: "PS"
            ]
        ]
    ]
] as List<Map>

@BaseScript CustomEndpointDelegate delegate
createProjectPages(httpMethod: "GET", groups: ["confluence-administrators", "confluence-users"]) { MultivaluedMap queryParams, String body ->
    // This is the space key specified in the custom script fragment
    def spaceKey = queryParams.getFirst("spaceKey") as String
    // This is the parent page id specified in the custom script fragment
    // The first page created in this script will use the page associated with the parent page id as its parent
    def parentPageId = queryParams.getFirst("parentPageId") as Long
    def mainPageTitle = spec.get(0).get("title")
    // Flag shown to user on successful or failed creation of new project structure pages
    def flag = [
        type : 'success',
        title: "Pages created",
        close: 'auto',
        body : "Refresh this page to see the newly created page (${mainPageTitle}) and its children in the page tree"
    ]
    try {
        createPages(spaceKey, parentPageId, spec)
    } catch (IllegalStateException | DuplicateDataRuntimeException | NotAuthorizedException e) {
        log.error("There was a problem trying to create the project structure", e)

        flag = [
            type : 'failure',
            title: "An error occurred",
            close: 'manual',
            body : "There was an error trying to create project structure pages"
        ]
    }
    Response.ok(JsonOutput.toJson(flag)).build()
}

/**
 * Create the desired page structure
 *
 * @param spaceKey The Key of the space to add pages for.
 * @param parentPageId The page id of the parent page.
 * @param spec The specification for the pages to be created.
 */
void createPages(
    String spaceKey, Long parentPageId, List<Map> spec
) throws IllegalStateException, NotAuthorizedException, Exception {
    def space = spaceManager.getSpace(spaceKey) as Space
    def parentPage = pageManager.getPage(parentPageId) as Page ?: spaceManager.getSpace(spaceKey).getHomePage()
    if (!parentPage) {
        throw new IllegalStateException("The specified parent page for new project structure pages does not exist")
    }
    if (!userHasPageViewPermission(parentPage)) {
        throw new NotAuthorizedException("User does not have the required permission to create child pages on page with id ${parentPage.getId()}")
    }
    spec.each { pageSpec ->
        createPage(parentPage, space, pageSpec as Map)
    }
}

/**
 * Check if the user clicking the fragment button has the relevant permission to create child pages.
 * @param parentPage
 * @return user permission view status
 */
boolean userHasPageViewPermission(Page parentPage) {
    def user = AuthenticatedUserThreadLocal.get()
    permissionManager.hasPermission(user, Permission.VIEW, parentPage)
}

/**
 * Create a page using the given page specification (pageSpec). This spec dictates the title of the page, the template
 * to be used to populate it (if any) and if required, the specification of any child pages.
 *
 * @param parentPage The parent page for the page we're about to create.
 * @param space The space that the page should be created in.
 * @param pageSpec The specification for the pages to be created.
 */
void createPage(Page parentPage, Space space, Map pageSpec) throws IllegalStateException {
    def testPageTitle = pageSpec.title as String
    def templateName = pageSpec.templateName as String
    def templateSpaceKey = pageSpec.templateSpaceKey as String
    String content = getTemplateContent(templateName, templateSpaceKey)
    def createdPage = createBasicPage(space, testPageTitle, content)
    linkPages(parentPage, createdPage)

    // Save this page
    pageManager.saveContentEntity(createdPage, DefaultSaveContext.SUPPRESS_NOTIFICATIONS)

    if (!pageManager.getPage(space.getKey(), createdPage.getTitle())) {
        throw new IllegalStateException("Unable to create page ${testPageTitle}")
    } else {
        log.debug("Created page ${testPageTitle} successfully")
    }

    // Build the children
    if (pageSpec.page) {
        pageSpec.page.each { childPageSpec ->
            createPage(createdPage, space, childPageSpec as Map)
        }
    }
}

/**
 * Get the content from the template to populate the page with.
 *
 * @param templateName The name of the template we wish to use.
 * @param templateSpace The space associated with the template we wish to use.
 * @return The template body content.
 */
String getTemplateContent(String templateName, String templateSpaceKey) {
    PageTemplate pageTemplate = templateSpaceKey == "global-template" ?
        pageTemplateManager.getGlobalPageTemplate(templateName) :
        pageTemplateManager.getPageTemplate(templateName, spaceManager.getSpace(templateSpaceKey))
    if (pageTemplate) {
        return pageTemplate.getContent()
    } else {
        throw new IllegalStateException("Unable to retrieve specified template")
    }
}

/**
 * Create a basic page. This is not linked in any hierarchy.
 *
 * @param space The space that this page belongs to.
 * @param title The title of the page we are creating.
 * @param content The content of the page we are creating.
 *
 * @return The create page object.
 */
Page createBasicPage(Space space, String title, String content) {
    def page = new Page()
    def bodyContent = new BodyContent(page, content, BodyType.XHTML)
    page.setVersion(1)
    page.setSpace(space)
    page.setTitle(title)
    page.setBodyContent(bodyContent)
    page.setCreator(AuthenticatedUserThreadLocal.get())

    page
}

/**
 * Link a parent and a child page together. This method creates a bi-directional relationship between the two pages.
 *
 * @param parent The parent page that we wish to link.
 * @param child The child page that we wish to link.
 */
void linkPages(Page parent, Page child) {
    // Set the parent page on the child
    child.setParentPage(parent)
    // Set the child page on the parent
    parent.addChild(child)
    // Set the ancestors on the child page
    def ancestors = []
    def parentPageAncestors = parent.getAncestors() as List
    if (parentPageAncestors) {
        ancestors.addAll(parentPageAncestors)
    }
    ancestors.add(parent)
    child.setAncestors(ancestors)
}
```

The custom fragment defines where the button is located and who has visibility of it.

The Condition in the custom script fragment above states that the button appears when the space key equals `PS`, and the Link value is _< base\_url>/rest/scriptrunner/latest/custom/createProjectPages?spaceKey=PS&parentPageId=851970_. In this example, the space key is `PS`, and the parent page has an ID of `851970`. You should change the `spaceKey` and `parentPageId` values to suit your needs.

Tip: Add or remove query parameters as required for your use case.

#### Limitations

Currently, with this implementation, the space key is passed via a query parameter. A custom fragment is needed for each space if you want the project structure created in the same space as the button.

Alternatively, you could have the fragment button in a single space. When the fragment button is clicked, a new space with the defined page structure is created.
