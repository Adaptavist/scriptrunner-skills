# Fast-track Transition an Issue

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > listeners > built-in-listeners
- Doc ID: doc-sr4js-442888814
- Source: https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/fast-track-transition-an-issue

This listener transitions an issue when the selected event is triggered and the specified condition is met. For example, you may want to:

-   Transition an issue if the value of a custom field is updated to a certain value. 
-   Transition an issue if the priority is updated.

For example, I have an **Estimated Number of** **Customers Affected** select list custom field for bugs. I want to set up this listener to fast-track transition an issue to _In Progress_ if the **Estimated Number of** **Customers Affected** field is updated to the _100+_ option. 

1.  Select the **Fast-track transition an issue** built-in listener.
2.  Enter a description of the listener in **Name**.
3.  Define which project(s) the listener should be **Applied to**.  
    You can either check _Global_ to apply the listener to all projects or check _Select projects(s)_ and define the projects you want to assign the listener to. 
4.  Select the **Events** on which the listener fires.   
    For example, to transition the issue based on the value of a field at creation, choose the **Issue Created** event.
5.  You can further refine this by entering a **C****ondition**. For example, here, you would specify the value of the select list custom field and the issue type (in this case, _Bug_). 
6.  Select a workflow action from the **Action** drop-down. For example, to transition the issue to _In Progress,_ select **Start Progress**. The selected action ID must be valid for the issue being transitioned. The list of actions are grouped under the name of the workflow to make it easier to find the correct ID for your desired workflow action.
7.  Optionally, you can use the **Additional Issue Actions** field to edit the issue when it transitions. For example, you can comment on the issue notifying the reporter that it has been fast-tracked. 
8.  Optionally, you can customise the **Transition Options** to override permissions, validators, and conditions set up on the issue. This is useful when you want to force the transition to happen as a user that does not have the correct permissions, or you want to use the standard condition that hides the transition from users. 

You can use this listener multiple times on a transition, for example, the _Create Issue_ transition, to effect different default start statuses for an issue depending on a field value.
