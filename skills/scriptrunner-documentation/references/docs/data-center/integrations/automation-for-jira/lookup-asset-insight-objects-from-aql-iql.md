# Lookup Asset (Insight) Objects from AQL (IQL)

- Platform: data-center
- Space: SR4JS
- Hierarchy: Integrations > Automation for Jira
- Doc ID: doc-sr4js-82320e9c-4f20-46ff-9954-346fbd5063b6-535ee93110e4be97
- Source: https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira#lookup-asset-insight-objects-from-aql-iql--en

We've provided an easy way to look up/retrieve [Insight/Asset objects](https://confluence.atlassian.com/servicemanagementserver/working-with-objects-1044784539.html) from [AQL/IQL](https://confluence.atlassian.com/servicemanagementserver/advanced-searching-aql-assets-query-language-1044784588.html) in Automation for Jira. You can use this action to retrieve any Assets object and/or attributes from any object schema. Once you have added the Lookup Asset (Insight) object from AQL (IQL) with ScriptRunner action, you can then reference components of the Assets object in another action using the `{{lookupAssets}}` [smart value](https://confluence.atlassian.com/automation/smart-values-syntax-and-formatting-1141480622.html).

For example, if you want to make all Host objects' attributes available to use in later actions, you could use the following AQL query in the Lookup Asset (Insight) object from AQL (IQL) with ScriptRunner action:

```
objectType = Host
```

Tip: Obtaining attributes

If you wish to discover more attributes, you can add [Log action](https://confluence.atlassian.com/automation/jira-automation-actions-993924834.html#Jiraautomationactions-logaction) to a rule that contains the Lookup Asset (Insight) object from AQL (IQL) with ScriptRunner action— `{{lookupAssets}}` must be added as the value in the Log action. Once the rule has run, you can check the [audit log](https://confluence.atlassian.com/automation/use-the-audit-log-1093013297.html) and it will display available attributes for you to use.

In subsequent actions, you can then access the Host objects' attributes using `{{lookupAssets}}`. Please take a look below for detailed examples.

## Example: Set the description of an issue to a list of object keys

In the following example, we want to retrieve all Host objects so we can list the object keys and names in the description of new issues.

1.  In Automation for Jira, select Create rule.
    
2.  Select Issue created as the trigger.
    
3.  Select Save.
4.  Select New action.
    
5.  Scroll to Miscellaneous and select Lookup Asset (Insight) object from AQL (IQL) with ScriptRunner.
    
6.  Enter an AQL (IQL) expression to get all _Host_ objects. In this example we enter objectType = Host.
    
7.  Select Save.
8.  Select New action.
9.  Select Edit issue.
10.  When prompted to choose fields to set, select Description.
     
11.  Enter a description and use the `{{lookupAssets}}` smart value to reference the Host objects. In this example we want to list the object keys and names of all Host objects, so we enter the following:
     
     ```
     {{#lookupAssets}}
         * {{objectKey}}: {{attributes.Name}}
     {{/}}
     ```
     
12.  Select Save.
13.  Name the automation and select Turn it on. In this example we name the automation List Host Objects.
     
14.  You can now test this rule by creating an issue.
     

If you wish, you can improve your rule further by adding conditions.

## Example: Working with multi-select Assets custom fields

If a user selects objects in an Assets multi-select custom field, it would be useful if attributes of the objects selected could be posted elsewhere on an issue. With this action you can list multiple Assets object attributes.

In the following example, we want the name and serial number number of each computer selected in the `Computers` Assets custom field to be posted as a comment on the issue.

Note: If you wish to use this example, you must make sure [an Assets multi-select custom field is configured](https://confluence.atlassian.com/servicemanagementserver/default-assets-custom-field-1044784428.html?_ga=2.94255005.1036060555.1690963799-1706769183.1685013838) with the name `Computers`, or equivalent.

1.  In Automation for Jira, select Create rule.
    
2.  Select Issue created as the trigger.
    
3.  Select Save.
4.  Select New action.
    
5.  Scroll to Miscellaneous and select Lookup Asset (Insight) object from AQL (IQL) with ScriptRunner.
    
6.  Enter an AQL (IQL) expression to get all Jira fields using AQL. In this example we enter object HAVING connectedTickets(key = {{issue.key}}).
7.  Select Save.
8.  Select New action.
9.  Under Issue actions, select Comment on issue.
    
10.  Enter the following comment:
     
     Note: In this example the `{{lookupAssets}}` smart value is used to reference the selected values from the `Computers` Assets custom field
     
     ```
     The following computer/s have been reported to have an issue:
     {{#lookupAssets}}
         * {{attributes.Name}}: Serial number {{attributes.Serial Number}}
     {{/}}
     ```
     
11.  Select Save.
12.  Name the automation and select Turn it on. In this example we name the automation Computers Name and Serial Number.
13.  You can now test this rule by creating an issue and selecting options in the Computers Assets custom field.
     

If you wish, you can improve your rule further by adding conditions. For example, you may want to add a condition to the rule so it does not execute if the `Computers` Assets custom field has no value.

## Related content

-   [Automation for Jira](../automation-for-jira.md)
-   [Execute a ScriptRunner Script](https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira/execute-a-scriptrunner-script)
-   [Lookup Assets (Insight) Object](https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira/lookup-asset-insight-object)
