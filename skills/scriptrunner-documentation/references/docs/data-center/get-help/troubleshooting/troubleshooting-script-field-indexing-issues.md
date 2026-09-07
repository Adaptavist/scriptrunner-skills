# Troubleshooting Script Field Indexing Issues

- Platform: data-center
- Space: SR4JS
- Hierarchy: get-help > troubleshooting
- Doc ID: doc-sr4js-348416811
- Source: https://docs.adaptavist.com/sr4js/latest/get-help/troubleshooting/troubleshooting-script-field-indexing-issues

## Cannot re-index or create/update issues after creating a script field

### Issue

You receive one of the following indexing errors, or one similar, in the atlassian-jira.log when you try to run a background re-index or create/update an issue:

```
Cannot change DocValues type from SORTED to NUMERIC for field
```

```
ERROR 2022-08-26 10:19:59,961 [onresolve.scriptrunner.customfield.GroovyCustomField] Script field failed on issue: SSPA-23, field: Text to Date Error
java.lang.Exception: The search indexer: com.onresolve.jira.groovy.groovyrunner:datetimerange expected your script to return a java.util.Date, but it returned an java.lang.String. We couldn't convert it to a java.util.Date
Caused by: org.codehaus.groovy.runtime.typehandling.GroovyCastException: Cannot cast object 'Some text' with class 'java.lang.String' to class 'java.util.Date'
```

### Cause

This indicates that your script field was created with a searcher and then changed to use a different searcher that is not compatible with the previous one.

For example, if a field has values stored from a script field that was set to use a "Free Text" searcher, and the searcher type is changed to the "Date Time Range Picker" searcher, the above error occurs for any further JQL index operations. This includes background re-indexing and the indexing that occurs naturally after creating/updating an issue.

### Solution

To fix this problem you can do one of the following:

-   Run a _Full Lock_ re-index. A background re-index will only update field values and does not update changes to field searcher types.
-   Delete and re-create the script field, but you must select the correct template before creating the field. This change still requires a re-index but this can be a background re-index instead of a full lock.
