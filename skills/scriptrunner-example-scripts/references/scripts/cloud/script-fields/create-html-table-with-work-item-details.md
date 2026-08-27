# Create HTML Table with Work Item Details

- Platform: cloud
- Feature: script-fields
- Tags: fields, customise, issue, ui
- Language: groovy
- Doc ID: example-cloud-rich-text-table-cloud
- Source: https://examples.scriptrunner.io/scripts/rich-text-table-cloud

## Overview

This script shows how to create a Rich Text Scripted Field that outputs an HTML table populated with work item data. It also calculates how long each work item has been in its current status.

## Example

As a user, I want to know the details of known bugs, such as:
- Work Item ID / Key
- Description
- Assignee
- Current status
- Time in current status
I can display additional details by extracting the relevant data from the work item and editing the ADF table row to add a field showing that data.

## Good to Know

Atlassian Document Format (ADF) is a JSON-like structure which is not directly compatible with Groovy.
The following line of code enables us to copy and paste ADF directly into our Groovy code:
`new groovy.json.JsonSlurper().parseText('''COPY AND PASTE ADF HERE''')`

## Script

```groovy
import groovy.time.TimeCategory

// Retrieving all bugs
Map<String, Object> bugs = (Map<String, Object>)get("/rest/api/3/search/jql")
        .queryString('jql', 'issueType=Bug')
        .queryString('fields', '*all')
        .header('Content-Type', 'application/json')
        .header('Accept', 'application/json')
        .asObject(Map).body

// Accessing the work in the payload
def work = (List<Map<String, Map>>) bugs.issues

def workItemData = work.collect {
    // Extracting the work item data we require
    String id = it.id
    String summary = (it.fields.summary as String).replace('"', '\\"')
    String statusChangeDate = it.fields.statuscategorychangedate
    String key = it.key
    String assignee = ((Map) it.fields.assignee)?.displayName ?: "Unassigned"
    String status = (((Map< String, Map>) it.fields.status)?.statusCategory).name ?: "Unknown status"

    // Calculating how long a work item has been in it's current status
    def timeInStatus = TimeCategory.minus(new Date(), Date.parse("yyy-MM-dd'T'HH:mm:ss.SSSZ", statusChangeDate))

    // Creating a formatted string to show the time since the status last changed
    def formattedTimeInStatus = ""
    if (timeInStatus.days > 0) {
        formattedTimeInStatus += "${timeInStatus.days} days, "
    }
    if (timeInStatus.hours > 0) {
        formattedTimeInStatus += "${timeInStatus.hours} hours, "
    }
    if (timeInStatus.minutes > 0) {
        formattedTimeInStatus += "${timeInStatus.minutes} minutes"
    }

    // Returning an ADF table row for each work item, populated with the data we have extracted
    """ {
          "type": "tableRow",
          "content": [
            {
              "type": "tableCell",
              "attrs": {},
              "content": [
                {
                  "type": "paragraph",
                  "content": [
                    {
                      "type": "text",
                      "text": "${key} / ${id}",
                      "marks": [
                        {
                          "type": "link",
                          "attrs": {
                            "href": "${baseUrl}/browse/${key}"
                          }
                        }
                      ]
                    }
                  ]
                }
              ]
            },
            {
              "type": "tableCell",
              "attrs": {},
              "content": [
                {
                  "type": "paragraph",
                  "content": [
                    {
                      "type": "text",
                      "text": "${summary}",
                      "marks": [
                        {
                          "type": "em"
                        }
                      ]
                    }
                  ]
                }
              ]
            },
            {
              "type": "tableCell",
              "attrs": {},
              "content": [
                {
                  "type": "paragraph",
                  "content": [
                    {
                      "type": "text",
                      "text": "${assignee}"
                    }
                  ]
                }
              ]
            },
            {
              "type": "tableCell",
              "attrs": {},
              "content": [
                {
                  "type": "paragraph",
                  "content": [
                    {
                      "type": "text",
                      "text": "${status}"
                    }
                  ]
                }
              ]
            },
            {
              "type": "tableCell",
              "attrs": {},
              "content": [
                {
                  "type": "paragraph",
                  "content": [
                    {
                      "type": "text",
                      "text": "${formattedTimeInStatus}"
                    }
                  ]
                }
              ]
            }
          ]
        }"""
}

// Outputting the entire table, with a row for each work item returned above
new groovy.json.JsonSlurper().parseText("""{
  "version": 1,
  "type": "doc",
  "content": [
    {
      "type": "table",
      "attrs": {
        "isNumberColumnEnabled": false,
        "layout": "default",
        "localId": "2114ce1a-d560-44f6-aca3-8e44e22584a3"
      },
      "content": [
        {
          "type": "tableRow",
          "content": [
            {
              "type": "tableHeader",
              "attrs": {},
              "content": [
                {
                  "type": "paragraph",
                  "content": [
                    {
                      "type": "text",
                      "text": "Work item Key / Work item ID",
                      "marks": [
                        {
                          "type": "strong"
                        }
                      ]
                    }
                  ]
                }
              ]
            },
            {
              "type": "tableHeader",
              "attrs": {},
              "content": [
                {
                  "type": "paragraph",
                  "content": [
                    {
                      "type": "text",
                      "text": "Summary",
                      "marks": [
                        {
                          "type": "strong"
                        }
                      ]
                    }
                  ]
                }
              ]
            },
            {
              "type": "tableHeader",
              "attrs": {},
              "content": [
                {
                  "type": "paragraph",
                  "content": [
                    {
                      "type": "text",
                      "text": "Assignee",
                      "marks": [
                        {
                          "type": "strong"
                        }
                      ]
                    }
                  ]
                }
              ]
            },
            {
              "type": "tableHeader",
              "attrs": {},
              "content": [
                {
                  "type": "paragraph",
                  "content": [
                    {
                      "type": "text",
                      "text": "Status",
                      "marks": [
                        {
                          "type": "strong"
                        }
                      ]
                    }
                  ]
                }
              ]
            },
            {
              "type": "tableHeader",
              "attrs": {},
              "content": [
                {
                  "type": "paragraph",
                  "content": [
                    {
                      "type": "text",
                      "text": "Time in Status",
                      "marks": [
                        {
                          "type": "strong"
                        }
                      ]
                    }
                  ]
                }
              ]
            }
          ]
        },
      ${workItemData.join(",")}
      ]
    }
  ]
}""")
```

