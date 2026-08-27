# Field Required

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > behaviours > behaviours-examples
- Doc ID: doc-sr4js-273486419
- Source: https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples/field-required

While Jira allows you to make [fields required](https://confluence.atlassian.com/adminjiraserver/specifying-field-behavior-938847255.html#Specifyingfieldbehavior-requirefield), ScriptRunner offers more advanced options that allow you to make fields mandatory under specific conditions. This page describes the different capabilities that ScriptRunner provides, and how to configure them.

Making a field required based on a condition

It's easy to make a field required based on a condition using Behaviours. This condition can be selected using the **Add new condition** option for the field, or the condition can be customized by adding a server-side script. In the example below we have a custom field called _Budget Approval Notes_ that we want to make sure it's mandatory for members of the _Finance team_ when creating or editing issues.

If you want to follow this example step-by-step, make sure you have a custom field called _Budget Approval Notes_ and a group called _Finance Team_ associated with a project. You can also use custom fields and groups of your choice when following this example. 

1.  From ScriptRunner, navigate to **Behaviours**. 
2.  Select **Create Behaviour**.
3.  Enter a name for the behaviour. In this example we enter `Make Budget Approval Notes Required for Finance Team`.
4.  Enter a description for the behaviour. This field is optional.
5.  Select **Create Mapping**.
6.  Then select the project and issue type(s) to map this behaviour to.
7.  Select **Add Mapping** to confirm the mapping.
8.  Select **Create** to create the behaviour.   
    ![](/sr4js/files/latest/273486419/279412742/1/1723807348000/Budget_example_1.png)  
    You're taken to a screen where you can configure the behaviour further.
    
9.  Optional: Enter a guide workflow.
    
10.  Scroll to the **Add Field** section and add the **Budget Approval Notes** field.  
     ![](/sr4js/files/latest/273486419/279412746/1/1723807349000/Budeget_example_2.png)
     
11.  Edit the **Optional/Required** field so it displays **Required**. This makes the field mandatory. 
12.  Select **Add new condition** to add a condition to the **Budget Approval Notes** field. This condition will run every time the create/edit form loads and when the value of this field changes.  
     ![](/sr4js/files/latest/273486419/279412745/1/1723807349000/Budget_example_3.png)
13.  Configure the condition as follows:
     1.  Select **When** for _Applicability_. 
     2.  Select **Current u****ser in group** for _Condition_. 
     3.  Select **Finance team** for _Project role_.
     4.  Select **Add**.  
         ![](/sr4js/files/latest/273486419/279412744/1/1723807349000/Budget_example_4.png)  
         
14.  Select **Save Changes**. 
     
     You can test to see if this behaviour works by using the [switch user](https://docs.adaptavist.com/sr4js/latest/get-started/settings/switch-user-function#switchuser) function. The _Budget Approval Notes_ field should display as required when the logged in user is a member of the _Finance Team_. 
     
     ![](/sr4js/files/latest/273486419/279412743/1/1723807348000/Budget_example_5.png)
     

## Making a field required based on a transition

To make a field required on transition we recommend you use the [Field(s) Required](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/field-s-required-validator) validator. When you use this validator, issues in your chosen project will throw an error if you try to transition them without completing the required field(s). 

Due to how validators work, the field will not show as required (display an asterisk) until you try to transition the issue without completing the required field(s). 

## Making a field required using Behaviours API

If you want to have a more complex behaviour to make fields required you construct your own script using `[formField.setRequired(boolean)](https://docs.adaptavist.com/sr4js/latest/features/behaviours/api-quick-reference#formfieldsetrequiredboolean)`.

  

* * *

## Related content

-   [Behaviours Tutorial](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-tutorial)
-   [Setting Field Defaults](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples/setting-field-defaults)
-   [Behaviours](https://docs.adaptavist.com/sr4js/latest/features/behaviours)
