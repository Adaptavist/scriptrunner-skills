# Field(s) Changed Validator

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > workflows > validators
- Doc ID: doc-sr4js-442885647
- Source: https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/field-s-changed-validator

Use the _Field(s) changed validator_ to ensure that the values of the selected fields have changed during a workflow transition. If there has been no change to the selected fields, the issue will not be permitted to transition, and an error will be displayed. For example, you may want to ensure that the _Assignee_ field is updated when transitioning between _In Development_ and _In Test_.

This validator must be applied to a transition with a [screen](https://confluence.atlassian.com/adminjiraserver0820/defining-a-screen-1095777068.html). When completing this validator, only fields configured in the associated transition screen are listed.

To find out which screen is associated with a transition, select the transition in your workflow diagram. The associated screen displays. Select the screen name to be taken to the _Configure Screen_ page.

![Image example of a screen attached to a transition](/sr4js/files/latest/442885647/442885648/1/1758746502000/Screen_example.png)

## Use this validator

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow you want to add this validator to. 
3.  Select the transition you want to add this validator to.  
    
    Make sure the transition you're applying this validator to has a [screen](https://confluence.atlassian.com/adminjiraserver0820/defining-a-screen-1095777068.html) applied to it.  
    
4.  Under **Options**, select **Validators.  
    ![](/sr4js/files/latest/442885647/442885650/1/1758746502000/Fields_changed_validator_2.png)  
    **
5.  On the _Transition_ page, select **Add validator**.
6.  Select **Field(s) changed validator**.  
    ![Image of the validator selected](/sr4js/files/latest/442885647/442885667/1/1758746503000/Fields_changed_v_logo.png)  
    
7.  Select **Add**.
8.  Optional: Enter a note that describes the validator (this note is for your reference when viewing all validators).
9.  Under **Fields** select one or more fields that you wish to be changed on issue transition.
10.  Select **Update**.  
     
11.  Select **Publish** and choose if you want to save a backup copy of the workflow.  
     ![Image with Publish option highlighted](/sr4js/files/latest/442885647/442885652/1/1758746502000/Require_comment_4.png)
     
     You can now test to see if this workflow validator works. Issues in your chosen project will throw an error if you try to transition the issue without modifying the chosen fields.
     
     ![Example of error](/sr4js/files/latest/442885647/442885649/1/1758746502000/Fields_changed_3.png)
     

  

* * *

## Related content

-   [Validators Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/validators-tutorial)
-   [Workflows](https://docs.adaptavist.com/sr4js/latest/features/workflows)
-   [Validators](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators)
