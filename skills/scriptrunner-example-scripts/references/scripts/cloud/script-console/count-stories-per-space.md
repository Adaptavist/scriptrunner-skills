# Count Stories Per Space

- Platform: cloud
- Feature: script-console
- Tags: automate, project, reporting, hapi
- Language: groovy
- Doc ID: example-cloud-Count-stories-per-project-cloud
- Source: https://examples.scriptrunner.io/scripts/Count-stories-per-project-cloud

## Overview

This example shows how you can perform a JQL search to return all stories in a set of spaces and provide a count of the number of stories per space.

## Example

As a Jira admin, I want to know how many stories are currently assigned to a space.

## Good to Know

* This example will work only in Jira Cloud.
* This example will return the first 10 work items
* This example will output the results into a table.

## Script

```groovy
import groovy.xml.MarkupBuilder

def mapping = WorkItems.search("issuetype = Story").countBy { workItem ->
    ((Map<String, Map>) workItem.fields).project.key
}

def writer = new StringWriter()
def builder = new MarkupBuilder(writer)
builder.table(class: "aui") {
    thead {
        tr {
            th("Space Key")
            th("Count")
        }
    }
    tbody {
        mapping.each { spaceKey, count ->
            tr {
                td {
                    b(spaceKey)
                }
                td(count)
            }
        }
    }
}

writer.toString()
```

