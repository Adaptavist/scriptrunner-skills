# Clone a Work item on transition with new due date and update date attribute of associated Assets.

- Platform: cloud
- Feature: post-functions
- Tags: workflow, automate, fields, issue, hapi
- Language: groovy
- Doc ID: example-cloud-Clone-issue-on-transition-with-new-due-date-and-update-date-attribute-of-associated-Assets-object-cloud
- Source: https://examples.scriptrunner.io/scripts/Clone-issue-on-transition-with-new-due-date-and-update-date-attribute-of-associated-Assets-object-cloud

## Overview

This script shows how to clone a work item with associated Assets with new work item Due Date in 3 months. Then, update a date attribute of the associated Assets.

## Example

As a product owner, I want to clone a work item to schedule a new maintenance task on Asset objects in the work item with a new due date in 3 months. Also, update the last maintenance date attribute of the Asset objects with original due date.

## Good to Know

* This example just clones the Summary, Description, Due date and Assets field but you can specify other fields to be cloned in the fields section of the rest API call.
* You can get the Object Attribute ID by navigating to Scheme > Object Type > Attributes.
* You need to pass your user account and [API token](https://support.atlassian.com/atlassian-account/docs/manage-api-tokens-for-your-atlassian-account/) for Assets API requests. As a best practice, you can store them as [Script Variables](https://docs.adaptavist.com/sr4jc/latest/features/script-variables). [Authentication proxy support](https://docs.adaptavist.com/sr4jc/latest/best-practices/rest-apis) for it is on the roadmap, please subscribe and vote on our [public Nolt backlog](https://scriptrunner-for-jira-cloud.nolt.io/186) to get updates on the progress.
* The customfield used to store the asset needs to be configured to be on the Create Work item screen of the space in order for the work item creating function to succeed.
  This can be set up by opening a work item and clicking on Configure > Custom Fields > (search for field via search box) > the Field > Screens

## Script

```groovy
import java.time.format.DateTimeFormatter
import java.time.LocalDate
import java.sql.Timestamp

// To find the Assets Attribute ID: Navigate to Scheme > Object Type > Attributes
def assetCustomFieldName = "customfield_12834"
final lastMaintenanceDateAssetAttributeId = 153

def sourceWorkItem = WorkItems.getByKey(issue.key) // Get the work item
def dueDate = sourceWorkItem.getDueDate()

if (!dueDate) {
    logger.error "No original due date"
    return
}

def assetFieldValue = sourceWorkItem.getCustomFieldValue(assetCustomFieldName)

if (!assetFieldValue) {
    logger.error "No value in Assets field: $assetCustomFieldName"
    return
}

final dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd")

def newDueDate = dueDate.toLocalDate().plusMonths(3)
def workItemKey = sourceWorkItem.getSpaceObject().key
def workTypeName = sourceWorkItem.getWorkType().name

WorkItems.create(workItemKey, workTypeName) {
    setSummary(sourceWorkItem.getSummary())
    setDescription(sourceWorkItem.getDescription())
    setDueDate(newDueDate.format(dateFormatter))
    setCustomFieldValue(assetCustomFieldName, assetFieldValue)
}.link("clones", sourceWorkItem)

assetFieldValue.each { asset ->
    def assetWorkspaceId = asset.workspaceId
    def assetObjectId = asset.objectId
    def updatedAssetResponse = put("https://api.atlassian.com/jsm/assets/workspace/" + assetWorkspaceId + "/v1/object/" + assetObjectId)
            .header("Content-Type", "application/json")
            .basicAuth("email@example.com", "<api_token>")
            .body([
                    attributes: [
                            [
                                    objectTypeAttributeId: lastMaintenanceDateAssetAttributeId,
                                    objectAttributeValues: [
                                            [
                                                    value: dueDate.toLocalDate().format(dateFormatter).toString(),
                                            ]
                                    ]
                            ]
                    ]
            ])
            .asObject(Map)

    assert updatedAssetResponse.status >= 200 && updatedAssetResponse.status < 300
}
```

