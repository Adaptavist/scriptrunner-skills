# Create Split Custom Field Context for Specific Spaces and Work Types in Jira

- Platform: cloud
- Feature: script-console
- Tags: workflow, hapi
- Language: groovy
- Doc ID: example-cloud-Split-Custom-Fields-cloud
- Source: https://examples.scriptrunner.io/scripts/Split-Custom-Fields-cloud

## Overview

This script dynamically configures a new custom field across specified spaces
and work types in Jira. It ensures that the field has relevant 
options available based on the selected initial context.

## Example

As an administrator, I need to ensure that my context field is properly configured with options that are 
relevant only to specific spaces and work types. This script automates the process of fetching field contexts,
adding new contexts, and populating them with options tailored to the needs of "Bug", "Story", and other work types.

## Good to Know

The script assumes that there are existing contexts and spaces in Jira. 
The script can be modified to include additional spaces and work types as needed.

## Script

```groovy
// Retrieve the list of all fields from the JIRA API and parse the response as a list
def fields = get("/rest/api/3/field").asObject(List).body

// Find and store the ID of a specific custom field named "My Custom Field"
def myField = fields.find { field ->
    field.name == "Select List Field"
}.id

// List of the work types that the custom field should be available for
// get("/rest/api/3/issuetype").asObject(List).body to get the list of work types
def workTypes = ["10005", "10007"] // must be IDs

// Fetch the context configuration for the specific field and parse the response as a map
def context = get("/rest/api/3/field/${myField}/context").asObject(Map).body

// Extract the IDs from all contexts available for the field
def contextIds = context.values*.id

// Initialize an empty list to accumulate all options across different contexts

// Use collect to transform each contextId into a list of options
// Use collectMany to transform each contextId into a list of options and flatten the list
def allOptions = contextIds.collectMany { contextId ->
    // Retrieve options for the current field context from the JIRA API
    def optionsResponse = get("/rest/api/3/field/${myField}/context/${contextId}/option").asObject(Map).body
    // Process the options to remove "id" key from each option and collect into a list
    optionsResponse.values.collect { option ->
        option.entrySet().findAll { it.key != "id" }.collectEntries()
    }
}

// Specify the space names of interest
def spaceNames = ["Your space name", "Your second space name"]

// Filter the list of spaces to find those that match the specified names
def matchingSpaces = Spaces.getAllSpaces().findAll { it.name in spaceNames }

// Extract the space IDs from the matching spaces
def spaceIds = matchingSpaces*.id

// Prepare the data for creating a new context for the field, including description, work types, name, and space IDs
def contextDescription = "A context used to define the custom field options for bugs."
def contextName = "Your New Context Name"
def contextBody = [
        description : contextDescription,
        issueTypeIds: workTypes,
        name        : contextName,
        projectIds  : spaceIds
]

// Create a new field context by sending a POST request to the JIRA API
def newContext = post("/rest/api/3/field/${myField}/context")
        .header("Content-Type", "application/json")
        .body(contextBody)
        .asObject(Map)
        .body

// Extract the ID of the newly created context
def contextId = newContext.id

// Define the body of the request to set options for the new context
def optionsBody = [
        options: allOptions
]

// Send a POST request to add options to the newly created context
post("/rest/api/3/field/${myField}/context/${contextId}/option")
        .header("Content-Type", "application/json")
        .body(optionsBody)
        .asObject(Map)
        .body
```

