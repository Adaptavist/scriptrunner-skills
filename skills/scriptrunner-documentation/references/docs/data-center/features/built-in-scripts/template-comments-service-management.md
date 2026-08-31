# Template Comments (Service Management)

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > built-in-scripts
- Doc ID: doc-sr4js-442889379
- Source: https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/template-comments-service-management

This feature is available in Jira Service Management only.

This built-in provides configurable template comments for Jira Service Management agents replying to customers.

The templates can use attributes of the current issue, linked issues, the reporter and current user, to create personalized comments.

Administrators can set up different available templates for different projects, or roles etc.

You can also specify a template to be used by default.

## Usage

This feature is disabled by default as since it was introduced, Atlassian added a similar feature. Their feature allows agents to save their own comments, however it does not allow (possibly complex) calculations on the issue’s attributes to populate the comment.

Enabling this feature will disable Service Management’s [_conversational mode_](https://jira.atlassian.com/browse/JSDSERVER-2257) (a default comment of the form, which provides a default snippet, as typically this replaces that. Disabling this feature in ScriptRunner will enable conversational mode.

If you have a need for this feature, enable it from _Built-in Scripts → \_Service Desk Template Comments_.

A few sample templates are provided. You can edit or delete them as appropriate.

When creating new templates, at the minimum you must provide the **Name** and **Template**.

The name is shown to the user in the dropdown box, to allow them to select that comment:

![Image example](/sr4js/files/latest/442889379/442889381/1/1758747021000/insert-comment.png)

The template is processed by [`GStringTemplateEngine`](http://docs.groovy-lang.org/latest/html/api/groovy/text/GStringTemplateEngine.html). To see the variables available to use, expand the Examples link, and click Kitchen Sink. Select a sample issue to preview the template with, and click Preview. You should see something like the following:

![Image of the result table](/sr4js/files/latest/442889379/442889380/1/1758747021000/kitchensink.png)

There is an additional string you can use in your template: `{CURSOR}`. This is not a variable so should not have a dollar sign. If found, the caret will be placed at this position within the comment text box. See the "default" template for an example.

## Snippets And Default

If a comment is marked as a _snippet_, it will be inserted at the current cursor position in the comment. If not, it will set or replace the entire comment.

A good strategy is to have a single default comment, with the cursor placed between the greeting and sign-off, and then the rest of the templates be snippets.

That way you can form the response from multiple snippets.

## Conditions

The _Condition / Code_ section controls two things

-   whether the template will be available for selection by the user
    
-   additional variables available to the template
    

To have different comments for different projects, you could use a condition such as:

```
issue.projectObject.key == 'ABC'
```

```
The Condition / Code section can also provide additional variables to the template.
```

In this example, we retrieve the value of a custom field and provide it in the template:

```
config.refund = issue.getCustomFieldValue('Refund Amount') ?: 0

return true // must return true otherwise the comment will be hidden
```

The template may look like:

```
Dear $customerFirstName,

We have processed your claim and you are entitled to a refund of

USD: $refund

Nice!
```
