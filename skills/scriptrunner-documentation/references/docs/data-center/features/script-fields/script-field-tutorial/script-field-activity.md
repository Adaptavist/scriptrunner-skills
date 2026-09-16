# Script Field Activity

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Script fields > Script Field Tutorial
- Doc ID: doc-sr4js-f00e115f-dc27-499d-a098-5e75fc51b2a7-3eba61d7ea8bc66a
- Source: https://docs.adaptavist.com/sr4js/latest/features#script-fields--en#script-field-tutorial--en#script-field-activity--en

Note: Make sure you have completed the [activity set up](https://docs.adaptavist.com/sr4js/latest/features/script-fields/script-field-tutorial) tasks before attempting this activity.

## Script Field Example

The Virtual Tour Service Management team would like better visibility into the last time a status change occurred for their story issues. By creating a script field, you can add this information right into the issue's view. For your instance, you may use different fields than the ones used in the following examples.

1.  Navigate to Script Fields, which is found under _ScriptRunner_ on the _Manage Apps_ page.
2.  Click Create Script Field.
3.  Choose Time of Last Status Change.
4.  Enter the appropriate information for the Field Name, Description, and Field Note.
    
    If you'd like to test to see if the field is operating as expected, you can enter a Preview Issue Key and click Preview.
    
5.  If the result of the preview is what you're expecting, click Add to create the field.
    
    A popup appears asking you to configure the _Context_ and _Screens_. You can also access these options from the cog to the right of the new field's name.
    
6.  Use the Configure Context option to restrict the field's scope to selected issue types and projects.
    
    For example, we could restrict to the Great Adventure Tours project.
    
7.  Using the Configure Screens option brings you to a list of all the screens in your Jira instance.
    
    Select the appropriate screens for your project(s) and click Update.
    
8.  Open an issue from the appropriate project.
    
    The date and time of last transition should appear in the _Dates_ section of the _View_ screen.
