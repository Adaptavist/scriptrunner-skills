# Create and Modify Jira Behaviours

- Platform: cloud
- Space: SR4JC
- Hierarchy: Features > Behaviours
- Doc ID: doc-sr4jc-11163637-f6ea-48ab-b3b1-05167f0d8f68-4b209d573ed6ca3d
- Source: https://docs.adaptavist.com/sr4jc/latest/features/behaviours#create-and-modify-jira-behaviours--en

## Create a Jira Behaviour

The steps below describe how you can create a new Jira behaviour:

1.  Navigate to ScriptRunner > Behaviours.
    
    You will see a list of any previously created behaviours.
    
2.  Click Create Behaviour.
    
    The following screen displays:
    
3.  Choose Jira Behaviour.
4.  Enter a name and description for the behaviour. It's good practice to make these as descriptive as possible.
5.  Select the spaces to which the behaviour will be applied from the Spaces drop-down list in the _Behaviours Mapping_ section.
    
    At least one space must be selected, and you have the option to select _All spaces_ if required.
    
6.  Select the type of work item you want to apply this behaviour to from the Work Types drop-down list.
    
    At least one work type must be selected, and you have the option to select _All work types_ if required.
    
    Note: Behaviours mapping with wildcards
    
    At least one work type must be selected, and you have the option to select _All_ _work types_ if required, which displays the maximum work types available.
    
    You can select the wildcard option for either All spaces or All work types only; due to an Atlassian limitation, both options cannot be chosen simultaneously.
    
    If you choose All spaces or All work types, any new spaces or work types added to your instance will automatically be included in the Behaviour. However, if you _manually_ select all the current spaces or work types instead of using the global _All_ options, then you must manually add these to the mapping, as they won't be automatically included.
    
7.  Click Add Script in the Behaviours Scripts section.
    
    You will see the _Add Field Script_ pop-up window appear, where you can add the behaviour script.
    
    Note: You can use the Fullscreen option to open the code editor in full-screen mode, and click Exit Fullscreen to return to the original size.
    
8.  Determine when the behaviour script will run by choosing either On load or On change (or both) from the Run the script options.
    
    | When | Runs |
    | --- | --- |
    | On load | The script will run when the create screen initially loads.Choose this option when you want the affected field to populate immediately upon opening the create screen. For example, a field name or description can be changed, or a value can be pre-populated into the field. |
    | On change | The script will run when the specified supported field change happens. You may want to run the script initially when it loads, AND if a change has occurred. Choose this option when you've added a condition to the logic and identified a trigger that will update the affected field. So, if you want to run the script after the user alters a field on the create screen, you should choose the On change option. For example, initially, you could set the assignee field to Bob, so all new bugs are assigned to them, but if the user changes the priority to High, the assignee would auto-update to Jane. |
    
9.  Choose to run the script on either the Create, View/Edit, or Transition (or multiple) view types from the _and on_ options.
    
    Refer to [Behaviours Supported Fields and Products](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-supported-fields-and-products), as not all field types are supported.
    
    Tip: Enable Transition View Per Screen
    
    Selecting the Transition View option will enable the behaviour for _all_ transition screens by default. If you want it to apply to a specific transition screen, then you need to specify the transition ID of that specific screen. To find that ID, go to Settings and select Work Items > Workflows > View and locate the _Transition Id_ column, where you will find the specific ID to use in your script. For example:
    
    ```
    // The transition ID for Done
    const transitionToDone = 41;
    
    // Get current transition ID
    const transitionId = await getContext().then(context =>
      context.extension.issueTransition.id
    );
    
    // If the current transition is to Done then do something
    if (transitionId == transitionToDone) {
      // Your logic here
    }
    ```
    
10.  Enter your code within the script box, as required.
     
     If needed, you can open the [API documentation](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-api) directly from here.
     
     Alternatively, you can reuse one of the many example scripts provided and modify the code as required, ensuring that you:
     
     -   Edit any variables, like custom field names, roles, or groups, in the example code so it's relevant to your instance.
     -   Choose the right time to run your script on load and/or change so that it runs when needed.
     
     You could also try our AI-powered script generation assistant, the [Behaviours Bot](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-bot).
     
     To choose an example:
     
     1.  Click Example scripts, and you are automatically redirected to the [ScriptRunner HQ](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=behaviours&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud) website, where you can view the Behaviours example scripts.
     2.  Choose your preferred script from the examples provided. You also have the option to search for a particular script.
     3.  Open the script and click Copy Cloud script.
     4.  Return to the script box and paste the copied code into the code editor.
     
11.  Click Save Script to save your behaviour script.
     
     Once saved, you will see the details displayed within the Behaviours Scripts table:
     
     You can use the Action ellipsis menu to Edit or Delete the script. If you want to continue adding more behaviour scripts, these must be defined separately, as outlined in the steps above. You can continue to add these to the table and add the logic needed until your business requirements for this behaviour are met.
     
12.  Click Save and enable to confirm the configurations for your behaviour. You also have the option to Save and disable the behaviour so that it can be activated another time.

The [Behaviour Logs](../../manage-app/review-logs.md) allow you to view data related to ScriptRunner for Jira Cloud Behaviours that have run in your Jira instance.

## Modify a Jira Behaviour

Follow the steps below to make changes to existing behaviours in ScriptRunner for Jira Cloud:

1.  Navigate to ScriptRunner > Behaviours.
    
    A list of previously created behaviours displays.
    
    You can search for a specific behaviour using the search bar by entering its name or UUID. The list of behaviours can be sorted by name and filtered using the available options—such as Affected Fields, Spaces, or Work Types — to help narrow down the list, for example:
    
2.  Click the Actions ellipsis next to your chosen behaviour, and you can choose from the following options:
    
    -   Edit - opens the _Edit Behaviour_ screen.
    -   Copy UUID - copies the UUID, which you can use in the search bar.
    -   Disable - makes the selected behaviour inactive. Disabled behaviours are clearly marked in the list.
    -   Delete - removes the behaviour if it is no longer in use.
    

### Edit a Jira Behaviour

1.  Click Edit from the Actions ellipsis next to the behaviour you want to modify.
    
    Click the Behaviour name to quickly navigate to the Edit Behaviour screen without opening the Actions ellipsis menu.
    
    The _Edit Behaviour_ screen opens, allowing you to make changes to any of the sections included here, such as edit the name and description, toggle the behaviour on or off, map to spaces and work types, and work with scripts.
    
    Note: All spaces OR all work types
    
    You can select all spaces or all work types, toggle seamlessly between them, and apply all options without manual configuration.
    
2.  Scroll to Behaviours Scripts and open the Actions ellipsis menu next to the Affected Field you want to edit.
    
    You can also delete each of the individual Behaviour Scripts via the Actions menu.
    
3.  Click Edit, and you will see the _Edit Field Script_ window displayed.
    
    Note:
    
    You can use the Fullscreen option to open the code editor in full-screen mode, and click Exit Fullscreen to return to the original size.
    
4.  Make the changes, such as modifying when the script runs, the type of view used, and/or editing the script code.
    
    Tip: Enable Transition View Per Screen
    
    Selecting the Transition View option will enable the behaviour for _all_ transition screens by default. If you want it to apply to a specific transition screen, then you need to specify the transition ID of that specific screen. To find that ID, go to Settings and select Work Items&gt;Workflows&gt;View and locate the _Transition Id_ column, where you will find the specific ID to use in your script.
    
    For example:
    
    ```
    // The transition ID for Done
    const transitionToDone = 41;
    
    // Get current transition ID
    const transitionId = await getContext().then(context =>
      context.extension.issueTransition.id
    );
    
    // If the current transition is to Done then do something
    if (transitionId == transitionToDone) {
    }
    ```
    
5.  Click Save to confirm the configurations for your behaviour.
