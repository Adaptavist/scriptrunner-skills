# Work with Application Links

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: HAPI
- Doc ID: doc-sr4c-7235877d-da9e-4435-a0e7-ebd44564a0d9-27d012e99cd3fb8a
- Source: https://docs.adaptavist.com/sr4c/latest/hapi#work-with-application-links--en

HAPI provides a simpler method of working with other Atlassian products that have been connected via [Application Links](https://confluence.atlassian.com/conf85/linking-to-another-application-1283360948.html) (app link).

HAPI is optimized for the most common integration solutions, such as making requests over an app link configured with _OAuth (with impersonation) authentication_.

The steps to making a request over an app link are:

1.  Select the app link.
    
    For example `ApplicationLinks.primaryJiraLink`, or `ApplicationLinks.getByName('Dogfood Jira')`
    
2.  Execute a request using the extension method `com.adaptavist.hapi.jira.extensions.ApplicationLinkExtensions#executeRequest`

## Working with Confluence

### Create a page and add an attachment to the page

In the following example, we're using the [Confluence REST API](https://docs.atlassian.com/ConfluenceServer/rest/8.4.2/#api/content-createContent) to create a page and then [add an attachment](https://docs.atlassian.com/ConfluenceServer/rest/8.4.2/#api/content/{id}/child/attachment-createAttachments) to that page.

Tip: To find the key for your Confluence space, go to Space tools > Overview.

Use the following script:

```
import static com.atlassian.sal.api.net.Request.MethodType.POST
import com.atlassian.sal.api.net.RequestFilePart

def confluenceLink = ApplicationLinks.primaryConfluenceLink
def pageResponse = confluenceLink.executeRequest(POST, 'rest/api/content') {
    setHeader('Content-Type', 'application/json')
    setEntity([
            type : 'page',
            title: 'new page',
            space: [
                    key: 'AAA'
            ],
            body : [
                    storage: [
                            value         : "<p>This is <br/> a new page</p>",
                            representation: "storage"
                    ]
            ]
    ])
} as Map

def pageId = pageResponse.id

def filePart = new RequestFilePart(new File('/path/to/screenshot.png'), 'file')
confluenceLink.executeRequest(POST, "rest/api/content/${pageId}/child/attachment") {
    addHeader("X-Atlassian-Token", "no-check")
    setFiles([filePart])
}
```

### Create a page for every subtask of a Jira issue and add a label

1.  Run the following script in the [Script Console](https://docs.adaptavist.com/sr4c/latest/features/script-console) to create a page with labels for Jira issues:
    
    ```
    import static com.atlassian.sal.api.net.Request.MethodType.GET
    
    def spaceToCreatePagesIn = 'HT'
    def issueKey = 'HAPI-1'
    
    def subTasks = ApplicationLinks.primaryJiraLink.executeRequest(GET, "/rest/api/2/issue/$issueKey/subtask") as List<Map<String,String>>
    
    subTasks.each {
        Pages.create(spaceToCreatePagesIn, "${it.key} - ${it.fields.summary}") {
            setLabels("hapi")
        }
    }
    ```
    
    After you run the script and open the space, you'll see a page with labels created for each sub-task on the issue that you assigned in the script:
    
    The Jira task and subtasks are untouched and appear like this:
    
2.  You can customize the Confluence space, the Jira issue key, and the label of this script:
    
    ```
    import static com.atlassian.sal.api.net.Request.MethodType.GET
    
    def spaceToCreatePagesIn = 'SPACEKEY'
    def issueKey = 'ISSUEKEY'
    
    def subTasks = ApplicationLinks.primaryJiraLink.executeRequest(GET, "/rest/api/2/issue/$issueKey/subtask") as List<Map<String,String>>
    
    subTasks.each {
        Pages.create(spaceToCreatePagesIn, "${it.key} - ${it.fields.summary}") {
            setLabels("LABEL")
        }
    }
    ```
    

## Working with Jira

In the following example, make a request to [get the current user](https://docs.atlassian.com/software/jira/docs/api/REST/7.6.1/?_ga=2.237355399.644023112.1696945594-468908056.1677091897#auth/1/session-currentUser) via the primary Jira app link. The primary Jira app link is the Jira application link that is marked with `PRIMARY` when you're on the _Application Links_ page.

```
import static com.atlassian.sal.api.net.Request.MethodType.GET
            
def result = ApplicationLinks.primaryJiraLink.executeRequest(GET, '/rest/auth/1/session') as Map 
            
def userName = result.name
```

The result is coerced to a map, list, or whatever is appropriate. If you request XML, you will be returned a `groovy.util.slurpersupport.GPathResult` .

### Making requests as a different user

You can make the request as a different user by utilizing `Users.runAs`. For example:

```
import static com.atlassian.sal.api.net.Request.MethodType.GET

def result = Users.runAs('anuser') {
    ApplicationLinks.primaryJiraLink.executeRequest(GET, '/rest/auth/1/session') as Map
}

assert result.name == 'anuser'
```

### Making a POST request

You can make a post request as well as `GET` requests (as we have done previously). To make a POST request set the `Content-Type` header, typically to `application/json`, and provide a Map or List to `setEntity`, this converts to JSON automatically. In the following example, we're making a POST request and creating an issue in the connected Jira instance.

Note: See the documentation for [Creating an Issue](https://docs.atlassian.com/software/jira/docs/api/REST/9.4.0/#api/2/issue-createIssue).

```
import static com.atlassian.sal.api.net.Request.MethodType.POST

def result = ApplicationLinks.primaryJiraLink.executeRequest(POST, '/rest/api/2/issue') {
    setHeader('Content-Type', 'application/json')
    setEntity([
            fields: [
                    project  : [
                            key: 'SR',
                    ],
                    summary  : 'Help me!',
                    issuetype: [
                            name: 'Task'
                    ]
            ]
    ])
} as Map

def issueKey = result.key
```

### Creating attachments in Jira

In the following example, we're creating an attachment for a specific issue in the connected Jira instance.

```
import static com.atlassian.sal.api.net.Request.MethodType.POST
import com.atlassian.sal.api.net.RequestFilePart

// note the 'file' string as the second argument is important, and should not be anything other than 'file'
def filePart = new RequestFilePart(new File('/path/to/screenshot.png'), 'file')

def issueKey = 'SR-100'
ApplicationLinks.primaryJiraLink.executeRequest(POST, "/rest/api/2/issue/${issueKey}/attachments") {
    addHeader("X-Atlassian-Token", "no-check")

    setFiles([filePart])
}
```

## Handling errors

If a request is not successful (that is, a response status code greater than 400 or less than 200), an exception is thrown. The response body will be parsed into a map or whatever is appropriate. In the following example, not all mandatory fields have been entered for creating an issue.

```
import static com.atlassian.sal.api.net.Request.MethodType.POST
import com.adaptavist.hapi.platform.applinks.exceptions.AppLinkResponseException

try {
    def result = ApplicationLinks.primaryJiraLink.executeRequest(POST, '/rest/api/2/issue') {
        setHeader('Content-Type', 'application/json')
        setEntity([
                fields: [
                        // note: project is missing
                        summary  : 'Help me!',
                        issuetype: [
                                name: 'Task'
                        ]
                ]
        ])
    } as Map
} catch (AppLinkResponseException e) {
    assert (e.entity as Map<String, Map>).errors.project == 'project is required'

    assert e.response.statusCode == 500
}
```

You also have access to the [Response](https://developer.atlassian.com/server/framework/atlassian-sdk/sal-services/#response) object through the exception, as shown.

## Related pages

-   [HAPI Script Format Help](https://docs.adaptavist.com/sr4c/latest/get-help/hapi-script-format-help)
-   [Run Scripts as Other Users Using HAPI](https://docs.adaptavist.com/sr4c/latest/hapi/run-scripts-as-other-users)
-   [Create a Page Using HAPI](https://docs.adaptavist.com/sr4c/latest/migration/migrating-to-or-from-cloud/rewrite-scripts-for-cloud/adapt-scripts-for-confluence-cloud#create-a-page--en)
