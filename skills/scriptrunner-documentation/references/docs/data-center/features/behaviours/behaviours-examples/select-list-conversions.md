# Select List Conversions

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > behaviours > behaviours-examples
- Doc ID: doc-sr4js-543948833
- Source: https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples/select-list-conversions

Several of the use cases here can now be better accomplished using one of the new picker fields.   
If possible you should use those, as they allow better options for validation, rendering, integration with Behaviours, and so on.  
Where there is a better feature to accomplish the same, that will be displayed in the text below.

Write a behaviour that converts a text field to a select or a multi-select field, on initialization of the form.

You can also specify the available options for the field, including a _picker_ function that performs as-you-type searching.

![](/sr4js/files/latest/543948833/543948820/1/1778063221000/gallery.png)

For example:

-   Allow the Jira user to select any GitHub or Bitbucket repository.
    
-   Require a link to another Jira issue where they can only pick from a constrained list.
    
-   Require a link to a remote Jira issue, for instance, constraining the remote issue to just those of a  _Support Request_  type.
    
-   Pick from a list of customers, where the customer information comes from a CRM database or REST service.
    
-   Pick from a list of Confluence spaces.
    

We use a behaviour for list conversion as there are millions of repositories in GitHub/Bitbucket. Importing all of the item as options into Jira for regular or multi-select lists is impractical.

If you have a manageable list of options, and you can synchronize them with your select field options, this gives you a couple of additional advantages:

-   The ability to rename options.
    
-   The ability to disable options.
    

## Walkthrough - pick from Jira issues

Link a text field to display a searchable list of issues that come from a JQL query. For example, you want to enforce the association of an end-user _Incident_ issue type with a  _Root Cause_ issue type.

You are advised to use an [Issue Picker](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/issue-picker) field rather than this method.  
The information below preceded the release of Issue Picker fields.

1.  The first step is to validate that your JQL query works, e.g.:
    
    ```
issuetype = 'Root Cause' and resolution is empty
```
    
2.  Next, create a behaviour, and add an initializer function containing something similar to the following:  
    
    ```
        getFieldByName("TextFieldA").convertToSingleSelect([ // <1>
            ajaxOptions: [
                url : getBaseUrl() + "/rest/scriptrunner-jira/latest/issue/picker",
                query: true, // keep going back to the sever for each keystroke

                // this information is passed to the server with each keystroke
                data: [
                    currentJql  : "project = SSPA ORDER BY key ASC", // <2>
                    label       : "Pick high priority issue in Support project", // <3>
                    showSubTasks: false, // <4>

                    // specify maximum number of issues to display, defaults to 10
                    // max       : 5,
                ],
                formatResponse: "issue" // <5>
            ],
            css: "max-width: 500px; width: 500px", // <6>
        ])
```
    
    **Line 1**: Convert a custom field called **TextFieldA.** This can be any short text field, even the **Summary**.
    
    **Line 8**: Specify the JQL query - customize to suit.
    
    **Line 9**: Label that appears at the top of the dropdown.
    
    **Line 10**: Set to  `true`  to also return sub-tasks.
    
    **Line 15**: When returning issues this must be  `"issue".`
    
    **Line 17**: Make the single select the same width as the multi-select.
    
    The JQL query you provide is not validated, check it first. If it’s invalid, no issues are displayed.
    
3.  Apply the behaviour to the project (and/or issue type) that you are testing with. The field to which you applied the issue picker should then look like:
    
    ![](/sr4js/files/latest/543948833/543948823/1/1778063220000/pick-issue.png)

You could use a post-function or listener to create this as an actual issue link.

If you want to modify the JQL query depending on other field inputs see [this example](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples).

## Walkthrough - external REST service

You are advised to use an [Issue Picker](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/issue-picker) Custom Picker field rather than this method.  
The information below preceded the release of Custom Picker fields.

### Create and test endpoint

This example deals with picking from a list that comes from an external provider, in this case GitHub.

The browser cannot make requests directly to the GitHub REST API due to [anti-XSS](https://en.wikipedia.org/wiki/Cross-site_scripting) measures, so we will write a REST endpoint that will effectively proxy the request on to GitHub. We will need to manipulate the request and response slightly.

1.  Create a new [REST endpoint](https://docs.adaptavist.com/sr4js/latest/features/rest-endpoints), containing the following code:
    
    This script is compatible with ScriptRunner version 10.x and above.
    
    ```
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.json.JsonBuilder
import groovy.json.JsonOutput
import groovy.transform.BaseScript
import groovyx.net.http.ContentType
import groovyx.net.http.HTTPBuilder
import groovyx.net.http.Method

import jakarta.ws.rs.core.MultivaluedMap
import jakarta.ws.rs.core.Response

@BaseScript CustomEndpointDelegate delegate

githubRepoQuery(httpMethod: "GET") { MultivaluedMap queryParams -> // <1>

    def query = queryParams.getFirst("query") as String

    def rt = [:]
    if (query) {
        def httpBuilder = new HTTPBuilder("https://api.github.com")
        def repos = httpBuilder.request(Method.GET, ContentType.JSON) {
            uri.path = "/search/repositories"
            uri.query = [q: "$query in:name", sort: "stars", order: "desc"]
            headers."User-Agent" = "My JIRA" // <2>

            response.failure = { resp, reader ->
                log.warn("Failed to query GitHub API: " + reader.text)
                return Response.serverError().build()
            }
        }

        rt = [
            items : repos["items"].collect { Map repo ->
                def repoName = repo."full_name"
                [
                    value: repoName,
                    html : repoName.replaceAll(/(?i)$query/) { "<b>${it}</b>" } // <3>
                        + "<span style=\"float: right\">${repo['stargazers_count']} ⭐</span>",
                    label: repoName,
                    icon : repo.owner?."avatar_url",
                ]
            },
            total : repos["total_count"],
            footer: "Choose repo... (${repos["items"].size()} of ${repos["total_count"]} shown...)"
        ]
    }

    return Response.ok(new JsonBuilder(rt).toString()).build()
}
```
    
      
    
    This script is compatible with ScriptRunner versions 8.x to 9.x.
    
    ```
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.json.JsonBuilder
import groovy.json.JsonOutput
import groovy.transform.BaseScript
import groovyx.net.http.ContentType
import groovyx.net.http.HTTPBuilder
import groovyx.net.http.Method

import javax.ws.rs.core.MultivaluedMap
import javax.ws.rs.core.Response

@BaseScript CustomEndpointDelegate delegate

githubRepoQuery(httpMethod: "GET") { MultivaluedMap queryParams -> // <1>

    def query = queryParams.getFirst("query") as String

    def rt = [:]
    if (query) {
        def httpBuilder = new HTTPBuilder("https://api.github.com")
        def repos = httpBuilder.request(Method.GET, ContentType.JSON) {
            uri.path = "/search/repositories"
            uri.query = [q: "$query in:name", sort: "stars", order: "desc"]
            headers."User-Agent" = "My JIRA" // <2>

            response.failure = { resp, reader ->
                log.warn("Failed to query GitHub API: " + reader.text)
                return Response.serverError().build()
            }
        }

        rt = [
            items : repos["items"].collect { Map repo ->
                def repoName = repo."full_name"
                [
                    value: repoName,
                    html : repoName.replaceAll(/(?i)$query/) { "<b>${it}</b>" } // <3>
                        + "<span style=\"float: right\">${repo['stargazers_count']} &#11088;</span>",
                    label: repoName,
                    icon : repo.owner?."avatar_url",
                ]
            },
            total : repos["total_count"],
            footer: "Choose repo... (${repos["items"].size()} of ${repos["total_count"]} shown...)"
        ]
    }

    return Response.ok(new JsonBuilder(rt).toString()).build()
}
```
    
      
    
    **Line 14**: **githubRepoQuery**  forms the final part of the REST URL  
    **Line 24**: Github API requires this header, the value is not important  
    **Line 37**: Highlight matched terms in a case-insensitive manner
    
    We are not authenticating to the GitHub API so only public repositories will be found. You can add authentication details if you have private repositories. Note also that without authentication you are [rate limited](https://developer.github.com/v3/#rate-limiting) to 60 requests per hour.
    
2.  Then you need to test this API alone. In your browser, go to: `<jira-base-url>/rest/scriptrunner/latest/custom/githubRepoQuery?query=tetris`
3.  You should see a response containing the first 30 matching items, sorted by popularity. Scroll down and check the  **total**  and  **footer**  keys are also correct. You might notice that the  **html**  value of each item has  **<b>**  tags to highlight the word  _tetris_.
    
    [JSONView](https://chrome.google.com/webstore/detail/jsonview/chklaanhfefbnpoihckbnefhakgolnmc?hl=en)  for Chrome will format the response nicely, as in the following image. Other plugins are available for other browsers.
    
    ![](/sr4js/files/latest/543948833/543948819/1/1778063221000/github-response.png)
    
4.  Try changing tetris to another string.
    

If this is working properly, you can move on to hooking it up to a text field.

### Behaviour

As in the previous example, create a behaviour and set the initializer code to:  

```
        getFieldByName("TextFieldB").convertToMultiSelect([ // <1>
            ajaxOptions: [
                url           : getBaseUrl() + "/rest/scriptrunner/latest/custom/githubRepoQuery", // <2>
                query         : true, // keep going back to the sever for each keystroke
                minQueryLength: 4, // <3>
                keyInputPeriod: 500, // <4>
                formatResponse: "general", // <5>
            ]
        ])
```

**Line 1**: Concert a custom field called  **TextFieldB**, this time to a  **multiselect**

**Line 3**: The URL of the endpoint that we tested above

**Line 5**: Don't make any query until the user has typed four characters

**Line 6**: Wait 500ms after the user has stopped typing before looking for repos

**Line 7**: When showing arbitrary, non-issue data, this must be  `"general"`

Testing should produce something similar to:

![](/sr4js/files/latest/543948833/543948829/1/1778063220000/tetris.png)

## Walkthrough - choose from a database table

You are advised to use a [Database Picker](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/database-picker) field rather than this method.  
A database picker has much greater control over the rendering and validation etc.  
The information below preceded the release of Database Picker fields.

In this example we’ll configure the picker to read from a database query. You would use this if you can get read-only access to the target database and there is no suitable REST API. For example, allowing the selection of a customer name where the customer list is in a CRM database.

The example worked through here reads the JiraEventType table from the current Jira. This is pointless, but is used because it’s something you will be able to test with, and is almost identical to querying any other database.

You can also use a [Database Picker](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/database-picker) field to do this.

1.  Configure a REST endpoint using the following code:
    
    This script is compatible with ScriptRunner version 10.x and above.
    
    ```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.config.database.DatabaseConfigurationManager
import com.atlassian.jira.config.database.JdbcDatasource
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.json.JsonBuilder
import groovy.sql.GroovyRowResult
import groovy.sql.Sql
import groovy.transform.BaseScript

import jakarta.ws.rs.core.MultivaluedMap
import jakarta.ws.rs.core.Response
import java.sql.Driver

@BaseScript CustomEndpointDelegate delegate

eventTypes(httpMethod: "GET") { MultivaluedMap queryParams ->

    def query = queryParams.getFirst("query") as String
    def rt = [:]

    def datasource = ComponentAccessor.getComponent(DatabaseConfigurationManager).getDatabaseConfiguration().getDatasource() as JdbcDatasource
    def driver = Class.forName(datasource.getDriverClassName()).newInstance() as Driver

    def props = new Properties()
    props.setProperty("user", datasource.getUsername())
    props.setProperty("password", datasource.getPassword())

    def conn = driver.connect(datasource.getJdbcUrl(), props)
    def sql = new Sql(conn) // <1>

    try {
        sql
        def rows = sql.rows("select name from jiraeventtype where name ilike ?", ["%${query}%".toString()]) // <2>

        rt = [
            items : rows.collect { GroovyRowResult row ->
                [
                    value: row.get("name"),
                    html : row.get("name").replaceAll(/(?i)$query/) { "<b>${it}</b>" },
                    label: row.get("name"),
                ]
            },
            total : rows.size(),
            footer: "Choose event type... "
        ]

    } finally {
        sql.close()
        conn.close()
    }

    return Response.ok(new JsonBuilder(rt).toString()).build()
}
```
    
      
    
    This script is compatible with ScriptRunner versions 8.x to 9.x.
    
    ```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.config.database.DatabaseConfigurationManager
import com.atlassian.jira.config.database.JdbcDatasource
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.json.JsonBuilder
import groovy.sql.GroovyRowResult
import groovy.sql.Sql
import groovy.transform.BaseScript

import javax.ws.rs.core.MultivaluedMap
import javax.ws.rs.core.Response
import java.sql.Driver

@BaseScript CustomEndpointDelegate delegate

eventTypes(httpMethod: "GET") { MultivaluedMap queryParams ->

    def query = queryParams.getFirst("query") as String
    def rt = [:]

    def datasource = ComponentAccessor.getComponent(DatabaseConfigurationManager).getDatabaseConfiguration().getDatasource() as JdbcDatasource
    def driver = Class.forName(datasource.getDriverClassName()).newInstance() as Driver

    def props = new Properties()
    props.setProperty("user", datasource.getUsername())
    props.setProperty("password", datasource.getPassword())

    def conn = driver.connect(datasource.getJdbcUrl(), props)
    def sql = new Sql(conn) // <1>

    try {
        sql
        def rows = sql.rows("select name from jiraeventtype where name ilike ?", ["%${query}%".toString()]) // <2>

        rt = [
            items : rows.collect { GroovyRowResult row ->
                [
                    value: row.get("name"),
                    html : row.get("name").replaceAll(/(?i)$query/) { "<b>${it}</b>" },
                    label: row.get("name"),
                ]
            },
            total : rows.size(),
            footer: "Choose event type... "
        ]

    } finally {
        sql.close()
        conn.close()
    }

    return Response.ok(new JsonBuilder(rt).toString()).build()
}
```
    
      
    
    **Line 29**: Configure driver - see [connecting to databases](https://docs.adaptavist.com/sr4js/latest/features/resources/database-connection) for more information
    
    **Line 33**: The SQL statement which should use the provided  _search_  parameter. Note that  _ilike_  is specific to Postgres
    
    If you actually want to run a SQL query against the current Jira database you can use [this method](https://docs.adaptavist.com/sr4js/latest/features/resources/database-connection) instead.
    
2.  Verify that it works by opening:  
    `<jira-base-url>/rest/scriptrunner/latest/custom/eventTypes?query=work`
    
3.  Connect it to a text field in your behaviour initializer:  
    
    ```
        getFieldByName("TextFieldC").convertToMultiSelect([
            ajaxOptions: [
                url           : getBaseUrl() + "/rest/scriptrunner/latest/custom/eventTypes",
                query         : true,
                formatResponse: "general"
            ]
        ])
```
    
4.  Verify it works:
    
    ![](/sr4js/files/latest/543948833/543948822/1/1778063221000/db-picker.png)

## Walkthrough - pick issue from remote Jira

This example demonstrates linking a remote Jira issue with the current issue, but where the remote issue must match a JQL query (performed on the remote instance).

You are advised to use a [Remote Issue Picker](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/remote-issue-picker) field rather than this method.  
The information below preceded the release of Remote Issue Picker fields.

You might use this if you have an internal Jira and a customer-facing Jira, and you want to enforce selecting a remote issue which has the same _Customer_ as on the internal instance. For the walkthrough, we use Atlassian’s public-facing Jira instance, and restrict the remote issue list to issues affecting  _Bitbucket Server_  with the _Enterprise_ component.

1.  Set up a REST endpoint with the following code:
    
    This script is compatible with ScriptRunner version 10.x and above.
    
    ```
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.json.JsonBuilder
import groovy.transform.BaseScript
import groovyx.net.http.ContentType
import groovyx.net.http.HTTPBuilder
import groovyx.net.http.Method

import jakarta.ws.rs.core.MultivaluedMap
import jakarta.ws.rs.core.Response

@BaseScript CustomEndpointDelegate delegate

pickRemoteIssue { MultivaluedMap queryParams ->
    def query = queryParams.getFirst("query") as String

    def jqlQuery = "project = BSERV and component = Enterprise" // <1>

    def httpBuilder = new HTTPBuilder("https://jira.atlassian.com")

    def response = httpBuilder.request(Method.GET, ContentType.JSON) {
        uri.path = "/rest/api/2/issue/picker"
        uri.query = [currentJQL: jqlQuery, query: query, showSubTasks: true, showSubTaskParent: true]

        response.failure = { resp, reader ->
            log.warn("Failed to query JIRA API: " + reader.errorMessages)
            return
        }
    }

    response.sections.each { section ->
        section.issues.each {
            // delete the image tag, because the issue picker is hard-coded
            // to prepend the current instance base URL.
            it.remove("img")
        }
    }

    return Response.ok(new JsonBuilder(response).toString()).build()
}
```
    
      
    
    This script is compatible with ScriptRunner versions 8.x to 9.x.
    
    ```
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.json.JsonBuilder
import groovy.transform.BaseScript
import groovyx.net.http.ContentType
import groovyx.net.http.HTTPBuilder
import groovyx.net.http.Method

import javax.ws.rs.core.MultivaluedMap
import javax.ws.rs.core.Response

@BaseScript CustomEndpointDelegate delegate

pickRemoteIssue { MultivaluedMap queryParams ->
    def query = queryParams.getFirst("query") as String

    def jqlQuery = "project = BSERV and component = Enterprise" // <1>

    def httpBuilder = new HTTPBuilder("https://jira.atlassian.com")

    def response = httpBuilder.request(Method.GET, ContentType.JSON) {
        uri.path = "/rest/api/2/issue/picker"
        uri.query = [currentJQL: jqlQuery, query: query, showSubTasks: true, showSubTaskParent: true]

        response.failure = { resp, reader ->
            log.warn("Failed to query JIRA API: " + reader.errorMessages)
            return
        }
    }

    response.sections.each { section ->
        section.issues.each {
            // delete the image tag, because the issue picker is hard-coded
            // to prepend the current instance base URL.
            it.remove("img")
        }
    }

    return Response.ok(new JsonBuilder(response).toString()).build()
}
```
    
      
    
    **Line 16:** Constraint query - optionally you could specify it in the  `ajaxOptions`  code for better reusability
    
    Your Jira server must allow HTTP connections outwards…​ you may need to configure your  _httpProxy_  settings.
    
2.  Verify this works by opening this URL in your browser: `<jira-base-url>/rest/scriptrunner/latest/custom/pickRemoteIssue?query=branch`
    
3.  You should see the sub-list of issues from the JQL query that contain the word  _branch_  in the summary.
4.  Configure your behaviour initializer to use this endpoint:
    
    ```
        getFieldByName("TextFieldD").convertToMultiSelect([
            ajaxOptions: [
                url           : getBaseUrl() + "/rest/scriptrunner/latest/custom/pickRemoteIssue",
                query         : true,
                formatResponse: "issue"
            ]
        ])
```
    
    ```
getFieldByName("TextFieldD").convertToMultiSelect([ ajaxOptions: [ url : getBaseUrl() + "/rest/scriptrunner/latest/custom/pickRemoteIssue", query: true, formatResponse: "issue" ] ])
```
    
5.  Should result in something like:  
    ![](/sr4js/files/latest/543948833/543948825/1/1778063220000/pick-remote-issue+%281%29.png)

This works because _[jira.atlassian.com](http://jira.atlassian.com)_ allows anonymous querying. If you have an application link set up between the two instances you will be better off using that to execute the remote requests, as it will allow impersonation of the current user.

## Pick Confluence space

You are advised to use an [Issue Picker](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/issue-picker) Custom Picker field rather than this method.  
The information below preceded the release of Custom Picker fields.

This example uses the Confluence remote API to search for a space.

You must have a working application link to Confluence for this to work.

Note that the searching uses the same logic as when you search in the Confluence  _space directory_, and searches on space name, description and label. You need to type a complete word from any one of these to get the correct results.

REST endpoint code:

This script is compatible with ScriptRunner version 10.x and above.

```
import com.atlassian.applinks.api.ApplicationLink
import com.atlassian.applinks.api.ApplicationLinkService
import com.atlassian.applinks.api.application.confluence.ConfluenceApplicationType
import com.atlassian.sal.api.component.ComponentLocator
import com.atlassian.sal.api.net.Request
import com.atlassian.sal.api.net.Response as SalResponse
import com.atlassian.sal.api.net.ResponseException
import com.atlassian.sal.api.net.ResponseHandler
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.json.JsonBuilder
import groovy.json.JsonSlurper
import groovy.transform.BaseScript
import org.apache.commons.lang3.StringUtils

import jakarta.ws.rs.core.MultivaluedMap
import jakarta.ws.rs.core.Response

@BaseScript CustomEndpointDelegate delegate

listConfluenceSpaces { MultivaluedMap queryParams ->

    def query = queryParams.getFirst("query") as String

    def applicationLinkService = ComponentLocator.getComponent(ApplicationLinkService)
    def ApplicationLink confluenceLink = applicationLinkService.getPrimaryApplicationLink(ConfluenceApplicationType)

    assert confluenceLink
    def authenticatedRequestFactory = confluenceLink.createImpersonatingAuthenticatedRequestFactory()

    def confResponse = null

    authenticatedRequestFactory
        .createRequest(Request.MethodType.GET, "rest/spacedirectory/1/search.json?query=${URLEncoder.encode(query)}&type=global&status=current")
        .addHeader("Content-Type", "application/json")
        .execute(new ResponseHandler<SalResponse>() {
            @Override
            void handle(SalResponse response) throws ResponseException {
                confResponse = new JsonSlurper().parse(response.getResponseBodyAsStream())
            }
        })

    def rt = [
        items : confResponse.spaces.collect { space ->

            def html = "${space.key} (${space.name})"
            if (query) {
                html = html.replaceAll(/(?i)$query/) { "<b>${it}</b>" }
            }

            [
                value: space.label,
                html : html,
                label: space.key,
                icon : space.logo.href,

            ]
        },
        total : confResponse.totalSize,
        footer: "Choose Confluence space...",
    ]

    return Response.ok(new JsonBuilder(rt).toString()).build()
}
```

This script is compatible with ScriptRunner versions 8.x to 9.x.

```
import com.atlassian.applinks.api.ApplicationLink
import com.atlassian.applinks.api.ApplicationLinkService
import com.atlassian.applinks.api.application.confluence.ConfluenceApplicationType
import com.atlassian.sal.api.component.ComponentLocator
import com.atlassian.sal.api.net.Request
import com.atlassian.sal.api.net.Response as SalResponse
import com.atlassian.sal.api.net.ResponseException
import com.atlassian.sal.api.net.ResponseHandler
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.json.JsonBuilder
import groovy.json.JsonSlurper
import groovy.transform.BaseScript
import org.apache.commons.lang3.StringUtils

import javax.ws.rs.core.MultivaluedMap
import javax.ws.rs.core.Response

@BaseScript CustomEndpointDelegate delegate

listConfluenceSpaces { MultivaluedMap queryParams ->

    def query = queryParams.getFirst("query") as String

    def applicationLinkService = ComponentLocator.getComponent(ApplicationLinkService)
    def ApplicationLink confluenceLink = applicationLinkService.getPrimaryApplicationLink(ConfluenceApplicationType)

    assert confluenceLink
    def authenticatedRequestFactory = confluenceLink.createImpersonatingAuthenticatedRequestFactory()

    def confResponse = null

    authenticatedRequestFactory
        .createRequest(Request.MethodType.GET, "rest/spacedirectory/1/search.json?query=${URLEncoder.encode(query)}&type=global&status=current")
        .addHeader("Content-Type", "application/json")
        .execute(new ResponseHandler<SalResponse>() {
            @Override
            void handle(SalResponse response) throws ResponseException {
                confResponse = new JsonSlurper().parse(response.getResponseBodyAsStream())
            }
        })

    def rt = [
        items : confResponse.spaces.collect { space ->

            def html = "${space.key} (${space.name})"
            if (query) {
                html = html.replaceAll(/(?i)$query/) { "<b>${it}</b>" }
            }

            [
                value: space.label,
                html : html,
                label: space.key,
                icon : space.logo.href,

            ]
        },
        total : confResponse.totalSize,
        footer: "Choose Confluence space...",
    ]

    return Response.ok(new JsonBuilder(rt).toString()).build()
}
```

  

Behaviour initializer code:  

```
        getFieldByName("TextFieldE").convertToMultiSelect([
            ajaxOptions: [
                url           : getBaseUrl() + "/rest/scriptrunner/latest/custom/listConfluenceSpaces",
                query         : true,
                formatResponse: "general"
            ]
        ])
```

Should result in something like:

![](/sr4js/files/latest/543948833/543948826/1/1778063220000/pick-confl-space.png)

### Dynamically changing the picker query

Advanced ScriptRunner skills required for this example.

In the first example we saw how you could turn a text field into a dropdown that allowed users to pick an issue from the results of a JQL query that we set once, in the initializer.

Great, but what if the validation query should be formed based on other inputs? That is to say, what if you needed the user to link to an issue from different JQL queries, depending on what other information was present on the form?

In this simple example we will work through, the form has a project-picker custom field, and a text field that will take the value of an issue the user selects. The JQL query needs to be of the form  `project = <selectedProject> and …​`.

In our example, the project picker has the name `ProjectPicker`, and the field that will be converted to an issue-picking single select has the name `TextFieldA`.

To do this, we don’t use an initializer - instead we add an _on change_ server-side script that will convert `TextFieldA` to a single-select issue picker - the JQL query will be formed from the value of the ProjectPicker field.

![](/sr4js/files/latest/543948833/543948828/1/1778063220000/reconvert.png)

Add code similar to this to the project picker field, or whatever are the inputs that should drive the JQL query:  

```
        def selectedProject = getFieldById(getFieldChanged()).value as Project
        def jqlSearchField = getFieldByName("TextFieldA")

        if (selectedProject) {
            jqlSearchField.setReadOnly(false).setDescription("Select an issue in the ${selectedProject.name} project")

            jqlSearchField.convertToSingleSelect([
                ajaxOptions: [
                    url           : getBaseUrl() + "/rest/scriptrunner-jira/latest/issue/picker",
                    query         : true,

                    data          : [
                        currentJql: "project = ${selectedProject.key} ORDER BY key ASC", // <1>
                        label     : "Pick high priority issue in ${selectedProject.name} project",
                    ],
                    formatResponse: "issue"
                ],
                css        : "max-width: 500px; width: 500px",
            ])
        } else {
            // selected project was null - disable control
            jqlSearchField.convertToShortText()
            jqlSearchField.setReadOnly(true).setDescription("Please select a project before entering the issue")
        }
```

**Line 13:** Build JQL query based on other field inputs

You may notice the value of the issue picker is not cleared if it becomes invalid for the new JQL query. The best solution to this is to add an _on change_ validator for the issue picker field. Alternatively, you could add a workflow validator if this is on a workflow function.

So, when the project picker is changed and it makes the selected issue invalid, you will see:

![](/sr4js/files/latest/543948833/543948827/1/1778063220000/reconvert-invalid.png)

This is done by adding the following server-side script for the issue picker field, in our case called `TextFieldA`:  

```
        def selectedIssueField = getFieldById(getFieldChanged())
        def selectedIssue = selectedIssueField.value as String
        log.debug("selectedIssue changed: ${selectedIssue}")
        def selectedProject = getFieldByName("ProjectPicker").value as Project

        if (selectedIssue && selectedProject) {

            def jqlQueryBuilder = JqlQueryBuilder.newBuilder()
            def searchService = ComponentAccessor.getComponent(SearchService)
            def user = ComponentAccessor.jiraAuthenticationContext.getLoggedInUser()

            def query = jqlQueryBuilder.where().project(selectedProject.id).and().issue(selectedIssue).buildQuery() // <1>
            if (searchService.searchCount(user, query) == 1) { // <2>
                selectedIssueField.clearError()
            } else {
                selectedIssueField.setError("Issue not found in the selected project")
            }
        }
```

**Line 12**: Build a query corresponding to that used for the picker

**Line 13**: Check the currently selected issue is found in that query
