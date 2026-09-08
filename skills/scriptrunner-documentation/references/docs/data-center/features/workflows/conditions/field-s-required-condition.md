# Field(s) Required Condition

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > workflows > conditions
- Doc ID: doc-sr4js-442885436
- Source: https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/field-s-required-condition

This condition checks that the selected fields have a value before it can transition in a workflow. If any of the specified fields are empty, the issue can not transition.

For example:

-   You want to ensure the system field **Fix Version/s** field has a value before the issue can be transitioned to _Done._ 
-   You have a **Purchase Order Number** database picker field, you want this to be completed before the issue can transition to _In Progress_. 

## Use this condition

To set up a Field(s) Required condition do the following:

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow you want to add a condition to. 
3.  Select the transition to which you wish to add a condition.
4.  Under **Options**, select **Conditions.  
    ![Image highlighting the Conditions option](/sr4js/files/latest/442885436/442885439/1/1758746486000/Select_done_transition.png)  
    **
5.  On the _Transition_ page, select **Add condition**.
6.  Select **Field(s) required** **condition**.
    
7.  Optional: Enter a description of the condition in **Note**.
8.  Optional: Enter a **Condition** for which the condition fires. If you leave this blank the condition will run on all issues in the workflow.
    
    If you need help writing your script, check out the [Scripting tips](https://docs.adaptavist.com/display/SR4JS/.Scripting+Tips+vDraft) page.
    
9.  Select the **Required field(s).**
    
    You can either type a field name or select from the drop-down menu. 
    
10.  Select **Update**.  
     ![Image showing the completed condition](/sr4js/files/latest/442885436/442885438/1/1758746486000/Field_required.png)
     
11.  Select **Publish** and choose if you want to save a backup copy of the workflow.  
     ![Image showing the Publish button being highlighted](/sr4js/files/latest/442885436/442885437/1/1758746486000/Select_publish.png)
     
     You can now test to see if this workflow condition works.
     

  

* * *

## Related content

-   [Conditions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/conditions-tutorial)
-   [Validators Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/conditions-tutorial)
-   [Workflow Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial)
