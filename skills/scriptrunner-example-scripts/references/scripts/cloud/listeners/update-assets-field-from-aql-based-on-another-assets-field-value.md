# Update Assets field from AQL based on another Assets field value

- Platform: cloud
- Feature: listeners
- Tags: issue, automate, fields
- Language: groovy
- Doc ID: example-cloud-Update-assets-field-from-aql-based-on-another-assets-field-value-cloud
- Source: https://examples.scriptrunner.io/scripts/Update-assets-field-from-aql-based-on-another-assets-field-value-cloud

## Overview

The scripts shows how you can retrieve an Assets field value. Then, perform an AQL query to retrieve a list of Asset objects and save them into another Assets field.

## Example

As a JSM agent, I want to fill matched phones to an Assets field named "Phones" from a chosen phone model. The phone model is selected in another Assets field named Model in a JSM ticket raised by a customer.
The phone models and phones are Assets stored in Jira Service Management. Each phone has an attribute named 'Model Name' using phone model as type value.

## Good to Know

* This script can bet set as a listener for Issue Created event.
* [More examples](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners/script-listener-examples) on setting different fields in our documentation site.
* You need to pass your user account and [API token](https://support.atlassian.com/atlassian-account/docs/manage-api-tokens-for-your-atlassian-account/) for Assets API requests. As a best practice, you can store them as [Script Variables](https://docs.adaptavist.com/sr4jc/latest/features/script-variables). [Authentication proxy support](https://docs.adaptavist.com/sr4jc/latest/best-practices/rest-apis) for it is on the roadmap, please subscribe and vote on our [public Nolt backlog](https://scriptrunner-for-jira-cloud.nolt.io/186) to get updates on the progress.

## Script

```groovy
final MODEL_ASSETS_CUSTOMFIELD_ID = 'customfield_12832'
final PHONES_ASSETS_CUSTOMFIELD_ID = 'customfield_12834'
final ATTRIBUTE_NAME_OF_MODEL_IN_PHONES = 'Model Name'

def workItemKey = issue.key

def getModelNameResponse = get('/rest/api/3/issue/' + workItemKey)
        .header('Content-Type', 'application/json')
        .queryString("expand", "${MODEL_ASSETS_CUSTOMFIELD_ID}.cmdb.attributes")
        .asObject(Map)

assert getModelNameResponse.status == 200

if (!getModelNameResponse.body.fields[MODEL_ASSETS_CUSTOMFIELD_ID]) {
    logger.warn "No value in Assets field: $MODEL_ASSETS_CUSTOMFIELD_ID"
    return
}

def workspaceId = getModelNameResponse.body.fields[MODEL_ASSETS_CUSTOMFIELD_ID].first().workspaceId
def objectSchemaId = getModelNameResponse.body.fields[MODEL_ASSETS_CUSTOMFIELD_ID].first().objectType.objectSchemaId
def modelName = getModelNameResponse.body.fields[MODEL_ASSETS_CUSTOMFIELD_ID].first().label
def aql = """
    "objectSchemaId" = "$objectSchemaId" and "$ATTRIBUTE_NAME_OF_MODEL_IN_PHONES" = "$modelName"
"""

def aqlQueryResponse = post("https://api.atlassian.com/jsm/assets/workspace/$workspaceId/v1/object/aql")
        .header('Content-Type', 'application/json')
        .basicAuth("user@example.com", "<api_token>")
        .body([
                qlQuery: aql
        ])
        .asObject(Map)

assert aqlQueryResponse.status == 200

def matchedPhoneAssetIds = aqlQueryResponse.body.values*.globalId
def updatePhonesAssetsFieldResponse = put('/rest/api/3/issue/' + workItemKey)
        .header('Content-Type', 'application/json')
        .body([
                fields:[
                        (PHONES_ASSETS_CUSTOMFIELD_ID): matchedPhoneAssetIds.collect { id -> [id: id] }
                ]
        ]).asString()

assert updatePhonesAssetsFieldResponse.status == 204
```

