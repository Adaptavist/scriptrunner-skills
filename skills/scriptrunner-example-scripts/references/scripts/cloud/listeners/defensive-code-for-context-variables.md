# Defensive code for context variables

- Platform: cloud
- Feature: listeners
- Tags: issue, hapi, customise, automate
- Language: groovy
- Doc ID: example-cloud-defensive-code-for-context-variables-cloud
- Source: https://examples.scriptrunner.io/scripts/defensive-code-for-context-variables-cloud

## Overview

Write code in Script Listeners that preemptively checks for the presence of all the context variables needed in the script

## Example

This example demonstrates how to safely write a script for a Script Listener, triggered by the update of a work item or attachment addition, to add a comment to the work item.
The comment mentions the display name of the user who initiated the event.

## Good to Know

Script Listeners provide access to different context variables depending on the selected trigger events.
For this script to function correctly, it must have access to the 'user' and 'work item' context variables.
For instance, the 'issue_updated' event provides these variables, whereas 'attachment_created' does not.
By selecting both events as triggers, defensive coding ensures that the script performs the desired task when possible (e.g., for 'issue_updated') and gracefully fails while logging useful information when not (e.g., for 'attachment_created').

## Script

```groovy
// Variables ISSUE and USER are being used in the script, so the logic first checks their availability

def missingVariables = ['issue', 'user'].findAll { !binding.hasVariable(it) }

if (missingVariables.isEmpty()) {
    def eventWorkItem = WorkItems.getByKey(issue.key as String)
    eventWorkItem.addComment("Last updated by: ${user.displayName}")
} else {
    logger.warn("No variable(s) [${missingVariables.join(', ')}] available in the context for event [${webhookEvent}]")
}
```

