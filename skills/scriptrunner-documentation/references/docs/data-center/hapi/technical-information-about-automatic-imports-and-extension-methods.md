# Technical Information about Automatic Imports and Extension Methods

- Platform: data-center
- Space: SR4JS
- Hierarchy: hapi
- Doc ID: doc-sr4js-348419277
- Source: https://docs.adaptavist.com/sr4js/latest/hapi/technical-information-about-automatic-imports-and-extension-methods

This page provides technical information on automatic imports and extension methods.

## Automatic imports

For convenience, HAPI classes such as `Issues`, `Users`, and `Projects` are automatically imported into all scripts compiled within ScriptRunner, and an explicit import is not required.

If you import another class called `Issues`, this results in a conflict. To avoid conflicts, HAPI classes won't automatically import if there is an existing import for a class with the same name in a script.

For cases where you have a script that contains a conflicting import, you can access HAPI via the `Hapi` automatic import. This automatic import is unlikely to conflict with other classes. For example:

```
Hapi.issues.create('ABC', 'Task') {
    summary = 'Hello world'
}
```

## Extension methods

Extension methods are methods that ScriptRunner adds to classes that are not part of its own API, for instance the Atlassian Jira API. In the following example, `delete()` is an extension method that is added by ScriptRunner.

```
def issue = Issues.getByKey('ABC-1')

issue.delete()
```

Other examples of extension methods include i`ssue.update()`, `user.delete()` and `group.add()`. See our [Javadocs](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/7.11.0/hapi/jira/groovydoc/index.html) for details of all available extension methods. 

  

* * *

## Related content

-   [Update Issues](https://docs.adaptavist.com/sr4js/latest/hapi/update-issues)
-   [Update Fields](https://docs.adaptavist.com/sr4js/latest/hapi/update-fields)
-   [Transition Issues](https://docs.adaptavist.com/sr4js/latest/hapi/transition-issues)
