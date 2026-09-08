# Require a comment on transition

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > workflows > validators
- Doc ID: doc-sr4js-442885701
- Source: https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/require-a-comment-on-transition

Use the _Require a comment on transition_ validator to make sure a comment is added to the issue during the chosen transition. For example, you can use this validator to ensure a closing statement is added to an issue when it is transitioned to _Done_, or equivalent.

This validator must be applied to a transition with a [screen](https://confluence.atlassian.com/adminjiraserver0820/defining-a-screen-1095777068.html). Comments do not need to be configured to a screen as all transition screens include the option to add a comment.

## Use this validator

1.  Go to **Administration > Issues > Workflows.**
2.  Select **Edit** on the workflow to which you want to add this validator. 
3.  Select the transition to which you wish to add this validator.  
    
    Make sure the transition you're applying this validator to has a [screen](https://confluence.atlassian.com/adminjiraserver0820/defining-a-screen-1095777068.html) applied to it.  
    
4.  Under **Options**, select **Validators.  
    ![Image with validators option highlighted and an arrow pointing to the screen](/sr4js/files/latest/442885701/442885709/1/1758746507000/Require_comment_1.png)  
    **
5.  On the _Transition_ page, select **Add validator**.
6.  Select **Require a comment on transition**.  
    ![Image of the validator selected](/sr4js/files/latest/442885701/442885721/1/1758746507000/Require_a_comment_v_logo.png)  
    
7.  Select **Add**.
8.  Optional: Enter a note that describes the validator (this note is for your reference when viewing all validators). 
9.  Select **Update**.  
    ![Image of completed validator](/sr4js/files/latest/442885701/442885707/1/1758746506000/Require_comment_3.png)  
    
10.  Select **Publish** and choose if you want to save a backup copy of the workflow.  
     ![Image with Publish option highlighted](/sr4js/files/latest/442885701/442885706/1/1758746506000/Require_comment_4.png)
     
     You can now test to see if this workflow validator works. Issues in your chosen project will throw an error if you try to transition the issue without a comment.
     
     ![Image displaying error message](/sr4js/files/latest/442885701/442885705/1/1758746506000/Require_comment_6.png)
     

* * *

## Related content

-   [Validators Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/validators-tutorial)
-   [Workflows](https://docs.adaptavist.com/sr4js/latest/features/workflows)
-   [Validators](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators)
