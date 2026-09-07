# Create Asset

- Platform: data-center
- Space: SR4JS
- Hierarchy: integrations > automation-for-jira
- Doc ID: doc-sr4js-442887343
- Source: https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira/create-asset

We’ve provided an easy way to create [Insight/Asset objects](https://confluence.atlassian.com/servicemanagementserver/working-with-objects-1044784539.html) in Automation for Jira. For example, you can use the **Create Asset with ScriptRunner** action to create a new Assets object when a new issue is created.

When you use this action, make sure you specify object type and attributes in JSON format.

Once you have added the **Create Asset with ScriptRunner** action, you can reference attributes of the Assets object in another action using the `{{createdObject}}` [smart value](https://confluence.atlassian.com/automation/smart-values-syntax-and-formatting-1141480622.html?_ga=2.262377676.1339457899.1693813727-1706769183.1685013838) (see step 10 in the example below for a working example of how to use this smart value).

Using `{{createdObject}}` you can retrieve the attribute values, in addition to other important object values. For example:

```
{{createdObject.objectKey}}       
{{createdObject.id}}
{{createdObject.attributes.Name}}       
{{createdObject.objectType.name}}
```

Obtaining attributes

If you wish to discover more attributes, you can add [Log action](https://confluence.atlassian.com/automation/jira-automation-actions-993924834.html#Jiraautomationactions-logaction) to a rule that contains the **Create Asset with ScriptRunner** action—`{{createdObject}}` must be added as the value in the **Log action**. Once the rule has run, you can check the [audit log](https://confluence.atlassian.com/automation/use-the-audit-log-1093013297.html) and it will display available attributes for you to use.

Retrieving object attributes using smart values is helpful in many contexts. For example, you can add a comment that links to the created object, as shown in the example below. 

## Example: Create Assets objects on issue creation and add a comment

In the following example, we want an Assets object to be created when a new issue is created. In addition, we want a comment to be added to the issue that links to the created object.

The following example uses attributes and objects from the _Sample IT Asset Schema_ template. If you are using your own schema, make sure you replace any mentioned names with those that match your own objects and attributes.

1.  In Automation for Jira, select **Create rule**.  
    ![](/sr4js/files/latest/442887343/442887348/1/1758746796000/A4J_create_rule.png)  
    
2.  Select **Issue created** as the trigger.   
    ![](/sr4js/files/latest/442887343/442887349/1/1758746796000/A4J_select_trigger.png) 
3.  Select **Save**.
4.  Select **New action**.   
    ![](/sr4js/files/latest/442887343/442887350/1/1758746797000/A4J_new_action.png) 
5.  Scroll to **Miscellaneous** and select **Create Asset with ScriptRunner**.  
    ![](/sr4js/files/latest/442887343/442887355/1/1758746797000/Create_asset_with_SR.png)  
    
6.  Enter the object type and any attribute values, in JSON format, into the **Attributes** text box. In addition, if you use values from the current issue, make sure you use the [JSON-escaping functions](https://confluence.atlassian.com/automation/jira-smart-values-json-functions-993924865.html) for smart values.  
    
    Examples are provided for you below the **Attributes** text box. 
    
    ![](/sr4js/files/latest/442887343/442887361/1/1758746797000/Create_Asset_w_SR.png)  
    
7.  Select **Save**.
8.  Select **New action**. 
9.  Under **Issue actions**, select **Comment on issue**.  
    ![](/sr4js/files/latest/442887343/442887344/1/1758746796000/A4J_comment_on_issue.png)  
    
10.  Enter a comment for this issue and use the `{{createdObject}}` smart value to reference an attribute of the created object. In this example, we want to create a comment that links to the created object, so we enter the following:
     
     ```
A new object has been created ({{createdObject.objectKey}}):
* {{baseUrl}}/secure/ObjectSchema.jspa?typeId={{createdObject.objectTypeId}}&objectId={{createdObject.id}}
```
     
11.  Select **Save**.
12.  Name the automation and select **Turn it on**. In this example we name the automation `Create Object Rule`.  
     ![](/sr4js/files/latest/442887343/442887346/1/1758746796000/Create_object_3.png)  
     An Assets object will now be created every time a new issue is created.
     

* * *

## Related content

-   [Update Asset](https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira/update-asset)
-   [Lookup Asset (Insight) Object](https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira/lookup-asset-insight-object)
-   [Lookup Asset (Insight) Objects from AQL/IQL](https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira/lookup-asset-insight-objects-from-aql-iql)
