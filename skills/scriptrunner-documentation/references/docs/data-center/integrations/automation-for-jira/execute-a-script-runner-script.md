# Execute a ScriptRunner Script

- Platform: data-center
- Space: SR4JS
- Hierarchy: integrations > automation-for-jira
- Doc ID: doc-sr4js-442888095
- Source: https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira/execute-a-scriptrunner-script

The **Execute a ScriptRunner script** action for [Automation for Jira](https://marketplace.atlassian.com/plugins/com.codebarrel.addons.automation/server/overview) lets you run your own code.

Due to incompatibly changing APIs in Automation for Jira, we provide two **Execute a ScriptRunner script** actions. One is deprecated, although there are no plans to remove it, and you do not need to migrate to the newer version unless you need access to something only available in the more recent version. Both actions provide a way to run a custom script, but you can call other ScriptRunner functions programmatically.

Permissions

We are aware of two Atlassian bugs related to permissions:

-   Non-admins, who shouldn't have permission to do so, can go into a rule and edit/save a script. However, the updated script is saved in their local browser session and they will not be able to publish the edited rule. Reloading the page demonstrates that even if the non-admin can save, when the page is reloaded the old code displays, showing the code is not persisted and would never run. 
-   Non-admins can publish changes to a disabled rule, however, an admin would need to enable the rule for those changes to be live. This is reported through bugcrowd. 

We have requested more details from Atlassian about these bugs.

![](/sr4js/files/latest/442888095/442888105/1/1758746904000/Execute_scriptrunner_script.png)

### Binding variables

The following binding variables are availabe:

 

Binding variable

Description

`issue`

The issue object that triggered the event

`currentUser`

The ApplicationUser defined as the actor for the rule

`initiator`

The ApplicationUser that initiated the event

`inputs`

The ComponentInputs. This could be used for example to retrieve the sprint if the trigger is Sprint Created Event.

`ruleContext`

The current RuleContext. This can be used to evaluate smart values.

Additionally, two utility functions are available for writing information and error messages to the Automation for Jira **audit log**. They are `addMessage(String message)` and `addError(String errorMessage)`. For example:

```
addMessage("My message")
addError("My error message")
```

The above example produces the following:

![Outcome of binding variables example.](/sr4js/files/latest/442888095/442888096/1/1758746904000/automation-for-jira-messages.png "Binding variables example.")

### Smart Values

You can evaluate [smart values](https://confluence.atlassian.com/automation/smart-values-993924860.html) using `ruleContext.renderSmartValues(String)`, for example:

```
log.warn ("Initiator of the action was... " + ruleContext.renderSmartValues('{{initiator}}'))
```

### Deprecated version

#### Binding Variables

Binding variable

Description

`issue`

The issue object that triggered the event

`currentUser`

The ApplicationUser defined as the actor for the rule

`errorCollection`

An ErrorCollection - use it to record error conditions, eg `errorCollection.addErrorMessage("Something went wrong").`

`executionContext`

Use this if you need to retrieve any information about the rule that is currently firing.

  

* * *

## Related content

-   [Automation for Jira](https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira)
-   [Lookup Asset (Insight) Object](https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira/lookup-asset-insight-object)
-   [Lookup Assets (Insight) Objects from AQL/IQL](https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira/lookup-asset-insight-objects-from-aql-iql)
