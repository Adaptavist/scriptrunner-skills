# Custom Script Field Examples

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > script-fields > custom-script-field
- Doc ID: doc-sr4js-442886512
- Source: https://docs.adaptavist.com/sr4js/latest/features/script-fields/custom-script-field/custom-script-field-examples

This page contains a number of [custom script field](https://docs.adaptavist.com/sr4js/latest/features/script-fields/custom-script-field) examples:

-   [Calculate a number based on other fields](#id-.CustomScriptFieldExamplesv9.x-calculate-number)
-   [Show the total time this issue has been In progress](#id-.CustomScriptFieldExamplesv9.x-time-in-progress)
-   [Show the number of attachments the issue has](#id-.CustomScriptFieldExamplesv9.x-attachm)
-   [Show all previous versions in a given project](#id-.CustomScriptFieldExamplesv9.x-previous-versions)
-   [Display an information message](#id-.CustomScriptFieldExamplesv9.x-display-message)
-   [Show the component lead](#id-.CustomScriptFieldExamplesv9.x-component-lead)
-   [Show multiple component leads](#id-.CustomScriptFieldExamplesv9.x-multiple-users)
-   [Show the work remaining in linked issues](#id-.CustomScriptFieldExamplesv9.x-linked-issues)
-   [Show the work remaining in all issues in an epic](#id-.CustomScriptFieldExamplesv9.x-work-remaining-epic)

## Examples

Don’t forget to reindex if you want your newly created scripted custom field to appear in existing issues.

For the examples below, you must first navigate to the **Custom Script Field** page:

1.  From **ScriptRunner**, select the **Fields** tab.
2.  Select **Create Script Field**.
3.  Select **Custom Script** **Field**.
4.  Create a custom script field based on the examples provided below. 

### Calculate a number based on other fields

You can calculate a number based on other fields. In the following example, we already have a number field called _Severity,_ and we want a new value that is the product of the _Priority_ and _Severity_:

1.  Enter the name for the custom script field. In this example, we enter _Critical Points_. 
2.  Optional: enter a description. In this example, we enter _Calculate critical points based on Priority and Severity_. 
3.  Optional: add a field note. 
4.  Select the **Number Field** template.
5.  Enter the following script into the script editor:
    
    ```
def severity = getCustomFieldValue("Severity")
if (severity) {
    return severity * Integer.parseInt(issue.priority.id)
}
else {
    return null
}
```
    
6.  Optional: enter an issue key and select **Preview** to preview this custom script field
7.  Select **Add**.  
    ![](/sr4js/files/latest/442886512/442886525/1/1758746708000/Calculate_number_based_on_other_fields.png)
8.  Configure the [context](https://confluence.atlassian.com/adminjiraserver/configuring-custom-field-contexts-1047552717.html) and [screens](https://confluence.atlassian.com/adminjiraserver/defining-a-screen-938847288.html) for this custom script field.

Be careful and test this against an issue with no _Severity_ value set.

### Show the total time this issue has been In Progress

You can create a custom field that shows the total time an issue has been in the `In Progress` state—summing up multiple times if necessary:

1.  Enter the name for the custom script field. In this example, we enter _Time In Progress_.
2.  Optional: enter a description. In this example, we enter _Total time this issue has been In Progress_. 
3.  Optional: add a field note. 
4.  Select the **Duration** template.
5.  Enter the following script into the script editor:  
    
    **An error occured**
    
    There is a problem with the file path provided or a failure to connect with Bitbucket. Check the File Path provided, Application Link for Bitbucket Data Center or the permissions of the app password for Bitbucket Cloud. [Contact your system administrator.](https://docs.adaptavist.com/contactadministrators.action)
    
6.  Optional: enter an issue key and select **Preview** to preview this custom script field
7.  Select **Add**.  
    ![](/sr4js/files/latest/442886512/442886522/1/1758746708000/Total_time_in_progress.png)
8.  Make sure the _Search Template/Searcher_ for this custom field is **Duration Searcher**.
    
    You can edit the _Searcher_ by selecting the configured searcher on the **Script Fields** page.  
    ![](/sr4js/files/latest/442886512/442886523/1/1758746708000/Edit_searcher.png)
    
9.  Configure the [context](https://confluence.atlassian.com/adminjiraserver/configuring-custom-field-contexts-1047552717.html) and [screens](https://confluence.atlassian.com/adminjiraserver/defining-a-screen-938847288.html) for this custom script field.

### Show the number of attachments the issue has

This example is superseded by the JQL function `[hasAttachments](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/attachments#hasattachments)`.

You can create a custom script field to show the number of attachments. This could easily be modified to show the number with a specific extension etc.

1.  Enter the name for the custom script field. In this example, we enter _Number of Attachments_. 
2.  Optional: enter a description.
3.  Optional: add a field note. 
4.  Select the **Number Field** template.
5.  Enter the following script into the script editor:
    
    ```
def numberAttachments = issue.attachments.size()

// use the following instead for number of PDFs
// def numberAttachments = issue.attachments.findAll {a ->
//    a.filename.toLowerCase().endsWith(".pdf")
// }.size()

return numberAttachments ? numberAttachments as Double : null
```
    
6.  Optional: enter an issue key and select **Preview** to preview this custom script field
7.  Select **Add**.  
    ![](/sr4js/files/latest/442886512/442886513/1/1758746707000/Number_of_attachments.png)
8.  Make sure the _Search Template/Searcher_ for this custom field is **Number Searcher**.
    
    You can edit the _Searcher_ by selecting the configured searcher on the **Script Fields** page.  
    ![](/sr4js/files/latest/442886512/442886523/1/1758746708000/Edit_searcher.png)
    
9.  Configure the [context](https://confluence.atlassian.com/adminjiraserver/configuring-custom-field-contexts-1047552717.html) and [screens](https://confluence.atlassian.com/adminjiraserver/defining-a-screen-938847288.html) for this custom script field.

### Show all previous versions in a given project

You can create a custom script field to display every version in a given project prior to the oldest fix version:

1.  Enter the name for the custom script field. In this example, we enter _Previous Versions_. 
2.  Optional: enter a description. 
3.  Optional: add a field note. 
4.  Select the **Version Picker** template.
5.  Enter the following script into the script editor:  
    
    ```
package com.onresolve.jira.groovy.test.scriptfields.scripts

import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.comparator.VersionComparator

def versionManager = ComponentAccessor.getVersionManager()
def versions = versionManager.getVersions(issue.projectObject)
def comparator = new VersionComparator()
def lowestFixVersion = issue.fixVersions.min(comparator)
def returnedVersions = versions.findAll {
    comparator.compare(it, lowestFixVersion) < 0
}
log.debug("All prior versions: ${returnedVersions}")
(lowestFixVersion ? returnedVersions : null)
```
    
      
    The script returns a list of [`Version`](https://docs.atlassian.com/jira/server/com/atlassian/jira/project/version/Version.html) objects.
    
6.  Optional: enter an issue key and select **Preview** to preview this custom script field
7.  Select **Add**.  
    ![](/sr4js/files/latest/442886512/442886521/1/1758746708000/Show_all_versions.png)
8.  Make sure the _Search Template/Searcher_ for this custom field is **Version Searcher**.
    
    You can edit the _Searcher_ by selecting the configured searcher on the **Script Fields** page.  
    ![](/sr4js/files/latest/442886512/442886523/1/1758746708000/Edit_searcher.png)
    
9.  Configure the [context](https://confluence.atlassian.com/adminjiraserver/configuring-custom-field-contexts-1047552717.html) and [screens](https://confluence.atlassian.com/adminjiraserver/defining-a-screen-938847288.html) for this custom script field.

### Display an information message

As an admin, you might want to display extra information about an issue, and not be able to search it. You can create a custom script field where your script can output HTML, and you effectively don’t use a velocity template. 

In the following example we want to draw attention to an issue when it is blocked by other issues that are not resolved, and not assigned.

1.  Enter the name for the custom script field. In this example, we enter _Blocking Issues Warning_. 
2.  Enter a description. 
3.  Optional: add a field note. 
4.  Select the **Text Field** template.
5.  Enter the following script into the script editor:
    
    In the code below we use a [MarkupBuilder](http://docs.groovy-lang.org/latest/html/api/groovy/xml/MarkupBuilder.html), in order to [avoid cross-site forgery attacks](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/avoid-cross-site-scripting-vulnerabilities).  In addition, we return null if there are no blocking issues so the field is not displayed at all.
    
    ```
import com.atlassian.jira.component.ComponentAccessor
import groovy.xml.MarkupBuilder
import com.atlassian.jira.config.properties.APKeys

def blockingIssues = issue.getInwardLinks()
    .findAll { issueLink -> issueLink.issueLinkType.name == "Blocks" }
    .collect { issueLink -> issueLink.sourceObject }
    .findAll { linkedIssue -> !linkedIssue.assignee && !linkedIssue.resolution }

if (blockingIssues) {
    def baseUrl = ComponentAccessor.getApplicationProperties().getString(APKeys.JIRA_BASEURL)
    def writer = new StringWriter()
    def builder = new MarkupBuilder(writer)

    builder.div(class: "aui-message aui-message-error shadowed") {
        p(class: "title") {
            strong("This issue is blocked by the following unresolved, unassigned issue(s):")
        }

        ul {
            blockingIssues.each { anIssue ->
                li {
                    a(href: "$baseUrl/browse/${anIssue.key}", "${anIssue.key}: ${anIssue.summary} (${anIssue.status.name})")
                }
            }
        }
    }

    return writer.toString()
} else {
    return null
}
```
    
6.  Optional: enter an issue key and select **Preview** to preview this custom script field
7.  Select **Add**.  
    ![](/sr4js/files/latest/442886512/442886535/1/1758746709000/Blocking_issue_warning.png)
8.  Make sure the _Search Template/Searcher_ for this custom field is **Free Text** **Searcher**.
    
    You can edit the _Searcher_ by selecting the configured searcher on the **Script Fields** page.  
    ![](/sr4js/files/latest/442886512/442886523/1/1758746708000/Edit_searcher.png)
    
9.  Configure the [context](https://confluence.atlassian.com/adminjiraserver/configuring-custom-field-contexts-1047552717.html) and [screens](https://confluence.atlassian.com/adminjiraserver/defining-a-screen-938847288.html) for this custom script field.

The field appears as follows:

![](/sr4js/files/latest/442886512/442886526/1/1758746708000/Blocking_issue_warning_preview.png)

### Show the component lead

As an admin, you might want to display the lead for the component selected for an issue, making use of the **User** display template.

1.  Enter the name for the custom script field. In this example, we enter _Component Lead_.
2.  Enter a description. 
3.  Optional: add a field note. 
4.  Select the **User Picker (single user)** template.
5.  Enter the following script into the script editor:
    
    ```
def components = issue.components
if (components) {
    return components.first().componentLead
}
```
    
    We return a **User** object, and use the **User Picker** template so the user is displayed with a clickable link and mouseover popup.
    
    Make sure you return an [`ApplicationUser`](https://docs.atlassian.com/DAC/javadoc/jira/reference/com/atlassian/jira/user/ApplicationUser.html) object and not a [`User`](https://docs.atlassian.com/DAC/javadoc/embedded-crowd-api/2.3.4/reference/com/atlassian/crowd/embedded/api/User.html). If you do the latter the template will show _Anonymous_.
    
6.  Optional: enter an issue key and select **Preview** to preview this custom script field
7.  Select **Add**.  
    ![](/sr4js/files/latest/442886512/442886527/1/1758746708000/Component_lead.png)
8.  Make sure the _Search Template/Searcher_ for this custom field is **User Picker** **Searcher**.
    
    You can edit the _Searcher_ by selecting the configured searcher on the **Script Fields** page.  
    ![](/sr4js/files/latest/442886512/442886523/1/1758746708000/Edit_searcher.png)
    
9.  Configure the [context](https://confluence.atlassian.com/adminjiraserver/configuring-custom-field-contexts-1047552717.html) and [screens](https://confluence.atlassian.com/adminjiraserver/defining-a-screen-938847288.html) for this custom script field.

The field appears as follows:

![](/sr4js/files/latest/442886512/442886529/1/1758746709000/Component_lead_result.png)

### Show multiple component leads

As an admin, you might want to display all unique component leads for the component selected for an issue:

1.  Enter the name for the custom script field. In this example, we enter _Component Leads_. 
2.  Enter a description. 
3.  Optional: add a field note. 
4.  Select the **User Picker (multiple users)** template.
5.  Enter the following script into the script editor:
    
    ```
issue.components*.componentLead
    .unique()
    .findAll()
```
    
6.  Optional: enter an issue key and select **Preview** to preview this custom script field
    
7.  Select **Add**.  
    ![](/sr4js/files/latest/442886512/442886533/1/1758746709000/Component_leads.png)  
    
8.  Make sure the _Search Template/Searcher_ for this custom field is **Multi** **User Picker** **Searcher**.  
    
    You can edit the _Searcher_ by selecting the configured searcher on the **Script Fields** page.  
    ![](/sr4js/files/latest/442886512/442886523/1/1758746708000/Edit_searcher.png)
    
9.  Configure the [context](https://confluence.atlassian.com/adminjiraserver/configuring-custom-field-contexts-1047552717.html) and [screens](https://confluence.atlassian.com/adminjiraserver/defining-a-screen-938847288.html) for this custom script field.

The field appears as follows:

![](/sr4js/files/latest/442886512/442886532/1/1758746709000/Component_leads_result.png)

### Show the work remaining in linked issues

In this example, we create a custom script field to show the work remaining in issues that are blocked by other issues. 

Sometimes you may break down tasks by usings a link type, such as _Blocks_, rather than using subtasks. However, when you do this you can’t see the rolled up remaining estimate. The following custom field shows the amount of time remaining on all issues that this issue _is blocked by_, and includes any time remaining on the current issue. 

The outbound link is `is blocked by` and the inbound link is B`locks`. See the Atlassian documentation for [Configuring issue linking](https://confluence.atlassian.com/adminjiraserver0820/configuring-issue-linking-1095777745.html) if you want to create your own custom links. 

1.  Enter the name for the custom script field. 
2.  In this example, we enter _Work remaining_. 
3.  Enter a description. 
4.  Optional: add a field note. 
5.  Select the **Duration (time-tracking)** template. This makes the display of the custom field match that of the Estimate field.
6.  Enter the following script into the script editor:  
    
    ```
// Sum up estimates of comprising issues.
// Inward links are used in this example,
// but can be updated to use outward links if required.
def sumOfChildIssueEstimates = issue
        .getInwardLinks { excludeSystemLinks = false }
        .sum(0) { link ->

            // If the linked ticket is not the type we want,
            // do not calculate an estimate for it
            if (link.issueLinkType.name != "Blocks") {
                return 0L
            }

            // If you replace .getInwardLinks() with .getOutwardLinks(),
            // you must also replace "sourceObject" with "destinationObject"
            // Otherwise, you will point back to the target issue
            def estimate = link.sourceObject.getEstimate() ?: 0L
            def sumOfSubTasksEstimates = link
                    .sourceObject
                    .subTaskObjects
                    .sum(0) { it.estimate } as long

            estimate + sumOfSubTasksEstimates

        } as long

def sumOfParentSubTasksEstimates = issue
        .subTaskObjects
        .sum(0) { it.estimate ?: 0 } as long

// If there are no estimates in the comprising tickets, the result is just the
// same as the remaining estimate, so let's not display it.
if (!sumOfChildIssueEstimates && !sumOfParentSubTasksEstimates) {
    return
}

// Add the estimate from the base ticket.
long parentIssueEstimate = issue.getEstimate() ?: 0L
parentIssueEstimate + sumOfChildIssueEstimates + sumOfParentSubTasksEstimates
```
    
    It is important this script returns a `Long`, so that we can search on it.
    
7.  Optional: enter an issue key and select **Preview** to preview this custom script field
    
8.  Select **Add**.  
    ![Example of completed custom field](/sr4js/files/latest/442886512/442886542/2/1758746710000/Work_remaining_completed_example.png)  
    
9.  Make sure the _Search Template/Searcher_ for this custom field is **Duration** **Searcher**.  
    
    You can edit the _Searcher_ by selecting the configured searcher on the **Script Fields** page.  
    ![](/sr4js/files/latest/442886512/442886523/1/1758746708000/Edit_searcher.png)
    
10.  Configure the [context](https://confluence.atlassian.com/adminjiraserver/configuring-custom-field-contexts-1047552717.html) and [screens](https://confluence.atlassian.com/adminjiraserver/defining-a-screen-938847288.html) for this custom script field.

The field appears as follows:

![](/sr4js/files/latest/442886512/442886536/1/1758746709000/Work_remaining_resultt.png)

#### Indexing

You may notice a further problem. When work is logged on one of the linked issues, the issues that link to it don’t get reindexed, so a search won’t return the correct results.

To handle this, we use a custom [_Script Listener_](https://docs.adaptavist.com/sr4js/latest/features/listeners/custom-listener) to follow `Blocks` links and reindex those issues:

1.  From **ScriptRunner**, select the **Listeners** tab.
2.  Select **Create Listener**. 
3.  Select **Custom Listener**.
4.  Enter the name for the listener. In this example, we enter _Reindex related issues_. 
5.  Select the projects for this listener to be applied to
6.  Select the **Issue Updated**, **Work Logged On Issue**, **Issue Worklog Updated**, and **Issue Worklog Deleted** events.
7.  Enter one of the following scripts into the editor:  
    
    If you use `getInwardsLinks` in the script above, you will want to use the `getOutwardLinks` example below. If you use `getOutwardLinks` in the script above, you will want to use the `getInwardsLinks` example below
    
    ```
event.issue.getInwardLinks() { excludeSystemLinks = false } // event is an IssueEvent
        .each { issueLink -> 
            if (issueLink.issueLinkType.name == "Blocks") {
                issueLink.getSourceObject().reindex()
            }
        }
```
    
    or
    
    ```
event.issue.getOutwardLinks() { excludeSystemLinks = false } // event is an IssueEvent
        .each { issueLink -> 
            if (issueLink.issueLinkType.name == "Blocks") {
                issueLink.getDestinationObject().reindex()
            }
        }
```
    
8.  Select **Add**.  
    ![](/sr4js/files/latest/442886512/442886541/1/1758746710000/Custom_listener_example.png)  
    

### Show the work remaining in all issues in an epic

In this example, we create a custom script field to show the work remaining in all issues in an epic. We have other requirements for this script field:

-   We only want this custom script field to display on _Epic_ issues. 
-   We want to include sub-tasks of issues in an epic in the total work remaining.
-   We want to include any time remaining on the epic itself.

Proceed with the example as follows:

1.  Enter the name for the custom script field. 
2.  In this example, we enter _Work remaining in all issues in this epic_. 
3.  Enter a description. 
4.  Optional: add a field note. 
5.  Select the **Duration (time-tracking)** template. This makes the display of the custom field match that of the Estimate field.
6.  Enter the following script into the script editor:  
    
    ```
package com.onresolve.jira.groovy.test.scriptfields.scripts

if (issue.issueType.name != "Epic") {
    return
}

// Sum up the estimates from comprising issues.
def sumOfChildIssueEstimates = issue.getOutwardLinks { excludeSystemLinks = false }
        .sum(0) { link ->

            if (link.issueLinkType.name != "Epic-Story Link") {
                return 0L
            }

            def estimate = link.destinationObject.getEstimate() ?: 0L
            def issueSubtasks = link.destinationObject.subTaskObjects
            def sumOfSubTasksEstimates = 0L

            // Include subtask estimates, if any exist
            if (issueSubtasks) {
                sumOfSubTasksEstimates = issueSubtasks.sum(0) { subtask ->
                    subtask.getEstimate()
                } as long
            }

            // Failsafe against tickets comprised only of subtask estimates
            estimate + sumOfSubTasksEstimates

        } as long

// If there are no estimates in the comprising tickets, the result is just the
// same as the remaining estimate, so let's not display it.
if (!sumOfChildIssueEstimates) {
    return 0L
}

// Add the estimate from the base ticket.
long parentIssueEstimate = issue.getEstimate() ?: 0L
sumOfChildIssueEstimates + parentIssueEstimate
```
    
    Sub-tasks
    
    We do not include sub-tasks of the epic itself when calculating the work remaining.
    
    It is important this script returns a `Long`, so that we can search on it.
    
7.  Optional: enter an issue key and select **Preview** to preview this custom script field
    
8.  Select **Add**.  
    ![](/sr4js/files/latest/442886512/442886514/1/1758746707000/Work_remaining_in_all_issues_in_epic.png)  
    
9.  Make sure the _Search Template/Searcher_ for this custom field is **Duration** **Searcher**.  
    
    You can edit the _Searcher_ by selecting the configured searcher on the **Script Fields** page.  
    ![](/sr4js/files/latest/442886512/442886523/1/1758746708000/Edit_searcher.png)
    
10.  Configure the [context](https://confluence.atlassian.com/adminjiraserver/configuring-custom-field-contexts-1047552717.html) and [screens](https://confluence.atlassian.com/adminjiraserver/defining-a-screen-938847288.html) for this custom script field.The field appears as follows:  
     ![](/sr4js/files/latest/442886512/442886516/1/1758746707000/Epics_example_2.png)
11.  Optional: If you notice issues with indexing, create a script listener that automatically indexes issues (as described in the [Indexing](#id-.CustomScriptFieldExamplesv9.x-indexing) section above).
     
     If you use the script in the [Indexing](#id-.CustomScriptFieldExamplesv9.x-indexing) section above, make sure you replace the script with the following:
     
     ```
event.issue.getInwardLinks { excludeSystemLinks = false } // event is an IssueEvent
        .each { issueLink ->
            if (issueLink.issueLinkType.name == "Epic-Story Link") {
                issueLink.getSourceObject().reindex()
            }
        }
```
