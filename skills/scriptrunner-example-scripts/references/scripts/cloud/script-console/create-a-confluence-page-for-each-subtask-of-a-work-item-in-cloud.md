# Create a Confluence Page for Each Subtask of a Work Item in Cloud

- Platform: cloud
- Feature: script-console
- Tags: automate, issue, hapi, integrate
- Language: groovy
- Doc ID: example-cloud-create-confluence-page-for-issues-cloud
- Source: https://examples.scriptrunner.io/scripts/create-confluence-page-for-issues-cloud

## Overview

When working in Jira, often you want to continue a conversation about a work item on a corresponding Confluence page.
Having all data on a Confluence page can be helpful when defining specifications for a task, swarming on an incident, or any other collaborative action in your workflow.
Use this script to create a corresponding page, with hierarchy in place, for each sub-task of a work item in a Confluence space linked via application links.

## Example

I am a product manager with multiple spaces in Jira.
I need each space to have a corresponding Confluence page to carry out more in-depth conversations.
These pages need to have a hierarchy in place for each sub-task of a work item in a Confluence space linked via application links.
I can use this script to automate the creation of the Confluence pages for each space.

## Good to Know

* Make sure the current user has write permissions on the target Confluence space.
* This snippet requires that you have both ScriptRunner for Jira Cloud and ScriptRunner for Confluence Cloud installed. If you do not have ScriptRunner for Confluence Cloud installed, you will need to update this example to specify user credentials to access the Confluence instance.

## Script

```groovy
def spaceKey = 'LTSE'
def workItem = WorkItems.getByKey('TEST-1')
def spaceSource = get("/wiki/api/v2/spaces?keys=${spaceKey}")
    .header('Content-Type', 'application/json')
    .asObject(Map)
if (spaceSource.status != 200) {
    return "Error fetching  ${spaceSource}"
}

def spaceId = spaceSource.body.results[0].id as String
def subtasks = workItem.getSubtasks()
def title = workItem.getSummary()
def rootContent = "<h2>Description</h2><p>${workItem.getDescription()}</p>"
def parent = createConfluencePage(title, spaceId, rootContent, null)

subtasks.forEach {subtask ->
    def subtitle = "${subtask.getKey()} - ${subtask.getSummary()}"
    def pageContent = "<h2>Description</h2><p>${subtask.getDescription()}</p>"
    createConfluencePage(subtitle, spaceId, pageContent, parent)
}

String createConfluencePage(String pageTitle, String spaceId, String pageContent, String parentPage) {
    def params = [
        type : "page",
        title: pageTitle,
        spaceId: spaceId,
        body : [
            storage: [
                value         : pageContent.toString(),
                representation: "storage"
            ]
        ]
    ] as Map
    if (parentPage != null) {
        params["parentId"] = [parentPage].collect { [id: parentPage.toString()] }
    }

    def pageResult = post('/wiki/api/v2/pages')
        .header('Content-Type', 'application/json')
        .body(params)
        .asObject(Map).body

    if (pageResult.statusCode) {
        logger.error("Failed to create a new page. Confluence responded with error code: {}", pageResult.statusCode)
    } else {
        logger.info("Successfully created a new space with id: {}", pageResult)
    }
    pageResult.id
}

parent
```

