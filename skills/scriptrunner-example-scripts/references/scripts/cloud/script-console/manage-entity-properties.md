# Manage Entity Properties

- Platform: cloud
- Feature: script-console
- Tags: automate, project, issue, user, hapi
- Language: groovy
- Doc ID: example-cloud-manage-entity-properties-cloud
- Source: https://examples.scriptrunner.io/scripts/manage-entity-properties-cloud

## Overview

This example demonstrates the usage of EntityProperties for managing custom properties on Jira Work Items (Issues), Comments, Users, and Spaces (Projects).
The script provides functionality to:
- Set a custom property for each entity type.
- Get a custom property for each entity type based on a key.
- Retrieve all property keys associated with an entity.
- Delete a specific property from an entity.

## Good to Know

Entity properties in Jira support various data types, allowing flexibility in storing custom values. 
You can set and retrieve the following types of properties for each entity:

String – Plain text values.
JSON – Structured data stored as a JSON object.
Boolean – true or false values.
Long – Large numerical values.
Integer – Whole numbers.
LocalDate – Date values without a time component.
LocalDateTime – Date and time values.
ActualType – JSON representation of any object
Each of these types can be set for an entity property and later retrieved using the appropriate key.

## Description

#### Overview

This example demonstrates the usage of EntityProperties for managing custom properties on Jira Work Items (Issues), Comments, Users, and Spaces (Projects).
The script provides functionality to:
- Set a custom property for each entity type.
- Get a custom property for each entity type based on a key.
- Retrieve all property keys associated with an entity.
- Delete a specific property from an entity.

#### Good to Know

Entity properties in Jira support various data types, allowing flexibility in storing custom values. 
You can set and retrieve the following types of properties for each entity:

String – Plain text values.
JSON – Structured data stored as a JSON object.
Boolean – true or false values.
Long – Large numerical values.
Integer – Whole numbers.
LocalDate – Date values without a time component.
LocalDateTime – Date and time values.
ActualType – JSON representation of any object
Each of these types can be set for an entity property and later retrieved using the appropriate key.

## Script

```groovy
import groovy.json.JsonOutput
import java.time.Instant
import java.time.LocalDate
import java.time.LocalDateTime

// 1. User Example
def userEntity = Users.getByAccountId("userAccountID").getEntityProperties()

// Setting Json, string, date properties on user
userEntity.setJson("userTestKey", JsonOutput.toJson([name: "Test", value: "TestValue"]))
userEntity.setLocalDate("userTestingDate", LocalDate.now())
userEntity.setString("userTestString", "Hello World")

// Getting user property values
userEntity.getJson("userTestKey")
userEntity.getLocalDate("userTestingDate")
userEntity.getString("userTestString")

// Getting user json entity property
userEntity.getEntityProperty("userTestKey")

// All user keys
userEntity.getKeys()

// Deleting all user properties
userEntity.delete("userTestKey")
userEntity.delete("userTestingDate")
userEntity.delete("userTestString")

// 2. Work Item Example
def issueEntity = WorkItems.getByKey("WORK_ITEM_KEY").getEntityProperties()

// Setting Json, boolean and datetime properties on work item's entity (issueEntity)
issueEntity.setJson("workItemTestKey", JsonOutput.toJson([name: "WorkItemTest", value: "TestWorkItemValue"]))
issueEntity.setBoolean("workItemTestBool", true)
issueEntity.setLocalDateTime("workItemTestLocalDateTime", LocalDateTime.now())

// Getting issue property values
issueEntity.getJson("workItemTestKey")
issueEntity.getBoolean("workItemTestBool")
issueEntity.getLocalDateTime("workItemTestLocalDateTime")

// Getting issue entity property
issueEntity.getEntityProperty("workItemTestBool")

// All issue keys
issueEntity.getKeys()

// Deleting all issue properties
issueEntity.delete("workItemTestKey")
issueEntity.delete("workItemTestBool")
issueEntity.delete("workItemTestLocalDateTime")

// 3. Space Example
def projectEntity = Spaces.getByKey("SPACE_KEY").getEntityProperties()

// Setting properties on space (project)
projectEntity.setInteger("spaceTestKey", 200)

// Getting project property values
projectEntity.getJson("spaceTestKey")
projectEntity.getEntityProperty("spaceTestKey")
projectEntity.getKeys()

// Deleting project property
projectEntity.delete("spaceTestKey")

// 4. Comment Example
def workItem = WorkItems.getByKey("WORK_ITEM_KEY")
def firstComment = workItem.getComments().getAt(0)
def commentEntity = firstComment.getEntityProperties()

// Setting property on comment
commentEntity.setAsActualType('testingInstance', Instant.now())

// Getting comment property value
commentEntity.getAsActualType("testingInstance", Instant)
commentEntity.getEntityProperty("testingInstance")

// All comment keys
commentEntity.getKeys()

// Deleting comment property
commentEntity.delete("testingInstance")
```

