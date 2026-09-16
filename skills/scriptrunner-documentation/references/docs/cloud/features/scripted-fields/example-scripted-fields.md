# Example Scripted Fields

- Platform: cloud
- Space: SR4JC
- Hierarchy: Features > Scripted Fields
- Doc ID: doc-sr4jc-477c07c4-9319-4b30-80ca-cbe0b5b6e4db-5804114d4b1aed95
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields#example-scripted-fields--en

Along with the example Scripted Fields outlined below, we have added a demo video to help you understand how this feature works in ScriptRunner for Jira Cloud:

[Media](https://www.youtube.com/embed/t3gnI11MBOU#)

Here are some examples that show how to use Jira APIs. The Scripted Fields feature in Cloud works differently from Server/Data Center, where you must use one of the return types.

CAUTION: Groovy Scripts

Remember, our scripts are written in Groovy! Check out our page on [Scripting in ScriptRunner for Jira Cloud](../../get-started/scripting-in-script-runner-for-jira-cloud.md) for tips.

## Calculate the difference between two dates

This example script calculates the difference in a time unit between two custom date fields. Save time manually tracking dates using this script.

```
import java.time.ZonedDateTime
import java.time.format.DateTimeFormatter
import java.time.temporal.ChronoUnit

// The work item key
final workItemKey = 'TEST-1'
final dateFieldName = 'Created'
final chronoUnit = ChronoUnit.DAYS

// Jira datetime field format
def formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSZ")

// Pick a date that you would like to calculate from
def workItemFieldId = getFieldIdFromName(dateFieldName)
// Pick a date from another date field, in this case the built-in 'Updated' field
def updatedFieldId = 'updated'

def createdDate = ZonedDateTime.parse(getWorkItemField(workItemKey, workItemFieldId), formatter)
def updatedDate = ZonedDateTime.parse(getWorkItemField(workItemKey, updatedFieldId), formatter)

def dateDifference = chronoUnit.between(createdDate, updatedDate)

/**
 * Get the work item field data on a given work item
 * @param workItemKey The key of the work item to get the data from
 * @param fieldId The field to get the data of
 * @return The value of the field
 */
String getWorkItemField(workItemKey, fieldId) {
 def workItemFieldValue = null
 def result = get('/rest/api/2/issue/' + workItemKey)
        .header('Content-Type', 'application/json')
        .asObject(Map)
 if (result.status == 200) {
        result.body.fields.each { key, value ->
 if (key == fieldId) {
                workItemFieldValue = value.toString()
            }
        }
        logger.warn "${workItemFieldValue}"
 return workItemFieldValue
    }

    logger.warn "Failed to find work item: Status: ${result.status} ${result.body}"
 null
}

/**
 * Get the id of a field
 * @param fieldName The name of the field
 * @return The field id
 */
String getFieldIdFromName(String fieldName) {
 def fields = get("/rest/api/2/field").asObject(List).body
 def customFieldObject = (fields as List<Map>).find { Map field ->
        field.name == fieldName
    }
    (customFieldObject as Map).id
}

// Return the value
"${dateDifference} ${chronoUnit.toString().toLowerCase()}"
```

## Calculate the sum of fields from multiple work items from a JQL query

This example script sums up the values of several custom fields across all sub-tasks, displaying the result in the parent work item.

```
// sum up the values of this custom field
final customFieldName = 'Amount Paid'
final parentWorkItemKey = 'Parent Work Item Key'

def parentWorkItem = Issues.getByKey(parentWorkItemKey)
def subtasks = parentWorkItem.subtasks

// if the work item doesn't have any sub-tasks or is a subtask itself then no need for action
if (subtasks.empty) {
 return
}
def customFieldId = parentWorkItem.getNames().find { it.value == customFieldName }.key
if (!customFieldId) {
    logger.info "Custom field with name $customFieldName is not configured for work item type ${parentWorkItem.issueType.name} and space ${parentWorkItem.getProjectObject().name}"
 return
}

def sum = subtasks.sum { subtask ->
    subtask.getCustomFieldValue(customFieldName) ?: 0
}

parentWorkItem.update {
    setCustomFieldValue(customFieldName, sum)
}
```

## Create HTML table with work item details

This example script shows how to create a Rich Text Scripted Field that outputs an HTML table populated with work item data. It also calculates how long each work item has been in its current status.

```
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
    String summary = (it.fields.summary as String).replace('"', '\"')
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

## Create work items based on data retrieved from external systems

This script makes an external system call and creates a new work item in a selected space, based on information returned.

```
import java.time.LocalDateTime
import java.time.ZoneOffset

final spaceKey = 'TEST'
//External task type name
final externalWorkItemTypeName = 'External Task'
//External system URL
final externalUrl = 'https://external.system'

//We can compute the time between epoch and one hour before now in order to obtain work items from external by this time.
def timestamp = LocalDateTime.now()
    .minusHours(1)
    .toInstant(ZoneOffset.UTC).toEpochMilli()

//We can define here the endpoint to get work items from the external system and the query strings that are needed.
//In this example, we use "since" as a query string parameter where is defined the time by which we want to search.
def results = get("$externalUrl/rest/api/1/results")
    .queryString('since', timestamp)
    .asObject(List)
    .body as List<Map>

//For every result obtained, a new work item is created.
results.each { Map result ->
    Issues.create(spaceKey, externalWorkItemTypeName ) {
        summary = result.name
        description = result.message
    }
}
```

## Currency conversion number field

The following example shows the conversion of a field value, into a specific currency using a publicly available currency conversion API. A Jira custom field (number) called Cost (USD) has already been set up in the target space. The following script takes the Cost (USD) value, converts it to EUR, and displays the result in a scripted field:

```
def currentWorkItem = Issues.getByKey(issue.key as String)
// The name of the field containing the value to be converted (e.g. 'Euro Amount', 'Cost EUR', 'Cost in euros')
def costFieldName = 'Euro Amount'

// Extract the value of that field from the work item being viewed
def euroValue = currentWorkItem.getCustomFieldValue(costFieldName) as BigDecimal

// Use a 3rd-party currency conversion REST API and configure it as appropriate
def conversionResult = get("https://api.exchangeratesapi.io/latest?base=EUR&symbols=USD")
        .queryString('access_key', 'DUMMY_API_KEY')
        .queryString('base', 'EUR')
        .queryString('symbols', 'USD')
        .asObject(Map)
        .body

def usdRate = (conversionResult.rates as Map<String, BigDecimal>).USD

// Return the new currency value
if (euroValue && conversionResult != null) {
 return euroValue * usdRate
} else {
 return 0
}
```

## Date of the first transition

This scripted field example script is designed to capture the date and time when a work item first underwent a specific transition. If the work item experiences the same transition multiple times, the field will display only the date of the initial occurrence.

```
def result = get('/rest/api/3/issue/' + issue.key + '/changelog')
    .header('Content-Type', 'application/json')
    .asObject(Map)
// Replace 'In Progress' with the status name
def firstTransitionDateTime = result.body.values.find {it['items']['field'].toString().contains('status') && it['items']['toString'].toString().contains('In Progress') }
firstTransitionDateTime ? firstTransitionDateTime['created'] : "-"
```

## Last comment

The following example shows how you can extract the last comment of a work item and to display the value of it inside a scripted field on the work item sidebar.

This then allows you to easily see what was added to the last comment on the work item without having to scroll through all of the comments on the work item.

This field should be configured to have a Text Field return type and should be configured to display in the Work item sidebar location.

```
// Get a work item by its key
def workItem = Issues.getByKey("PROJECT-123")

// Get the most recent comment
def lastComment = workItem.getLastComment()

if (lastComment) {
    logger.info("Last comment by ${lastComment.author.displayName}: ${lastComment.body}")
} else {
    logger.info("No comments found on this work item")
}
```

## Show parent work item in hierarchy

This example script is designed to display a work item's parent, where you define what parent means.

```
// Set your target parent work type (e.g., "Task", "Epic")
final String TARGET_WORK_TYPE = "Epic"
// Set how far up the hierarchy to check
final int MAX_DEPTH = 10

Map findParentOfType(String currentWorkItemKey, String targetType, int maxDepth, int depth = 0) {
 if (depth >= maxDepth) {
 return null
    }

 def workItemResponse = get("/rest/api/3/issue/${currentWorkItemKey}")
            .queryString('fields', 'parent,issuetype,summary,key')
            .asObject(Map)

 if (workItemResponse.status != 200) {
 return null
    }

 def currentWorkItem = workItemResponse.body as Map
 def fields = currentWorkItem.fields as Map

 // Only check the current work item's type if we're not on the first call (depth > 0)
 // This ensures we never return the starting work item, only its parents/ancestors
 if (depth > 0) {
 def workItemType = fields.issuetype as Map

 if (workItemType.name == targetType) {
 return [
                    key: currentWorkItem.key,
                    summary: fields.summary
            ]
        }
    }

 // Check for parent
 def parent = fields.parent as Map

 if (!parent) {
 return null
    }

 // Recurse with the parent's key
 return findParentOfType(parent.key as String, targetType, maxDepth, depth + 1)
}

// Use the current work item from the scripted field binding
def parentWorkItem = findParentOfType(issue.key as String, TARGET_WORK_TYPE, MAX_DEPTH)

if (parentWorkItem) {
 def parentKey = parentWorkItem.key
 def parentSummary = parentWorkItem.summary as String

 return [
            version: 1,
            type   : "doc",
            content: [
                    [
                            type   : "paragraph",
                            content: [
                                    [
                                            type : "text",
                                            text : "${parentKey} - ${parentSummary}",
                                            marks: [
                                                    [
                                                            type : "link",
                                                            attrs: [
                                                                    href: "${baseUrl}/browse/${parentKey}"
                                                            ]
                                                    ]
                                            ]
                                    ]
                            ]
                    ]
            ]
    ]
} else {
 return [
            version: 1,
            type   : "doc",
            content: [
                    [
                            type   : "paragraph",
                            content: [
                                    [
                                            type: "text",
                                            text: "No Parent Found"
                                    ]
                            ]
                    ]
            ]
    ]
}
```

## Show sprint dates

This example script is designed to enhance your Jira work item tracking by automatically displaying the start and end dates of the active sprint associated with a given work item.

If the work item is not part of an active sprint, the script will display the message: "The \[WORK-ITEM-KEY\] work item is not currently in an active sprint." This ensures that users are aware when a work item is not currently scheduled in any ongoing sprint, helping to avoid confusion and enabling better sprint planning and management.

```
def currentWorkItem = Issues.getByKey(issue.key as String)
def sprint = currentWorkItem.getCustomFieldValue("Sprint")?.find { sprint -> sprint.state == 'active' }

if (sprint) {
    String sprintStartDate = sprint.startDate.substring(0, 10)
    String sprintEndDate = sprint.endDate.substring(0, 10)

 return "Sprint starting: ${sprintStartDate} - Sprint ending: ${sprintEndDate}"

} else {
 // Return a default message if the work item is not in active sprint
 return "The ${currentWorkItem.key} work item is not currently in an active sprint"
}
```

## Sum up story points below an epic work item

The following example shows how you can return all the Story work items below an Epic work item and to sum up the Story Points field for these and then display this value inside a script field on the Epic work item.

This then allows you to easily see how many story points you have set for all stories inside of your Epic work item.

This field should be configured to display for just the Epic work item type and to have a Number return type as well as to be configured to display in the Work item sidebar location.

CAUTION: If you wish to sum up extra issue types other than Story issues then you can modify the JQL queryString parameter in the allStories rest call of the script to include the extra work item types that you require.

```
def currentWorkItem = Issues.getByKey(issue.key as String)
if (currentWorkItem.getIssueType().name == 'Epic') {
 return Issues.search("parent='${currentWorkItem.key}'").collect { child ->
        child.getCustomFieldValue('Story Points') ?: 0 // if Story Points is null default to zero
    }.sum()
}
```

## Time of last status change

This example script is designed to capture the date and time when a work item last underwent a specific transition. If the work item experiences the same transition multiple times, the field will display only the date of the most recent occurrence.

```
def result = get('/rest/api/3/issue/' + issue.key + '/changelog')
        .header('Content-Type', 'application/json')
        .asObject(Map)
// Replace 'In Progress' with the status name
def lastTransitionDateTime = result.body.values.findAll { it['items']['field'].toString().contains('status') && it['items']['toString'].toString().contains('In Progress') }.last()
lastTransitionDateTime ? lastTransitionDateTime['created'] : "-"
```
