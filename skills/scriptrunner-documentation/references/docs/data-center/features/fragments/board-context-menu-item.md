# Board Context Menu Item

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > fragments
- Doc ID: doc-sr4js-443373670
- Source: https://docs.adaptavist.com/sr4js/latest/features/fragments/board-context-menu-item

This is a variation of a [web item](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-item), that allows you to place a menu item in the _context menu_ (right-click) of issues in a _Scrum_ or _Kanban_ board.

![](/sr4js/files/latest/443373670/443373667/1/1758886178000/context-menu-items.png)

As with other web items you have the option of calling a REST endpoint which can cause a flag or dialog to be displayed (or have no visible output), or linking to another page.

Examples of usage might be to set a specific label on the selected issue(s), or run them through a workflow transition with hard-coded field updates.

You can also add commonly-used actions that are available through the _"dot"_ menu to the context menu, for example _Create sub-task_, _Clone issue_, and so on.

You can restrict whether the context menu item appears on issues in _active_ sprints, future _planned_ sprints, the _backlog_, or all three.

Currently the position of the context menu items is fixed - they will always appear in a new section above _Print selected card_. Contact us if you want more control over the positioning.

### Walkthrough

We will add a menu item with a pre-defined label to any selected issues. In your business process, this may signify that some review has happened. You could also configure the board to drive the card colors from JQL queries selecting this label, which would make it more apparent which cards had been labelled.

1.  From ScriptRunner **UI Fragments > Create Fragment > Planning board context menu item**.
2.  Fill the form out as shown:  
    ![](/sr4js/files/latest/443373670/443373669/1/1758886178000/Board_context_example.png)  
    The link points to a [REST endpoint](https://docs.adaptavist.com/sr4js/latest/features/rest-endpoints) that we have created previously. The code for this is shown below:
    
    The issue keys of the selected issue keys will be passed to the endpoint in the `issueKeys` parameter. This will always be an array, even if a single item is selected.
    
      
    
    This script is compatible with ScriptRunner version 10.x and above.
    
    ```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.label.LabelManager
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.json.JsonOutput
import groovy.transform.BaseScript

import jakarta.ws.rs.core.MultivaluedMap
import jakarta.ws.rs.core.Response

@BaseScript CustomEndpointDelegate delegate

def labelManager = ComponentAccessor.getComponent(LabelManager)
def jiraAuthenticationContext = ComponentAccessor.jiraAuthenticationContext
def issueManager = ComponentAccessor.issueManager

ghAddLabel(httpMethod: "GET") { MultivaluedMap queryParams ->
    def issueKeys = queryParams.get("issueKeys") as List<String>
    def issues = issueKeys.collect { issueManager.getIssueObject(it) }

    issues.each {
        labelManager.addLabel(jiraAuthenticationContext.loggedInUser, it.id, "red", false)
    }

    def flag = [
        type : 'success',
        title: "Label Added",
        close: 'auto',
        body : "This issue has been approved for release"
    ]

    Response.ok(JsonOutput.toJson(flag)).build()
}
```
    
    This script is compatible with ScriptRunner versions 8.x to 9.x.
    
    ```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.label.LabelManager
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.json.JsonOutput
import groovy.transform.BaseScript

import javax.ws.rs.core.MultivaluedMap
import javax.ws.rs.core.Response

@BaseScript CustomEndpointDelegate delegate

def labelManager = ComponentAccessor.getComponent(LabelManager)
def jiraAuthenticationContext = ComponentAccessor.jiraAuthenticationContext
def issueManager = ComponentAccessor.issueManager

ghAddLabel(httpMethod: "GET") { MultivaluedMap queryParams ->
    def issueKeys = queryParams.get("issueKeys") as List<String>
    def issues = issueKeys.collect { issueManager.getIssueObject(it) }

    issues.each {
        labelManager.addLabel(jiraAuthenticationContext.loggedInUser, it.id, "red", false)
    }

    def flag = [
        type : 'success',
        title: "Label Added",
        close: 'auto',
        body : "This issue has been approved for release"
    ]

    Response.ok(JsonOutput.toJson(flag)).build()
}
```
    
      
    
      
    
3.  Select **Add**.
4.  On clicking on the new context menu item (if you don’t see it double-check the issue is in an _active_ sprint), the issue will be labelled, and a flag will appear.  
    ![](/sr4js/files/latest/443373670/443373665/1/1758886178000/context-menu-item-output.png)

### Conditions

Unlike other web item conditions, these receive a `List` of `com.atlassian.jira.issue.Issue` objects in the script binding. This is because you can multi-select issues and then right-click.

So, if we wanted a condition where the item above would only appear if all the selected issues didn’t have the label `red`, we would write it as follows:

```
issues.every { !it.labels*.label.contains('red') }
```

There are further examples shown on the configuration page. As always, you can see all available _binding variables_ by clicking the question mark icon under the script box.

### Actions that invoke built-in dialogs

For actions that invoke one of Jira’s built-in dialogs, such as _Create sub-task_, there is no need to provide a link - indeed the link will be hidden in the configuration page.

You can provide a condition, but we will automatically apply relevant conditions - for instance if the issue is already a sub-task, the _Create sub-task_ item will not appear. Likewise if you are already _watching_ an issue, the _Watch Issue_ item can’t be made to appear. Additionally, all of these actions will only be shown if only a **single** issue is selected.

This applies to all the actions shown below:

![](/sr4js/files/latest/443373670/443373666/1/1758886178000/built-in-dialog-actions.png)
