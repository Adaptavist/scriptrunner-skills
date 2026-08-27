# Trim comments on Work Items which exceed a maximum number of comments

- Platform: cloud
- Feature: script-console
- Tags: automate, organise, manage, hapi
- Language: groovy
- Doc ID: example-cloud-Trim-Down-Comments-On-Issues-That-Exceed-A-Maximum-Number-Of-Comments-cloud
- Source: https://examples.scriptrunner.io/scripts/Trim-Down-Comments-On-Issues-That-Exceed-A-Maximum-Number-Of-Comments-cloud

## Overview

Trim down comments on all work items which exceed specified number of comments on them inside a space.

## Example

As a project manager I want to clear up comments on work items with over 25 comments on to keep my backlog in a refined state.

## Good to Know

* This script removes the oldest comments first.
* This script uses the [numberOfComments](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/jql-keywords#numberofcomments) JQL Keyword provided by *ScriptRunner for Jira Cloud*.

## Script

```groovy
// Specify the space key
def spaceKey = ""

// Specify the number of comments
def maximumNumberOfComments = 0

// Validate that a spaceKey and maximum number of comments has been specified
if (spaceKey.size() == 0 || maximumNumberOfComments == 0) {
    return "You must specify a space key and the maximum number of comments to be able to archive the work items"
}

// Construct the JQL to return the work items which have comments exceeding the threshold
def jqlQuery = "project = ${spaceKey} and numberOfComments > ${maximumNumberOfComments}"

def searchRes = WorkItems.search(jqlQuery)

searchRes.each { workItem ->
    def comments = (List<Map>) (workItem.fields.comment as Map).comments

    def numberOfComments = comments.size()

    def commentsToDrop = numberOfComments - maximumNumberOfComments

    def commentsToDelete = comments*.id.take(commentsToDrop)

    commentsToDelete.each { id ->
        def deleteComment = delete("/rest/api/3/issue/${workItem.key}/comment/${id}")
            .asObject(String)
        // Validate the comment was deleted correctly
        assert deleteComment.status >= 200 && deleteComment.status < 300
    }
    // Log out how many comments were removed per work item
    logger.info("${commentsToDrop} Comments were removed to leave the ${maximumNumberOfComments} newest comments on the ${workItem.key} work item.")
}
```

