# Create a Sub-task

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > listeners > built-in-listeners
- Doc ID: doc-sr4js-442887823
- Source: https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/create-a-sub-task

Use this listener to create a new sub-task when the chosen event fires, or reopen a matching sub-task. This listener can be used multiple times to trigger the creation/reopening of several sub-tasks. You may want to:

-   Create a sub-task depending on the value selected in a select field. 
-   Reopen a matching sub-task when a parent issue is commented on. 

For example, I have a task that deals with multiple components of a business process. I want to auto create a sub-task whenever someone adds a component to the **Tasks Components** field so that I can automatically break down my task into component specific sub-tasks.

1.  From ScriptRunner, navigate to the **Listeners** tab and select **Create Listener** > **Create a sub-task.**
2.  Enter a description of the listener in **Name**.
3.  Define which project(s) the listener should be **Applied to**.  
    You can either check _Global_ to apply the listener to all projects or check _Select projects(s)_ and define the projects you want to assign the listener to. 
4.  Select the **Events** on which the listener fires.   
    For example, to create sub-tasks depending on the changes to a field, choose the **Issue Updated** event.
5.  Optionally, select **Example scripts** to display a list of example conditions that you can use to control when your listener runs. For example, you can set a condition that evaluates whether or not the issue priority field has changed. The listener only runs if the condition evaluates to true.
    
    ![](/sr4js/files/latest/442887823/442887839/1/1758746884000/Built_in_listeners.png)  
    
6.  Select the **Target Issue Type**. This is the Issue type the sub-task will be set to. This issue type must be valid for the current project.
7.  Optionally, enter a **Sub-task Summary**.
8.  Choose which **Fields to copy** to the sub-task. If you select _Custom_ an additional field displays where you can specify the fields you want to copy. 
9.  In the **As User** field, there is the possibility to select a user. The sub-task is created on their behalf, making the selected user the Creator and Reporter of the new sub-task. If empty, the current user is assigned.
10.  You can use the **Additional issue actions** field to customize the newly cloned issue. For example, you can set the sub-task summary to match the value selected from the select-list.
11.  Optionally, set a **Sub-task Action**. This action is only applied if a matching sub-task already exists. 
12.  Select **Add**.
