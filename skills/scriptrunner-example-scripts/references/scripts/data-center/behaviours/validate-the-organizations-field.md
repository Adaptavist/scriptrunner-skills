# Validate the Organizations field

- Platform: data-center
- Feature: behaviours
- Tags: issue
- Language: groovy
- Doc ID: example-dataCenter-validate-the-organizations-field-onPrem
- Source: https://examples.scriptrunner.io/scripts/validate-the-organizations-field-onPrem

## Overview

This behaviour is used to validate the Service Desk's Organizations field while creating or editing an issue.

## Example

This behaviour makes a call to the REST endpoint using the [sample code](https://library.adaptavist.com/entity/use-the-rest-endpoint-to-get-the-organizations-details).
Once the values are obtained from the REST endpoint, they are stored in a map. 
Next, the IDs of organizations selected from Organizations field will be used to get the values from the map.
Once the values are obtained from the map, the characters used in the map values (the organizations' names) are validated to check if they meet the conditions set.

## Description

#### Overview
This behaviour is used to validate the Service Desk's Organizations field while creating or editing an issue.
                              
#### Example
This behaviour makes a call to the REST endpoint using the [sample code](https://library.adaptavist.com/entity/use-the-rest-endpoint-to-get-the-organizations-details).
Once the values are obtained from the REST endpoint, they are stored in a map. 
Next, the IDs of organizations selected from Organizations field will be used to get the values from the map.
Once the values are obtained from the map, the characters used in the map values (the organizations' names) are validated to check if they meet the conditions set.

## Script

```groovy
import com.onresolve.jira.groovy.user.FieldBehaviours
import groovy.json.JsonSlurper
import groovy.transform.BaseScript

@BaseScript FieldBehaviours behaviours
def organization = getFieldById(fieldChanged)
def organizationValue = organization.formValue as List
organization.clearError()

//Specify the Service Desk's ID
final def serviceDeskId = '<SERVICE_DESK_ID>'
final def host = applicationProperties.getString('jira.baseurl')
final def restEndpointName = 'getOrganizations'

def baseUrl = "${host}/rest/scriptrunner/latest/custom/${restEndpointName}?serviceDeskId=${serviceDeskId}"
def response = baseUrl.toURL().text

def json = new JsonSlurper().parseText(response) as Map

organizationValue.each {
    def output = json[it].toString()
    //Validate characters used in the String
    if (!Character.isLetter(output.charAt(0)) || !Character.isLetter(output.charAt(1)) || !Character.isDigit(output.charAt(2))
            || !Character.isDigit(output.charAt(3)) || !Character.isDigit(output.charAt(4)) || output.charAt(5).toString() != '_') {
        organization.setError("Invalid Characters Used")
    }
}
```

