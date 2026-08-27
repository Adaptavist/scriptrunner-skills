# Add customer to organisation when a work item is created through the customer portal.

- Platform: cloud
- Feature: post-functions
- Tags: workflow, automate, issue
- Language: groovy
- Doc ID: example-cloud-add-user-to-organisation-when-service-desk-issue-created-cloud
- Source: https://examples.scriptrunner.io/scripts/add-user-to-organisation-when-service-desk-issue-created-cloud

## Overview

Add customers to configured organisations when they create a work item through the service desk portal and select their organisation in a select list custom field.

## Example

As a product manager I want to add customers from a list of companies to organisations automatically when requests are created so that I manage these requests.

## Good to Know

* On line *1* you must specify the Id of your Jira Service Management portal. 
* On line *12* you must specify the name of the custom field where customers will select their organisation in. 
* Any customers who dont match an organisation or specify one will be caught in the default case where we just log out that no matching organisation was found and perform no operation.

* Note: If a user is already in an organisation then the script does not attempt to add them again.

* The utility method named *addToOrganisations* defines all the logic for checking if users already exist in an organisation and adding them if they do not to avoid duplicating this logic inside the Switch statement.

## Script

```groovy
def serviceDeskId = "2"

def currentUser = issue.fields.reporter.accountId

def fields = issue.fields as Map

// Get the Custom field to get the option value from
def organisationCustomField = get("/rest/api/2/field")
        .asObject(List)
        .body
        .find {
            (it as Map).name == "Organisation"
        } as Map

assert organisationCustomField

def organisationValue = (fields[organisationCustomField.id] as Map)?.value

def organisations = get("rest/servicedeskapi/servicedesk/${serviceDeskId}/organization")
        .asObject(Map)

assert organisations

def organisationsValues = organisations.body.values

switch (organisationValue) {
    case "Adaptavist":
        def adaptavistId = organisationsValues.find {
            (it as Map).name == "Adaptavist"
        } as Map

        addToOrganisation(adaptavistId, currentUser)
        break

    case "Google":
        def googleId = organisationsValues.find {
            (it as Map).name == "Google"
        } as Map

        addToOrganisation(googleId, currentUser)
        break

    case "Atlassian":
        def atlassianId = organisationsValues.find {
            (it as Map).name == "Atlassian"
        } as Map

        addToOrganisation(atlassianId, currentUser)
        break

    default:
        logger.info("No matching organisation specified.")
        break
}

// Utility method for handling all the logic to add users to an organisation
def addToOrganisation(Map organisation, currentUser) {
    def currentUsersInOrganistion = get("/rest/servicedeskapi/organization/${organisation.id}/user")
        .asObject(Map)
        .body
        .values

    if (currentUser in currentUsersInOrganistion.accountId) {
        logger.info("User already in organisation, script terminating.")
        return
    }

    def addToOrganisation = post("rest/servicedeskapi/organization/${organisation.id}/user")
        .header("Content-Type", "application/json")
        .body([
            accountIds    : [currentUser],
            organisationId: organisation.id
        ])
        .asObject(Map)

    assert addToOrganisation.status >= 200 && addToOrganisation.status <= 300
}
```

