# Using a Server-side Validator to set the Fix Versions Required

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Behaviours > Behaviours Examples
- Doc ID: doc-sr4js-5e7a3f5e-f7c1-46ba-853b-a95dc844a9c7-9d4a21d9f3d93a74
- Source: https://docs.adaptavist.com/sr4js/latest/features#behaviours--en#behaviours-examples--en#using-a-server-side-validator-to-set-the-fix-versions-required--en

On this page, we provide you with an example of how to set the Fix Version/s field as required using a [server-side script](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-tutorial#should-i-add-an-initialiser-or-server-side-script--en) in a Behaviour. For example, when you mark an issue as Resolved with the resolution of Fixed, you want the developer to specify the Fix Version/s. You may also want to hide this field if the resolution is any other resolution, such as Won't Fix.

Note: Prerequisites

The following example will only work if your project has the following:

-   A workflow status with a Resolved status and Resolve Issue transition (or something similar)
-   A Resolve Issue transition with a [screen](https://confluence.atlassian.com/adminjiraserver100/defining-a-screen-1442845527.html) associated with it.
-   A Resolve Issue transition screen that includes the Resolution and Fix Version/s fields.
-   A [Resolution](https://confluence.atlassian.com/adminjiraserver/defining-resolution-field-values-938847105.html) field value of Fixed.

1.  Navigate to ScriptRunner > Behaviours.
2.  Select Create Behaviour.
3.  Enter a name for the behaviour. In this example we enter `Set Fix Version as Required`.
4.  Optional: Enter a description for the behaviour.
5.  Select Create Mapping.
6.  Select the project and issue type(s) to map this behaviour to. In this example we chose the ITSM project and All issue types.
7.  Select Add Mapping to confirm the mapping.
8.  Select Create to create the behaviour.
    
    \`
    
    You're taken to the Edit Behaviour screen where you can configure the behaviour further.
    
9.  Scroll to the Add Field field, select the Resolution field, and then select Add.
    
10.  Select Create Script.
     
     A code editor displays.
     
11.  Enter the following script:
     
     ```
     import com.atlassian.jira.issue.resolution.Resolution
     
     def resolutionField = getFieldById("resolution")
     def fixVersionsField = getFieldById("fixVersions")
     
     def resolution = resolutionField.getValue() as Resolution
     
     if (resolution.name == "Fixed") {
         fixVersionsField.setRequired(true)
         fixVersionsField.setHidden(false)
     } else {
         fixVersionsField.setRequired(false)
         fixVersionsField.setHidden(true)
     }
     ```
     
     Tip: This sets the Fix Version/s field to required and shown if the resolution is Fixed, and to optional and hidden if the resolution is anything else.
     
12.  Select Save Changes.

You can test to see if this behaviour works. The Fix Version/s field will display as required when the resolution of Fixed is selected. The field will also display a warning if a user tries to transition the issue without adding the fix version.

The Fix Version/s field will disappear if any other resolutions are selected.

## Related content

-   [Behaviours](https://docs.adaptavist.com/sr4js/latest/features/behaviours)
-   [Behaviours Tutorial](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-tutorial)
-   [Field(s) Required Condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/fields-required-condition)
