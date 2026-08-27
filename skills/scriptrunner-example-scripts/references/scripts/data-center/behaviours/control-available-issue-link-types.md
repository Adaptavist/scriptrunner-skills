# Control Available Issue Link Types

- Platform: data-center
- Feature: behaviours
- Tags: issue, fields
- Language: groovy
- Doc ID: example-dataCenter-control-link-directions-onPrem
- Source: https://examples.scriptrunner.io/scripts/control-link-directions-onPrem

## Overview

*Behaviours* allow you to change how fields behave on issue Create or Update screens.
Use this script to restrict the available link values on the Linked Issues field inside an issue Create or Update screen.

## Example

As a project manager, I want to limit the available issue link types for issues in a specific project so that I can easily create and maintain JQL filters to find issues with certain link types.
I can use this script to restrict the link type options in the Create or Update form of an issue, to only those I have approved.
Limiting the link types used, and therefore number of JQL filters I need to create/maintain.

## Good to Know

* Set up this script as an initialiser.
* This script only works in the issue Create and Update screens, but not on the Link form accesible through the More options menu in the issue View page.
* Add the Linked Issue field to the Create or Update issue screens.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.link.IssueLinkTypeManager
import com.onresolve.jira.groovy.user.FieldBehaviours
import org.apache.log4j.Logger
import org.apache.log4j.Level
import groovy.transform.BaseScript

@BaseScript FieldBehaviours fieldBehaviours
def log = Logger.getLogger(getClass())
log.setLevel(Level.DEBUG)

def linkTypesField = getFieldById("issuelinks-linktype")

def allowedOutwardTypesNames = ["blocks", "relates to", "causes"]
def allowedInwardTypesNames = ["is blocked by", "relates to", "is caused by"]

def issueLinkTypeManager = ComponentAccessor.getComponent(IssueLinkTypeManager)
def allLinkTypes = issueLinkTypeManager.getIssueLinkTypes(false)

// Get the outward link names you want
def outwardAllowedLinks = allLinkTypes.findAll { linkType ->
    linkType.outward in allowedOutwardTypesNames
}.collectEntries { linkType ->
    [(linkType.outward): linkType.outward]
}
// Get the inward link names you want
def inwardAllowedLinks = allLinkTypes.findAll { linkType ->
    linkType.inward in allowedInwardTypesNames
}.collectEntries { linkType ->
    [(linkType.inward): linkType.inward]
}

// Combine maps of allowed link direction names
def allowedLinks = outwardAllowedLinks + inwardAllowedLinks
log.debug("Allowed Links = $allowedLinks")

// The options for the 'issuelinks-linktype' field have to be set in this structure: [blocks:blocks, relates to:relates to]
// because the html structure of the field uses the actual link direction name as the value property.
linkTypesField.setFieldOptions(allowedLinks)
```

