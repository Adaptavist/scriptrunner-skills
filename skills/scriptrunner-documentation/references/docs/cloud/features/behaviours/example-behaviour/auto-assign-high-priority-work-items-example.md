# Auto-assign High Priority Work Items Example

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > behaviours > example-behaviour
- Doc ID: doc-sr4jc-414318819
- Source: https://docs.adaptavist.com/sr4jc/latest/features/behaviours/example-behaviour/auto-assign-high-priority-work-items-example

You can use the Behaviours feature to automatically set the **Assignee** field when the **Priority** field is set to high and clear it for any other value. For example, as a Space Manager, you might want all high-priority work items to be assigned to the technical lead.

To do so, follow the steps below:

1.  Navigate to **ScriptRunner > Behaviours**.
2.  Click **Create Behaviour** and the following screen appears:  
    ![](/sr4jc/files/latest/414318819/578715720/1/1784645528000/create+behaviour+ex+4.png)
3.  Choose the **Jira Behaviour** option.
4.  Enter a name and description for the behaviour. For this example, we use _Auto-assign high priority work items_ and _Automatically assigns the work item to a specific user when the priority is high_.
5.  Select the **Spaces** and **Work types** to which the behaviour will be applied (or mapped).  
    
    You cannot simultaneously select all spaces and all work types. See our [Behaviour Limitations](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-limitations) for more details.
    
6.  Click **Add Script**. You will see the _Add Field Script_ pop-up window appear, where you can add the behaviour script.
7.  Choose to run the script **On Change** and for the **Create View** view type.
8.  Click **Example Scripts,** and you are automatically redirected to the [ScriptRunner HQ](https://www.scriptrunnerhq.com/help/example-scripts?__hstc=61790195.da95f02d1ae0d1d31a393cdad208fa8e.1751962752113.1753699681099.1753779400943.54&__hssc=61790195.13.1753779400943&__hsfp=4179679497) website**.** There, you will find a variety of examples available.
9.  Filter or search to find the [Set the assignee field when the priority is set to High](https://www.scriptrunnerhq.com/help/example-scripts/set-the-assignee-field-when-the-priority-is-set-to-high-cloud) example script, and click **Copy Cloud Script**.
10.  Paste the copied code into your script editor, as shown below:  
     ![](/sr4jc/files/latest/414318819/524224855/2/1774281776000/set+assignee+example.png)
11.  Click **Save Script** and then **Save and enable**. Now that you have created the behaviour, you will see that a high-priority field will be assigned only to the Space Manager when creating a story in Jira.
