# Copy attachments from one work item to another

- Platform: cloud
- Feature: script-console
- Tags: organise, administer, issue, hapi
- Language: groovy
- Doc ID: example-cloud-copy-attachments-from-one-issue-to-another-cloud
- Source: https://examples.scriptrunner.io/scripts/copy-attachments-from-one-issue-to-another-cloud

## Overview

This script copies all attachments from one Jira work item to another work item. 
It retrieves the attachment metadata from the source work item, downloads each file, and uploads it to the destination work item.

## Example

I am a project manager, and I want to duplicate all files from a bug reported in one work item to a follow-up work item. 
I can use this script to automatically transfer every attachment without manually downloading and uploading each file.

## Good to Know

* You need to provide both the source and destination work item keys to indicate where attachments should be copied from and to.

## Script

```groovy
import org.apache.http.entity.ContentType

def originWorkItemKey = "TEST-1"
def destinationWorkItemKey = "TEST-2"
def sourceWorkItem = WorkItems.getByKey(originWorkItemKey)

// Get all the attachment details in the origin work item
def attachments = sourceWorkItem.fields.attachment
logger.info("${attachments}")

attachments.each{ attachment ->
    // Get the attachment as binary
    logger.info("${attachment.content}")
    def fileBody = get("${attachment.content}").asBinary().body

    // Add the attachment to the destination work item
    def result = post("/rest/api/3/issue/" + destinationWorkItemKey + "/attachments")
        .header('X-Atlassian-Token', 'no-check')
        .field("file", fileBody, ContentType.create(attachment.mimeType), attachment.filename)
        .asObject(List)

    if (result.status == 200){
        return result.body
    } else {
        return "Failure in adding attachment => Status: ${result.status} ${result.body}"
    }
}
```

