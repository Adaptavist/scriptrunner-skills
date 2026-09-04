# Listeners Tutorial

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > listeners
- Doc ID: doc-sr4js-442887724
- Source: https://docs.adaptavist.com/sr4js/latest/features/listeners/listeners-tutorial

For a video on listeners, see the [Using Listeners](https://docs.adaptavist.com/sr4js/latest/training/course-introduction-to-scriptrunner-for-jira-data-center-server/1-3-video-using-listeners-in-scriptrunner-for-jira-data-center-server) training video. 

While out-of-the-box, Jira includes tools to help with automating tasks, you may find yourself looking for more. Perhaps you use post functions to handle some automated events after a a user completes a workflow transition. Or maybe you use some automation rules in Jira Service Management to alert administrators to high-priority tickets. With ScriptRunner for Jira, there are several ways to turn a manual process into an automatic one. One of those ways is with a listener. A listener, also known as a script listener, is an automated procedure or function in ScriptRunner that waits (or listens) for a specific event to occur in Jira and then carries out an action if the event occurs.

Listeners are part of the overall ScriptRunner functionality, so you manage them from the _Listeners_ page of ScriptRunner.

![Image of listeners page](/sr4js/files/latest/442887724/442887726/1/1758746875000/Listeners_main_page.png)

The basic thing to understand is that listeners just hang out in your Jira instance and wait for an event to happen in order to carry out an action. You have many possibilities for listener events, including things like logging work on an issue and reopening an issue. In these examples, either event could trigger an action as a result of the event. In addition to events, you can also apply conditions to a listener. So, maybe you don't want something to happen every time an issue is created, but you do need an email to send each time an issue is created from a certain high-priority project. You can set this up with a script listener and apply the appropriate conditions.

When a listener's event occurs, the listener then fires off the action you set up. ScriptRunner for Jira includes several built-in options for script listeners, or you can work with your own if you are feeling groovy (writing in Groovy, that is). So, if you want to create a sub-task if someone selects a certain value from a select list on an issue, you can do that with a listener.

## Why use listeners?

Listeners allow you more control over automated actions than what you would find in a post-function. For example, let's say that whenever a _Critical_ level priority issue occurs in a particular project, you need for a cloned issue to be created in a different project. You could use a workflow post-function to do this when a _Critical_ level issue is being created, but if the issue is created as _Major_ priority, then subsequently edited and changed to _Critical_, a workflow function would not catch it. A listener would though!

ScriptRunner enables you to create two types of listeners: built-in listeners and custom listeners.

## Built-In listeners

Use the built-in listeners if you do not want to write Groovy scripts in order to create custom listeners. Be aware, however, that some of these built-in listeners require a little bit of scripting in the **Condition** inline field. There are several examples if you use a condition, but you may need to edit the script to match your exact project key. The following built-in listeners are available:

-   [Adds the Current User as a Watcher](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/adds-the-current-user-as-a-watcher)
-   [Clones an Issue and Links](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/clones-an-issue-and-links)
-   [Create a Sub-task](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/create-a-sub-task)
-   [Execution Failure Notifier](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/execution-failure-notifier)
-   [Fast-track Transition an Issue](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/fast-track-transition-an-issue)
-   [Fires an Event when Condition is True](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/fires-an-event-when-condition-is-true)
-   [Post a Message to Slack](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/post-a-message-to-slack)
-   [Send a custom email (non-issue events)](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/send-a-custom-email-non-issue-events)
-   [Send a Custom Email](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/send-a-custom-email)
-   [Version Synchroniser](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/version-synchroniser)

You can write three types of custom listeners, but we don’t go into detail on that process here.

For examples of custom listeners, see our [Example Scripts](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=listeners&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=dataCenter).

## Parts of a listener

### Event

Each listener needs an event to trigger it’s action. A listener is essentially "listening" for this event to occur. Some examples of events:

-   A user comments on an issue
    
-   A watcher was added to an issue
    
-   An issue was closed
    
-   An issue was reopened.
    

Depending on the application installed, you may see different events for Jira Software and Jira Service Management.

### Optional condition

If you choose, you can select a condition to apply to your listener. Conditions limit the events the listener looks for to just issues or events that match the conditions. Some examples of conditions:

-   A project matches a specific key
    
-   An issue has a certain priority, such as _Major_
    
-   A cascading select list has a certain first value.
    
    -   You see these and other condition options when you choose to **Example scripts** in the script editor. You can use additional conditions if you know what you are looking for by typing in the script editor.
        

### Action

This setup is similar to automation rules in Jira Service Management, with the condition action as your "If". You can select specific projects to associate a listener with, both using the _Project Key_ menu, or using the condition: `issue.projectObject.key == 'Project Key'`

Some actions you can use:

-   Create a sub-task
    
-   Add current user as a watcher
    
-   Fire an additional event, such as "issue created"
    
-   Send a custom email.
    

## Examples

### Create a sub-task

In this example, create a listener that creates a sub-task based on a certain event and condition. For our example, we create a sub-task on high-priority issues in the Great Adventure Licensing and Financing project.

1.  From ScriptRunner, select the **Listeners** tab.
2.  On the _Listeners_ page, select **Create Listener.**
    
3.  Select **Create a sub-task**.
    
4.  Complete the fields for your listener:
    
    1.  **Name**: Enter a name for the listener. For our example, we are creating licensing sub-tasks when high-priority issues receive a comment in the licensing project.
        
    2.  **Applied to**: Select the project(s) you want the listener to apply to. 
        
    3.  **Events**: Select the events the listener will fire on. We are using Issue Commented.
        
        ![](/sr4js/files/latest/442887724/442887725/1/1758746875000/Listener_example_1.png)
    4.  **Condition**: Enter a condition if you wish to use one. This condition will apply some limitations on the listener, defining, beyond project, when the listener should run. There is a list of examples under this field. For our example we are using priority and looking for issues that are high priority. The default example is _Major_, but you can update this with a different priority in the **Condition** inline script field.
        
    5.  Other fields specific to the listener you chose. For example, we are using the **Target Issue Type** of _Licensing_ for the new sub-task and leaving the summary blank to inherit the summary from the parent.
        
5.  Experiment with **Sub-task Summary** and **Fields to Copy**, if you wish. In our example, we have left these fields blank.
    
6.  Finally, if you want to add any additional actions or add a sub-task action, you can do that before adding your sub-task. For our example, we will set the sub-task status to _To Do_.
    
7.  When you are done with your script listener options, select **Add**. We recommend testing your script listener to make sure it is working properly. For our example, we added a comment to an issue in the affected project. As a result, we have a sub-task with a summary copied from the parent issue in the _To Do_ status.
    

### Fast-track transition an issue

Before you start this task, create workflow that includes some type of review status. This could be:

-   Review
    
-   In Review
    
-   Waiting for Approval
    

For this example, we are transitioning a payroll issue. In your instance, experiment with the issues you have.

1.  From ScriptRunner, select the **Listeners** tab.
2.  Click **Create Listener**, and then click **Fast-track transition an issue**.
    
3.  Select the appropriate project key and choose your **Event(s)** to trigger the listener. For our example, we are going to set the listener to listen for **Issue Commented**.
    
4.  If you want, set a condition on the listener. This condition can restrict the listener to match what you specify in the condition. For our example, we restrict to issue priority and listen for high-priority issues only.
    
    ![Example showing multiple fields filled in](/sr4js/files/latest/442887724/442887747/1/1758746877000/Fast_track_listener_1.png)
5.  Lastly, set your intended **Action**, which is what will happen to the issue when the event occurs. For our example, we choose **Start Progress** and **Skip Permissions**.
    
    You can set additional issue actions if you choose.
    
    ![Example showing options selected](/sr4js/files/latest/442887724/442887748/1/1758746877000/Fast_track_listener_2.png)
    
    You can allow the listener to skip workflow conditions and validators, as well as permissions-this may be useful in case a user doesn’t have a specific permission to perform an action, but you want that action to take place for cases where the listener applies.
    
6.  When you are finished with your settings, select **Add**. The listener will now be in effect for your instance and listening for the event(s) you selected. To test your listener, complete the action within the conditions (if applied) to ensure your action completes.
    

When fast track transitioning an issue, the issue needs to be in the status directly before the destination status. You cannot skip statuses when completing the fast-track transition.

### Add the current user as a watcher

This example creates a listener that adds the current user as a watcher. This listener may be useful if you want to stay updated on the progress of an issue after you complete an action on that issue, such as assigning the issue or leaving a comment. For our example, we add the current user as a watcher when they assign a _Payroll_ type issue.

1.  From ScriptRunner, select the **Listeners** tab.
2.  On the _Listeners_ page, select **Create Listener**.
    
3.  From the options, select **Adds the current user as a watcher**.
    
    ![](/sr4js/files/latest/442887724/442887727/1/1758746876000/image2022-5-12_11-4-37.png)
4.  Complete the fields for your listener:
    
    1.  **Name**: Enter a name for the listener. 
        
    2.  **Applied to**: Select the project(s) you want the listener to apply to. 
        
    3.  **Events**: Select the events the listener will fire on. For our example, we will use the _Issue Assigned_ event.
        
    4.  **Condition**: Select any conditions you want to apply to the listener. For this particular listener, you may want to restrict to certain projects, priorities, or by certain selections within select lists. For our example, we are using the condition of _Issue Type_ to look for only the _Payroll_ issues.

Your results may vary depending on if you chose a different even or a different condition. You can test this listener by going to an issue and selecting an assignee, then noting the _Watchers_ section of the page. Before trying this listener, make sure that you are not already watching the page.

For more examples of Listeners, visit our [documentation](https://docs.adaptavist.com/sr4js/latest/features/listeners).
