# Project and Issue Type Behaviours

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > behaviours > behaviours-examples
- Doc ID: doc-sr4js-441363976
- Source: https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples/project-and-issue-type-behaviours

In certain scenarios, you may need to implement different behaviours based on the selected project or issue type. To do this, we recommend you use an initialiser, as described below. 

Behaviour mapping

Behaviours are mapped to specific combinations of projects and/or issue types. When a user changes the issue type, the system discards the current behaviours and retrieves new ones appropriate for the new project/issue type combination. As a result, it is not possible to listen for project and issue type changes within a behaviour itself.

## Use an initialiser

We recommend you implement project or issue type-specific logic by using [initialisers](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-tutorial#should-i-add-an-initialiser-or-server-side-script). Initialisers run whenever the _Create Issue_, _Edit Issue_, or _Transition issue_ page loads, allowing you to set field properties (e.g., read-only, required) and execute specific logic based on the current context. For example, the correct way to handle switching on issue type or project name/key is by using an initialiser:

```
if (issueContext.issueType.name == "Bug") {
    ...
}

if (issueContext.projectObject.key == "FOO") {
    ...
}
```

-   `issueContext` is an instance of `[IssueContext](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/issue/context/IssueContext.html)`.
-   `issueContext` is always available, regardless of whether the issue is being created or already exists.
-   Use `issueContext` to access project and issue type information.

Incorrect approach

You may want to add the Issue Type or Project field directly to a behaviour, however this will not produce the desired results. This approach fails because behaviours are context-specific and do not persist across issue type changes. For example, if you changed the issue type to one that had no behaviours, it wouldn’t make sense for the existing behaviour to continue running.

By following the recommendation above, you can create more robust and maintainable project and issue type-specific behaviours.
