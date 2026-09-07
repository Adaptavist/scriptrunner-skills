# Dashboard and Gadgets

- Platform: data-center
- Space: SR4JS
- Hierarchy: best-practices
- Doc ID: doc-sr4js-442889206
- Source: https://docs.adaptavist.com/sr4js/latest/best-practices/dashboard-and-gadgets

Enterprise Jira users often need to automatically generate dashboards with gadgets, to provide a consistent management-level overview of progress. These could be created either on demand, or automatically in response to version or project-created events.

Some gadgets take a JQL string, but others require a saved filter, so you may also need to generate one or more saved filters at the same time as creating a dashboard. Take care that you share both the dashboard and any dependent saved filters with your target users - in the example we share it globally.

The secret to perfecting this is (as always) to start small and work with a simple script in the Script Console. Once that’s working you can wire it to events such as version created/resolved etc using a [Script Listener](https://docs.adaptavist.com/sr4js/latest/features/listeners/custom-listener).

Start by creating a template dashboard using the normal UI. When you are happy you can run the following script, which will dump the configuration of the dashboard to the console. Make sure you start with only a single gadget to keep things simple.

```
import com.atlassian.jira.bc.JiraServiceContext
import com.atlassian.jira.bc.JiraServiceContextImpl
import com.atlassian.jira.bc.portal.PortalPageService
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.portal.PortletConfiguration
import groovy.json.JsonOutput
import groovy.xml.MarkupBuilder

def user = ComponentAccessor.jiraAuthenticationContext.getLoggedInUser()
JiraServiceContext sourceUserServiceCtx = new JiraServiceContextImpl(user)
def portalPageService = ComponentAccessor.getComponent(PortalPageService)

def dashId = 10203L // <1>

def output = portalPageService.getPortletConfigurations(sourceUserServiceCtx, dashId).collect { col ->
    col.collect { PortletConfiguration gadget ->
        [
            row              : gadget.row,
            column           : gadget.column,
            color            : gadget.color,
            openSocialSpecUri: gadget.openSocialSpecUri.getOrNull().toString(),
            completeModuleKey: gadget.completeModuleKey.getOrNull().toString(),
            userPrefs        : gadget.userPrefs,
        ]
    }
}

def prettyOutput = JsonOutput.prettyPrint(JsonOutput.toJson(output))
log.debug(prettyOutput)

def writer = new StringWriter()
def builder = new MarkupBuilder(writer)
builder.pre(prettyOutput)
writer
```

**Line 13:** Change the dashboard ID to the one you want to inspect

Now, plug those values into the script below, and execute:

```
import io.atlassian.fugue.Option
import com.atlassian.gadgets.dashboard.Color
import com.atlassian.gadgets.dashboard.Layout
import com.atlassian.jira.bc.JiraServiceContext
import com.atlassian.jira.bc.JiraServiceContextImpl
import com.atlassian.jira.bc.portal.PortalPageService
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.search.SearchRequest
import com.atlassian.jira.issue.search.SearchRequestManager
import com.atlassian.jira.jql.parser.JqlQueryParser
import com.atlassian.jira.portal.PortalPage
import com.atlassian.jira.portal.PortletConfigurationManager
import com.atlassian.jira.sharing.SharedEntity

def user = ComponentAccessor.jiraAuthenticationContext.getLoggedInUser()
JiraServiceContext sourceUserServiceCtx = new JiraServiceContextImpl(user)

def portalPageService = ComponentAccessor.getComponent(PortalPageService)
def portletConfigurationManager = ComponentAccessor.getComponent(PortletConfigurationManager)
def searchRequestManager = ComponentAccessor.getComponent(SearchRequestManager)
def jqlQueryParser = ComponentAccessor.getComponent(JqlQueryParser)

def dashboardTemplate = new PortalPage.Builder()
    .name("My new dash")
    .description("Info....")
    .owner(user)
    .layout(Layout.AA)
    .permissions(SharedEntity.SharePermissions.GLOBAL) // <1>
    .build()

def query = jqlQueryParser.parseQuery("project = JRA") // <2>

// share filter globally
def templateSearchRequest = new SearchRequest(query, user, "JRA issues", "my description")
templateSearchRequest.setPermissions(SharedEntity.SharePermissions.GLOBAL)
def newSearchRequest = searchRequestManager.create(templateSearchRequest)

// note that portal page names must be unique per user
if (!portalPageService.validateForCreate(sourceUserServiceCtx, dashboardTemplate)) {
    return sourceUserServiceCtx.errorCollection
}

def targetDash = portalPageService.createPortalPage(sourceUserServiceCtx, dashboardTemplate)

portletConfigurationManager.addDashBoardItem(targetDash.id, 0, 0, // <3>
    Option.some(URI.create('rest/gadgets/1.0/g/com.atlassian.jira.gadgets:assigned-to-me-gadget/gadgets/assigned-to-me-gadget.xml')),
    Color.color1,
    [
        'isConfigured': 'true', // <4>
        'refresh'     : '15',
        'sortColumn'  : '',
        'columnNames' : 'issuetype|issuekey|summary|priority',
        'num'         : '10'
    ],
    Option.none()
)

portletConfigurationManager.addDashBoardItem(targetDash.id, 1, 0,
    Option.some(URI.create('rest/gadgets/1.0/g/com.atlassian.jira.gadgets:filter-results-gadget/gadgets/filter-results-gadget.xml')),
    Color.color2,
    [
        "filterId"    : newSearchRequest.id.toString(), // <5>
        'isConfigured': 'true',
        'refresh'     : 'false',
        "isPopup"     : "false",
        'columnNames' : 'issuetype|issuekey|summary|priority',
        'num'         : '10'
    ],
    Option.none() // <6>
)

log.debug("Created dashboard: $targetDash.id")
```

**Line 28:** Shared globally, change to suit

**Line 31:** Sample query - you could plug in versions from a VersionCreated event for instance

**Line 45:** Numbers are column and row position

**Line 49:** User configuration for the gadget - take from the dumped configuration

**Line 62:** Generated search request

**Line 69:** Module key - empty for built-in gadgets

This will create a new dashboard with two configured gadgets. You should end up with a new dashboard:

![](/sr4js/files/latest/442889206/442889217/1/1758747007000/gen-dash.png)

Jira doesn’t like it if you generate multiple dashboards for the same user with the exact same name. When testing delete the dashboard after each run.
