# Perform a JQL Search in ScriptRunner for Jira

- Platform: data-center
- Feature: script-console
- Tags: automate, reporting, issue, hapi
- Language: groovy
- Doc ID: example-dataCenter-jql-search-onPrem
- Source: https://examples.scriptrunner.io/scripts/jql-search-onPrem

## Overview

Use this snippet to search for issues using JQL.

## Example

Iterate over issues matching JQL in order to update them, or add a comment etc.

## Description

#### Overview

Use this snippet to search for issues using JQL.

#### Example

Iterate over issues matching JQL in order to update them, or add a comment etc.

## Script

```groovy
Issues.search('project = SR and reporter = currentUser()').each { issue ->
    // do something with `issue`
}

// if you just need a count use `.count()
Issues.count('project = SR and reporter = currentUser()')
```

