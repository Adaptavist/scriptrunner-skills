# Issue Picker Customizations

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > script-fields > built-in-script-fields > issue-picker
- Doc ID: doc-sr4js-442889027
- Source: https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/issue-picker/issue-picker-customizations

You can customize the picker in many ways using the _Configuration Script_ option. However, it’s recommended you get the basic functionality of your picker working before you work on advanced customization.

Configure advanced functionality by editing the configuration script and specifying closures or string values. For operations like rendering the display value, the closure is called (if present), along with any arguments required. The following information explains what happens by default, and what arguments are available to your closure, as well as usage examples.

You do not need to include all possible closure arguments. You can omit superfluous arguments, but you must keep the order. Only drop arguments from the right of the list, for example:

`myClosure = { foo, bar, baz →`

can be shortened to:

`myClosure = { foo -> // ... }`

These customizations can be complex. Ensure you thoroughly test on a non-production system.

## Customizing the Displayed Value

To customize the display of this value, implement:

```
import com.atlassian.jira.issue.Issue

renderIssueViewHtml = { Issue issue, String baseUrl ->
    // return HTML based on the provided issue
}
```

**issue**

The target issue as selected.

**Multi issue picker**

In the case of a multi-picker, this closure will be called for each selected issue.

For example, to display the key and the value of a custom field:

```
import com.atlassian.jira.issue.Issue
import com.onresolve.scriptrunner.canned.util.OutputFormatter

renderIssueViewHtml = { Issue issue, String baseUrl ->
    OutputFormatter.markupBuilder {
        div {
            a(href: "${baseUrl}/browse/${issue.key}", issue.key)
            mkp.yield(': ')
            span(issue.getCustomFieldValue('ShortText1'))
        }
    }
}
```

This example is more or less the same behaviour as you would get if you added this custom field to the **Search Fields**, but can be expanded upon to something more complex.

If the current user does not have permission to view the selected issue(s), the above closure is not called. Instead, just the issue key is displayed without being linked.

This helps avoid accidentally disclosing information about the selected issue(s) to users who would otherwise not have permission to view them.

However, in the case of multiple issue pickers, this same strategy also makes it difficult to present the selected issues in a table.

If you want to do this, instead of the above closure, you can opt to render all the selected issues rather than issue by issue. The closure to implement is:

```
import com.atlassian.jira.issue.Issue

renderViewHtml = { List<Issue> issues, Closure<Issue> hasPermission, String baseUrl ->
    // return HTML based on the provided list of issues
}
```

**Single issue picker**

In the case of a single issue picker, the passed list `issues` always contain a single issue.

In this case, you are responsible for not disclosing information to the current user that they could not otherwise see.

You do that by calling the passed-in closure `hasPermission` on each issue; it returns `true` if the user has _browse_ permissions on the current issue, and `false` if they do not.

For example, to implement a table that displays the **Issue key**, **Summary**, and **Description**:

```
import com.atlassian.jira.issue.Issue
import com.onresolve.scriptrunner.canned.util.OutputFormatter

renderViewHtml = { List<Issue> issues, Closure<Issue> hasPermission, String baseUrl ->
    OutputFormatter.markupBuilder {
        table(class: 'aui') {
            thead {
                tr {
                    td('Key')
                    td('Summary')
                    td('Description')
                }
            }
            issues.each { issue ->
                tbody {
                    tr {
                        if (hasPermission(issue)) {
                            td {
                                a(href: "${baseUrl}/browse/${issue.key}", issue.key)
                            }
                            td(issue.summary)
                            td(issue.description)
                        } else {
                            td(colspan: 3, issue.key + ' (Permission Denied)')
                        }
                    }
                }
            }
        }
    }
}
```

Note the use of `hasPermission` to show only the issue key and the "Permission Denied" message if the user does not have browse permissions.

The result:

![](/sr4js/files/latest/442889027/442889030/1/1758746990000/image2021-7-12_12-13-47.png)

### Customizing the Column View and Text Only Views

The column view HTML is what is shown in the issue navigator, and the text-only view is use in the _History_ tab, email notifications and CSV exports.

The behaviour and signatures for the column view closures are the same as the ones used for displaying the result on the _View Issue_ screen. The closure names are:

-   `renderIssueColumnHtml` for rendering each issue separately. 
-   `renderColumnHtml` for rendering all issues together.
-   `renderTextOnlyValue` for rendering all issues together (advanced - you should not need to implement this).

If you want the column view to be the same as the standard view, you can just assign one closure to the other, for example:

```
renderIssueColumnHtml = renderIssueViewHtml 
// or
renderColumnHtml = renderViewHtml
```

### HTML Escaping

Issue attributes such as **Summary**, **Description**, or custom field values are not automatically escaped for HTML. You need to do this in your script. The simplest way is to use [MarkupBuilder](https://docs.groovy-lang.org/latest/html/api/groovy/xml/MarkupBuilder.html) as shown in the examples above.

However, any javascript or unsafe HTML is automatically removed.

## Customizing the JQL

The JQL in the configuration is used both to restrict the issues shown in the drop-down, and to validate any issues selected in the drop-down.

To set the JQL use: 

```
import com.atlassian.jira.issue.Issue

getJql = { Issue issue, String configuredJql ->
    // return a String for the jql to be used for the drop-down and validation
}
```

**issue**

The issue which this field is currently on. 

**configuredJql**

The JQL as configured in the form. You could use this to avoid repeating yourself, and use the Jira API to build a compound query based on this.

For example, in the form you could set `PROJECT = X.` To then restrict this to only issues reported by the current user, you would use the API (instead of string concatenation) to combine `configuredJql` with `reporter = currentUser().``   `

The issue passed to this function, as with other pickers, is live, meaning it reflects any changes currently being made in the issue form (edit/transition etc). So, although you can use behaviours to set the JQL, it's preferable to use this method.

### Setting JQL Based on Permissions Example

For example, you want to restrict the JQL for the picker to just those issues created by the current user, except if the current user has global administrator permissions:

```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.Issue
import com.atlassian.jira.permission.GlobalPermissionKey

def globalPermissionManager = ComponentAccessor.globalPermissionManager

getJql = { Issue issue, String configuredJql ->

    def currentUser = Users.loggedInUser
    def isAdmin = globalPermissionManager.hasPermission(GlobalPermissionKey.ADMINISTER, currentUser)

    if (isAdmin) {
        return ''
    } else {
        return 'reporter = currentUser()'
    }
}
```

The JQL configured in the form is also important - this JQL will be used in contexts when there is no current issue in scope, for example when setting a default value, or when searching using the issue navigator.

The JQL returned by the method above should only narrow the scope of possible issues fitting the query, not widen it. Otherwise a user may not be able to search for a selected issue.

### Setting JQL Based on Issue Attributes

In the example above, the JQL was based on permissions of the current user, however,  we can also base it on attributes of the issue currently being edited.

In this example, any issue can be selected if the **Priority** is _High;_ otherwise only issues reported by the current user can be selected:

```
import com.atlassian.jira.issue.Issue

getJql = { Issue issue, String configuredJql ->

    if (issue.priority?.name == 'High') {
        return ''
    } else {
        return 'reporter = currentUser()'
    }
}
```

## Miscellaneous

### Setting the Number of Results in the Drop-down

By default, the top 30 search results are shown in the drop-down. This can be decreased or increased by setting it in the configuration script:

```
maxRecordsForSearch = 1
```

### Setting Search Fields for Picker

When the end-user types in the drop-down, a search is executed based on the JQL, then further filtering and ordering is done based on the terms the user has entered.

For performance reasons, the picker loads as few fields as possible from the Lucene index, by default just the **Issue Key** and **Summary**.

This means, to use additional fields when displaying the option HTML, the full issue needs to be loaded from the database (for example: `issueManager.getIssueObject(...)`), or you must specify the full list of fields to load from the index. When setting this, be sure to also include the fields displayed in the form. 

```
getSearchFields = {
    // specify the list of fields to be returned in the picker search. These fields can be used when
    // customising the option HTML or the dropdown icon
}
```

This list should contain field IDs, so for instance, if you want a custom field, the ID would be in the format: `customfield_12345`.

### Rendering Option HTML

You can customise the HTML shown for each matching result in the drop-down.

```
import com.atlassian.jira.issue.Issue

renderOptionHtml = { String displayValue, Issue issue, Closure<String> highlight, String baseUrl ->
    // return HTML to be displayed in the picker. Called for each matched issue when searching.
}
```

**displayValue**

A string that would be displayed by default. Use this to prepend something to the usual output.

**issue**

The issue object that has been matched from the configured JQL, and the text the user has entered in the drop-down.

**highlight**

Use this closure to add bold tags around enter text the user has entered in the drop-down, for example: `highlight(issue.summary)`.

To display a field that is not one of the search fields configured in the form, add this field ID to `getSearchFields`. In the example below, we want to use **Priority** so we specify it in addition to the **Issue key** and **Summary**:

```
import com.atlassian.jira.issue.Issue
import com.onresolve.scriptrunner.canned.util.OutputFormatter

getSearchFields = {
    ['issuekey', 'summary', 'priority']
}

renderOptionHtml = { String displayValue, Issue issue, Closure<String> highlight ->
    OutputFormatter.markupBuilder {
        i('Priority: ' + issue.priority?.name)
        mkp.yield(' ')
        mkp.yieldUnescaped(displayValue)
    }
}
```

![](/sr4js/files/latest/442889027/442889029/1/1758746990000/image2021-7-18_17-18-27.png)

### Customising the Icon in the Drop-down

By default, the icon shown is the one for the issue type. If you wish to change that implement:

```
import com.atlassian.jira.issue.Issue

getDropdownIcon = { Issue issue, String baseUrl ->
    // return a String: a link to an icon, or base64 encoded string beginning 'data:image/jpg;base64, '
}
```

In the following example, we customise the icon for the **Priority** - other examples you could use are the icon for the **Status**, or the user avatar for the **Reporter** or **Assignee**.

```
import com.atlassian.jira.issue.Issue

getSearchFields = {
    ['issuekey', 'summary', 'priority']
}

getDropdownIcon = { Issue issue, String baseUrl ->
    baseUrl + issue.priority.iconUrl
}
```

![](/sr4js/files/latest/442889027/442889028/1/1758746990000/image2021-7-18_18-11-13.png)
