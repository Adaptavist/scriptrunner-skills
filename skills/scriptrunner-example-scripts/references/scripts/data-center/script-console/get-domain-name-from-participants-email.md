# Get Domain Name from Participants Email

- Platform: data-center
- Feature: script-console
- Tags: issue
- Language: groovy
- Doc ID: example-dataCenter-get-domain-name-from-participants-email-onPrem
- Source: https://examples.scriptrunner.io/scripts/get-domain-name-from-participants-email-onPrem

## Overview

The ScriptRunner console is used to extract the domain name from the email addresses of the participants, 
once their email has been retrieved using the [REST endpoint](https://library.adaptavist.com/entity/get-email-address-of-participants).

## Example

In this example, after the email addresses are obtained from the REST endpoint, the domain name of each email address is extracted and logged.

## Description

#### Overview

The ScriptRunner console is used to extract the domain name from the email addresses of the participants, 
once their email has been retrieved using the [REST endpoint](https://library.adaptavist.com/entity/get-email-address-of-participants).
                              
#### Example

In this example, after the email addresses are obtained from the REST endpoint, the domain name of each email address is extracted and logged.

## Script

```groovy
import groovy.json.JsonSlurper

//Set the base url of your jira instance
def baseUrl = '<JIRA_BASE_URL>'

//Specify the issue key
final def issueKey = '<ISSUE_KEY>'

final def restEndpointName = 'getParticipantsEmail'

def hostUrl = "${baseUrl}/rest/scriptrunner/latest/custom/${restEndpointName}?issueKey=${issueKey}"

def response = hostUrl.toURL().text

def json = new JsonSlurper().parseText(response)

def artifacts = json.collect().sort()

artifacts.each {
    log.warn "${it.toString().split('@').last()}"
}
```

