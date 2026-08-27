# HAPI Examples

- Platform: cloud
- Space: SR4JC
- Hierarchy: hapi
- Doc ID: doc-sr4jc-288524081
- Source: https://docs.adaptavist.com/sr4jc/latest/hapi/hapi-examples

To help you get started using HAPI effectively in your Jira instance, we have provided several use cases/examples below that incorporate HAPI in the scripts. You can use these examples to explore and customize your Jira instance.

## Update parent with subtask count

As an engineer working on larger tasks, it is better for tracking and delegation purposes to have these broken down into multiple subtasks. To have an accurate overview, it's crucial to know how many subtasks a parent work item has. Whenever a new subtask is created, updated, or deleted, the parent work item should reflect the current count of its subtasks.

### HAPI solution

Create a **custom listener** and use **HAPI**.

This script automates the task of updating the parent work item with the number count of its subtasks, removing the need to manually check and update it every time.

With HAPI, we've made it easy for you to [update work items](https://docs.adaptavist.com/sr4jc/latest/hapi/work-with-work-items). This means the script for the following use case has fewer imports, is much shorter, and is easier to adapt to your own instance if desired.

1.  Navigate to **Apps** **\> ScriptRunner.**
2.  Open **Script** **Listeners > Create Listener**. 
3.  Enter a name for the listener in _Script Listener Called_.
4.  Enable the Script Listener.
5.  Select any of the Work Item related events (**Issue Updated, Issue Deleted, Issue Created)** under **On these e****vents**.
6.  Select the spaces you want the listener to be active for; you can select **All Spaces** for this example.
7.  Enter a condition on which the code will run. 
8.  Choose from either _ScriptRunner Add-On User_ or _Current User_ as the user you wish to run the listener from the **Run code as:** drop-down options.
9.  Write the following script in the **Code to run:** field. This code is executed when the Evaluate Condition is **true**.  
    
    ```
def eventWorkItem = WorkItems.getByKey(issue.key as String)
def subTasks= eventWorkItem.getSubTaskObjects()
def subTaskCount = subTasks.size()

println("Total subtasks for ${eventWorkItem.getKey()}: ${subTaskCount}")

eventWorkItem.update {
    setCustomFieldValue('Subtask Count', subTaskCount)
}
```
    
10.  Click **Save**. You can test your script using the **Save** button, which will execute the script and return the results.
     

#### Test

To verify this script:

1.  **Create a Subtask:** Add a new subtask to any of your work items in Jira.
2.  **Ensure Field Exists:** Confirm that you have a numerical custom field named _Subtask Count_ in your Jira instance. If the field has a different name, update the script accordingly before testing.

Your parent ticket will be updated with the subtask Count.

![](/sr4jc/files/latest/288524081/524224144/1/1774023205000/image-2026-3-20_17-13-24.png)

## Add a comment on the work item created

When a support ticket is raised, we often want to automatically add a comment to the work item, thanking the reporter and providing helpful information such as response timelines, documentation links, and work timings. This ensures better communication and sets clear expectations for the reporter.

### HAPI solution

Create a **custom listener** and use **HAPI**.

This script demonstrates how to automatically add a comment to a newly created work item in Jira, improving communication by providing relevant information right away. Using HAPI, [Update Work Items (Update Issues)](https://docs.adaptavist.com/sr4jc/latest/hapi/work-with-work-items) has been made simple and efficient.

1.  Navigate to **Apps** **\> ScriptRunner.**
2.  Open **Script** **Listeners > Create Listener**. 
3.  Enter a name for the listener in _Script Listener Called_.
4.  Enable the Script Listener.
5.  Select the **Issue Created** under **On these e****vents**.
6.  Select the spaces you want the listener to be active for; you can select **All Spaces** for this example.
7.  Enter a condition on which the code will run. 
8.  Choose from either _ScriptRunner Add-On User_ or _Current User_ as the user you wish to run the listener from the **Run code as:** drop-down options.
9.  Write the following script in the **Code to run:** field. This code is executed when the Evaluate Condition is **true**.  
    
    ```
def eventWorkItem = WorkItems.getByKey(issue.key as String)
def author = eventWorkItem.getCreator().displayName

eventWorkItem.addComment("""Thank you ${author} for creating a support request.
We'll respond to your query within 24hrs.
In the meantime, please read our documentation: http://example.com/documentation""")
```
    
      
    
10.  Click **Save**. You can test your script using the **Save** button, which will execute the script and return the results.
     

#### Test

To test this script, you need to create a new ticket, and it will automatically be updated with the added comment.

![](/sr4jc/files/latest/288524081/524224141/1/1774023566000/image-2026-3-20_17-19-25.png)

## Bulk update multiple work item resolutions

As a Jira admin, I want to change the resolution of a large number of work items that were mislabelled. I can use this script to update the resolution of all these issues to their corresponding one ("Duplicate").

### HAPI solution

Run this **HAPI** script using the **script console**.

This script automates the process of bulk updating the resolution of all issues returned from the JQL search that meet the specified conditions.

1.  Navigate to **Apps** **\> ScriptRunner.**
2.  Open **Script** **Console.**
3.  Write the following script in the code editor:
    
    ```
// The Name of the resolution to be set
def resolutionName = 'Cannot Reproduce'

// Get all issues matching the specified JQL Query
WorkItems.search("project = TEST AND issueType = Bug").each { workItem ->
    workItem.transition('Done') {
        setResolution(resolutionName)
    }
    logger.info("Resolution set to ${resolutionName} for the ${workItem.key} work item")
}
```
    
4.  Click **Run.**

#### Test

 The script updates the resolution of the work item.

## Add or update the link for a work item in Jira Cloud

As a Jira admin, I want to bulk link work items to keep track of my related work for one of my spaces. I can do this quickly and efficiently with this script.

### HAPI solution

Run this **HAPI** script using the **script console**.

Linking issues means you can create an association between two existing work items. With this script, you can bulk link a set of work items.

1.  Navigate to **Apps** **\> ScriptRunner.**
2.  Open **Script** **Console.**
3.  Write the following script in the code editor:
    
    ```
// Specify the source work item
final sourceWorkItemKey = "TVP-68"
// Specify the target issue
final targetWorkItemKey = "TVP-44"
// Specify the link direction name to use
final linkType = "blocks"

// Create the link between both work items
WorkItems.getByKey(sourceWorkItemKey).link(linkType, targetWorkItemKey)
```
    
4.  Click **Run.**

#### Test

![](/sr4jc/files/latest/288524081/524224140/1/1774023652000/image-2026-3-20_17-20-51.png)

## How to create a new script video demo

&amp;amp;amp;lt;p&amp;amp;amp;gt;&amp;amp;amp;lt;br/&amp;amp;amp;gt;&amp;amp;amp;lt;/p&amp;amp;amp;gt;
