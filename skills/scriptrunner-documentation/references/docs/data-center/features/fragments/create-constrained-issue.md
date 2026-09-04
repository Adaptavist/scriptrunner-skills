# Create Constrained Issue

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > fragments
- Doc ID: doc-sr4js-288522322
- Source: https://docs.adaptavist.com/sr4js/latest/features/fragments/create-constrained-issue

A special case of a web item creates a menu item that will open the _Create Issue_ dialog with a predefined project, and optionally issue type.

This can be useful to workflow designers. Imagine a workflow where at one transition the user is required to create a new linked issue. Typically this is done by having a _self_ or _any to any_ transition which will create the linked issue with a post-function. Then the user is required to edit the linked issue further. This built-in script removes this action from the workflow, and allows the linked issue to be edited in the _create_ step.

Let’s go through an example:

In this example we set up a web item that will open the _Create Issue_ dialog to create a linked issue in another project

1.  Create the `tools-menu-additional` web section in `opsbar-operations`, as described in steps 1-2 on the [Web Section](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-section) page. 
2.  From ScriptRunner go to **UI Fragments > Create Fragment > Constrained create issue dialog**.
3.  Fill out the form as follows:  
    ![](/sr4js/files/latest/288522322/288522313/1/1726581414000/Create_contrained_issue_example.png)  
    Make sure you add the condition, which says the link will be displayed only for one project, and a particular status.
4.  If the condition is fulfilled **Create blocking...** appears:  
    ![](/sr4js/files/latest/288522322/288522314/1/1726581414000/Constrained_issue_2.png)  
    Selecting the link shows the **Create Issue** dialog with the selected project and issue type pre-filled:  
    ![](/sr4js/files/latest/288522322/288522321/1/1726581414000/Constrained_issue_3.png)
    
    The problem here is that the issue won’t be linked automatically. The solution is integration with Behaviours, as described below.
    

## Behaviours integration

A [Behaviour](https://docs.adaptavist.com/sr4js/latest/features/behaviours) is required to pre-fill the _Linked Issues_ field. We don’t want this behaviour to fire on every issue that it’s mapped to though. A behaviour script is able to get some information about how the create issue dialog was opened, which is the ID of the web item.

There are two API methods, that are available to all behaviours scripts, which facilitate this:

`getBehaviourContextId()` gets the ID of the web item that was clicked. In the example above it would be `link-create-blocking.getContextIssueId()` that gets the ID of the issue that was on the screen when the item was clicked.

`getBehaviourContextId()` and `getContextIssueId()` only work for constrained issue web items. These two APIs will return a null value if used with other web items

With these we can create a behaviour, with the following initializer function.

```
import com.atlassian.jira.component.ComponentAccessor

def issueManager = ComponentAccessor.getIssueManager()

if (getBehaviourContextId() == "link-create-blocking") {
    getFieldById("project-field").setReadOnly(true)
    getFieldById("issuetype-field").setReadOnly(true)

    def contextIssue = issueManager.getIssueObject(getContextIssueId())

    getFieldById("summary").setFormValue("Issue created from ${contextIssue.key}").setReadOnly(true)
    getFieldById("issuelinks-linktype").setFormValue("blocks").setReadOnly(true)
    getFieldById("issuelinks-issues").setFormValue(contextIssue.key).setReadOnly(true)
}
```

The behaviour must be mapped to the target project, but because you are checking the _context ID_, it won’t be fired when an issue is created in this project from the normal _Create_ button.

This behaviour sets the link direction, and the linked issue. It also sets the summary and makes several fields read-only as you can see:

![](/sr4js/files/latest/288522322/288522317/1/1726581414000/create-issue-linked.png)

## Creating a sub-task

You may wish to create a sub-task of the current issue (or any other issue) at a particular stage.

We currently don’t have support via the UI for this ([SRJIRA-2162](https://productsupport.adaptavist.com/browse/SRJIRA-2162)). But you can do it with a raw XML fragment, with the caveat that the form will open in full-screen mode.

Reminder, pressing the _Preview_ button generates the XML for any web fragment, which you can modify and submit via [the raw xml module built-in script](https://docs.adaptavist.com/sr4js/latest/features/fragments/raw-xml-module-built-in-script).

The XML to use is for example:

```
<web-item key='link-create-subtask' name='ScriptRunner generated web item - create-subtask' section='operations-operations' weight='1'>
    <label>Create Linked Subbie</label>
    <link linkId='link-create-constrained-subtask'>/jira/secure/CreateSubTaskIssue.jspa?parentIssueId=${issue.id}&amp;pid=${issue.projectObject.id}&amp;issuetype=10004</link>
</web-item>
```

Set the issue type ID of the sub-task, and set the context path correctly. In the case of the example above it is _/jira_.

## Further community examples:

-   Using a context provider ( [Atlassian Answers](https://answers.atlassian.com/questions/43888344/script-runner---create-linked-issues-and-conditions-on-automation))
