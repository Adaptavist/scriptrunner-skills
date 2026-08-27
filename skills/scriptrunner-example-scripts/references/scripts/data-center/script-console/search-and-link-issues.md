# Search and Link Issues

- Platform: data-center
- Feature: script-console
- Tags: organise, manage, hapi, issue
- Language: groovy
- Doc ID: example-dataCenter-search-and-link-issues-onPrem
- Source: https://examples.scriptrunner.io/scripts/search-and-link-issues-onPrem

## Overview

Searches for issues via a JQL query and links them to an issue.

## Example

As a Jira Admin, I want to link all support tickets requesting a new feature to the feature ticket in question.

## Good to Know

You can specify the user you want to run the script as.
Read more about [how to work with Users](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-users) with HAPI.

## Script

```groovy
def matchingIssuesJqlQuery = """
    project = 'SR' 
    AND component = Safari 
    AND labels IN (Elephant, Hippo)
"""
def matchingIssues = Issues.search(matchingIssuesJqlQuery)
def featureIssue = Issues.getByKey('SR-1') // Issue which all the other issues will be linked to

matchingIssues.each { issue ->
    // Other link type values can be set depending on the
    // Outward/Inward Descriptions in "Issue linking" configuration, e.g.:
    // 'blocks', 'is blocked by', 'clones', 'is cloned by', etc.
    issue.link('relates to', featureIssue)
}
```

