# JQL FAQs

- Platform: data-center
- Space: SR4JS
- Hierarchy: get-help > frequently-asked-questions
- Doc ID: doc-sr4js-442886684
- Source: https://docs.adaptavist.com/sr4js/latest/get-help/frequently-asked-questions/jql-faqs

### When are scripted fields changes updated so that the result can be found with a JQL search?

Scripted fields values, much like any other custom field, have their values updated in the JQL index when an action on the issue causes the issue to be re-indexed. So, for example, creating/updating, or transitioning an issue through standard Jira methods trigger Jira to run a re-index of that issue.

### When updating an issue, do all scripted fields values on linked issues get updated so they can be found with a JQL search?

Updating an issue does not cause the scripted fields of linked issues to be re-calculated/updated. If you are editing an issue that has linked issues, only the issue you are editing has its scripted fields updated in the JQL index when you save the update.

There is one exception to this - sub-tasks of an issue are re-indexed when the parent issue is updated but not the other way around. If a sub-task is updated, the parent is not re-indexed.

ScriptRunner JQL AI

If you're not sure where to start with JQL Functions or are in need of a quick search filter, try our [ScriptRunner JQL AI](https://docs.adaptavist.com/sr4js/latest/features/jql-functions#sr-jql-ai).
