# Update Priority Based on Linked Issues - ITSM

- Platform: data-center
- Feature: post-functions
- Tags: automate, workflow, fields, issue
- Language: groovy
- Doc ID: example-dataCenter-itsm-lab-5-update-priority-in-transition-onPrem
- Source: https://examples.scriptrunner.io/scripts/itsm-lab-5-update-priority-in-transition-onPrem

## Overview

Use this script as a post function to update the priority of an issue based on the type of linked issues.

Implement the post function before the _Update Change History for an Issue and Store the Issue in the Database_ step of a workflow.

* Navigate to **Issues** > **Workflows** using the **Administration** Cog in the top right corner.
* Find the _Software Simplified Workflow_ workflow and click **Edit**.
* In the list of transitions, find the _Backlog_ transition and choose **Selected For Development**.
* Click the **Post Functions** tab.
* Click the **Add Post Function** on the right.
* From the list, choose **Script Post-Function [ScriptRunner]** and click **Add**.
* Choose **Custom Script Post-Function**.
* Configure the screen and add the script.
* Click **Update**. The post function should now show up in the list.
* Click **Publish** at the top to publish the workflow.
* When it asks you to save a backup click **No**.

## Example

Detailed use case example: [Using PostFunctions to Set Remedial Action Priority](http://hub.adaptavist.com/hubfs/Belgium%20Event%20-%202018/Lab%205%20Using%20PostFunctions%20to%20Set%20Remedial%20Actions.pdf)

## Description

#### Overview

Use this script as a post function to update the priority of an issue based on the type of linked issues.

Implement the post function before the _Update Change History for an Issue and Store the Issue in the Database_ step of a workflow.

* Navigate to **Issues** > **Workflows** using the **Administration** Cog in the top right corner.
* Find the _Software Simplified Workflow_ workflow and click **Edit**.
* In the list of transitions, find the _Backlog_ transition and choose **Selected For Development**.
* Click the **Post Functions** tab.
* Click the **Add Post Function** on the right.
* From the list, choose **Script Post-Function [ScriptRunner]** and click **Add**.
* Choose **Custom Script Post-Function**.
* Configure the screen and add the script.
* Click **Update**. The post function should now show up in the list.
* Click **Publish** at the top to publish the workflow.
* When it asks you to save a backup click **No**.

#### Example

Detailed use case example: [Using PostFunctions to Set Remedial Action Priority](http://hub.adaptavist.com/hubfs/Belgium%20Event%20-%202018/Lab%205%20Using%20PostFunctions%20to%20Set%20Remedial%20Actions.pdf)

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor

// the name of the priority to set
final priorityName = 'Highest'

def numberOfLinkedAlerts = ComponentAccessor.issueLinkManager
    .getOutwardLinks(issue.id)
    .findAll { it.issueLinkType.name in ['Problem/Incident'] && it.destinationObject.issueType.name == 'Alert' }
    .size()

if (issue.issueType.name == 'Remedial Action' && numberOfLinkedAlerts) {
    def availablePriorities = ComponentAccessor.constantsManager.priorities
    def highestPriority = availablePriorities.findByName(priorityName)

    assert highestPriority: "Could not find priority with name $priorityName. Available priorities are ${availablePriorities*.name}"
    issue.setPriority(highestPriority)
}
```

