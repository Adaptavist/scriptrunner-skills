# Make Fields Editable Based on Role Example

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > behaviours > example-behaviour
- Doc ID: doc-sr4jc-414318834
- Source: https://docs.adaptavist.com/sr4jc/latest/features/behaviours/example-behaviour/make-fields-editable-based-on-role-example

You can use the Behaviours feature to control field editability based on user roles. For example, as a Space Manager, you may want fields to be editable for users with the Developer role but read-only for those with the Administrator role. To achieve this, you'll need to check which space roles the logged-in user belongs to, then configure the behaviour to make fields editable for Developers and read-only for Administrators.

To do so, follow the steps below:

1.  Navigate to **ScriptRunner > Behaviours**.
2.  Click **Create Behaviour** and the following screen appears:**  
    ![](/sr4jc/files/latest/414318834/578715725/1/1784645258000/create+behaviour+ex+3.png)  
    **
3.  Choose the **Jira Behaviour** option.
4.  Enter a name and description for the behaviour. In this example, we use _Make fields editable_ and _Make fields editable for a particular role_.
5.  Select the **Spaces** and **Work types** to which the behaviour will be applied (or mapped).  
    
    You cannot simultaneously select all space and all work types. See our [Behaviour Limitations](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-limitations) for more details.
    
6.  Click **Add Script**. You will see the _Add Field Script_ pop-up window appear, where you can add the behaviour script.
7.  Choose to run the script **On Change** and for the **View/Edit** view type.
8.  Click **Example Scripts,** and you are automatically redirected to the [ScriptRunner HQ](https://www.scriptrunnerhq.com/help/example-scripts?__hstc=61790195.da95f02d1ae0d1d31a393cdad208fa8e.1751962752113.1753699681099.1753779400943.54&__hssc=61790195.16.1753779400943&__hsfp=4179679497) website**.** There, you will find a variety of examples available.
    
9.  Filter or search to find the [Make Fields Editable to only users in a certain role](https://www.scriptrunnerhq.com/help/example-scripts/Restrict-Field-Actions-To-Certain-Roles-cloud) example script, and click **Copy Cloud Script**.
    
10.  Paste the copied code into your script editor, as shown below:  
     ![](/sr4jc/files/latest/414318834/524224863/1/1774281317000/makes+fields+editable.png)
11.  Click **Save Script** and then **Save and enable**. Now that you have created the behaviour, it automatically checks the currently logged-in user's space roles and adjusts field permissions, making fields editable for Developers and read-only Administrators.
