# Remote Issue Picker

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > script-fields > built-in-script-fields
- Doc ID: doc-sr4js-442886564
- Source: https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/remote-issue-picker

A field that allows for picking an issue, or issues, from a pre-defined JQL query _from a linked Jira instance_. Examples for usage might be:

-   Connect an internal issue to its corresponding issue in a public-facing Jira instance
    
-   Link an internal issue to a blocking issue in an external Jira instance for an open source project
    

This is similar to a standard remote issue link, but has some advantages, and disadvantages, versus an issue link.

-   The primary problem with remote issue links is that you can’t control the subset of issues that can be linked to. This field allows you to do that by specifying a JQL query
    
-   Issue links are not fields, which means linking is always available. With a field you can enforce a link, or hide it at certain states of the workflow
    

## Using this feature

Create a new field via _Admin → Script Fields_. Note that although you can create these types of field via _Admin → Custom Fields_, you cannot configure them there so it is easier to do it through the ScriptRunner interface.

![](/sr4js/files/latest/442886564/442886566/1/1758746712000/create-remote-issue-picker.png)

You can preview the result…​ but note that if you are previewing before creating the field, you will not be able to see a preview of the _view_ output as no issue will have a value for this field. Previewing is useful to verify that the picker is only displaying the correct candidate issues.

After creating the field, ensure it has the correct context and the correct screens. Make sure you type valid content into the field, otherwise options may not display. 

![](/sr4js/files/latest/442886564/442886569/1/1758746712000/remote-issue-picker-usage.png)

You should ensure that the people who can edit issues with this type of field also have permission to view any linked remote issues.

Do options load slowly or not display when you start typing a valid remote issue key?

The remote issue picker field makes REST calls from the client (user's browser) to the remote server to retrieve the issues to show as field options. This means the remote server needs to be accessible from the user's machine, and network speed can impact option loading if the connection is slow. 

**Solution:**

Use a JQL query in the _Remote Issue Picker_ configuration to reduce the number of issues the remote Jira server has to process. Otherwise it can introduce added latency when the client needs to retrieve the issues to show as options.

In addition, **make sure your users have a suitable internet connection to the remote Jira server.**

## Searching

You can search for issues by prefixing the app link name. It’s probably easiest to do this using the _basic_ search interface, then switching to _advanced_ mode as necessary.

You can search for issues linking to a particular issue, example:

```
"Public Issue" = "Remote Instance:AAAA-10"
"Public Issue" in ("Remote Instance:AAAA-10", "Remote Instance:AAAA-12")
```

You can also use the _IN_, _!=_, _NOT IN_ operators.

## Programmatic updates

Creating an issue using `IssueService`:

```
        def issueService = ComponentAccessor.issueService
        def issueInputParameters = issueService.newIssueInputParameters()

        def relevantConfig = customField.getRelevantConfig(new IssueContextImpl(getTestProject(), getBugIssueType()))

        issueInputParameters.addCustomFieldValue(fieldId, "AAAA-10")
            .addCustomFieldValue("$fieldId:fieldConfigId", relevantConfig.id.toString())
```

  

You must provide the _fieldConfigId_ number as shown above when using `IssueService`. This is because Jira doesn’t let us accurately retrieve the _Field Configuration_, which we need for retrieving the configured parameters of the field.

If you retrieve or set the value directly on the issue, the result will be a `com.onresolve.scriptrunner.canned.jira.fields.editable.remoteissue.RemoteJiraIssueReference` object, or if you have chosen a **multiple** issue picker, a `Collection<RemoteJiraIssueReference>`.

`RemoteJiraIssueReference` is a simple object with the following properties: `id` \- the issue ID (not key) of the remote issue, and `appId` \- the application link **ID** (not name).

```
        // single remote issue picker
        assert issue.getCustomFieldValue(customField) instanceof RemoteJiraIssueReference

        // multiple remote issue picker
        assert issue.getCustomFieldValue(customField) instanceof Collection
        assert issue.getCustomFieldValue(customField).every { it instanceof RemoteJiraIssueReference }
```
