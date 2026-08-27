# Trim links on work items which exceed a maximum number of links

- Platform: cloud
- Feature: script-console
- Tags: automate, organise, manage, hapi
- Language: groovy
- Doc ID: example-cloud-Trim-Issue-Links-On-Issues-That-Exceed-A-Maximum-Number-Of-Issue-Links-cloud
- Source: https://examples.scriptrunner.io/scripts/Trim-Issue-Links-On-Issues-That-Exceed-A-Maximum-Number-Of-Issue-Links-cloud

## Overview

Trim down links on all work items which have over a specified number of links on them inside a space.

## Example

As a project manager I want to trim down links on work items with over 25 links to other work items to keep my backlog in a refined state.

## Good to Know

* This script deletes the oldest links on the work item first
* This script uses the [numberOfLinks](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/jql-keywords#numberoflinks) JQL Keyword provided by *ScriptRunner for Jira Cloud*.

## Script

```groovy
// Specify the space key
def spaceKey = ""

// Specify the number of links threshold
def maximumNumberOfLinks = 0

// Validate that a spaceKey and maximum number of links has been specified
if (spaceKey.size() == 0 || maximumNumberOfLinks == 0) {
    return "You must specify a space key and the maximum number of links to be able to trim the links"
}

// Construct the JQL to return the work items which have links exceeding the threshold
def jqlQuery = "project = ${spaceKey} and numberOfLinks > ${maximumNumberOfLinks}"

def processedWorkItems = []

WorkItems.search(jqlQuery).each { workItem ->
    def links = workItem.getLinks()
    def numberOfLinks = links.size()

    def numberOfLinksToDrop = numberOfLinks - maximumNumberOfLinks
    def linksToBeDeleted = links.take(numberOfLinksToDrop)

    linksToBeDeleted.each { link ->

        def linkName = link.inwardIssue ? link.type.inward : link.type.outward
        def targetWorkItemKey = link.inwardIssue?.key ?: link.outwardIssue?.key

        try {
            workItem.unlink(linkName, WorkItems.getByKey(targetWorkItemKey))
        } catch (e) {
            if (e.message.contains("No work item link with id")) {
                // Just log and skip to the next link to be deleted if this link got deleted by a previous iteration from another work item
                logger.error(e.message)
            } else {
                // Otherwise do throw the exception
                throw e
            }
        }
    }

    def result = "${numberOfLinksToDrop} links on the ${workItem.key} work item were removed to leave the ${maximumNumberOfLinks} newest links."
    logger.info(result)
    processedIssues.add(result)
}

processedWorkItems
```

