# Escalation Service

- Platform: cloud
- Space: SR4JC
- Hierarchy: features
- Doc ID: doc-sr4jc-103678285
- Source: https://docs.adaptavist.com/sr4jc/latest/features/escalation-service

## Before you start

[![](/sr4jc/files/latest/103678285/339510913/1/1741343975000/sr-icon-power.png)](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=escalation-services&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud)

  

[![](/sr4jc/files/latest/103678285/339510914/1/1741343975000/Copy+of+sr-icon-mortar-board.png)](https://docs.adaptavist.com/sr4jc/latest/training/course-scriptrunner-for-jira-cloud-for-beginners/1-2-module-scriptrunner-for-jira-cloud-automation-capabilities)

Visit ScriptRunner HQ to see example scripts. 

  

View training on ScriptRunner for Jira Cloud Automation Capabilities.

[ScriptRunner HQ](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=escalation-services&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud)

  

[Training Module](https://docs.adaptavist.com/sr4jc/latest/training/course-scriptrunner-for-jira-cloud-for-beginners/1-2-module-scriptrunner-for-jira-cloud-automation-capabilities)

  

## What is the Escalation Service?

The _Escalation Service_ enables you to establish a process for modifying work items after a specified period has elapsed. This is useful for business procedures that require tasks to be completed within a specific time frame (service level agreement).

## How to use Escalation Services

Escalation Services can be used if, for example, a task has been opened but not assigned for 7 days. You could automatically move it to a "Prioritize" status, or add a comment which will cause an email to be sent.

The minimum interval between code executions is 1 hour. The scheduler is triggered every hour and gathers all the tasks to be executed within that hour. The task executions are queued and workers will consume them in no predefined order. That means that the execution time of the task can not be guaranteed to be the same every hour. As an example: if you configure a job to be run every hour, it might be run at 01:02 and then 02:24 and then 03:00 and then at 04:46 etc depending on how busy our systems are

Create an Escalation Service

1.  Navigate to **ScriptRunner > Escalation Service**.  
    Depending on whether or not you have already created escalation services, you are presented with either a landing screen or a list of previously created escalation services.
2.  Click **Create Escalation Service** from the initial landing screen if none have been previously created.![](/sr4jc/files/latest/103678285/524222495/1/1769451303000/get-started-with-escalation-services.png)  
    OR  
    Click **Create Escalation Service** from the previously created list. ![](/sr4jc/files/latest/103678285/166539095/1/1680619606000/escalation+service.jpg)
3.  **(Optional)** You can modify or delete any of the previously created escalation services. Click **Edit** or **Delete** via the **Actions** ellipsis to select your chosen escalation service and delete or **[edit](#id-.EscalationServicevCurrent-editescalation)** as required.  
    You will see the _Create Escalation Service_ screen, as shown below:   
    ![](/sr4jc/files/latest/103678285/452002070/1/1760630376000/create+esc+servuce.png) 
4.  Enter a name in the **The Escalation Service called** field. NOTE: The **With** **Identifier** field shows the unique identification key for the new escalation service.  
    
5.  Activate the **Enable Escalation Service** toggle. When set to **Enabled**, the new escalation service becomes active as soon as it is saved.
6.  Click on the edit pencil within the **On this schedule** field.
    -   The Scheduler dialog lets you choose between running your script on several days during the week (e.g. Monday, Wednesday, Friday), or running your script on particular days of the month (e.g. the last day of the month, the 2nd Tuesday of the month).
    -   You can enable a monthly schedule.
    -   Additionally, you can select an hour interval during which time your script will run.
    -   Each service can execute for the same length of time as [Script Listeners](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners), [Perform Actions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions) and in the [Script Console](https://docs.adaptavist.com/sr4jc/latest/features/script-console) as documented in the script [limitations](https://docs.adaptavist.com/x/gb4OBg).
7.  Enter a JQL query, for example, `status = 'In progress'`. Each defined job must include a JQL query to find the work items you wish to modify. 
8.  Enter the name of the user you wish to run the service for in **As This User**.
    
9.  Write your script in the code editor.  
    
    Reuse a script
    
    Click **Load** to reuse a previously saved script from [Script Manager](https://docs.adaptavist.com/sr4jc/latest/features/script-manager).  
    Further details on how to use this feature can be found in the [Reuse scripts in the UI](https://docs.adaptavist.com/sr4jc/latest/features/script-manager#id-.ScriptManagervDraft-ReusescriptsintheUIReusescriptsintheUI) section of the documentation.
    
    The code you provide as part of the job configuration will be run against each work item individually and in parallel. Each work item will be injected into your code as part of the Script Context.  
    OR  
    Alternatively, you can click the **Example scripts** button to view a list of example scripts related to this feature.  
    ![](/sr4jc/files/latest/103678285/524222494/1/1769451407000/copy-add-label-to-work-item.png)  
    So, rather than writing your own script, you can reuse one of the many examples provided, as follows:
    1.  Choose an example script from the list provided, and the code automatically appears. You also have the option to search for a particular script.
    2.  Click **Copy Code** and then **Close**.
    3.  Paste the copied code in the code editor.  
        
10.  (Optional) Click **Script Context** to open an information modal that highlights parameters/code variables.  
     For further information on referencing Script Context values, refer to [Example Script Variables](https://docs.adaptavist.com/sr4jc/latest/features/script-variables/example-script-variables).
11.  Click **Save** or **Run Now**. The results of the run and logs are displayed for each work item.
     

Maximum Issues

The maximum number of work items you can modify in any execution of an Escalation Service job is 50. In other words, we limit the number of work items returned by each JQL query to 50.

## Edit an Escalation Service

1.  Navigate to **ScriptRunner > Escalation Service**. A list of all escalation services is shown.
    
2.  Click **Edit** on the **Actions** ellipsis of the escalation service you wish to edit. You will see the _Edit Escalation Service_ screen.
    
3.  Edit the fields as required. When all changes have been made, click **Save**. You can also click **Revert** to undo those changes.
    
4.  Click **Run Now** after all changes are complete.

* * *

## Related content

-   Take our [ScriptRunner Tour](https://www.scriptrunnerhq.com/atlassian-apps/jira/scriptrunner-for-jira/cloud/get-started?__hstc=61790195.f51af098489d804a43e94be57b4d239c.1722866988392.1743171866570.1743492508364.505&__hssc=61790195.24.1743492508364&__hsfp=3420112851).
-   [S](https://docs.adaptavist.com/api/javadoc/cloud/scriptrunner/latest/hapi/jira/groovydoc/com/adaptavist/hapi/cloud/jira/projects/Projects.html#method_summary)ee our [Example Scripts](https://www.scriptrunnerhq.com/help/example-scripts?__hstc=61790195.f51af098489d804a43e94be57b4d239c.1722866988392.1743171866570.1743492508364.505&__hssc=61790195.24.1743492508364&__hsfp=3420112851) for Escalation Services.
