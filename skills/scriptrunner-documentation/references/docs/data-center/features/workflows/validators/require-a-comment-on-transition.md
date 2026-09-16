# Require a comment on transition

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Workflows > Validators
- Doc ID: doc-sr4js-3e147310-52a9-486a-ac09-c5a81a83ef2f-b4216f339d9787ac
- Source: https://docs.adaptavist.com/sr4js/latest/features#workflows--en#validators--en#require-a-comment-on-transition--en

Use the _Require a comment on transition_ validator to make sure a comment is added to the issue during the chosen transition. For example, you can use this validator to ensure a closing statement is added to an issue when it is transitioned to _Done_, or equivalent.

Tip: This validator must be applied to a transition with a [screen](https://confluence.atlassian.com/adminjiraserver0820/defining-a-screen-1095777068.html). Comments do not need to be configured to a screen as all transition screens include the option to add a comment.

## Use this validator

1.  Go to Administration > Issues > Workflows.
2.  Select Edit on the workflow to which you want to add this validator.
3.  Select the transition to which you wish to add this validator.
    
    Tip: Make sure the transition you're applying this validator to has a [screen](https://confluence.atlassian.com/adminjiraserver0820/defining-a-screen-1095777068.html) applied to it.
    
4.  Under Options, select Validators.
    
5.  On the _Transition_ page, select Add validator.
6.  Select Require a comment on transition.
    
7.  Select Add.
8.  Optional: Enter a note that describes the validator (this note is for your reference when viewing all validators).
9.  Select Update.
    
10.  Select Publish and choose if you want to save a backup copy of the workflow.
     

You can now test to see if this workflow validator works. Issues in your chosen project will throw an error if you try to transition the issue without a comment.

## Related content

-   [Validators Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/validators-tutorial)
-   [Workflows](https://docs.adaptavist.com/sr4js/latest/features/workflows)
-   [Validators](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators)
