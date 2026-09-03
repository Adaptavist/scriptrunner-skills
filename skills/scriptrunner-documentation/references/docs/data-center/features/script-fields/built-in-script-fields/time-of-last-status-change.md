# Time of Last Status Change

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > script-fields > built-in-script-fields
- Doc ID: doc-sr4js-442888345
- Source: https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/time-of-last-status-change

Use this built-in script field to display the date and time an issue's status was last changed. For example, if an issue's status was last changed from _To-do_ to _Done_, this field will display when this change occurred. 

This script field will display a status change if the status of an issue is transitioned to the same status, for example from **To-do** to **To-do**. 

## Using this build-in script field

This built-in script field is automatically applied globally, however, you can configure the context and screens as you like.

1.  From ScriptRunner, select the **Fields** tab to enter the _Script Fields_ page.
2.  Select **Create Script Field**.
3.  Select the **Time of Last Status Change** built-in script**.**
4.  Enter a **Field Name**, for example `Time of Last Status Change`.
5.  Optional: Enter a **Field Description**. This description is only visible when you edit this built-in script field.
6.  Optional: Enter a **Field Note**. This note is visible under the field name on the _Script Fields_ page.
7.  Optional: Enter an issue key to preview how this field displays and select **Preview**.
8.  Select **Add**.  
    ![](/sr4js/files/latest/442888345/442888346/1/1758746931000/Time_of_last_status_change.png)  
    A pop-up displays that enables you to configure the screens and context for this built-in script field.  
    ![](/sr4js/files/latest/442888345/442888347/1/1758746932000/Configure_context_and_screens.png)
9.  Configure the [context](https://confluence.atlassian.com/adminjiraserver/configuring-custom-field-contexts-1047552717.html) and [screens](https://confluence.atlassian.com/adminjiraserver/defining-a-screen-938847288.html) for this built-in script field.
10.  You can now test this built-in script field by going to an issue this field is configured to. You can find this script field in the _Dates_ section of an issue.  
     ![](/sr4js/files/latest/442888345/442888348/2/1758746932000/Time_of_last_status_change_results.png)
