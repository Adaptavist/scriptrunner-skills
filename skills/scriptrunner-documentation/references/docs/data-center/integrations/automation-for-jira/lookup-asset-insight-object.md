# Lookup Asset (Insight) Object

- Platform: data-center
- Space: SR4JS
- Hierarchy: Integrations > Automation for Jira
- Doc ID: doc-sr4js-b8e707b1-5341-4b48-967c-73fb2919957d-3670faddbfc54375
- Source: https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira#lookup-asset-insight-object--en

We've provided an easy way to look up/retrieve [Insight/Asset objects](https://confluence.atlassian.com/servicemanagementserver/working-with-objects-1044784539.html) in Automation for Jira. You can use the Lookup Asset (Insight) object with ScriptRunner action to retrieve an Assets object from any object schema. Once you have added the Lookup Asset (Insight) object with ScriptRunner action, you can then reference the attributes of the Assets object in another action using the `{{lookupAsset}}` [smart value](https://confluence.atlassian.com/automation/smart-values-syntax-and-formatting-1141480622.html).

Using `{{lookupAsset}}` you can retrieve the attribute values, in addition to other important object values. For example:

```
{{lookupAsset.objectKey}}        
{{lookupAsset.id}}
{{lookupAsset.attributes.Name}}        
{{lookupAsset.objectType.name}}
```

Tip: Obtaining attributes

If you wish to discover more attributes, you can add [Log action](https://confluence.atlassian.com/automation/jira-automation-actions-993924834.html#Jiraautomationactions-logaction) to a rule that contains the Lookup Asset (Insight) object with ScriptRunner action— `{{lookupAsset}}` must be added as the value in the Log action. Once the rule has run, you can check the [audit log](https://confluence.atlassian.com/automation/use-the-audit-log-1093013297.html) and it will display available attributes for you to use.

Retrieving object attributes using smart values is helpful in many contexts. For example, you can improve automated comments to include Assets object values to give users a more personalized experience.

## Example: Personalize comments using asset object information

In the following example, we want users to receive a personalized message, as a comment, about their computer when they create an issue.

Note: If you wish to use this example, you must make sure [an Assets custom field is configured](https://confluence.atlassian.com/servicemanagementserver/default-assets-custom-field-1044784428.html?_ga=2.94255005.1036060555.1690963799-1706769183.1685013838) with the name `Computer`, or equivalent.

1.  In Automation for Jira, select Create rule.
    
2.  Select Issue created as the trigger.
    
3.  Select Save.
4.  Select New action.
    
5.  Scroll to Miscellaneous and select Lookup Asset (Insight) object with ScriptRunner.
    
6.  Enter a smart value expression to get the Asset key. In this example, we enter `{{issue.Computer.key}}`. If you're using your own Assets custom field, replace `Computer` with the name of your Assets custom field.
    
7.  Select Save.
8.  Select New action.
9.  Under Issue actions, select Comment on issue.
    
10.  Enter a comment for this issue and use the `{{lookupAsset}}` smart value to reference a value within the `Computer` Asset object. In this example, we want to create a comment that includes the serial number and model for their computer, so we enter the following:
     
     ```
     We're sorry to hear you're having issues with your {{lookupAsset.attributes.Model}} computer (serial number {{lookupAsset.attributes.Serial Number}}).
      
     We'll get back to you as soon as possible.
     ```
     
11.  Optional: Under More options, check the Share with customer option so that the customer will receive an email with the comment.
12.  Select Save.
13.  Name the automation and select Turn it on. In this example we name the automation Computer Issue Rule.
     
14.  You can now test this rule by creating an issue and selecting the Computer Assets custom field.
     

If you wish, you can improve your rule further by adding conditions. For example, you may want to add a condition to the rule so it does not execute if the `Computer` Assets custom field has no value.

## Related content

-   [Automation for Jira](../automation-for-jira.md)
-   [Execute a ScriptRunner Script](https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira/execute-a-scriptrunner-script)
-   [Lookup Assets (Insight) Objects from AQL/IQL](https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira/lookup-asset-insight-objects-from-aql-iql)
