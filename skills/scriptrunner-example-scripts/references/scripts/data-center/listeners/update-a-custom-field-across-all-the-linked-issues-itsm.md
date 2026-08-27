# Update a Custom Field Across all the Linked Issues - ITSM

- Platform: data-center
- Feature: listeners
- Tags: automate, workflow
- Language: groovy
- Doc ID: example-dataCenter-itsm-lab-3-update-field-in-linked-issues-onPrem
- Source: https://examples.scriptrunner.io/scripts/itsm-lab-3-update-field-in-linked-issues-onPrem

## Overview

Place this script in a Custom Listener, to automatically update the value of a custom field across all linked issues.

* Navigate to **Add-ons** > **Script Listeners** using the **Administration Cog** in the top right corner.
* Click **Add New Item** and select **Custom Listener**.
* Configure the screen and add the code.
* Click **Add**.

## Example

Detailed use case example: [Script Listener for Updating All Linked Incidents](http://hub.adaptavist.com/hubfs/Belgium%20Event%20-%202018/Lab%203%20Script%20Listener%20for%20Updating%20All%20Linked%20Incidents.pdf)

## Good to Know

* Associate this script with the `Issue Updated` event listener.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.ModifiedValue
import com.atlassian.jira.issue.util.DefaultIssueChangeHolder

import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

// the name of the custom field to update
final customFieldName = 'Workaround'

def issue = event.issue
def change = event.changeLog.getRelated('ChildChangeItem').find { it.field == customFieldName }

// Was not the 'Workaround' field that changed, do nothing
if (!change) {
    return
}

def linkedIssues = ComponentAccessor.issueLinkManager
    .getOutwardLinks(issue.id)
    .findAll { it.issueLinkType.name in ['Problem/Incident'] && it.destinationObject.issueType.name == 'Alert' }

// There are no linked 'Alerts' with 'Problem/Incident' link, do nothing
if (!linkedIssues) {
    return
}

def customField = ComponentAccessor.customFieldManager.getCustomFieldObjects(issue)?.find {
    it.name == customFieldName
}

def newWorkaround = """h4. Workaround - ${LocalDateTime.now().format(DateTimeFormatter.ofPattern('dd/MMM/yyyy HH:mm'))}<br>
${change.newstring}"""

linkedIssues.each {
    def linkedIssue = it.destinationObject
    def oldValue = linkedIssue.getCustomFieldValue(customField)
    def newValue = newWorkaround + oldValue
    customField.updateValue(null, linkedIssue, new ModifiedValue(oldValue, newValue), new DefaultIssueChangeHolder())
}
```

