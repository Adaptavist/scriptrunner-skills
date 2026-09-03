# Simplify Current Scripts with HAPI

- Platform: data-center
- Space: SR4JS
- Hierarchy: hapi
- Doc ID: doc-sr4js-441364159
- Source: https://docs.adaptavist.com/sr4js/latest/hapi/simplify-current-scripts-with-hapi

The following page will guide you through ways to simplify your current scripts with [HAPI](https://docs.adaptavist.com/sr4js/latest/hapi). The guidance will include why it's useful to simplify your scripts, how to find scripts that can be simplified, and examples of simplified scripts. 

What is HAPI?

HAPI is an API (application programming interface) for doing common tasks in Jira, including managing issues, searching for issues, updating fields and much more! HAPI is a simple alternative to Jira's regular API and can be used in your Groovy scripts. Go to our [main HAPI page](https://docs.adaptavist.com/sr4js/latest/hapi) to learn more about HAPI.

## Why should you simplify your scripts with HAPI?

There are many reasons you should simplify your scripts with HAPI:

-   It significantly reduces the complexity of your scripts by abstracting away a lot of the boilerplate code. This ensures your scripts are easier to write and understand.
-   Scripts that utilize HAPI are easier to maintain, which means less time troubleshooting when scripts stop working. We maintain HAPI functions, so when Atlassian makes changes to their underlying API, we will ensure that your scripts continue to function correctly without you having to make any changes.
-   Scripts that are built using HAPI will be easier to migrate if you decide to move to Jira Cloud. HAPI in ScriptRunner for Jira Cloud works the same as it does in Data Center, however, not all methods that are available in Data Center are available in Cloud (see the [Feature Parity](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/migrating-to-cloud/feature-parity#hapi) page for more details). Scripts that utilize HAPI methods will likely need far fewer modifications to be migrated to ScriptRunner for Jira Cloud.

## How to find scripts to simplify

The easiest way to find scripts that can be simplified with HAPI is by using the [Script Registry](https://docs.adaptavist.com/sr4js/latest/features/script-registry) and the [HAPI code helper](https://docs.adaptavist.com/sr4js/latest/get-started/settings/hapi-code-helper):

1.  From ScriptRunner, select the ellipsis menu and select **Script Registry**.  
    ![Image showing the Script Registry option being selected](/sr4js/files/latest/441364159/441364162/1/1733833106000/Script_registry_1.png)
2.  Select **Run**. All of your ScriptRunner custom scripts will display below, categorized by feature.   
    ![Image showing the Script Registry Run button highlighted](/sr4js/files/latest/441364159/441364163/1/1733833106000/Script_registry_2.png)
3.  Browse through your scripts and see what you might be able to update to HAPI.  
    -   You can identify scripts that can be updated with the help of the [HAPI code helper](https://docs.adaptavist.com/sr4js/latest/get-started/settings/hapi-code-helper). This helper detects where your scripts can be simplified with HAPI code and suggests an alternative (see image below).  
        
        The HAPI code helper doesn't cover all things HAPI, just some of the most common cases. 
        
          
        ![Image highlighting an example of the HAPI code helper](/sr4js/files/latest/441364159/441364161/1/1733849637000/HAPI_linter.png)  
        
    -   For scripts not covered by the HAPI code helper, you will have to familiarize yourself with HAPI methods by browsing our [HAPI documentation](https://docs.adaptavist.com/sr4js/latest/hapi) and [Javadocs](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/9.6.0/hapi/jira/groovydoc/overview-summary.html).   
        
        ComponentAccessor
        
        The presence of `ComponentAccessor` in your script may indicate it can be simplified using HAPI. HAPI's architecture often eliminates the need for direct component access in many scenarios, allowing you to replace or remove numerous component-related operations. While not all component interactions become obsolete, HAPI significantly reduces their necessity.
        

## Examples of simplifying scripts with HAPI

Check out this [YouTube video](https://www.youtube.com/watch?v=NHESFvp0EeI) that also shows how to convert a script.

The examples below illustrate the application of HAPI in script simplification. They demonstrate how HAPI can be utilized to:

1.  Reduce script length
2.  Improve code readability
3.  Enhance script comprehensibility

### Validating attachments in a transition (Validator)

The following example is taken from the [Validating Attachments/Links In Transitions](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/validating-attachments-links-in-transitions) page. 

The following example details how to find properties of attachments added to this transition or on creation, for example the file name:

```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.attachment.TemporaryWebAttachmentManager
import com.atlassian.jira.issue.fields.AttachmentSystemField
import webwork.action.ActionContext

def temporaryAttachmentManager = ComponentAccessor.getComponent(TemporaryWebAttachmentManager)
def temporaryAttachmentIds = ActionContext.getRequest()?.getParameterValues(AttachmentSystemField.FILETOCONVERT)

temporaryAttachmentIds.each { String attachmentId ->
    def attachment = temporaryAttachmentManager.getTemporaryWebAttachment(attachmentId).getOrNull()
    if (attachment) {
        log.debug "Uploaded attachment name: ${attachment.filename}"
    }
}
```

We can simplify the above script with the HAPI [`attachmentsAddedInTransition`](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/8.10.0/hapi/jira/groovydoc/com/adaptavist/hapi/jira/issues/implementation/MutableIssueSupport.html#getAttachmentsAddedInTransition\(com.atlassian.jira.issue.MutableIssue\)) method:

```
issue.attachmentsAddedInTransition.each { attachment ->
    log.debug("Uploaded attachment name: ${attachment.filename}")
}
```

### Auto close subtask (Custom Post Function)

The following example is taken from the [Custom Post Functions](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/custom-post-functions) page. 

The following example details how to _Resolve_ all currently open sub-tasks when the parent task is transitioned to _Resolved_:

```
import com.atlassian.jira.component.ComponentAccessor

def issueService = ComponentAccessor.getIssueService()
def user = ComponentAccessor.getJiraAuthenticationContext().getLoggedInUser()

def subTasks = issue.getSubTaskObjects()
subTasks.each {
    if (it.statusObject.name == "Open") {
        def issueInputParameters = issueService.newIssueInputParameters()
        issueInputParameters.with {
            setResolutionId("1") // resolution of "Fixed"
            setComment("*Resolving* as a result of the *Resolve* action being applied to the parent.")
            setSkipScreenCheck(true)
        }

        // validate and transition subtask
        def validationResult = issueService.validateTransition(user, it.id, 5, issueInputParameters)
        if (validationResult.isValid()) {
            def issueResult = issueService.transition(user, validationResult)
            if (!issueResult.isValid()) {
                log.warn("Failed to transition subtask ${it.key}, errors: ${issueResult.errorCollection}")
            }
        } else {
            log.warn("Could not transition subtask ${it.key}, errors: ${validationResult.errorCollection}")
        }
    }
}
```

We can simplify the above script with the HAPI [`transition`](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/9.6.0/hapi/jira/groovydoc/com/adaptavist/hapi/jira/issues/implementation/IssuesImplementation.html) method:

```
def subTasks = issue.subTaskObjects
subTasks.each { subTask ->
    if (subTask.status.name == "Open") {
        subTask.transition('Resolve Issue') {
            setResolution('Done')
        }
    }
}
```

### Set a custom field value

The following example is taken from the [Clones an Issue and Links](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/clones-an-issue-and-links) page. 

The following example details how to set the **Summary** field, and set a custom field called **MyCustomFieldType** to _my value_:

```
issue.summary = 'Cloned issue'
def cf = customFieldManager.getCustomFieldObjects(issue).find {it.name == 'MyCustomFieldType'}
issue.setCustomFieldValue(cf, "my value")
```

We can simplify the above script with the HAPI `[setCustomFieldValue](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/8.10.0/hapi/jira/groovydoc/com/adaptavist/hapi/jira/issues/delegate/AbstractIssuesDelegate.html#setCustomFieldValue\(java.lang.String,%20java.lang.String\))` method:

```
issue.summary = 'Cloned issue'
issue.setCustomFieldValue('My custom field name', "my value")
```

  

* * *

## Related content

-   [HAPI YouTube videos](https://www.youtube.com/watch?v=sY2JRMRvAdg&list=PLnsCytbU4bI4GoBSOA7qpGOhM7i2IUrF5)
-   [HAPI](https://docs.adaptavist.com/sr4js/latest/hapi)
-   [Javadocs](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/9.6.0/hapi/jira/groovydoc/overview-summary.html)
