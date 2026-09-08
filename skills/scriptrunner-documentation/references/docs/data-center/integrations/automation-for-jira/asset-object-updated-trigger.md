# Asset Object Updated Trigger

- Platform: data-center
- Space: SR4JS
- Hierarchy: integrations > automation-for-jira
- Doc ID: doc-sr4js-442887321
- Source: https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira/asset-object-updated-trigger

You can use the **Asset Object updated with ScriptRunner** trigger to create a rule that runs whenever an Assets object is updated. You can also use the associated `{{updatedObject}}` [smart value](https://confluence.atlassian.com/automation/smart-values-syntax-and-formatting-1141480622.html) to apply conditions to the rule and input the updated object's information elsewhere, for example, into an email or a comment (see step 14 in the example below for a working example of how to use this smart value). 

There are many things you can do with this trigger. For example, you could use the **Send email** action and ensure an email is sent to a specific user every time an object is updated.

If you want to trigger this rule conditionally, use the [Advanced compare condition](https://confluence.atlassian.com/automation/jira-automation-conditions-993924794.html#Jiraautomationconditions-advancedcompareconditionAdvancedcomparecondition) with the `{{updatedObject}}` smart value, and be careful not to add trailing spaces. Using `{{updatedObject}}` you can retrieve the attribute values, in addition to other important object values. For example: 

```
{{updatedObject.objectKey}}
{{updatedObject.id}}
{{updatedObject.attributes.Name}}
{{updatedObject.objectType.name}}
```

Obtaining attributes

If you wish to discover more attributes, you can add [Log action](https://confluence.atlassian.com/automation/jira-automation-actions-993924834.html#Jiraautomationactions-logaction) to a rule that contains the **Asset Object updated with ScriptRunner** trigger—`{{updatedObject}}` must be added as the value in the **Log action**. Once the rule has run, you can check the [audit log](https://confluence.atlassian.com/automation/use-the-audit-log-1093013297.html) and it will display available attributes for you to use.

Retrieving object attributes using smart values is helpful in many contexts. For example, if you only want an email sent when the object updated is a specific object type, you can use {{updatedObject.objectType.name}}, and enter the object type you want to match.

**Scope**

The **Asset Object updated with ScriptRunner** trigger is a **Global** trigger, which means a rule with this trigger is applied to all projects and can only be managed by Jira Administrators. 

## Example: Send an email when an object is updated

In the following example, we want an email to be sent to a specific user if any License object has been updated. We want the user to be notified of the change so they can check whether it is valid and decide if they want to take action.

The following example uses attributes and objects from the _Sample IT Asset Schema_ template. If you are using your own schema, make sure you replace any mentioned names with those that match your own objects and attributes.

1.  In Automation for Jira, select **Create rule**.  
    ![](/sr4js/files/latest/442887321/442887325/1/1758746794000/A4J_create_rule.png)  
    
2.  Select **Asset Object updated with ScriptRunner** as the trigger.  
    ![](/sr4js/files/latest/442887321/442887329/1/1758746794000/Asset_object_updated_with_SR.png)  
    
3.  Select **Save**.
4.  Select **New condition**.
5.  Select **Advanced compare condition**.  
    ![](/sr4js/files/latest/442887321/442887326/1/1758746794000/Advance_compare_condition.png)
6.  Enter `{{updatedObject.objectType.name}}` for the first value.
7.  Make sure the equals condition is selected. 
8.  Enter `License` for the second value. 
9.  Select **Save**.  
    ![](/sr4js/files/latest/442887321/442887327/1/1758746794000/Advance_compare_condition_2.png)
10.  Select **New action**. 
11.  Select **Send email**. 
12.  Choose who the email will be sent to. In this example we select `jira-administrators`.
13.  Enter a Subject for the email. In this example we enter `Object {{updatedObject.objectKey}} was just updated`. 
14.  Enter the following into the **Content** field:
     
     The following description uses smart values to display the object key, the object name, and a link to the new object. 
     
     ```
The following object was just updated:
* Object Key: {{updatedObject.objectKey}}
* Object Name: {{updatedObject.attributes.Name}}
* Link: {{baseUrl}}/secure/ObjectSchema.jspa?typeId={{updatedObject.objectTypeId}}&objectId={{updatedObject.id}}

You must check the change history of the object to make sure the change is valid and decide if you need to take any action.
```
     
15.  Select **Save**.
16.  Name the automation and select **Turn it on**. In this example we name the automation `Updated License Rule`.  
     ![](/sr4js/files/latest/442887321/442887322/1/1758746794000/Asset_updated_turn_on.png)  
     An email is now sent to Jira administrators every time a License object is updated.

  

* * *

## Related content

-   [Asset Object Created Trigger](https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira/asset-object-created-trigger)
-   [Lookup Asset (Insight) Object](https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira/lookup-asset-insight-object)
-   [Lookup Asset (Insight) Objects from AQL/IQL](https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira/lookup-asset-insight-objects-from-aql-iql)
