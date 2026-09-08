# Script Field Tutorial

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > script-fields
- Doc ID: doc-sr4js-101624114
- Source: https://docs.adaptavist.com/sr4js/latest/features/script-fields/script-field-tutorial

For a video on script fields, see the [Using Script Fields](https://docs.adaptavist.com/sr4js/latest/training/course-introduction-to-scriptrunner-for-jira-data-center-server/1-4-video-using-script-fields-in-scriptrunner-for-jira-data-center-server) training video. 

ScriptRunner gives you the ability to create custom fields that rely on an underlying script with a feature called script fields. At the time of this writing, ScriptRunner includes four pre-built custom fields, as well as the ability to apply a custom (or in-line) script to an entirely new field.

This feature is located in the _Manage Apps_ page. (**Administration>Manage Apps**).

![](/sr4js/files/latest/101624114/101627913/1/1600701245000/scriptfields.png)

The eight types of script fields available are:

1.  **Custom Script Field**
    
    This is the function you’d use to create a new custom field and script.
    
2.  **Date of First Transition**
    
    Displays the date that an issue was first moved to a designated status.
    
3.  **Issue(s) Picker**
    
    Allows you to select another issue, optionally constrained by a JQL query.
    
4.  **No. of Times in Status**
    
    Deploying this field informs users of how many times an issue has been in a designated status.
    
5.  **Show Parent Issue in Hierarchy**
    
    This field displays the parent issue in the hierarchy, and can be configured to follow Portfolio parent field or alternate links.
    
6.  **Remote Issue(s) Picker**
    
    Select an issue(s) from a linked Jira instance, optionally constrained by a JQL query.
    
7.  **Time of Last Status Change**
    
    The time stamp of the last status change is displayed in the issue.
    
8.  **Database Picker**
    
    Pick an item from a linked database table.
    

Fields need to be added to the relevant schemes by a Jira administrator in order to be used.

## Why Use Script Fields?

Script Fields can calculate or amalgamate data from one or more existing fields. When your users need calculations displayed in an issue, in reports, or they want to display other information that isn’t readily available via custom fields, ScriptRunner script fields give you the ability to meet their needs.

## Example of Script Field

In this example, we’ll help Great Adventure managers gauge how many times issues are being sent to the _In Progress_ status to determine whether or not excessive re-work is being done. If they find that there are issues, they can drill down and see what is causing the repeat work.

1.  Navigate to the ScriptRunner menu and select **Script Fields**.
    
2.  On the _Script Fields_ page that opens, click **Add New Item**. The five options of script field type appear.
    
3.  Click on **No. of Times in Status** option to open the form in which the script field will be defined.
    
4.  Enter `Count_In_Progress` in the **Field Name** box.
    
    ![](/sr4js/files/latest/101624114/101627914/1/1600701245000/FieldName_and_Description.png)
5.  Enter some descriptive text in the **Description** field.
    
6.  Select **In Progress** as the applicable status type from the list provided.
    
    ![](/sr4js/files/latest/101624114/101627919/1/1600701245000/IssueStatusField.png)
7.  Click **Add** at the bottom of the form, to create the field, then click **Configure Context** in the resulting pop-up.
    
    ![](/sr4js/files/latest/101624114/101627920/1/1600701245000/ConfigureContext.png)
8.  When the _Modify Configuration Scheme Context_ page displays, note that the name of the field can not be changed, but you could alter the description.
    
9.  Select the **Epic**, **Story**, **Task** and **Sub-Task** issue types.
    
    ![](/sr4js/files/latest/101624114/101627917/1/1600701245000/IssueTypeSelection.png)
10.  Select **Apply to Issues Under Selected Projects**.
     
11.  Then, select the **Great Adventures Customer Service** project from the list provided.
     
     ![](/sr4js/files/latest/101624114/101627895/1/1600701245000/ChooseContext.png)
12.  Click **Modify** to save the changes.
     
13.  On the next form, click **View Custom Fields**.
     
     ![](/sr4js/files/latest/101624114/101627896/1/1600701245000/ViewCustomFields.png)
14.  When the custom fields are shown, click the **Ellipses** icon to the right of the custom field that was just created.
     
15.  Select **Screens**.
     
16.  Then select the **Jira Service Desk Screen** for the Great Adventures Customer Service project by clicking in the selection box to the right of each entry.
     
     ![](/sr4js/files/latest/101624114/101627916/1/1600701245000/AssociateToScreens.png)
17.  Click **Update** to finalize the configuration.
     
18.  Navigate to the **Projects** page and select the Great Adventures Customer Service project.
     
19.  The newly-created field should now be visible on any _Edit/View_ and _Resolve_ screen for the Great Adventures Customer Service project.
     
     This field can now be searched using JQL. This permits any user to determine whether an issue has transitioned to the _In Progress_ state more often than would be normal. For example, it could help Jira admins identify tasks managed by people who are not following the internal processes correctly (given that _In Progress_ should not exceed a count of 6-10 before the issue is closed). It could also be used to help identify problems with workflow controls.
     

For more examples of script fields, see our [Example Scripts](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=script-fields&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=dataCenter).
