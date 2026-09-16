# Field(s) Required Validator

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Workflows > Validators
- Doc ID: doc-sr4js-4223ec3d-c644-40b7-a17e-3d0457577d25-ee5534784128e800
- Source: https://docs.adaptavist.com/sr4js/latest/features#workflows--en#validators--en#fields-required-validator--en

Use the _Field(s) required validator_ to check that the selected fields have a value during a workflow transition. If any of the specified required fields are empty, the issue will not be permitted to transition, and an error will display.

For example:

-   You want to ensure the system field Fix Version/s field has a value before the issue can be transitioned to _Done._
-   You have a Purchase Order Number database picker field, you want this to be completed before the issue can transition to _In Progress_.

Tip: This validator must be applied to a transition with a [screen](https://confluence.atlassian.com/adminjiraserver0820/defining-a-screen-1095777068.html). When completing this validator, only fields configured in the associated transition screen are listed in the Required Field(s) drop-down.

To find out which screen is associated with a transition, select the transition in your workflow diagram. The associated screen displays. Select the screen name to be taken to the _Configure Screen_ page.

Note: Red asterisk

Due to how validators work, the field will not show as required (display an asterisk) until you try to transition the issue without completing the required field(s).

You can use our Behaviours feature to [make a field required based on a condition](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples/field-required#making-a-field-required-based-on-a-transition--en). This will display the red asterisk however this option is not transition-dependent.

## Use this validator

1.  Go to Administration > Issues > Workflows.
2.  Select Edit on the workflow you want to add this validator to.
3.  Select the transition you want to add this validator to.
    
    Tip: Make sure the transition you're applying this validator to has a [screen](https://confluence.atlassian.com/adminjiraserver0820/defining-a-screen-1095777068.html) applied to it.
    
4.  Under Options, select Validators.
    
5.  On the _Transition_ page, select Add validator.
6.  Select Field(s) required validator.
    
7.  Select Add.
8.  Optional: Enter a note that describes the validator (this note is for your reference when viewing all validators).
9.  Optional: Enter the Condition for which the validator fires. If you leave this blank, the validator will run on all issues in the workflow.
    
    Tip: Select Example scripts to help you construct a condition.
    
10.  Select the Required Fields.
11.  Select Update.
12.  Select Publish and choose if you want to save a backup copy of the workflow.
     

You can now test to see if this workflow validator works. Issues in your chosen project will throw an error if you try to transition the issue without completing the required field(s).

## Related content

-   [Validators Tutorial](https://docs.adaptavist.com/sr4js/latest/features/workflows/workflow-functions-tutorial/validators-tutorial)
-   [Workflows](https://docs.adaptavist.com/sr4js/latest/features/workflows)
-   [Validators](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators)
