# Example Behaviour

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > behaviours
- Doc ID: doc-sr4jc-151629802
- Source: https://docs.adaptavist.com/sr4jc/latest/features/behaviours/example-behaviour

Example scripts

You can find many example Behaviours scripts in the [Example scripts](https://www.scriptrunnerhq.com/help/example-scripts) section of the [ScriptRunner website](https://www.scriptrunnerhq.com).

If you are setting a field value that is in **Atlassian Doc Format**, you can use the [ADF builder tool](https://developer.atlassian.com/cloud/jira/platform/apis/document/playground/) provided by Atlassian and refer to their [documentation](https://developer.atlassian.com/cloud/jira/platform/apis/document/structure/?_ga=2.116963205.265153314.1664180857-1688501704.1660815719) for more details.

## Example: Change field name 

This example shows you how to change the name displayed for a specific field within the work item creation screen in Jira. In this example, the field entitled **Summary** is changed to **Ticket Title** in response to a particular team's preferences.

Follow the steps below to create the behaviour:

1.  Open the _Behaviours_ tab and click **Create Behaviour**. You will see the _Create Behaviour_ screen displayed:  
    ![](/sr4jc/files/latest/151629802/574260422/1/1784631152000/jira+behaviour+create.png)
2.  Choose the **Jira Behaviour** option.
3.  Enter a name and description for the behaviour. It's good practice to make these as descriptive as possible.
4.  Scroll down to the _Behaviour Mapping_ section and select the relevant space to which this behaviour will be mapped from the _Spaces_ drop-down. For this example, choose the **Docs** space.
5.  Select the work type that will be associated with the behaviour from the _Work Types_ drop-down. For this example, choose the **Task** work item type.
6.  Scroll down to the _Behaviours Scripts_ section and click **Add Script**. The _Add Field Script_ pop-up window is displayed, where you can add the behaviour script:  
    ![](/sr4jc/files/latest/151629802/395903591/2/1774275603000/add+field+script.png)
7.  Define _when_ the script should run. This can be when the work item creation screen loads initially and/or in response to a field change. For this example, check the **On load** option so that the **Summary** field is renamed to **Ticket Title** when the work item creation screen loads.
    
    When
    
    Runs
    
    On load
    
    The script will run when the create screen initially loads. Choose this option when you want the affected field to populate immediately upon opening the create screen. 
    
    For example, a field name or field description is changed, or a value is pre-populated into the field.
    
    On change
    
    The script will run when the specified supported field change happens. Choose this option when you've added a restrict transition to the logic and identified a trigger that will update the affected field. 
    
8.  Choose **Create** from the view type options of **Create**, **View/Edit**, or **Transition** to run the script on. Refer to the [Behaviours Supported Fields and Products](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-supported-fields-and-products) details, as not all field types are supported.
9.  Enter your code within the script box, as required. Note that you can open the [API documentation](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-api) directly from here.   
    Alternatively, you can reuse one of the many example scripts provided and modify the code as required, ensuring that you:
    
    -   Edit any variables, like custom field names, roles, or groups, in the example code so it's relevant to your instance.
    -   Choose the right time to run your script on load and/or change so that it runs when needed.
    
    To choose an example:   
    1.  Click **Example scripts,** and you are automatically redirected to the [ScriptRunner HQ website](https://www.scriptrunnerhq.com/help/example-scripts?__hstc=61790195.dc865c37e20bd115fe7ef340c103a316.1727432789496.1757052734380.1757057082801.507&__hssc=61790195.43.1757057082801&__hsfp=173020142&_gl=1*1fyspf7*_gcl_aw*R0NMLjE3NTI1NzYxMzkuQ2owS0NRanctTmZEQmhEeUFSSXNBRC1JTGVEamRsNHFfRFZDdklFSzBkcjhaX1hPSmpvZTJaaTVtLThNQ3kzbXN1X0V2UUNENE14cFN4c2FBbkhSRUFMd193Y0I.*_gcl_au*MzIzNDM2MjIxLjE3NTE4NzUwMTE.*_ga*MTYzNDU5NTExMC4xNzI3NDMyNzkw*_ga_C6V1F2HSMM*czE3NTcwNTcwODAkbzUyMyRnMSR0MTc1NzA2MTQyNiRqNTkkbDAkaDExMDk2NjUwNTY.), where you can view the Behaviours example scripts.
    2.  Choose your preferred script from the examples provided. You also have the option to search for a particular script.  
        
    3.  Open the script and click **Copy Cloud script**.
    4.  Return to the script box and paste the copied code into the code editor.
10.  Click **Save Script** once you have confirmed the parameters as `getFieldById("summary").setName("Ticket Title")`;.
11.  Click **Save and enable** to confirm the configurations for your behaviour.  
     Now that you have created the behaviour to run when the screen loads, you will see the field entitled **Summary** change to **Ticket Title** when you create new tasks within the **Docs** space in your Jira instance.
12.  Refresh your screen and click **Create** to see the behaviour in action. You are returned to the _Create work item_ screen, where you will see your changes, as shown below:  
     ![](/sr4jc/files/latest/151629802/395903589/1/1750245101000/new+ticket+title.png)  
     If you wish to revert to the original **Summary** field name, click **Disable** from the ellipsis menu next to your chosen behaviour, as shown below:  
     ![](/sr4jc/files/latest/151629802/395903587/1/1750245216000/edit+behaviours+.png)
