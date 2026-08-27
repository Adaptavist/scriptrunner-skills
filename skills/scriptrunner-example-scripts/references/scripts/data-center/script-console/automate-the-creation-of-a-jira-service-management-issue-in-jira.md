# Automate the Creation of a Jira Service Management Issue in Jira

- Platform: data-center
- Feature: script-console
- Tags: automate, issue, hapi
- Language: groovy
- Doc ID: example-dataCenter-basics-create-jsm-issue-onPrem
- Source: https://examples.scriptrunner.io/scripts/basics-create-jsm-issue-onPrem

## Overview

This script demonstrates how to create Jira Service Management issues programmatically. 
You can use this script anywhere in Jira that allows you to add a custom script e.g. listeners, workflow functions, REST Endpoints. 
You can either add this as a standalone script or as part of a larger script to create some serious automation!

There are two examples here. 
The first creates a Jira Service Management issue with minimal fields - the project, issue type and the summary. 
By default, no other fields are required in Jira.

The second example demonstrates setting some additional fields.

## Example

I want to create multiple Jira Service Management issues weekly for organizations.

## Description

#### Overview

This script demonstrates how to create Jira Service Management issues programmatically. 
You can use this script anywhere in Jira that allows you to add a custom script e.g. listeners, workflow functions, REST Endpoints. 
You can either add this as a standalone script or as part of a larger script to create some serious automation!

There are two examples here. 
The first creates a Jira Service Management issue with minimal fields - the project, issue type and the summary. 
By default, no other fields are required in Jira.

The second example demonstrates setting some additional fields.

#### Example

I want to create multiple Jira Service Management issues weekly for organizations.

## Script

```groovy
// By default this is all you need to specify
Issues.create('JSM', 'IT Help') {
    setSummary('Please help!')
}

// and an example setting more fields
Issues.create('JSM', 'IT Help') {
    setSummary('Need more help!')
    setDescription('a longer description')
    setRequestType('Computer support')
    setRequestChannel('api')
    setRequestParticipants(Users.loggedInUser)
    setOrganizations('My Org', 'My Other Org')
}
```

