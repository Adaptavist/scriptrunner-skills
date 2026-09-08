# Link to Confluence From Jira

- Platform: data-center
- Space: SR4JS
- Hierarchy: integrations > atlassian-products > via-app-links
- Doc ID: doc-sr4js-442889171
- Source: https://docs.adaptavist.com/sr4js/latest/integrations/atlassian-products/via-app-links/link-to-confluence-from-jira

Sometimes you might want to create a confluence page corresponding to an issue. For instance when new `Epic` types are created, or when high-priority issues change state.

A simple example is as follows:

```
import com.atlassian.applinks.api.ApplicationLink
import com.atlassian.applinks.api.ApplicationLinkService
import com.atlassian.applinks.api.application.confluence.ConfluenceApplicationType
import com.atlassian.jira.issue.Issue
import com.atlassian.sal.api.component.ComponentLocator
import com.atlassian.sal.api.net.Request
import com.atlassian.sal.api.net.Response
import com.atlassian.sal.api.net.ResponseException
import com.atlassian.sal.api.net.ResponseHandler
import groovy.json.JsonBuilder
import groovy.json.JsonSlurper

/**
 * Retrieve the primary confluence application link
 * @return confluence app link
 */
def ApplicationLink getPrimaryConfluenceLink() {
    def applicationLinkService = ComponentLocator.getComponent(ApplicationLinkService)
    final ApplicationLink conflLink = applicationLinkService.getPrimaryApplicationLink(ConfluenceApplicationType)
    conflLink
}

// the issue provided to us in the binding
Issue issue = issue

// if you don't want to create confluence pages based on some criterion like issue type, handle this, eg:
if (!issue.issueTypeObject.name == "Bug") {
    return
}

def confluenceLink = getPrimaryConfluenceLink()
assert confluenceLink: 'must have a working app link set up'

def authenticatedRequestFactory = confluenceLink.createImpersonatingAuthenticatedRequestFactory()

// set the page title - this should be unique in the space or page creation will fail
def pageTitle = issue.key + " Discussion"
def pageBody = """h3. ${issue.summary}

{quote}${issue.description}{quote}

Yada yada, use this page to discuss the above...
"""

authenticatedRequestFactory
    .createRequest(Request.MethodType.POST, "rest/api/content")
    .addHeader("Content-Type", "application/json")
    .setRequestBody(new JsonBuilder(params).toString())
    .execute(new ResponseHandler<Response>() {
        @Override
        void handle(Response response) throws ResponseException {
            if (response.statusCode != HttpURLConnection.HTTP_OK) {
                throw new Exception(response.getResponseBodyAsString())
            } else {
                def webUrl = new JsonSlurper().parseText(response.responseBodyAsString)["_links"]["webui"]
            }
        }
    })
```

The outline of this script is essentially:

-   retrieve Confluence application link
    
-   set up parameters to pass to the REST API call which will create the Confluence page, eg page title and content
    
-   use the REST API to create the page
    

Assuming you have set up the app link to authenticate with OAuth or Trusted Apps, it will create the page as the user running the transition (so make sure they have the correct permissions in Confluence).

Whilst it’s perfectly possible to create the page remotely without an app link, it will require embedding credentials for the Confluence administrator account in your script, which is not desirable.

The most important part of this is setting up the parameters to be passed to the REST API:

```
def params = [
    type : "page",
    title: pageTitle,
    space: [
        key: "TEST" // set the space key - or calculate it from the project or something
    ],
    /* // if you want to specify create the page under another, do it like this:
     ancestors: [
         [
             type: "page",
             id: "14123220",
         ]
     ],*/
    body : [
        storage: [
            value         : pageBody,
            representation: "wiki"
        ],
    ],
]
```

Most of this is self-explanatory. You can hard-code the key or you might want to set it dynamically based on the project, issue type etc etc. You’ll also need to either hard-code your server ID or retrieve it. You can find out your Confluence server’s ID using [the documented methods from Atlassian](https://confluence.atlassian.com/confkb/what-is-the-confluence-server-id-151519275.html).

If you do not specify an ancestor page your page will be created at the root of the space, which might not be under the home page, and hence not easy to find.

The final part is where you set the body of the page (using [Confluence Storage Format](https://confluence.atlassian.com/display/DOC/Confluence+Storage+Format) syntax).

Here is a full example of using the storage format to create the page:

```
import com.atlassian.applinks.api.ApplicationLink
import com.atlassian.applinks.api.ApplicationLinkService
import com.atlassian.applinks.api.application.confluence.ConfluenceApplicationType
import com.atlassian.jira.issue.Issue
import com.atlassian.sal.api.component.ComponentLocator
import com.atlassian.sal.api.net.Request
import com.atlassian.sal.api.net.Response
import com.atlassian.sal.api.net.ResponseException
import com.atlassian.sal.api.net.ResponseHandler
import groovy.json.JsonBuilder
import groovy.json.JsonSlurper
import groovy.xml.MarkupBuilder

static ApplicationLink getPrimaryConfluenceLink() {
    def applicationLinkService = ComponentLocator.getComponent(ApplicationLinkService)
    final ApplicationLink conflLink = applicationLinkService.getPrimaryApplicationLink(ConfluenceApplicationType)
    conflLink
}

// the issue provided to us in the binding
Issue issue = issue

// if you don't want to create confluence pages based on some criterion like issue type, handle this, eg:
if (issue.issueType.name != "Bug") {
    return
}

def confluenceLink = getPrimaryConfluenceLink()
assert confluenceLink: 'must have a working app link set up'

def authenticatedRequestFactory = confluenceLink.createImpersonatingAuthenticatedRequestFactory()

// add more paragraphs etc
xml.p("Some additional info here.")

// print the storage that will be the content of the page
log.debug(writer.toString())

// set the page title - this should be unique in the space or page creation will fail
def pageTitle = issue.key + " Discussion"

def params = [
    type : "page",
    title: pageTitle,
    space: [
        key: "TEST" // set the space key - or calculate it from the project or something
    ],
    body : [
        storage: [
            value         : writer.toString(),
            representation: "storage"
        ]
    ]
]

authenticatedRequestFactory
    .createRequest(Request.MethodType.POST, "rest/api/content")
    .addHeader("Content-Type", "application/json")
    .setRequestBody(new JsonBuilder(params).toString())
    .execute(new ResponseHandler<Response>() {
        @Override
        void handle(Response response) throws ResponseException {
            if (response.statusCode != HttpURLConnection.HTTP_OK) {
                throw new Exception(response.getResponseBodyAsString())
            } else {
                def webUrl = new JsonSlurper().parseText(response.responseBodyAsString)["_links"]["webui"]
            }
        }
    })
```

The interesting part:

```
// write storage format using an XML builder
def writer = new StringWriter()
def xml = new MarkupBuilder(writer)
xml.'ac:structured-macro'('ac:name': "jira") {
    'ac:parameter'('ac:name': "key", issue.key)
    'ac:parameter'('ac:name': "server", "System JIRA")
    'ac:parameter'('ac:name': "serverId", "YOUR-SERVER-ID")
}
```

We use a _builder_ to make sure the XML we create is well-formed. We use the _Jira Issue_ macro to create a link back to the issue. This will also create a remote link on the Jira ticket.
