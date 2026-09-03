# Work with Linked Applications

- Platform: data-center
- Space: SR4JS
- Hierarchy: hapi
- Doc ID: doc-sr4js-442888281
- Source: https://docs.adaptavist.com/sr4js/latest/hapi/work-with-linked-applications

HAPI provides a simpler method of working with other Atlassian products that have been connected via [Application Links](https://confluence.atlassian.com/adminjiraserver/link-to-other-applications-938846918.html) (app link). HAPI is optimised for the most common integration solutions, such as making requests over an app link configured with _OAuth (with impersonation) authentication_.

The steps to making a request over an app link are:

1.  Select the app link. For example `ApplicationLinks.primaryJiraLink` , or `ApplicationLinks.getByName('Dogfood Jira')` 
2.  Execute a request using the extension method `com.adaptavist.hapi.jira.extensions.ApplicationLinkExtensions#executeRequest`

## Making requests to a Jira app link

In the following example, make a request to [get the current user](https://docs.atlassian.com/software/jira/docs/api/REST/7.6.1/#auth/1/session-currentUser) via the primary Jira app link. The primary Jira app link is the Jira application link that is marked with **PRIMARY** when you're on the **Application links** page.

![Image displaying primary app link](/sr4js/files/latest/442888281/442888282/1/1758746926000/Application_links_primary.png)

```
            import static com.atlassian.sal.api.net.Request.MethodType.GET
            
            def result = ApplicationLinks.primaryJiraLink.executeRequest(GET, '/rest/auth/1/session') as Map 
            
            def userName = result.name
```

The result is coerced to a **Map, List**, or whatever is appropriate. If you request XML, you will be returned a `groovy.util.slurpersupport.GPathResult` .

### Making requests as a different user

You can make the request as a different user by utilizing `Users.runAs`, for example :

```
            import static com.atlassian.sal.api.net.Request.MethodType.GET
            
            def result = Users.runAs('anuser') { 
                ApplicationLinks.primaryJiraLink.executeRequest(GET, '/rest/auth/1/session') as Map
            } 
            
            assert result.name == 'anuser'
```

### Making a POST request

You can make a **POST** request as well as **GET** requests (as we have done previously). To make a POST request set the `Content-Type` header, typically to `application/json`, and provide a Map or List to `setEntity`, this converts to JSON automatically. In the following example we're making a POST request and creating an issue in the connected Jira instance.

See the [Atlassian `Create issue` API](https://docs.atlassian.com/software/jira/docs/api/REST/7.6.1/#api/2/issue-createIssue) documentation for more information.

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

## Creating attachments in Jira

In the following example we're creating an attachment for a specific issue in the connected Jira instance.

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

## Working with Confluence

In the following example we're using the [Confluence REST API](https://developer.atlassian.com/server/confluence/confluence-server-rest-api/) to create a page, and then add an attachment to that page.

To find the key for your confluence space, in confluence go to **Space tools > Overview**.  

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

![Image showing how you can work with confluence using HAPI](/sr4js/files/latest/442888281/442888286/1/1758746926000/Application_links_create_page.png)

## Handling errors

If a request is not successful (that is, a response status code greater than 400 or less than 200), an exception is thrown. The response body will be parsed into a Map or whatever is appropriate. In the following example, not all mandatory fields have been entered for creating an issue.

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

You also have access to the [Response](https://docs.atlassian.com/DAC/javadoc/sal/2.6/reference/com/atlassian/sal/api/net/Response.html) object through the exception, as shown. 

  

* * *

## Related content

-   [Javadocs link](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/8.10.0/hapi/jira/groovydoc/com/adaptavist/hapi/jira/applinks/ApplicationLinks.html)
-   [Update Issues](https://docs.adaptavist.com/sr4js/latest/hapi/update-issues)
-   [Transition Issues](https://docs.adaptavist.com/sr4js/latest/hapi/transition-issues)
