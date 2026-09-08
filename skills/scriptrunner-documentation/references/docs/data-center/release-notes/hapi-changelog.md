# HAPI Changelog

- Platform: data-center
- Space: SR4JS
- Hierarchy: release-notes
- Doc ID: doc-sr4js-442888330
- Source: https://docs.adaptavist.com/sr4js/latest/release-notes/hapi-changelog

Find the latest updates and enhancements to HAPI on this page.

## Compatibility policy

We will try to maintain HAPI compatibility between releases. Unfortunately, we can't promise never to change HAPI—such a promise does not align with the key goal of being compatible with the Jira API. If the Jira API changes substantially, e.g. in Jira 10, HAPI may need to change too.

## Breaking changes policy

HAPI is a new API, therefore breaking changes may need to be introduced as we respond to feedback from our customers. We will endeavour to avoid making breaking changes if at all possible, if such changes are introduced they will be communicated via this changelog and in release notes.

In the future a more rigid breaking change policy may be introduced after responding to initial feedback from customers.

## Have any feedback? 

![Survey icon](/sr4js/files/latest/442888330/442888331/1/1758746930000/sr-icon-documentation.png)

Take our short survey and let us know what you think about HAPI!

[Take survey](https://www.surveymonkey.com/r/YXPMPKT)

## Changelog

### 8.14.0

#### Breaking changes

We have moved the location of several exceptions (see below), which may cause a breaking change for you if you use them in a script. If you use any of these exceptions in a script, you must update the import statement:

  

Exception

Previous import statement

New import statement

`InvalidUserKeyException.groovy`

`import com.adaptavist.hapi.jira.issues.exceptions.InvalidUseryKeyException`

`import com.adaptavist.hapi.platform.exceptions.InvalidUseryKeyException`

`InvalidUsernameException.groovy`

`import com.adaptavist.hapi.jira.issues.exceptions.InvalidUsernameException`

`import com.adaptavist.hapi.platform.exceptions.InvalidUsernameException`

`AppLinkResponseException.groovy`

`import com.adaptavist.hapi.jira.issues.exceptions.AppLinkResponseException`

`import com.adaptavist.hapi.platform.applinks.exceptions.AppLinkResponseException`

`NoSuchApplicationLinkException.groovy`

`import com.adaptavist.hapi.jira.issues.exceptions.NoSuchApplicationLinkException`

`import com.adaptavist.hapi.platform.applinks.exceptions.NoSuchApplicationLinkException`

### 8.10.0

#### User date information

We've developed a HAPI update for retrieving user date information. You can now retrieve the date a user was created and the date a user was last updated. Find out more details on the [Work with Users](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-users#creation-date) page. 

#### Linking issues

You can now link and unlink issues using the issue type ID. Check out the [Work with Issue Links](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-issue-links) page for more information on working with issue links. 

### 8.8.0

#### New HAPI code helper

We've added a HAPI code helper, also known as a linter, that detects where your scripts can be simplified with HAPI code and suggests an alternative. Find out more details, and information about how to enable/disable this feature, on the  [HAPI Code Helper](https://docs.adaptavist.com/sr4js/latest/get-started/settings/hapi-code-helper)  page.

### 8.7.0

#### Assets/Insight

You can now use dot notation to retrieve attribute values. Check out the [Retrieving attribute values](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-assets-insight#retrieve-attribute-values) documentation for more information.

#### Issue and entity properties

You can now work with issue and entity properties using HAPI. Check out the [Work with Issue and Entity Properties](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-issue-and-entity-properties) page for more information. 

#### User properties

Similar to working with issue and entity properties described above, you can now work with user properties. Check out the [Work with user properties](https://docs.adaptavist.com/display/SR4JS/Work+with+User#user-propertiess) documentation for an example.

### 8.6.0

#### Reindex issues

You can now reindex issues with HAPI. Check out the [Reindex Issues](https://docs.adaptavist.com/sr4js/latest/hapi/reindex-issues) documentation to learn more about reindexing issues.

### 8.5.0

#### Create issues

You can now create issues using the issue type ID. Check out the [Create Issues](https://docs.adaptavist.com/sr4js/latest/hapi/create-issues) page to learn more about creating issues. 

#### Assets

We've added the `.count` method to Assets. This method allows you to efficiently count the results of an Assets AQL/IQL query. Check out the documentation for [Executing an AQL query](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-assets-insight#execute-aql) to see an example.

### 8.3.0

#### Comments

You can now update comments with HAPI. Check out the [Work with Comments](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-comments) page to learn more about what you can do with comments.

### 8.1.0

#### Getting attachments/links during a transition

We've simplified some examples for accessing links or attachments during a workflow transition. Check out the documentation for [Validating Attachments/Links in Transition](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/validating-attachments-links-in-transitions) to see the simplified examples.

#### Comments

You can now do the following with comments:

-   Retrieve comments
-   Delete a comment

Check out the [Work with Comments](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-comments) page to learn more about what you can do with comments.

#### Assets

We've made it easier to access attribute values in a type-safe way. Check out the documentation for [Retrieving attribute values](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-assets-insight#retrieve-attribute-values) for more information.

### 8.0.0

#### Breaking change related to retrieving the customer request type

You can now retrieve more properties of a request type.

We changed the return type for `getRequestType()` on `Issue` to return a `com.atlassian.servicedesk.api.requesttype.RequestType` rather than a `com.atlassian.servicedesk.api.request.type.CustomerRequestType`.

The previous object did not allow users to retrieve properties of the request type, such as the name.  Check out the documentation for [retrieving the customer request type](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-jira-service-management#requesttype) for more information.

We made this breaking change instead of introducing a new method because our analytics showed limited use of this method.

### 7.13.0

#### Assets

We've made the following change to Assets:

-   New syntax to update attribute values. For example if you have attributes that allow for multiple values, you can add values to attributes using `add()`. You can update  attribute values using `remove()` ,  `clear()` , and  `replace()` . 

Check out the [Updating attributes](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-assets-insight#updateattributes) documentation to find out more about what you can do with attributes.

#### Filters

You can now do the following with filters:

-   Find a filter you own by name
-   Find a filter by name and owner
-   Find all filters with a given name
-   Find all filters

Check out the [Work with Filters](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-filters) page to find out more about filters. 

### 7.12.0

#### Projects

You can now do the following with projects:

-   Update a project
-   Update the project type
-   Delete a project

Check out the [Work with Projects](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-projects) page to find out more about projects. 

#### Jira Service Management (JSM) workflow approvals

In JSM you can now do the following with workflow approvals:

-   Add approvers to an issue
-   Approve an issue
-   Reject an issue
-   Check if an issue needs an approval decision
-   Retrieve approvals

Check out the [JSM approval](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-jira-service-management#approvals) documentation to find out more about what you can do with workflow approvals.

#### Project permission schemes

You can now do the following with project permission schemes:

-   Retrieve a project's permission scheme
-   Add permissions to a permission scheme
-   Remove permissions from a permission scheme
-   Check permissions

Check out the [Work with Permission Schemes](https://docs.adaptavist.com/display/SR4JS/Working+with+Permissions) page to find out more about what you can do with project permission schemes. 

### 7.11.0

HAPI is released!
