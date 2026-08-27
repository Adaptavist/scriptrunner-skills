# Automate the Creation of a Work Item in Jira Cloud

- Platform: cloud
- Feature: script-console
- Tags: issue, hapi, automate
- Language: groovy
- Doc ID: example-cloud-basics-create-issue-cloud-cloud
- Source: https://examples.scriptrunner.io/scripts/basics-create-issue-cloud-cloud

## Overview

This script saves you the time and effort of creating work items manually. 
You can add this script to anywhere in Jira that allows you to add a custom script e.g. listeners, workflow functions, REST Endpoints. 
You can either add this as a standalone script or as part of a larger script to create some serious automation!

## Example

I am a product manager, and I need to create several work items weekly for different departments. 
For example, I need marketing to provide me with a weekly analytics report for live product campaigns. 
Previously, I was having to spend time every week manually assigning these work items. However, with this script, I can schedule the work items to be created automatically every week.

## Good to Know

- If the reporter user does not exist, it's assigned to the logged in user.
- Work Item type defined must exist in the space.
- If priority defined does not exist, it takes the first priority that the 'priority' endpoint returns.

## Script

```groovy
def loggedInUser = Users.getLoggedInUser()
def accountId = "Account ID of user"
def reporterUser = accountId ? Users.getByAccountId(accountId) : null
def reporter = reporterUser ?: loggedInUser

WorkItems.create("SPACE_KEY", "WORK_TYPE_NAME") {
    setReporter(reporter)
    setSummary('Groovy Friday')
    setPriority('High')
}
```

