# Web Item Provider Built-In Script

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > fragments
- Doc ID: doc-sr4js-284328774
- Source: https://docs.adaptavist.com/sr4js/latest/features/fragments/web-item-provider-built-in-script

You have seen that we can add web items to new or existing web sections, and use conditions to determine whether they should be displayed for the current user, or issue, page etc.

However, if you want to dynamically generate web items according to the current circumstances, you need a _web item provider_. Official documentation is lacking, vote for [PLUGFRAG-17](https://ecosystem.atlassian.net/browse/PLUGFRAG-17).

Examples of a web item provider might be:

-   Show the top 5 issues for the current user in active sprints in the Issues top-level menu
    
-   Show a web item in the More Actions menu for each of the current issue’s subtasks
    

## Usage

First of all, let’s look at a simple example. For the web item provider, you must either provider a class that implements `com.atlassian.plugin.web.api.provider.WebItemProvider` or, more simply, a script that returns a collection of `com.atlassian.plugin.web.api.WebItem`.

Using the `com.atlassian.plugin.web.model.WebFragmentBuilder` import is the easiest way to create a WebItem collection.

Set up the fragment like in the following screen capture:

![](/sr4js/files/latest/284328774/288718867/1/1726566639000/Screenshot+2024-09-17+at+10.50.19.png)

The provider class/script can either be under a script root or inline. Here is a simple example:

```
import com.atlassian.plugin.web.model.WebFragmentBuilder

["Foo", "Bar", "Quz"].collect {
    new WebFragmentBuilder(50). // <1>
        id("sample-web-item-${it.toLowerCase()}"). // <2>
        label("$it Sample Web Item").
        title("$it Sample Web Item Title").
        styleClass("").
        addParam("data-my-key", "data-value"). // <3>
        addParam("iconUrl", "/jira/images/icons/priorities/highest.svg"). // not all places will show icons
        webItem(""). // <4>
        url("/").
        build()
}
```

**Line 4:** The 50 refers to the _weight_ of the item

**Line 5:** Give each web item a unique ID

**Line 9:** Additional data element items

**Line 11:** This parameter refers to the section, but it’s defined by the section for the context provider itself. i.e. it uses the section you choose in the 'Custom web item provider' form, so you can leave this blank as an empty string.

There are a couple of shortcuts in this script that can be confusing. No `return` statements are used (as the result of the last statement is returned in groovy). So the `collect` returns the web items.

### Example: My Top Issues

I often find I am distracted by email, instant messaging etc, and that Jira doesn’t always get me back on track. This example is supposed to provide a quick cue by displaying the most important issues I should be working on, where _most important_ is defined as the top five issues assigned to the current user in active sprints, ordered by rank. The finished result looks like:

![](/sr4js/files/latest/284328774/284328773/1/1725268147000/my-top-issues.png)

There are two parts to this - one is a web item provider which will run the query, fetching at most 5 results, and return them as web items. The other is a new section in the _Issues_ menu to add them to. The web section is configured like so:

![](/sr4js/files/latest/284328774/284328765/1/1725268148000/Web_item_provider_example.png)

The web item provider:

![](/sr4js/files/latest/284328774/284328766/1/1725268148000/web_item_2.png)

The code to generate the web items:

```
import com.atlassian.jira.bc.issue.search.SearchService
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.jql.parser.JqlQueryParser
import com.atlassian.jira.security.JiraAuthenticationContext
import com.atlassian.jira.util.velocity.VelocityRequestContextFactory
import com.atlassian.jira.web.bean.PagerFilter
import com.atlassian.plugin.web.model.WebFragmentBuilder

def jqlQueryParser = ComponentAccessor.getComponent(JqlQueryParser)
def query = jqlQueryParser.parseQuery("assignee = currentUser() and resolution is EMPTY and sprint in openSprints() order by rank")

def searchService = ComponentAccessor.getComponent(SearchService)
def jiraAuthenticationContext = ComponentAccessor.getComponent(JiraAuthenticationContext)
def searchResults = searchService.search(jiraAuthenticationContext.getLoggedInUser(), query, new PagerFilter(0, 5)) // <1>

def velocityRequestContextFactory = ComponentAccessor.getComponent(VelocityRequestContextFactory)
def requestContext = velocityRequestContextFactory.getJiraVelocityRequestContext()
def baseUrl = requestContext.getBaseUrl()

searchResults.results.collect { issue ->
    def issueLabel = "${issue.key} ${issue.summary}"

    String iconUrl = issue.issueType.iconUrl
    if (!iconUrl.startsWith("http://") && !iconUrl.startsWith("https://")) {
        iconUrl = baseUrl + iconUrl
    }
    new WebFragmentBuilder(50).
        id("sample-web-item-${issue.key.toLowerCase()}").
        label(issueLabel).
        title(issueLabel).
        styleClass("").
        addParam("class", "issue-link").
        addParam("data-issue-key", issue.getKey()).
        addParam("iconUrl", iconUrl).
        webItem("").
        url(baseUrl + "/browse/" + issue.getKey()).
        build()
}
```

  

**Line 14:** Get at most 5 issues
