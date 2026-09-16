# Asset Object Created Trigger

- Platform: data-center
- Space: SR4JS
- Hierarchy: Integrations > Automation for Jira
- Doc ID: doc-sr4js-20e79188-d195-4b96-a761-3b85a64d7a7b-501f889b076cb773
- Source: https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira#asset-object-created-trigger--en

You can use the Asset Object created with ScriptRunner trigger to create a rule that runs whenever an Assets object is created. You can also use the associated `{{createdObject}}` [smart value](https://confluence.atlassian.com/automation/smart-values-syntax-and-formatting-1141480622.html) to apply conditions to the rule and input the created object's information elsewhere, for example, into an email or a comment (see step 15 in the example below for a working example of how to use this smart value).

There are many things you can do with this trigger. For example, you could use the Create Issue action to create a Task every time a new object is created.

If you want to trigger this rule conditionally, use the [Advanced compare condition](https://confluence.atlassian.com/automation/jira-automation-conditions-993924794.html#Jiraautomationconditions-advancedcompareconditionAdvancedcomparecondition) with the `{{createdObject}}` smart value, and be careful not to add trailing spaces. Using `{{createdObject}}` you can retrieve the attribute values, in addition to other important object values. For example:

```
{{createdObject.objectKey}}
{{createdObject.id}}
{{createdObject.attributes.Name}}
{{createdObject.objectType.name}}
```

Tip: Obtaining attributes

If you wish to discover more attributes, you can add [Log action](https://confluence.atlassian.com/automation/jira-automation-actions-993924834.html#Jiraautomationactions-logaction) to a rule that contains the Asset Object created with ScriptRunner trigger— `{{createdObject}}` must be added as the value in the Log action. Once the rule has run, you can check the [audit log](https://confluence.atlassian.com/automation/use-the-audit-log-1093013297.html) and it will display available attributes for you to use.

Retrieving object attributes using smart values is helpful in many contexts. For example, if you want to create a _Task_ with the same name as the created object, you can use `{{createdObject.attributes.Name}}`.

## Scope

The Asset Object created with ScriptRunner trigger is a Global trigger, which means a rule with this trigger is applied to all projects and can only be managed by Jira Administrators.

## Example: Create a Task when a new License object is created

In the following example, we want a new Task to be created when a new License object is created. In this example, the purpose of the Task is to assign the new License to a user.

Tip: The following example uses attributes and objects from the Sample IT Asset Schema template. If you are using your own schema, make sure you replace any mentioned names with those that match your own objects and attributes.

1.  In Automation for Jira, select Create rule.
    
2.  Select Asset Object created with ScriptRunner as the trigger.
    
3.  Select Save.
4.  Select New condition.
5.  Select Advanced compare condition.
    
6.  Enter {{createdObject.objectType.name}} for the first value.
7.  Make sure the equals condition is selected.
8.  Enter License for the second value.
9.  Select Save.
    
10.  Select New action.
11.  Select Create issue.
     
12.  Select the project you want to apply the rule to. In this example we choose our `Jira Testing Project (JRA)`.
13.  Select the Task issue type.
14.  Enter New License Created: {{createdObject.attributes.Name}} in the Summary field.
15.  Enter the following into the Description field:
     
     The following description uses smart values to display the object key, the license key, and a link to the new object.
     
     ```
     A new License object has been created ({{createdObject.objectKey}}):
     * License key: {{createdObject.attributes.License Key}}
     * Link: {{baseUrl}}/secure/ObjectSchema.jspa?typeId={{createdObject.objectTypeId}}&objectId={{createdObject.id}}
      
     This key must be assigned to a user.
     ```
     
16.  Select Save.
     
     You could add more options to this action to improve the created issue. For example, you could add the user who typically manages your licenses as an Assignee.
     
17.  Name the automation and select Turn it on. In this example we name the automation New License Rule.
     
     A new Task will now be created every time a new License object is created.
     

## Related content

-   [Asset Object Updated Trigger](https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira/asset-object-updated-trigger)
-   [Lookup Asset (Insight) Object](https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira/lookup-asset-insight-object)
-   [Lookup Asset (Insight) Objects from AQL/IQL](https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira/lookup-asset-insight-objects-from-aql-iql)
