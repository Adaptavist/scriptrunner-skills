# Update Asset

- Platform: data-center
- Space: SR4JS
- Hierarchy: Integrations > Automation for Jira
- Doc ID: doc-sr4js-ee78317b-55c4-42a8-8436-aab128c5a284-aa1b9de1700e8db4
- Source: https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira#update-asset--en

We've provided an easy way to update [Insight/Asset objects](https://confluence.atlassian.com/servicemanagementserver/working-with-objects-1044784539.html) in Automation for Jira. For example, you can use the Update Asset with ScriptRunner action to update the attributes of an Assets object when an issue is updated.

When you use this action, make sure you specify object type and attributes in JSON format. You can provide either the `objectKey` as a string, OR the `objectId` as an integer.

## Example: Update an issue’s Assets object when you update an issue

In the following example, we want an object linked to an issue to be updated when the issue is updated, specifically, we want the object’s name to update if the issue summary is updated. In the following example, our objects are linked to our issues through an Assets (Insight) object custom field called `Computer`.

1.  In Automation for Jira, select Create rule.
    
2.  Select Issue updated as the trigger.
    
3.  Select Save.
4.  Select New action.
    
5.  Scroll to Miscellaneous and select Update Asset with ScriptRunner.
    
6.  Enter the object key and any attributes, in JSON format, into the Attributes text box.
    
    In addition, if you use values from the current issue, make sure you use the [JSON-escaping functions](https://confluence.atlassian.com/automation/jira-smart-values-json-functions-993924865.html) for smart values. You must specify the Assets custom field value within the JSON string. In the example below, our Assets custom field is Computer.
    
    Note: Examples are provided for you below the Attributes text box.
    
7.  Select Save.
8.  Name the automation and select Turn it on.
    
    In this example we name the automation Update Object Rule.
    
    When the summary of an issue is updated, and the issue has a linked `Computer` Assets object custom field, the `Name` of the linked object is also updated.
    

## Related content

-   [Create Asset](https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira/create-asset)
-   [Lookup Asset (Insight) Object](https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira/lookup-asset-insight-object)
-   [Lookup Asset (Insight) Objects from AQL/IQL](https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira/lookup-asset-insight-objects-from-aql-iql)
