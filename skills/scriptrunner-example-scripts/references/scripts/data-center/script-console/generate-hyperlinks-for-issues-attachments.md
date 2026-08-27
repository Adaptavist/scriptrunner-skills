# Generate Hyperlinks for Issues Attachments

- Platform: data-center
- Feature: script-console
- Tags: automate, workflow
- Language: groovy
- Doc ID: example-dataCenter-basics-working-with-attachments-onPrem
- Source: https://examples.scriptrunner.io/scripts/basics-working-with-attachments-onPrem

## Overview

Generate a list of hyperlinks for the attachments of an issue, allowing the attachment to be downloaded from the link.

## Example

I want to ensure all my issues have up-to-date attachments and old attachments are removed.
Using this script so attachments are generated as hyperlinks, I can easily monitor and clean up old attachments.

## Description

#### Overview

Generate a list of hyperlinks for the attachments of an issue, allowing the attachment to be downloaded from the link.

#### Example

I want to ensure all my issues have up-to-date attachments and old attachments are removed.
Using this script so attachments are generated as hyperlinks, I can easily monitor and clean up old attachments.

## Script

```groovy
import groovy.xml.MarkupBuilder

final String issueKey = 'SSPA-10'

def issue = Issues.getByKey(issueKey)

def attachments = issue.attachments
if (!attachments) {
    return "No attachments found for issue $issueKey"
}

def stringWriter = new StringWriter()
def content = new MarkupBuilder(stringWriter)

content.html {
    p {
        ul {
            attachments.each { attachment ->
                li {
                    a(href: attachment.downloadUrl, attachment.filename)
                    span("added by " + attachment.authorKey)
                }
            }
        }
    }
}

stringWriter.toString()
```

