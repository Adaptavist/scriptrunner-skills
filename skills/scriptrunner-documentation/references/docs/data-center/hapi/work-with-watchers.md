# Work with Watchers

- Platform: data-center
- Space: SR4JS
- Hierarchy: HAPI
- Doc ID: doc-sr4js-09a321f1-56ce-45f7-ad91-99bcf3faf150-a13c1610258a8d50
- Source: https://docs.adaptavist.com/sr4js/latest/hapi#work-with-watchers--en

Add and remove watchers on Jira issues using HAPI, with code examples for each operation.

## Add a watcher to an issue

Add a watcher to an issue as follows:

```
Issues.getByKey('SR-10').addWatcher('jdoe')
```

## Remove a watcher from an issue

Remove a watcher from an issue as follows:

```
Issues.getByKey('SR-10').removeWatcher('jdoe')
```

## Retrieve the watchers from an issue

Retrieve watchers from an issue as follows:

```
Issues.getByKey('SR-10').watchers
```

## Security

By default all watcher operations respect the permissions of the current logged in user. You may want to ignore permission checks with the `overrideSecurity` property:

Note: In this example we're using the `overrideSecurity` property to ignore permission checks when adding a watcher to an issue.

```
Issues.getByKey('SR-10').addWatcherOverrideSecurity('jdoe')
```

## Related content

-   [Javadocs link](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/8.10.0/hapi/jira/groovydoc/com/adaptavist/hapi/jira/issues/implementation/IssuesImplementation.html)
-   [Work with Groups](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-groups)
-   [Work with Projects](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-projects)
