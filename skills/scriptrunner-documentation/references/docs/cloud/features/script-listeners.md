# Script Listeners

- Platform: cloud
- Space: SR4JC
- Hierarchy: features
- Doc ID: doc-sr4jc-101629014
- Source: https://docs.adaptavist.com/sr4jc/latest/features/script-listeners

![](/sr4jc/files/latest/101629014/403866205/1/1751970370000/sr-migrate+%281%29.png)

**Migrating from ScriptRunner for Jira Server/DC to Cloud?** **Learn more in our** **[Feature Parity](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/feature-parity-and-script-alternatives#listeners)** **overview.**

## Before you start

[![](/sr4jc/files/latest/101629014/339510916/1/1741346826000/sr-icon-power.png)](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=listeners&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud)

  

[![](/sr4jc/files/latest/101629014/339510917/1/1741346826000/Copy+of+sr-icon-mortar-board.png)](https://docs.adaptavist.com/sr4jc/latest/training/course-scriptrunner-for-jira-cloud-for-beginners/1-2-module-scriptrunner-for-jira-cloud-automation-capabilities)

Visit ScriptRunner HQ to see example scripts. 

  

Learn about event-based automating with Script Listeners.

[ScriptRunner HQ](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=listeners&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud)

  

[Training Videos](https://docs.adaptavist.com/sr4jc/latest/training/course-scriptrunner-for-jira-cloud-for-beginners/1-2-module-scriptrunner-for-jira-cloud-automation-capabilities)

Condition script examples

The condition script will be evaluated before your code is executed. In the case where a value **other than true** is returned then we get a **false** result, and the code will **not** execute. The condition is evaluated using the [Jira Expression Framework](https://developer.atlassian.com/cloud/jira/software/jira-expressions/?_ga=2.230038236.1976807474.1684141123-2016015256.1672998146#introduction).

You can refer to our [Example Restrictions and Validators](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/example-restrictions-and-validators) page for further details.

Action required!

As a result of [Atlassian's Transition to Forge Events and Missing Event Properties](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/atlassian-s-transition-to-forge-events-and-missing-event-properties), it's important that you review and update any Script Listeners that depend on the missing properties. There is _no workaround_ for retrieving these properties via the Atlassian REST API. Therefore, to ensure your scripts do not break after the transition, they need to be removed from any scripts that use them.

## What are Script Listeners?

A listener is an automated procedure or function in ScriptRunner that waits (or listens) for a specific event to occur in Jira and then carries out an action if the event occurs. Listeners sit on your instance and wait for a [webhook event](https://developer.atlassian.com/cloud/jira/platform/webhooks/) to happen before executing the listener script. Webhooks are triggered after an action has occurred in Jira, such as when a space is created or a work item is updated.

Script Listeners that trigger Scripted Fields, and vice versa

[Scripted Fields](https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields) work items are updated after a script is executed, triggering an `issue_updated` webhook event in Jira. This event is sent to ScriptRunner, but does not cause the script to run again or trigger any associated script listeners configured for work item update events.

Script Listeners that update work items will trigger an `issue_updated` webhook event in Jira, which is then sent to ScriptRunner. If scripted fields are configured for the updated work items, they execute once, updating the work item and triggering another `issue_updated` webhook event without requiring any further processing.

## How to use Script Listeners

You may want to use a Script Listener to:

-   Populate a space with initial work items when it is created.
    
-   Post a message to Slack when a work item is created.
-   Store story points of sub-tasks against the parent work item.

Script Listener Infinite Loop Restriction

Previously, it was important to ensure that your scripts did not inadvertently trigger events your script listener was listening for, as this risked causing an infinite loop. However, now self-triggering scripts can no longer execute after 10 runs. This restriction means that if a script creates an event that results in the same script running again, ScriptRunner will count the number of times this occurs and reject the 11th run. If this happens, you will see a log message informing you that Scriptrunner has cut off a self-triggering script loop.

### Script Listeners and Post Functions

The crucial difference between Script Listeners and Post Functions is that the latter rely on a transition change, whereas the former depend on an event occurring, which can happen at any time.

_Script Listeners give you more control over automated actions than you would get with a Post Function._

For example, whenever there is a _Critical_ level priority work item in a specific space, you want a message to be sent to a Slack channel. If you use a post function to do this, the event will fire only after a transition, not when the work item is edited. Therefore, if the priority of the work item were edited to _Critical,_ the post function would not catch it until after the work item had been transitioned. To achieve this use case, you would use a listener to catch a change in priority when it happens. 

## Create a Script Listener

1.  Navigate to **ScriptRunner > Script Listeners**.  
    Depending on whether or not you have already created script listeners, you are presented with either a landing screen or a list of the previously created script listeners.
2.  Click **Create Script Listener** from the initial landing screen if none have been previously created. Or, if you would prefer to make use of our built-in examples, click **Add Examples** to add two script listener examples to your instance.![](/sr4jc/files/latest/101629014/261685636/1/1717080194000/lets+add+some+script+listeners.jpeg)  
    _**OR**_  
    Click **Create Script Listener** from the previously created list.  
    ![](/sr4jc/files/latest/101629014/524222499/1/1773083246000/click-create-script-listener.png)  
    
3.  **(Optional)** You can modify or delete any of the script listeners listed. Click **Edit** or **Delete** via the **Actions** ellipsis to select the relevant script listener and delete, or refer to [Edit a script listener](#id-.ScriptListenersvCurrent-editlistener).You will see the Create Script Listener screen, as shown below:  
    ![](/sr4jc/files/latest/101629014/585007623/1/1785520771000/image+%288%29.png)  
    
4.  Enter a name for the listener in **Script Listener Called**.
5.  Choose to **Enable Script Listener**, or turn off to disable.
6.  Select the event(s) you wish the listener script to trigger on in **On These Events**, for example, **Work Item Updated**.
    
7.  Select the spaces you want the listener to be active for; you can select **All Spaces** (default) or a number of individually selected spaces per listener.
    
    Space settings apply only to events related to work items, spaces, work item links, versions, and comments. If you need to filter `issuelinks` for both the source and destination work items, be sure to include both spaces in the filter.
    
    The location of the outward link in the work item defines the mapping that is required, for example:  
    If Space A is mapped, and ITEM-1 in Space A is assigned a “_blocks_” link to another work item, this means ITEM-1 is the outward link that fires the Script Listener. If Space A is mapped, and ITEM-1 in Space A is assigned an “_is blocked by_” link, this means ITEM-1 is the inward link, which would not fire the Script Listener since it is not mapped.
    
    Enter a condition on which the code will run. Note that the _ScriptRunner Add-on user_ always runs the condition_,_ but you can choose who runs the script.
    
8.  The [condition script](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/restrict-transitions) will be evaluated before your code is executed. If a value **other than true** is returned, the code will **not** execute. The condition is evaluated using the [Jira Expression Framework](https://developer.atlassian.com/cloud/jira/software/jira-expressions/?_ga=2.239484483.1976807474.1684141123-2016015256.1672998146#introduction). Event-specific Script Context parameters and variables are listed [here](#id-.ScriptListenersvCurrent-scriptcontext) for each event. The work item property is not an available Context variable for work item link created events.
    
9.  Choose from either _ScriptRunner Add-On User_ or _Current User_ as the user you wish to run the listener from the **Run code as:** drop-down options. Script Listeners can make requests to Jira using either user.  
    
    When using the _Initiating User_, any action resulting from the function is registered as performed by them. For example, if a work item is commented on, the comment comes from the _Initiating User_ rather than the _ScriptRunner Add-on User,_ who may have nothing to do with the work item/space affected. Permissions are considered when executing actions. The user selected in the **Run code as:** field must have the required permissions to perform the specified action. Typically, the _ScriptRunner Add-on User_ has space admin permissions; however, this can be restricted. The _Initiating User_ may have higher permissions than the _ScriptRunner Add-on User_.
    
10.  Write your script in the code editor. This code is executed when the Evaluate Condition is **true**.
     
     Reuse a script
     
     Click the **Script Usage** drop-down list to view your saved script files and identify exactly where they are configured in your instance.  
     You can also click **Load** to reuse a previously saved script from [Script Manager](https://docs.adaptavist.com/sr4jc/latest/features/script-manager). Further details on how to use these features can be found in [Reuse scripts in the UI](https://docs.adaptavist.com/sr4jc/latest/features/script-manager#id-.ScriptManagervDraft-ReusescriptsintheUI).
     
     OR  
     Alternatively, you can click the **Example scripts** button to view a list of example scripts related to this feature.  
     ![](/sr4jc/files/latest/101629014/294139635/1/1729691069000/listener+copy+code.png)  
     So, rather than writing your own script, you can reuse one of the many examples provided, as follows:
     

1.  Choose an example script from the list provided, and the code automatically appears. You also have the option to search for a particular script.
2.  Click **Copy Code** and then **Close**.
3.  Paste the copied code in the code editor.

12.  **(Optional)** Click **Script context** to view an information modal highlighting parameters/code variables.  
     
     Script context
     
     The Script Context is a set of parameters/code variables automatically available in your script to provide contextual data for the script listeners. The parameters and variables in the Script Context are different for each Listener Event. Event-specific Script Context parameters and variables are listed [here](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners/script-listener-examples#id-.ScriptListenerExamplesvCurrent-scriptcontext) for each event.
     
     Common parameters in the Script Context for all the events are:
     
     -   -   baseUrl - Base url to make API requests against. This is the URL used for relative request paths e.g. if you make a request to `/rest/api/2/issue` we use the baseUrl to create a full request path.
             
         -   logger - Logger to use for debugging purposes. Check the methods available [org.slf4j.Logger](https://www.slf4j.org/apidocs/org/slf4j/Logger.html)
             
         -   timestamp - The timestamp of the event in milliseconds e.g. 1491562297883
             
         -   webhookEvent - The webhook event type. [Atlassian Connect Webhook Documentation](https://developer.atlassian.com/cloud/jira/platform/webhooks/)
             
     
     For further information on referencing Script Context values, refer to [Example Script Variables](https://docs.adaptavist.com/sr4jc/latest/features/script-variables/example-script-variables).
     
13.  Click **Save**. You can test your script using the **Run Now** button, which will execute the script and return the results.

## Edit a Script Listener

1.  Navigate to **ScriptRunner > Script Listeners**. A list of all previously created listeners is shown.
    
    You can check which event triggers have been chosen for each listener by clicking the relevant **Event** from the list.  
    ![](/sr4jc/files/latest/101629014/166538360/1/1680256110000/listener+events.jpg)  
    
2.  Click **Edit** from the **Action** ellipsis on the listener you wish to edit.  
    ![](/sr4jc/files/latest/101629014/524222497/1/1773083445000/click-script-action.png)  
    Similarly, you can also choose the listener you wish to delete by clicking **Delete** from the **Action** ellipsis.  
    
3.  Edit the fields, as required, from within the **Edit Script Listener** screen.
4.  Click **Save** when all changes have been made.

## Related content

-   Take our [ScriptRunner Tour](https://www.scriptrunnerhq.com/atlassian-apps/jira/scriptrunner-for-jira/cloud/get-started?__hstc=61790195.f51af098489d804a43e94be57b4d239c.1722866988392.1743171866570.1743492508364.505&__hssc=61790195.18.1743492508364&__hsfp=3420112851).
-   See our [Example Script Listeners](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners/example-script-listeners).
