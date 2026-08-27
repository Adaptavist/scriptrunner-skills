# Create Work items based on data retrieved from External Systems

- Platform: cloud
- Feature: script-fields
- Tags: automate, issue, fields, hapi
- Language: groovy
- Doc ID: example-cloud-create-issue-from-external-system-cloud
- Source: https://examples.scriptrunner.io/scripts/create-issue-from-external-system-cloud

## Overview

This script makes an external system call and creates a new work item in a selected space, based on information returned.

## Example

I am in charge of the company on-boarding Jira space. Every time a new employee is added to our external HR system,
I would like Jira work items to be created based on their department. I can use this script to connect to that systems
REST API, retrieve the required data, and create work items automatically, saving me the time and effort of manually
creating work items.

## Good to Know

* External task type can be defined as a new type to identify what work items has been created by the external system.
* External system can be customised with the requirements needed. In this example, external system specifications are:
  - No authentication is required. If authentication is needed, can be added in the endpoint call thanks to [Unirest HTTP Library](http://kong.github.io/unirest-java/#requests).
  - A query parameter named as "timestamp" is needed to specify search date.
  - Result obtained is a JSON objects list, where each object has a property named as "name" and "message". Based on this information, the new work items can be created in Jira.

## Script

```groovy
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
    WorkItems.create(spaceKey, externalWorkItemTypeName ) {
        summary = result.name
        description = result.message
    }
}
```

