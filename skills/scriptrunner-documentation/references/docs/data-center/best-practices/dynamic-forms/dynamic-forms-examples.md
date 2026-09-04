# Dynamic Forms Examples

- Platform: data-center
- Space: SR4JS
- Hierarchy: best-practices > dynamic-forms
- Doc ID: doc-sr4js-442888184
- Source: https://docs.adaptavist.com/sr4js/latest/best-practices/dynamic-forms/dynamic-forms-examples

## Using one script for many listeners

You may want a listener that comments on issues, one comment happens when the issue is created, and a different comment happens when the issue is assigned. Using Dynamic Forms, you can write an annotated script that comments on an issue and then use the script on multiple listeners. You would have to configure the form field and listener as appropriate. For example, place a file like the one below in your script roots in the [Script Editor](https://docs.adaptavist.com/sr4js/latest/features/script-editor):

```
import com.onresolve.scriptrunner.parameters.annotation.ShortTextInput

@ShortTextInput(label = "Comment Text", description = "This text will appear in a comment on the issue when the listener fires.")
def commentText

String issueKey = event.issue.key
def issue = Issues.getByKey(issueKey)

issue.update {
    comment = commentText
}
```

Once you have saved the script, you can configure a [Custom Listener](https://docs.adaptavist.com/sr4js/latest/features/listeners/custom-listener) on the _Issue Created_ event, and another on the _Issue Assigned_ event. When you reach the **Script** section, select **File** and find the newly saved script file. The form fields will automatically display, letting you input a different comment for each listener while using the same script!

![](/sr4js/files/latest/442888184/442888186/1/1758746914000/Issue+Created+Dynamic+Forms+Example.png)

![](/sr4js/files/latest/442888184/442888185/1/1758746914000/Issue+Assigned+Dynamic+Forms+Example.png)

## Create an issue

The following example shows the use of dynamic form annotations in a script which creates a new issue. A short text annotator is used for **Project Key** and **Summary**, select list annotator for **Issue Type** and **Priority**, and user picker for **User**.

```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.user.ApplicationUser
import com.onresolve.scriptrunner.parameters.annotation.Select
import com.onresolve.scriptrunner.parameters.annotation.ShortTextInput
import com.onresolve.scriptrunner.parameters.annotation.UserPicker
import com.onresolve.scriptrunner.parameters.annotation.meta.Option

@ShortTextInput(description = "Project key", label = "Project")
String projectKey

@Select(
    description = "The issue type for the new issue",
    label = "Issue type",
    options = [
        @Option(label = "Bug", value = "Bug"),
        @Option(label = "Story", value = "Story")
    ]
)
String issueTypeName

@Select(
    description = "The priority of the new issue",
    label = "Priority",
    options = [
        @Option(label = "High", value = "High"),
        @Option(label = "Low", value = "Low")
    ]
)
String priorityName

@UserPicker(label = "User", description = "User with that user key will be the reporter of the issue")
ApplicationUser user

@ShortTextInput(description = "The summary for the new issue", label = "Summary")
String summary

def loggedInUser = ComponentAccessor.jiraAuthenticationContext.getLoggedInUser()

def newIssue = Issues.create(projectKey, issueTypeName) {
    setPriority(priorityName)
    // if we cannot find user with the specified key or this was left blank, then set as a reporter the logged in user
    setReporter(user ?: loggedInUser)
    setSummary(summary)
}

"New issue key: $newIssue.key"
```

![](/sr4js/files/latest/442888184/442888189/2/1758746914000/Dynamic_forms_example_1.png)

## Change issue priority

The following example shows the use of dynamic form annotations in a script that changes the priority of an issue. A short text annotator is used for the **Issue Key** field, select list annotator for **Priority**, and checkbox annotator for **Send Email**.

```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.event.type.EventDispatchOption
import com.onresolve.scriptrunner.parameters.annotation.Checkbox
import com.onresolve.scriptrunner.parameters.annotation.Select
import com.onresolve.scriptrunner.parameters.annotation.ShortTextInput
import com.onresolve.scriptrunner.parameters.annotation.meta.Option

@ShortTextInput(description = "The key of the issue to be updated", label = "Issue Key")
String issueKey

@Select(
    description = "The name of the priority to set",
    label = "Priority",
    options =
        [
            @Option(label = "High", value = "High"),
            @Option(label = "Medium", value = "Medium"),
            @Option(label = "Low", value = "Low")
        ]
)
String priorityName

@Checkbox(description = "Check to send notification email", label = "Send Email")
boolean sendMail

def issueService = ComponentAccessor.issueService
def loggedInUser = ComponentAccessor.jiraAuthenticationContext.getLoggedInUser()
def issue = ComponentAccessor.issueManager.getIssueByCurrentKey(issueKey)
def availablePriorities = ComponentAccessor.constantsManager.priorities
def priority = availablePriorities.find { it.name == priorityName }
def issueInputParams = issueService.newIssueInputParameters()
issueInputParams.with {
    priorityId = priority.id
}
def updateValidationResult = issueService.validateUpdate(loggedInUser, issue?.id, issueInputParams)
assert updateValidationResult.isValid(): updateValidationResult.errorCollection

def updateResult = issueService.update(loggedInUser, updateValidationResult, EventDispatchOption.ISSUE_UPDATED, sendMail)
"Issue priority changed to: $updateResult.issue.priority.name"
```

![](/sr4js/files/latest/442888184/442888191/2/1758746915000/Dynamic_forms_example_2.png)
