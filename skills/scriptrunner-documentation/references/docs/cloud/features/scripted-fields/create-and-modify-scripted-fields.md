# Create and Modify Scripted Fields

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > scripted-fields
- Doc ID: doc-sr4jc-517020958
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields/create-and-modify-scripted-fields

Change notice: Atlassian's changes to custom field configurations

From January 2026, Atlassian has changed how custom fields are configured in Jira (see [this article](https://community.atlassian.com/forums/Jira-articles/Announcement-Changes-to-field-and-work-type-configuration-in/ba-p/3023478) for details). New custom fields are no longer automatically linked to all field configuration schemes. Instead, you must associate custom fields with a field configuration scheme and add them to the relevant space screens. In addition, **Field Configurations** and **Field Configuration Schemes** are merging into a new **Field Schemes** option.

**Impact on Scripted Fields:**

When you create a new scripted field that uses custom fields and attempt to add it to a space, it will not appear unless it has first been associated with a field configuration scheme. To associate a scripted field with a space:

1.  Navigate to **Jira Settings > Field Configuration**.
2.  Select the **Custom Field (Scripted Field)**.
3.  Associate the field with the appropriate field configuration scheme.
4.  Add the field to the relevant space screen.

## Create a Scripted Field

1.  Navigate to **ScriptRunner > Scripted Fields**.  
    Depending on whether or not you have already created scripted fields, you are presented with either a landing screen or a list of the previously created scripted fields.
    
2.  Click **Create Scripted Field** from the initial landing screen if none have been previously created. If you would prefer to make use of our built-in examples, click **Add Examples** to add two scripted field examples to your instance.![](/sr4jc/files/latest/517020958/517020960/1/1773314515000/landing+screen+scripted+fields.jpeg)  
    _**OR**_  
    Click **Create Scripted Field** from the previously created list.  
    ![](/sr4jc/files/latest/517020958/517020961/1/1773314516000/scripted+field+list.jpg)
    
3.  Enter the name of the scripted field in **Field Name**.  
    ![](/sr4jc/files/latest/517020958/517020962/1/1773314516000/create+scripted+field+new.png)
    
4.  Enter a description for the scripted field that summarises its purpose in the **Description** field.  
    NOTE: The **Identifier** field shows the unique identification key for the new scripted field.
5.  Select the scripted field's **Field Type** from the list provided. Ensure you pick the correct field type for the data returned by your script. See [Return Types](https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields/return-types) for more information.
    
6.  Enter a script in the code editor that will run as a **Script to execute**. This script is triggered when a work item is loaded.
    
    View or reuse saved scripts
    
    Click the **Script Usage** drop-down list to view your saved script files and identify exactly where they are configured in your instance. You can also click **Load** to reuse a previously saved script from [Script Manager](https://docs.adaptavist.com/sr4jc/latest/features/script-manager). Further details on how to use these features can be found in [Reuse scripts in the UI](https://docs.adaptavist.com/sr4jc/latest/features/script-manager#id-.ScriptManagervDraft-ReusescriptsintheUI).
    
    OR  
    Alternatively, you can click the **Example scripts** button to view a list of example scripts related to this feature. So, rather than writing your own script, you can reuse one of the many examples provided, as follows:
    
    1.  Choose an example script from the list provided, and the code automatically appears. You also have the option to search for a particular script.
        
    2.  Click **Copy Code** and then **Close**.
    3.  Paste the copied code in the code editor.
    
    ![](/sr4jc/files/latest/517020958/524224565/1/1774524208000/scripted+field+example+script.png)  
    
    Scripted fields in Jira Cloud do not dynamically update. The script triggers on work item load, and also when a work item that contains a scripted field is updated. Therefore, changes to the field value are not reflected instantly, and the work item must be reloaded.
    
7.  ****(Optional)**** Click **Script context** to view an information modal highlighting parameters/code variables. For further information on referencing Script Context values, refer to [Example Script Variables](https://docs.adaptavist.com/sr4jc/latest/features/script-variables/example-script-variables).
8.  **(Optional)** Select a work item in **Test against work item** to test the scripted field before saving. We recommend carrying out this step.  
    
    Any changes to the scripted field's configuration will require a re-test.
    
9.  Click **Save.  
    **Once saved, you will see a new entry in the **Custom Field ID** column of the scripted fields list that is associated with your newly created scripted field. If you want to modify the custom field, refer to [Step 3](#id-.CreateandModifyScriptedFieldsvCurrent-step4) below. Scripted fields run when a work item is viewed or updated, so they must be added to the view and edit screens for them to run. To do this:
    

1.  1.  Open your preferred space from the Jira admin page and click **Space Settings**.
    2.  Navigate to **Work Items > Layout**, where you will see the default _Work Item Layout_ page.
    3.  Drag the newly created scripted field anywhere within the Work Item panel, click **Save,** and return to **Space Settings**.  
        You can now open any work item and view the scripted field within the layout of that work item.

## Edit a Scripted Field

1.  Navigate to **ScriptRunner > Scripted Fields**. A list of all previously created scripted fields is shown.
    
2.  **(Optional)** Click **Delete** via the **Actions** ellipsis for any scripted field you wish to remove.
    
3.  **(Optional)** Click the relevant entry in the **Custom Field ID** column if you want to modify the details of any of the custom fields associated with each scripted field. You are redirected to the **Edit Custom Field Details** screen contained within the **Work Items** section of the Jira admin. After completing the required edits, click **Update** to confirm your changes, as shown below:  
    ![](/sr4jc/files/latest/517020958/524225350/1/1774623726000/edit+custom+field+details.png)  
    
4.  Click **Edit** on the **Actions** ellipsis of the scripted field you wish to edit. The _Edit Scripted Field_ screen is displayed.
    
5.  Edit the fields as required. Remember, you can choose from our list of example scripts for Scripted Fields.
    
    Limited edits for Scripted Fields
    
    There are limits to the changes that can be made here because a custom field has already been created for the scripted field you are editing. If you want to change the **Field Name** or **Description**, you need to navigate to the Jira administration section. Also, you must [create a new scripted field](#id-.CreateandModifyScriptedFieldsvCurrent-createscriptedfield) in ScriptRunner if you want to change the **Field Type**.
    
6.  Click **Save** after all changes are complete. You can also click **Revert** to undo those changes.
