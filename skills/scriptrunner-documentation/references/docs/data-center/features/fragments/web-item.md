# Web Item

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > fragments
- Doc ID: doc-sr4js-443373649
- Source: https://docs.adaptavist.com/sr4js/latest/features/fragments/web-item

A web item is a button or link that appears at the location you choose.

Here are some things you can do with web items:

-   Redirect to another location
    
-   Invoke a script endpoint and run code, which can respond with:
    
    -   A flag
        
    -   A dialog
        
    -   A redirection to another page
        

## Examples

### Google Link Example

A basic example of a web item is a link to Google at the top of the navigation bar.

1.  From ScriptRunner, select **UI Fragments > Create Fragment**.
2.  Select **Custom web item**. 
3.  Fill out the web item form:  
    ![](/sr4js/files/latest/443373649/443373637/1/1758886168000/Web_item_google_1.png)
    
    You can understand the **Section** field’s values by reading the [Atlassian web item documentation](https://developer.atlassian.com/confdev/confluence-plugin-guide/confluence-plugin-module-types/web-ui-modules), or you can use the [Fragment locator](https://docs.adaptavist.com/sr4js/latest/features/fragments#fragment-locator) tool.
    
    The **[Weight](https://developer.atlassian.com/server/confluence/web-item-plugin-module/#:~:text=Default%3A%C2%A0false.-,weight,-Determines%20the%20order)** field determines the placement of the web item. If you set it to _1,_ the link becomes the first item on the left.
    
    Weight field
    
    For some locations, setting the **Weight** to a number below 9 may cause existing Atlassian elements to be overwritten. If an issue is found, increasing the weight value will likely resolve the problem.
    
4.  Select **Add** to register the fragment.
    
5.  Go to the dashboard in a new tab, and see your new link.
    
6.  Select the link to go to Google.  
    ![](/sr4js/files/latest/443373649/443373642/1/1758886168000/Web_item_example_2.png)
    

### Tools menu link

Next we’ll try to add a link to Jira issues _More Actions_ menu, which will do a Google search on the current issue summary.

Create a new web item or change the values to the following:

![](/sr4js/files/latest/443373649/443373645/1/1758886168000/Search_web_for_issue.png)

The Link used in this example is `https://www.google.com/search?q=${issue.summary}`.

You should now be able to see this on the operations bar of any issue:

![](/sr4js/files/latest/443373649/443373640/1/1758886168000/Tools_menu_link_2.png)

Note that the URL is processed with velocity before rendering. The variables you can use depend on the context of the Web Item.

-   `issue` \- an [Issue](https://docs.atlassian.com/jira/server/com/atlassian/jira/issue/Issue.html) object
    
-   `jiraHelper` \- a [JiraHelper](https://docs.atlassian.com/jira/server/com/atlassian/jira/plugin/webfragment/model/JiraHelper.html) object
    

If you don’t change the **key**, the module from the first part of the tutorial will be overwritten.

### REST endpoints for web item integration

#### Basic approval endpoint

The following endpoint provides a simple approval mechanism that returns a JSON flag response:

-   You can add this endpoint using the [REST Endpoints](https://docs.adaptavist.com/sr4js/latest/features/rest-endpoints) feature.
-   You can access the endpoint using the following URL pattern:  
    `http://<jira-base-url>/rest/scriptrunner/latest/custom/approve?issueId=12345`

This script is compatible with ScriptRunner version 10.x and above.

```
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.json.JsonOutput
import groovy.transform.BaseScript

import jakarta.ws.rs.core.MultivaluedMap
import jakarta.ws.rs.core.Response

@BaseScript CustomEndpointDelegate delegate

approve(httpMethod: "GET") { MultivaluedMap queryParams ->

    // the details of getting and modifying the current issue are omitted for brevity
    // def issueId = queryParams.getFirst("issueId") as Long // use the issueId to retrieve this issue

    def flag = [
        type : 'success',
        title: "Issue approved",
        close: 'auto',
        body : "This issue has been approved for release"
    ]

    Response.ok(JsonOutput.toJson(flag)).build()
}
```

This script is compatible with ScriptRunner versions 8.x to 9.x.

```
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.json.JsonOutput
import groovy.transform.BaseScript

import javax.ws.rs.core.MultivaluedMap
import javax.ws.rs.core.Response

@BaseScript CustomEndpointDelegate delegate

approve(httpMethod: "GET") { MultivaluedMap queryParams ->

    // the details of getting and modifying the current issue are omitted for brevity
    // def issueId = queryParams.getFirst("issueId") as Long // use the issueId to retrieve this issue

    def flag = [
        type : 'success',
        title: "Issue approved",
        close: 'auto',
        body : "This issue has been approved for release"
    ]

    Response.ok(JsonOutput.toJson(flag)).build()
}
```

  

Expected response:

```
{
  "type": "success",
  "title": "Issue approved",
  "close": "auto", 
  "body": "This issue has been approved for release"
}
```

##### Considerations for production use:

-   Authorization: Limit approval access to specific groups or project roles
-   Conditional display: Hide the menu item for already approved issues

To address these considerations, we'll explore the use of Conditions in the following section.

#### Conditions

Conditions determine the visibility of web item links based on context and user details. The available context depends on the web section and the page where the item appears.

In Jira, you have access to a `jiraHelper` object (an instance of [`JiraHelper`](https://docs.atlassian.com/software/jira/docs/api/7.1.4/com/atlassian/jira/plugin/webfragment/model/JiraHelper.html)) which provides methods to retrieve current project information. If the context includes an issue, it's bound as the 'issue' variable in the script. This allows reuse of conditions from workflow functions and other areas.

For example, to show an "Approve" menu item only when the current issue doesn't have an "approved" label, you could use this condition:

```
! ("approved" in issue.labels*.label)
```

This condition can be entered inline or written to a file under a script root.

It's crucial to write conditions defensively, as the available context varies by web section and page. For instance, a link in the top navigation bar (`system.top.navigation.bar`) won't have access to the current issue.

In sections like `operations-top-level`, you can reliably assume the issue context variable is defined.

As well as using a _script_, you can use a concrete class that implements [`Condition`](https://developer.atlassian.com/static/javadoc/plugins/latest/reference/com/atlassian/plugin/web/Condition.html). Why would you want to do this? Because you may wish to extend your own existing `Condition`, or one provided by the application.

#### Dialogs endpoint (Advanced)

While ScriptRunner supports showing dialogs when a user clicks a web item, complex interactions may require custom JavaScript. To display a dialog, select the **Run code and display a dialog** option when configuring your web item. The associated endpoint should return HTML for an AUI [dialog2](https://docs.atlassian.com/aui/latest/docs/dialog2.html).

Here's an example of a REST endpoint that displays a dialog:

You can add this endpoint using the [REST Endpoints](https://docs.adaptavist.com/sr4js/latest/features/rest-endpoints) feature.

```
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.transform.BaseScript

import jakarta.ws.rs.core.MediaType
import jakarta.ws.rs.core.MultivaluedMap
import jakarta.ws.rs.core.Response

@BaseScript CustomEndpointDelegate delegate

showDialog { MultivaluedMap queryParams ->

    // get a reference to the current page...
    // def page = getPage(queryParams)

    def dialog =
        """<section role="dialog" id="sr-dialog" class="aui-layer aui-dialog2 aui-dialog2-medium" aria-hidden="true" data-aui-remove-on-hide="true">
            <header class="aui-dialog2-header">
                <h2 class="aui-dialog2-header-main">Some dialog</h2>
                <a class="aui-dialog2-header-close">
                    <span class="aui-icon aui-icon-small aui-iconfont-close-dialog">Close</span>
                </a>
            </header>
            <div class="aui-dialog2-content">
                <p>This is a dialog...</p>
            </div>
            <footer class="aui-dialog2-footer">
                <div class="aui-dialog2-footer-actions">
                    <button id="dialog-close-button" class="aui-button aui-button-link">Close</button>
                </div>
                <div class="aui-dialog2-footer-hint">Some hint here if you like</div>
            </footer>
        </section>
        """

    Response.ok().type(MediaType.TEXT_HTML).entity(dialog.toString()).build()
}
```

This endpoint generates a basic AUI dialog2 structure. The dialog includes a header, content area, and footer with a close button. By using the ID `sr-dialog`, a button with the ID `dialog-close-button` is automatically configured to dismiss the dialog when clicked.

For more complex interactions, you'll need to implement custom JavaScript. Here's an example of how you might enhance dialog functionality:

```
(function ($) {
    $(function () {
		AJS.dialog2.on("show", function (e) {
			var targetId = e.target.id;
			if (targetId == "my-own-dialog") {
				var someDialog = AJS.dialog2(e.target);
				$(e.target).find("#dialog-close-button").click(function (e) {
					e.preventDefault();
					someDialog.hide();
					someDialog.remove();
				});
				// etc
			}
		});
    });
})(AJS.$);
```

-   The [data-aui-remove-on-hide](https://docs.atlassian.com/aui/latest/docs/dialog2.html#dialog-methods) attribute controls whether the dialog is removed from the DOM when hidden. Removing this attribute will only hide the dialog instead of removing it.
-   If you choose to only hide the dialog, you'll need to handle re-showing it in your JavaScript code. The web item trigger will create a new dialog instance each time it's activated.
-   You can include your additional JavaScript with a [web resource fragment](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-resource).

On clicking the link the dialog will display:

![](/sr4js/files/latest/443373649/443373646/1/1758886168000/show-dialog+%283%29.png)

#### Redirects endpoint

Redirects are useful when you want to execute some code and then navigate to another page or refresh the current one. This functionality is particularly handy for updating content and providing immediate visual feedback to users.

Here's an example that demonstrates how to add a label to an issue and then redirect to the updated issue page:

You can add this endpoint using the [REST Endpoints](https://docs.adaptavist.com/sr4js/latest/features/rest-endpoints) feature.

```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.label.LabelManager
import com.atlassian.sal.api.ApplicationProperties
import com.atlassian.sal.api.UrlMode
import com.onresolve.scriptrunner.runner.ScriptRunnerImpl
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import com.onresolve.scriptrunner.runner.util.UserMessageUtil
import groovy.transform.BaseScript

import jakarta.ws.rs.core.MultivaluedMap
import jakarta.ws.rs.core.Response

@BaseScript CustomEndpointDelegate delegate

def labelManager = ComponentAccessor.getComponent(LabelManager)
def applicationProperties = ScriptRunnerImpl.getOsgiService(ApplicationProperties)
def issueManager = ComponentAccessor.getIssueManager()
def user = ComponentAccessor.jiraAuthenticationContext?.loggedInUser

labelIssue(httpMethod: "GET") { MultivaluedMap queryParams ->

    def issueId = queryParams.getFirst("issueId") as Long
    def issue = issueManager.getIssueObject(issueId)

    labelManager.addLabel(user, issueId, "approved", false)
    UserMessageUtil.success("Issue approved")

    def baseUrl = applicationProperties.getBaseUrl(UrlMode.ABSOLUTE)
    Response.temporaryRedirect(URI.create("${baseUrl}/browse/${issue.key}")).build()
}
```

When creating your web item, make sure to select _Navigate to a link_ as the intention setting.

### Further examples

-   Displaying a message if a page is publicly visible ( [Atlassian Answers](https://answers.atlassian.com/questions/39421287/answers/39443357))
    
-   Showing recent projects from a particular project category ( [Atlassian Answers](https://answers.atlassian.com/questions/42676621/answers/42677710) )
