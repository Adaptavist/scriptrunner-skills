# HAPI Examples

- Platform: data-center
- Space: SR4JS
- Hierarchy: hapi
- Doc ID: doc-sr4js-442888845
- Source: https://docs.adaptavist.com/sr4js/latest/hapi/hapi-examples

You may have read how [HAPI](https://docs.adaptavist.com/sr4js/latest/hapi) works but are unsure how to use it effectively in your Jira instance. Below are multiple use cases/examples that incorporate HAPI in the scripts, ready for you to explore and customize to your Jira instance:

-   [Automatically add users to linked issues as watchers](#id-.HAPIExamplesv9.x-addwatchers)
-   [Calculate the impact of an issue based on the number of linked support cases](#id-.HAPIExamplesv9.x-calculateseverity)
-   [Automatically add reviewers based on the issue request type](#id-.HAPIExamplesv9.x-addreviewers)
    

For the examples on this page, you will notice a reference to Great Adventure. Great Adventure is the fictitious company we use to help provide use cases and examples of concepts covered.

## Automatically add users to linked issues as watchers

### Scenario

When a support request is raised, other issues are sometimes linked to the support request issue because they cause the support request. Great Adventure wants the reporter of the initial support request, and [request participants](https://confluence.atlassian.com/servicemanagementserver/adding-request-participants-939926441.html), to be automatically added as watchers to the linked issues that cause the raised issue.

With this automation, Great Adventure can ensure people are informed of linked issues and subsequently progress.

### Solution

Create a **custom listener** and use **HAPI**.

Why is HAPI useful?

With HAPI, we've made it easy for you to [Work with Issue Links](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-issue-links), [Users](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-users), and [Watchers](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-watchers). This means the script for the following use case has fewer imports, is much shorter, and is easier to adapt to your own instance if desired.

### Steps

Expand to view steps...

1.  From ScriptRunner go to **Listeners > Create Listener**. 
2.  Select **Custom listener**. 
3.  Add an optional note to describe the listener. In this example, we enter `Automatically add users as watchers`.
4.  Select the project/s the listener should trigger for. In this example, we choose **Global (All projects)**.
5.  Select **IssueLinkCreatedEvent** under **Events**.
6.  Enter the following script into the script editor:  
    
    ```
final LINK_TYPE = "Problem/Incident"

def link = event.getIssueLink()
def outwardIssue = link.destinationObject
def inwardIssue = link.sourceObject

if (link.issueLinkType.name == LINK_TYPE) {
    def requestParticipants = outwardIssue.requestParticipants
    def usersToAdd = requestParticipants ? [*requestParticipants, outwardIssue.reporter] : [outwardIssue.reporter]
    usersToAdd.each { user ->
        inwardIssue.addWatcher(user)
    }
}
```
    
7.  Select **Add**. 

#### Test

You can now test this example by linking one issue to another using `causes` or `is caused by` link type. The reporter, and if applicable, request participants, are added as watchers to the issue that **causes** the linked issue.  

![Image showing an the results of the example](/sr4js/files/latest/442888845/442888877/1/1758746977000/HAPI_watchers_final_2.png)

## Calculate the impact of an issue based on the number of linked support cases

### Scenario

Great Adventure wants to calculate the impact of an issue based on the number of customer support cases that have been linked to it.

With this automation, Great Adventure can monitor the impact of certain issues and use JQL search to easily identify high impact issues. 

### Solution

Create a **custom script field** and use **HAPI** to count the number of _**causes**_ links an issue has.

Why is HAPI useful?

With HAPI, we've made it easy for you to [Work with Issue Links](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-issue-links). This means the script for the following use case is much simpler and easy to adapt to your own instance if desired.

### Steps

Expand to view steps...

1.  From ScriptRunner go to **Fields > Create Script Field**. 
2.  Select **Custom Script Field**. 
3.  Enter the name for the custom script field. In this case we name the custom field `Impact`.
    
    If you already have a custom field with the name `Impact`, we recommend you choose a different name to avoid conflict.
    
4.  Enter the description for the custom script field. In this case we enter Issue `Impact calculated from the number of linked support cases`.
5.  Optional: Add an note to the **Field Note** field.
6.  Select the **Text Field(multi-line)** template.
7.  Enter the following script into the script editor:
    
    ```
import com.atlassian.jira.project.type.ProjectTypeKeys

def countOfLinkedSupportCases = issue.outwardLinks.count {
    it.issueLinkType.outward == "causes" && it.destinationObject.projectObject.projectTypeKey == ProjectTypeKeys.SERVICE_DESK
}

switch (countOfLinkedSupportCases) {
    case { it >= 25 } -> "Critical Impact"
    case { it >= 12 } -> "High Impact"
    case { it >= 6 } -> "Moderate Impact"
    case { it >= 3 } -> "Low Impact"
    default -> "Minimal Impact"
}
```
    
8.  Optional: Enter an issue key for preview.
9.  Optional: Select **Preview** to preview the custom field. 
10.  Select **Add**.
11.  Configure the [context](https://confluence.atlassian.com/adminjiraserver/configuring-custom-field-contexts-1047552717.html) and the [screens](https://confluence.atlassian.com/adminjiraserver/defining-a-screen-938847288.html) by following the links provided in the popup that appears after you have created the new field.![Image showing the a popup that allows you to configure the context and screens](/sr4js/files/latest/442888845/442888867/1/1758746976000/HAPI_impact_pop_up.png)
     
     You can also configure the context and the screens for script field from the _Actions_ ellipses menu on the **Script Fields** page.
     

#### Test

You can check this example works by going to a given issue that this custom field is configured to. 

![Image showing the results of this example](/sr4js/files/latest/442888845/442888868/1/1758746977000/HAPI_impact_result.png)

You can also easily find all issues with a given impact using the following JQL search:

```
Impact ~ "Critical Impact"
```

## Automatically add reviewers based on the issue request type

### Scenario

Great adventure wants reviewers to be set automatically depending on the issue request type. For example, purchases over 100 dollars need to be cleared by the accounts department, and any travel requests need to be cleared by your manager.

With this automation, Great Adventure can stay aligned with their internal auditing and governance rules.

### Solution

Create a **custom workflow function** and use **HAPI**.

Why is HAPI useful?

With HAPI, we've made it easy for you to [Update Issues](https://docs.adaptavist.com/sr4js/latest/hapi/update-issues#working-with-workflow-functions) from a workflow function. This means the script for the following use case is much simpler and easy to adapt to your own instance if desired.

### Steps

Expand to view steps...

1.  From ScriptRunner go to **Workflows > Create Workflow Function**. 
2.  Select an approval workflow for the workflow function to be added to.
3.  Select a suitable _Create_ transition. In this example we select `Create issue (Initial → Waiting for approval)`.
4.  Select the **Post function** workflow function type.
5.  Select **Create**.  
    ![Image showing the Create Workflow screen](/sr4js/files/latest/442888845/442888869/1/1758746977000/HAPI_uc_reviewers_1.png)
6.  Select **Custom script post-function**.
7.  Add an optional note to describe the listener. In this case we add `Automatically add reviewers based on the issue request type`.
8.  Enter the following script into the script editor:
    
    If you're using the exact example below, make sure you replace the users with usernames that exist in your instance. 
    
    ```
/*This is a map of request-Type -> Request Reviewers*/
def requestTypeToApprovers = [
    "Purchase over \$100": ["financeTeamUser", "lineManagerUser"],
    "Travel request"     : ["travelTeamUser", "lineManagerUser"]
]

if (issue.issueType.name == "Service Request with Approvals") {
    def requiredApproverNames = requestTypeToApprovers[issue.requestType?.name]

    if (requiredApproverNames) {

        issue.set {
            setCustomFieldValue('Approvers') {
                requiredApproverNames.each {
                    add(it)
                }
            }
        }
    }
}
```
    
9.  Select **Add**.   
    You are taken to the workflow page for the transition you are adding this function to. 
10.  Check you are happy with the changes to the transition and select **Publish**.  
     ![Image showing the Publish button highlighted](/sr4js/files/latest/442888845/442888870/1/1758746977000/HAPI_uc_reviewers_2.png)

#### Test

You can check this example works by raising a request a checking that the approvals have been added. 

![Image showing the results of this example](/sr4js/files/latest/442888845/442888872/1/1758746977000/HAPU_uc_reviewers_3.png)

  

* * *

## Related content

-   [Listeners](https://docs.adaptavist.com/sr4js/latest/features/listeners)
-   [Workflows](https://docs.adaptavist.com/sr4js/latest/features/workflows)
-   [Script Fields](https://docs.adaptavist.com/sr4js/latest/features/script-fields)
