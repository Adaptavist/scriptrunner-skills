# Times an Issue was in each Status

- Platform: data-center
- Feature: script-fields
- Tags: customise, fields
- Language: groovy
- Doc ID: example-dataCenter-times-issue-was-in-each-status-onPrem
- Source: https://examples.scriptrunner.io/scripts/times-issue-was-in-each-status-onPrem

## Overview

Use this script to show how many times an issue was in each workflow status.

## Example

As a project manager, I want to see how an issue is moving through the development and review process. Using this
script, I can see how many statuses an issue has been through, and how many times it was in each status.

## Good to Know

* Use 'Text Field' as the template type.
* Set the 'Search Template' to 'None'.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.history.ChangeItemBean
import groovy.xml.MarkupBuilder

def statusMap = [:] as Map<Object, Integer>

// When an issue state is changed, the counter state is increased
ComponentAccessor.changeHistoryManager.getChangeItemsForField(issue, 'status').each { ChangeItemBean item ->
    if (statusMap[item.fromString]) {
        if (item.fromString != item.toString) {
            statusMap[item.fromString] ++
        }
    } else {
        statusMap[item.fromString] = 1
    }
}

if (!statusMap) {
    return null
}

// Print the counter state map
def stringWriter = new StringWriter()
def content = new MarkupBuilder(stringWriter)

content.html {
    ul {
        statusMap.collect { status, times -> "$status : $times" }.each { status ->
            li(status)
        }
    }
}

stringWriter.toString()
```

