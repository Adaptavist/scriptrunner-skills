# Linked Issues Condition

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > workflows > conditions
- Doc ID: doc-sr4js-442885492
- Source: https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/linked-issues-condition

Use the _Linked issues condition_ to control whether or not a user can transition an issue based on the status or resolution of linked issues. There are several options available when setting up the _Linked Issues Condition_, and these are described below. 

## Status vs resolution check

The **Status** indicates an issue's position in its workflow, while **Resolution** specifies why an issue is closed. The _Linked issues condition_ allows you to check the status or resolution of linked issues before an issue can be transitioned. 

### Status check

The **Status** radio button allows you to control the transition based on the status of any linked issues. If the **Status** option is selected, the transition is only allowed if _all_ linked issues of the selected link directions are in _any_ of the selected statuses.

For example, you want to only allow the transition of a story to _Done_ if all _is blocked by_ or _is caused by_ linked issues are in the _Done_ status.

![](/sr4js/files/latest/442885492/442885496/1/1758746490000/Blockers_must_be_done.png)

Use the **Invert condition** checkbox to reverse the above condition logic

### Resolution check

The **Resolution** radio button allows you to control the transition based on the resolution of the linked issues. If the **Resolution** option is selected, two options are available:

-   **Any Resolution** - Allows the transition if linked issues (of the specified link type) have _any_ resolution.
-   **Select Resolution(s)** - Allows the transition if linked issues (of the specified link type) have any specified resolution.

For example, you want to only allow the transition of an Epic to _Done_ if all the issues in the epic and epic subtasks have a resolution.

![](/sr4js/files/latest/442885492/442885495/1/1758746490000/Enforce_resolution.png)

Alternatively, you want to only allow an Epic to transition to _Done_ when all issues in the epic and epic subtasks have the resolution _Done_.

![](/sr4js/files/latest/442885492/442885494/1/1758746490000/Restrict_to_done.png)

Use the **Invert condition** checkbox to reverse the above condition logic

## Use this condition

You can add this condition to any transition except the _Create_ transition.

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow you want to add a condition to. 
3.  Select the transition to which you wish to add a condition.
4.  Under **Options**, select **Conditions.  
    **
5.  On the _Transition_ page, select **Add condition**.
6.  Select the **Linked issues condition** condition.  
    ![](/sr4js/files/latest/442885492/442885518/1/1758746492000/Linked_issues_condition_logo.png)  
    
7.  Enter a description of the condition in **Note**.
8.  Select the **Link Directions** you want the condition to look for.
9.  Select if you want to use **Status** or **Resolution** for the **Checks on the linked issues.**
10.  If you choose **Status**, enter the status values you want to check for.  
     **OR**  
     If you choose **Resolution**, select the **Any resolution** radio button to check if the issue has any resolution set, or choose **Select resolution(s)** and enter the required resolutions.
11.  Optionally, select to **Invert Condition**. This option reverses the condition logic. 
12.  Click **Update.  
     ![](/sr4js/files/latest/442885492/442885494/1/1758746490000/Restrict_to_done.png)  
     **

The **is epic of** link direction can be used to control the ability to transition an epic based on the issues shown in the **Issues in Epic** section of the epic.

The **subtask** link direction can be used to control the parent issues ability to transition based on the linked subtasks.

## Links with the same inward and outward direction names

Links with the same inward and outward direction names, for example **relates to**, are not supported and cannot be selected from the **Link Direction (Link Type)** field.

Go to the **Administration > Issues > Issue linking** (under **Issue Features**) to view your link type direction names.
