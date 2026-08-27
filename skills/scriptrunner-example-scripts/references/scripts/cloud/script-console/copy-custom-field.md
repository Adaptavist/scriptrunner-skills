# Copy Custom Field

- Platform: cloud
- Feature: script-console
- Tags: automate, issue, fields, hapi
- Language: groovy
- Doc ID: example-cloud-copy-custom-field-cloud
- Source: https://examples.scriptrunner.io/scripts/copy-custom-field-cloud

## Overview

This example shows how you can copy custom field values for work items returned by a JQL search.

## Description

#### Overview

This example shows how you can copy custom field values for work items returned by a JQL search.

## Script

```groovy
// Define a JQL query for the work items on which you want to copy custom field values
def query = 'project = FOO'

// Here you can specify the names of the fields you want to copy from and into
def sourceFieldName = 'Assignee'
def targetFieldName = 'My User Field'

// We retrieve a list of all fields in this JIRA instance
def fields = get("/rest/api/2/field")
    .asObject(List)
assert fields.status == 200

List<Map> allFields = fields.body
// Now we lookup the field IDs
Map sourceField = allFields.find { it.name == sourceFieldName }
Map targetField = allFields.find { it.name == targetFieldName }

assert sourceField : "No field found with name '${sourceFieldName}'"
assert targetField : "No field found with name '${targetFieldName}'"

// Search for the work items we want to update
def searchResult = WorkItems.search(query)

// A useful helper method
def sanitiseValue(fieldValue) {
    // If we strip ids and self links out, we can set options by their values
    if (fieldValue instanceof Map) {
        fieldValue.remove('id')
        fieldValue.remove('self')
    }
    if (fieldValue instanceof List || fieldValue.class?.isArray()) {
        fieldValue.each {
            sanitiseValue(it)
        }
    }
}
// Each field type stores its value in a different way, we allow some conversion between types here
def getValue(sourceValue, String sourceType, String targetType) {
    if (sourceType == targetType) {
        return sourceValue
    }
    if (sourceType == 'option' && targetType == 'array') {
        return [sourceValue]
    }

    if (sourceType == 'option' && targetType == 'string') {
        return (sourceValue as Map).value
    }

    if (sourceType == 'array' && (targetType == 'option' || targetType == 'user')) {
        return (sourceValue as List)[0]
    }
    if (sourceType == 'array' && targetType == 'string') {
        return (sourceValue as List<Map>).collect { it.value }.join(',')
    }

    if (sourceType == 'string' && targetType == 'option') {
        return [value: sourceValue]
    }

    if (sourceType == 'string' && targetType == 'array') {
        return [[value:sourceValue]]
    }
    if (sourceType == 'user' && targetType == 'array') {
        return [sourceValue]
    }
    sourceValue
}

String sourceType = (sourceField.schema as Map).type
String targetType = (targetField.schema as Map).type
def count = 0

// Now we iterate through the search results
searchResult.each { workItem ->
    def workItemFields = workItem.fields as Map
    def sourceFieldValue = workItemFields[sourceField.key]

    if (sourceFieldValue) {
        // If there is a field value in the source field we try and convert it into a format that
        // the target field will understand
        sanitiseValue(sourceFieldValue)
        def updateDoc = [fields: [
            (targetField.key): getValue(sourceFieldValue, sourceType, targetType)
        ]]

        // Now we make the change, ignoring whether the field exists on the edit screen
        workItem.update {
            setCustomFieldValue(targetFieldName, getValue(sourceFieldValue, sourceType, targetType))
        }
        count++
    }
}
logger.info("Updated '${targetFieldName}' on ${count} issues")
```

