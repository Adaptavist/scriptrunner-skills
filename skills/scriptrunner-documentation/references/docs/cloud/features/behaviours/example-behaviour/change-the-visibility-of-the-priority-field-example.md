# Change the Visibility of the Priority Field Example

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > behaviours > example-behaviour
- Doc ID: doc-sr4jc-414318811
- Source: https://docs.adaptavist.com/sr4jc/latest/features/behaviours/example-behaviour/change-the-visibility-of-the-priority-field-example

You can use the Behaviours feature to control who can see or edit the **Priority** field based on their user permissions. For example, if you want only Space Managers to change the field, you can configure the behaviour to hide the field from all other users.

To do so, follow the steps below:

1.  Navigate to **ScriptRunner > Behaviours**.
2.  Click **Create Behaviour** and the following screen appears:**  
    ![](/sr4jc/files/latest/414318811/578715718/1/1784638847000/create+behaviours+ex+2.png)  
    **
3.  Choose the **Jira Behaviour** option.
4.  Enter a name and description for the behaviour. In this example, we use _Hide the priority field from users with certain permissions_ and _Hide the priority field from anyone who does not have that permission_.
5.  Select the **Spaces** and **Work Types** to which the behaviour will be applied (or mapped).  
    
    You cannot simultaneously select all spaces and all work types. See our [Behaviour Limitations](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-limitations) for more details.
    
6.  Click **Add Script**. You will see the _Add Field Script_ pop-up window appear, where you can add the behaviour script.
7.  Choose to run the script **On Load** and for the **View/Edit** view type.
8.  Click **Example Scripts**, and you are automatically redirected to the [ScriptRunner HQ](https://www.scriptrunnerhq.com/help/example-scripts?__hstc=61790195.da95f02d1ae0d1d31a393cdad208fa8e.1751962752113.1753699681099.1753779400943.54&__hssc=61790195.13.1753779400943&__hsfp=4179679497) website**.** There, you will find a variety of examples available.
9.  Filter or search to find the [Change the visibility of the priority field](https://www.scriptrunnerhq.com/help/example-scripts/Show-Priority-To-Users-In-Specific-Group-cloud) example script, and click **Copy Cloud Script**.
10.  Paste the copied code into your script editor, as shown below:  
     ![](/sr4jc/files/latest/414318811/524224851/1/1774280852000/change+visibility+example.png)
11.  Click **Save Script** and then **Save and enable**. 
     
     Now that you have created the behaviour, you will see that the **Priority** field is only visible to the Space Managers when creating an issue in Jira.
