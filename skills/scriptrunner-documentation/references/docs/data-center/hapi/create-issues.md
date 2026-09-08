# Create Issues

- Platform: data-center
- Space: SR4JS
- Hierarchy: hapi
- Doc ID: doc-sr4js-442888438
- Source: https://docs.adaptavist.com/sr4js/latest/hapi/create-issues

![](/sr4js/files/latest/442888438/441364723/1/1750778122000/sr-icon-cloud.png)

**Migrating to Jira Cloud? This feature is available in Cloud. Check out our** **[HAPI Cloud documentation](https://docs.adaptavist.com/display/SR4JC/Work+with+Issues#createissues)** **for more details.** 

With HAPI you can quickly and easily create issues and set parameters. 

## Creating issues

You can use the following code to create an issue:

You can also create issues using the issue type ID. For example, instead of `'Task'` you might use the ID `10101`.

Please note, the ID for the _Task_ issue type might differ in your instance. See the Atlassian documentation for [Finding the ID for Issue Types](https://confluence.atlassian.com/jirakb/finding-the-id-for-issue-types-646186508.html).

```
            Issues.create('ABC', 'Task') {
                setSummary('my first HAPI 😍')
            }
```

  

![Image creating an issue using HAPI](/sr4js/files/latest/442888438/442888443/1/1758746939000/Create_an_issue.png)

The script above only sets the four fields that are always required when creating an issue in Jira:

-   The project
-   Issue type
-   Summary
-   Reporter (taken from the current user).

The above code will fail if other mandatory fields are set through the configuration scheme. Either set them or test on a project with the default configuration scheme.

### Fill out more fields when creating issues

You can fill out more fields when you create an issue. See our [Javadocs](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/7.11.0/hapi/jira/groovydoc/com/adaptavist/hapi/jira/issues/delegate/AbstractIssuesDelegate.html) for a full list of fields.

To fill out more fields, enter the following:

After you enter `set` you can use the keyboard shortcut of **control + space** to show available completions.

```
Issues.create('ABC', 'Task') {
    setSummary('my issue created with HAPI ')
    set
}
```

**Video**

Your browser does not support the HTML5 video element

## Creating a subtask

To create a subtask, use `createSubTask` and specify the subtask issue type. For example:

```
            def issue = Issues.getByKey('ABC-1')

            issue.createSubTask('Sub-task') {
                setSummary('This is the summary')
            }
```

  

* * *

## Related content

-   [Update Issues](https://docs.adaptavist.com/sr4js/latest/hapi/update-issues)
-   [Transition Issues](https://docs.adaptavist.com/sr4js/latest/hapi/transition-issues)
-   [Javadocs link (AbstractIssuesDelegate)](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/8.10.0/hapi/jira/groovydoc/com/adaptavist/hapi/jira/issues/delegate/AbstractIssuesDelegate.html)
-   [Javadocs link (Issues)](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/8.10.0/hapi/jira/groovydoc/com/adaptavist/hapi/jira/issues/Issues.html)
