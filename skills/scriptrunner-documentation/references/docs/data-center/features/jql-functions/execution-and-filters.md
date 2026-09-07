# Execution and Filters

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > jql-functions
- Doc ID: doc-sr4js-442889140
- Source: https://docs.adaptavist.com/sr4js/latest/features/jql-functions/execution-and-filters

## Executing

The code below demonstrates how to execute a JQL query, which may be useful in a validator or post-function etc. This code can also be tested from the Script Console.

```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.bc.issue.search.SearchService
import com.atlassian.jira.jql.parser.JqlQueryParser
import com.atlassian.jira.web.bean.PagerFilter

def jqlQueryParser = ComponentAccessor.getComponent(JqlQueryParser)
def searchService = ComponentAccessor.getComponent(SearchService)
def issueManager = ComponentAccessor.getIssueManager()
def user = ComponentAccessor.getJiraAuthenticationContext().getLoggedInUser()

// edit this query to suit
def query = jqlQueryParser.parseQuery("project = JRA and assignee = currentUser()")

def search = searchService.search(user, query, PagerFilter.getUnlimitedFilter())

log.debug("Total issues: ${search.total}")

search.results.each { documentIssue ->
    log.debug(documentIssue.key)

    // if you need a mutable issue you can do:
    def issue = issueManager.getIssueObject(documentIssue.id)

    // do something to the issue...
    log.debug(issue.summary)
}
```

### Creating and Sharing

This code demonstrates how to create, save, and share a _saved filter_:

```
import com.atlassian.jira.bc.JiraServiceContextImpl
import com.atlassian.jira.bc.filter.SearchRequestService
import com.atlassian.jira.bc.issue.search.SearchService
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.search.SearchRequest
import com.atlassian.jira.sharing.SharePermissionImpl
import com.atlassian.jira.sharing.SharedEntity
import com.atlassian.jira.sharing.type.ShareType
import com.atlassian.sal.api.component.ComponentLocator

def searchRequestService = ComponentLocator.getComponent(SearchRequestService)
def user = ComponentAccessor.jiraAuthenticationContext?.getLoggedInUser()
def searchService = ComponentAccessor.getComponent(SearchService)

def serviceContext = new JiraServiceContextImpl(user)

def parseResult = searchService.parseQuery(user, "project = JRA")
if (parseResult.isValid()) {

    // create the search request
    def query = parseResult.query
    def searchRequest = new SearchRequest(query, user, "My filter", "Some description")

    // set shares
    def sharePerm = new SharePermissionImpl(null, ShareType.Name.GROUP, "jira-administrators", null)
    searchRequest.setPermissions(new SharedEntity.SharePermissions([sharePerm] as Set))

    // store the search request
    searchRequestService.createFilter(serviceContext, searchRequest)
}
```
