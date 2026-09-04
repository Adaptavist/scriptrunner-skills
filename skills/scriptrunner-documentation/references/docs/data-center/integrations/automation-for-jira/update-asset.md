# Update Asset

- Platform: data-center
- Space: SR4JS
- Hierarchy: integrations > automation-for-jira
- Doc ID: doc-sr4js-442887366
- Source: https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira/update-asset

We’ve provided an easy way to update [Insight/Asset objects](https://confluence.atlassian.com/servicemanagementserver/working-with-objects-1044784539.html) in Automation for Jira. For example, you can use the **Update Asset with ScriptRunner** action to update the attributes of an Assets object when an issue is updated.

When you use this action, make sure you specify object type and attributes in JSON format. You can provide either the `objectKey` as a string, OR the `objectId` as an integer.

## Example: Update an issue's Assets object when you update an issue

In the following example, we want an object linked to an issue to be updated when the issue is updated, specifically, we want the object's name to update if the issue summary is updated. In the following example, our objects are linked to our issues through an Assets (Insight) object custom field called `Computer`.

1.  In Automation for Jira, select **Create rule**.  
    ![](/sr4js/files/latest/442887366/442887387/1/1758746799000/A4J_create_rule.png)  
    
2.  Select **Issue updated** as the trigger.   
    ![](/sr4js/files/latest/442887366/442887391/1/1758746799000/Issue_update.png) 
3.  Select **Save**.
4.  Select **New action**.   
    ![](/sr4js/files/latest/442887366/442887381/1/1758746798000/A4J_new_action.png) 
5.  Scroll to **Miscellaneous** and select **Update Asset with ScriptRunner**.  
    ![](/sr4js/files/latest/442887366/442887392/1/1758746799000/Update_asset_with_SR.png)  
    
6.  Enter the object key and any attributes, in JSON format, into the **Attributes** text box. In addition, if you use values from the current issue, make sure you use the [JSON-escaping functions](https://confluence.atlassian.com/automation/jira-smart-values-json-functions-993924865.html) for smart values. You must specify the Assets custom field value within the JSON string. In the example below, our Assets custom field is `Computer`.  
    
    Examples are provided for you below the **Attributes** text box. 
    
    ![](/sr4js/files/latest/442887366/442887394/1/1758746799000/Update_asset_w_SR.png)  
    
7.  Select **Save**.
8.  Name the automation and select **Turn it on**. In this example we name the automation `Update Object Rule`.  
    ![](/sr4js/files/latest/442887366/442887388/1/1758746799000/Update_object_3.png)  
    When the summary of an issue is updated, and the issue has a linked `Computer` Assets object custom field, the `Name` of the linked object is also updated.
    

  

* * *

## Related content

-   [Create Asset](https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira/create-asset)
-   [Lookup Asset (Insight) Object](https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira/lookup-asset-insight-object)
-   [Lookup Asset (Insight) Objects from AQL/IQL](https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira/lookup-asset-insight-objects-from-aql-iql)
