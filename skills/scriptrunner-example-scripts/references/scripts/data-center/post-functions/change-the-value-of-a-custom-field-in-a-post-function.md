# Change the Value of a Custom field in a Post Function

- Platform: data-center
- Feature: post-functions
- Tags: automate, fields, issue, hapi
- Language: groovy
- Doc ID: example-dataCenter-set-custom-field-value-onPrem
- Source: https://examples.scriptrunner.io/scripts/set-custom-field-value-onPrem

## Overview

This script sets the value of issue fields during a post function, in a workflow transition.

The syntax for updating/setting fields is exactly the same as used when creating, updating or transitioning an issue - see [this example](https://library.adaptavist.com/entity/basics-updating-customfields), except that you use `issue.set { ... }` rather than `issue.update { ... }`.

`.set`, which is available on 
[com.atlassian.jira.issue.MutableIssue](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/issue/MutableIssue.html), 
updates the issue fields in memory only, and does not persist them to the database. This works in a script post-function providing 
it is ordered before the system post-functions for storing and reindexing an issue.

## Example

Automatically set fields on issue creation or transition, based on the value of other fields.

## Description

#### Overview

This script sets the value of issue fields during a post function, in a workflow transition.

The syntax for updating/setting fields is exactly the same as used when creating, updating or transitioning an issue - see [this example](https://library.adaptavist.com/entity/basics-updating-customfields), except that you use `issue.set { ... }` rather than `issue.update { ... }`.

`.set`, which is available on 
[com.atlassian.jira.issue.MutableIssue](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/issue/MutableIssue.html), 
updates the issue fields in memory only, and does not persist them to the database. This works in a script post-function providing 
it is ordered before the system post-functions for storing and reindexing an issue.   

#### Example

Automatically set fields on issue creation or transition, based on the value of other fields.

## Script

```groovy
issue.set {
    setCustomFieldValue('TextFieldA', 'a new value')

    setDescription('an updated description')
}
```

