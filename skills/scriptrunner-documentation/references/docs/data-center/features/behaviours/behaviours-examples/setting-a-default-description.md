# Setting a Default Description

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Behaviours > Behaviours Examples
- Doc ID: doc-sr4js-7cae289f-ffc8-490a-b059-cbbbd4544f60-352037b277cc9043
- Source: https://docs.adaptavist.com/sr4js/latest/features#behaviours--en#behaviours-examples--en#setting-a-default-description--en

In this example, we set a default description for renewal issues in the Great Adventure Licensing and Finance project. We recommend you change the details in this example and use your own project/s and description. This description contains set text to help the licensing specialists complete the issues, acting as a template to gather the correct information.

1.  Navigate to ScriptRunner > Behaviours.
2.  Select Create Behaviour.
3.  Enter a name for the behaviour. In this case we enter `Renewal Description`.
4.  Enter a description for the behaviour. This field is optional but in this case we enter `This behaviour adds a default description to new renewal issues`.
5.  Select Create Mapping.
6.  Then select the project and issue type(s) to map this behaviour to. In this case we chose the Great Adventure Licensing and Finance project and All issue types.
7.  Select Add Mapping to confirm the mapping.
8.  Select Create to create the behaviour.
    
    You're taken to a screen where you can configure the behaviour further.
    
9.  Select Create Script under Initialiser.
10.  Copy the following code into the inline script editor:
     
     ```
     def desc = getFieldById("description")
     
     def defaultValue = """\
             h2. Renewal Information
             * Confirm Company Name:
             * Confirm Existing License:
             * Confirm Number of Users:
             * Confirm Type of License:
             h3. Notes
             Provide any notes on renewal. Copy/pate from proposals and email correspondence as needed.
     
             h3. Final Actions
             * Update Jira Issue with appropriate information.
             * Assign issue to Licensing lead for approval.
         """.stripIndent()
     
     if (!desc.formValue) {
         desc.setFormValue(defaultValue)
     }
     ```
     
11.  Select Save Changes.

You can now test to see if this behaviour works!

## Related content

-   [1.2 Video: Using Behaviours in ScriptRunner for Jira Data Center/Server](../../../training/course-introduction-to-script-runner-for-jira-data-center/1-2-video-using-behaviours-in-script-runner-for-jira-data-center.md)
-   [Behaviours](https://docs.adaptavist.com/sr4js/latest/features/behaviours)
-   [Behaviours Tutorial](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-tutorial)
