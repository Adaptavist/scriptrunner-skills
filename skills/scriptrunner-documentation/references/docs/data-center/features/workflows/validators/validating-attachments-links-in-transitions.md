# Validating Attachments/Links In Transitions

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > workflows > validators
- Doc ID: doc-sr4js-442886030
- Source: https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/validating-attachments-links-in-transitions

If a user adds attachments or links in a workflow transition, normally you cannot validate them because they're not accessible via the Jira API until the transition is complete. However, we have made it easy to access links or attachments by using extension methods on `[MutableIssue](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/issue/MutableIssue.html?_ga=2.93838303.393075385.1679903559-2029362582.1658496808)`. Check out the following documentation for more information on accessing attachments and links during transition:

-   [Accessing attachments during transition](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-attachments#attachment-during-transition)
-   [Accessing links in transition](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-issue-links#links-in-transition)

## Validating attachments added

The following example details how to find properties of attachments added to this transition or on creation, for example the file name. 

The **Attachments** field must be on the transition screen to get attachments like this.

```
issue.attachmentsAddedInTransition.each { attachment ->
    log.debug("Uploaded attachment name: ${attachment.filename}")
}
```

### Making attachments required on issue creation

Using the following script in conjunction with a [Custom script validator](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/custom-validators), you can make attachments required on issue creation:

This validator must be added to the **Create** transition. 

```
import com.opensymphony.workflow.InvalidInputException

if(issue.attachmentsAddedInTransition.size() == 0) {
    throw new InvalidInputException("attachment", "Attachment is required")
}
```

## Blocking files by extension

Using the following script in conjunction with a [Simple scripted validator](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/simple-scripted-validators), you can block files with certain extensions from being added:

```
import com.google.common.io.Files

def extensionsToBlock = ['exe', 'reg']

!issue.attachmentsAddedInTransition.any { attachment ->
    Files.getFileExtension(attachment.filename).toLowerCase() in extensionsToBlock
}
```

You cannot select the **Attachments** field as the field to show the error on. Leave the error field blank, and the error message will be shown at the top of the form.

## Reading attachments added this transition

If you need to read the contents of newly-added attachments, for in-depth validation, you can get the data as follows:

```
issue.attachmentsAddedInTransition.each { attachment ->
    attachment.withInputStream { stream ->
        log.warn('File text: ' + stream.text)
    }
}
```

Check out our HAPI documentation on [Accessing attachments during transition](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-attachments#attachment-during-transition) for more information on how to access attachments during transition.

## Validating links added this transition

The following example shows how to read links that have been added on the screen during the transition, and in this case, stops the action unless at least one _blocks_ link has been added.

```
issue.allOutwardLinks*.issueLinkType.outward == ['blocks']
```

Check out our HAPI documentation on [Accessing links in transition](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-issue-links#links-in-transition) for more information on how to access links in transition.

  

* * *

## Related content

-   [Work with Attachments](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-attachments)
-   [Work with Issue Links](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-issue-links)
-   [Validators](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators)
