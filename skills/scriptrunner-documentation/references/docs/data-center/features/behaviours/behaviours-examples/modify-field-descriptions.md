# Modify Field Descriptions

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Behaviours > Behaviours Examples
- Doc ID: doc-sr4js-d19ec49e-9412-480c-b900-b2b99169350f-883a64ae0d730e88
- Source: https://docs.adaptavist.com/sr4js/latest/features#behaviours--en#behaviours-examples--en#modify-field-descriptions--en

You can use Behaviours to modify field descriptions, for example, to make a field mandatory and add a description. For example, you can use the following example to make the _Description_ field required and add a note to the field when the _Priority_ of an issue is set to _Highest_:

1.  From ScriptRunner, navigate to Behaviours.
2.  Select Create Behaviour.
3.  Enter a name for the behaviour. In this example we enter `Modify description field when priority is highest`.
4.  Enter a description for the behaviour. This field is optional.
5.  Select Create Mapping.
6.  Then select the project and issue type(s) to map this behaviour to.
7.  Select Add Mapping to confirm the mapping.
8.  Select Create to create the behaviour.
    
    You're taken to a screen where you can configure the behaviour further.
    
9.  Optional: Enter a guide workflow.
10.  Scroll to the Add Field section and add the Priority field.
     
11.  Select Create Script to add a server side script to the _Priority_ field.
     
12.  Copy the following code into the inline script editor:
     
     ```
     def formField = getFieldById(getFieldChanged())
     def descField = getFieldById("description")
     
     def priority = formField.getValue()?.name
     if (priority == "Highest") { // choose priority by name
         descField.setHelpText("Please explain why priority is Highest.")
         descField.setRequired(true)
     } else {
         descField.clearHelpText()
         descField.setRequired(false)
     }
     ```
     
     Note: After pasting the code, you might encounter a static type error message. This is a common occurrence when working with Groovy scripts in this context. If you want to get rid of this error you can update line 4 to the following: 
     
     ```
     def priority = (formField.getValue() as com.atlassian.jira.issue.priority.Priority)?.name
     ```
     
     This tells the compiler explicitly what type to expect, which should resolve the static type checking error.
     
13.  Select Save Changes.

You can now test to see if this behaviour works.

## Related content

-   [Behaviours](https://docs.adaptavist.com/sr4js/latest/features/behaviours)
-   [Behaviours Tutorial](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-tutorial)
-   [Field(s) Required Validator](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/fields-required-validator)
