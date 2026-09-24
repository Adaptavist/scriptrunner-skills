# Web Item

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Fragments
- Doc ID: doc-sr4c-903b85e4-f9cf-468c-bfff-2346960d6813-1ec273fba667388b
- Source: https://docs.adaptavist.com/sr4c/latest/features#fragments--en#web-item--en

A web item is a button or link that appears at the location you choose.

Note: Avoid for navigation

Web Items should not be used for navigation linking in button group sections. See [Atlassian's documentation](https://aui.atlassian.com/aui/latest/docs/buttons.html) for more.

Here are some things you can do with web items:

-   Redirect to another location
-   Invoke a script endpoint and run code, which can respond with:
    -   A flag
    -   A dialog
    -   A redirection to another page

## Examples

### Google Link Example

A basic example of a web item is a link to Google at the top of the navigation bar.

1.  Fill out the web item form:
    
    Tip: You can understand the Section field's values by reading the [Atlassian web item documentation](https://developer.atlassian.com/confdev/confluence-plugin-guide/confluence-plugin-module-types/web-ui-modules), or you can use the section finder tool. The Weight field determines the placement of the web item. If you set it to _1_, the link becomes the first item on the left.
    
    Warning: Weight field
    
    For some locations, setting the _Weight_ to a number below nine may cause existing Atlassian elements to be overwritten. If an issue is found, increasing the weight value will likely resolve the problem.
    
    Warning: Key field
    
    The Key field will be used as `id` , `attribute data-web-item-key` and/or `data-first-web-item-key` of the element, depending on the location of the web-item.Avoid using a key that has already been used by another element on the Confluence page.
    
2.  Click Add to register the fragment.
3.  Go to the dashboard in a new tab, and see your new link.
    
4.  Click the link to go to Google.

### Tools Menu Link

For a more complicated web item, you can add a link to the Confluence wiki pages, which does a Google search on the title of the current page.

1.  Fill out the web item form:
    
2.  Click Add to register the fragment.
3.  Go to the dashboard in a new tab.
4.  Select this item from the ellipsis menu of any wiki page:
    

Note: The URL is processed with Velocity before rendering. The variables you can use depend on the context of the web item:

-   `page` - a [Page](https://docs.atlassian.com/confluence/6.0.1/com/atlassian/confluence/pages/Page.html) object
-   `space` - a [Space](https://docs.atlassian.com/confluence/6.0.1/com/atlassian/confluence/spaces/Space.html) object

CAUTION: They Key needs to be different for each new module you create. If you don't change the key, the module from the first part of the tutorial is overwritten.

### Acting on the Current Page/Issue

You can run code that operates on the current page and returns a message to the user. For example, you could add a property showing approval.

1.  Define a _REST Endpoint_ script, with one endpoint, named `approve`.
    
    You can use this code:
    
    ```
    import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
    import groovy.json.JsonOutput
    import groovy.transform.BaseScript
    
    import javax.ws.rs.core.MultivaluedMap
    import javax.ws.rs.core.Response
    
    @BaseScript CustomEndpointDelegate delegate
    
    approve(httpMethod: "GET") { MultivaluedMap queryParams ->
    
        // the details of adding properties or labels to the page, to indicate approval, are ommitted for brevity
        def pageId = queryParams.getFirst("pageId") as Long // use the pageId to retrieve this page
    
        def flag = [
            type : 'success',
            title: "Page approved",
            close: 'auto',
            body : "You have signified your approval of this page"
        ]
    
        Response.ok(JsonOutput.toJson(flag)).build()
    }
    ```
    
    Bitbucket
    
2.  Verify that this works by browsing to: `http://<confluence-url>/rest/scriptrunner/latest/custom/approve?pageId=12345`.
    
    It should respond with some JSON.
    
    Tip: If you are working with the page, be sure to enter a valid page ID.
    
3.  Wire this code to an _Approve_ button on the page using a web item.
    
    The form should look like this:
    
    Warning: Do What must be set as shown or the flag won't appear.
    
    Tip: Note that the URL is relative to the application base URL, so you don't need to include the context path if one is set.
    
    The format of the flag is defined in the [AUI Flag](https://docs.atlassian.com/aui/latest/docs/flag.html) documentation. Change the Type to return error and warning messages, etc.
    
4.  Click the Approve button, and you should see the flag.
    
    Tip: As before, experiment with the Weight field to adjust the menu item's position up or down.
    

The problem we currently face is that we will likely need to limit page approval to only those in a specific group or with a certain space permission. We also don't want to show the menu item if the page has already been approved. You can moderate these with conditions.

## Conditions

The Condition field is used to define whether the link should be shown, and it can utilise any available information in its context. What is available in the context depends on the specific web section and the page being viewed. Details of the current user can also be used.

For example, if the web item is on a wiki page, you get the `page` and `space` as conditions. If the web item is in a _Space Admin_ section, then you may only get the `space`.

The context variable is an instance of [`WebInterfaceContext`](https://docs.atlassian.com/atlassian-confluence/6.6.0/com/atlassian/confluence/plugin/descriptor/web/WebInterfaceContext.html) . You can use its methods to retrieve the current page.

### Example

You can show only the _Approve_ menu item where the current user is a space admin and the current page does not already have the _Approved_ label.

1.  Click the Expand Examples to reveal that there are already two samples that are similar to the two parts of this condition.
    
    Combining the two parts looks like this:
    
    ```
    import com.atlassian.confluence.pages.Page
    import com.atlassian.confluence.security.Permission
    import com.atlassian.confluence.security.PermissionManager
    import com.atlassian.confluence.user.ConfluenceUser
    import com.atlassian.sal.api.component.ComponentLocator
    import com.atlassian.confluence.spaces.Space
    
    def user = context.user as ConfluenceUser
    def space = context.space as Space
    def page = context.page as Page
    
    if (user && space) {
        def permissionManager = ComponentLocator.getComponent(PermissionManager)
        return !page.labels*.name.contains("approved") &&
            permissionManager.hasPermission(user, Permission.ADMINISTER, space)
    } else {
        return false
    }
    ```
    
2.  Enter this code in Condition.
    
    It can be entered inline or written to a file underneath a script root.
    

You should now be able to see that it doesn't appear for users who are not space admins or when the page is already labelled 'Approved'.

Tip: Conditions must be written defensively. What is available in the context or jiraHelper map depends on the particular web section, and the page that it's viewed on.

For instance, a link in the top section ( `system.header/left`) will not always have the same context variables. When viewed on the dashboard, it may contain just the current user. When you are looking at a page in a space, you will have a reference to the current page object. Therefore, check that context variables are not null before calling methods or properties on them.

If you are using a section like `system.content.action`, you can assume that you will always have the `page` context variable defined.

In addition to using a script, you can use a concrete class that implements conditions, which extends the existing condition.

### Dialogs (Advanced)

You can show some dialogs. For complex interactions, you need to write javascript.

To display a dialog when the user clicks a web item, select the Run Code and Display a Dialog option. The endpoint needs to return HTML for an AUI [dialog2](https://docs.atlassian.com/aui/latest/docs/dialog2.html). The following REST endpoint code displays a dialog when clicked:

```
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.transform.BaseScript

import javax.ws.rs.core.MediaType
import javax.ws.rs.core.MultivaluedMap
import javax.ws.rs.core.Response

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

The button with the ID `dialog-close-button` will be automatically wired to close when clicked if you use a dialog ID of `sr-dialog`.

If you require more complex interactions, you should require some javascript and wire the elements, for example:

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

Note: Removing the dialog from the DOM when the dialog is hidden (for example, when pressing the ESC key) is controlled by the [data-aui-remove-on-hide](https://docs.atlassian.com/aui/latest/docs/dialog2.html#dialog-methods) attribute.

Removing this attribute hides the dialog rather than remove it when the dialog is hidden.

In this case, handle re-showing the dialog in your JavaScript code. The web item trigger re-renders a completely new dialog for you.

You can include your additional dialog with a [web resource fragment](https://docs.adaptavist.com/sr4c/latest/features/fragments/web-resource).

When you click the link, the dialog appears:

### Redirects

Return a redirect to run code and then redirect to another page, or load the same page after updating it.

The following example adds a label to the current page/issue and then refreshes it by redirecting to the same page:

```
import com.atlassian.confluence.labels.Label
import com.atlassian.confluence.labels.LabelManager
import com.atlassian.confluence.labels.Labelable
import com.atlassian.confluence.labels.Namespace
import com.atlassian.confluence.pages.PageManager
import com.atlassian.sal.api.ApplicationProperties
import com.atlassian.sal.api.component.ComponentLocator
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.transform.BaseScript

import javax.ws.rs.core.MultivaluedMap
import javax.ws.rs.core.Response

@BaseScript CustomEndpointDelegate delegate

def labelManager = ComponentLocator.getComponent(LabelManager)
def pageManager = ComponentLocator.getComponent(PageManager)
def applicationProperties = ComponentLocator.getComponent(ApplicationProperties)

labelPage(httpMethod: "GET") { MultivaluedMap queryParams ->

    def pageId = queryParams.getFirst("pageId") as Long
    def page = pageManager.getPage(pageId)

    def label = labelManager.getLabel("approved")
    if (!label) {
        label = labelManager.createLabel(new Label("approved", Namespace.GLOBAL))
    }
    labelManager.addLabel(page as Labelable, label)

    Response.temporaryRedirect(URI.create("${applicationProperties.baseUrl}/pages/viewpage.action?pageId=${pageId}")).build()
}
```

Warning: Make sure to select Navigate to a Link as the intention setting.
