# Tempo

- Platform: data-center
- Space: SR4JS
- Hierarchy: integrations > other-apps
- Doc ID: doc-sr4js-284099328
- Source: https://docs.adaptavist.com/sr4js/latest/integrations/other-apps/tempo

This page gives guidance on using ScriptRunner with _[Tempo Timesheets for Jira](https://marketplace.atlassian.com/plugins/is.origo.jira.tempo-plugin)_ to fulfil basic scripting needs, such as:

-   Sum worklogs with a specific attribute, for example to display on the issue the amount of _Overtime_
    
-   Aggregate worklogs
    
-   Auto-create worklogs
    

The core of this approach lies in the two annotations discussed in [Scripting Other Plugins](https://docs.adaptavist.com/sr4js/latest/integrations/other-apps), namely _@WithPlugin_ and _@PluginModule_.

These examples use Tempo Timesheets for Jira version 10. For information that works in previous versions, see previous versions of this page.

## Examples

### Summing worklogs with an attribute

Tempo allows you to categorize worklogs with [additional attributes](https://tempoplugin.jira.com/wiki/display/TEMPO/Configuring+Worklog+Attributes). For example, we have a checkbox attribute called _Overtime_, and we’d like to display the total overtime on each issue.

1.  We configure the _Overtime_ attribute as follows:  
    ![](/sr4js/files/latest/284099328/441364122/1/1732191655000/Screenshot+2024-11-21+at+11.39.33.png)
2.  Set up a custom [scripted field](https://docs.adaptavist.com/sr4js/latest/features/script-fields). In this example, we call it _Total Overtime_. For this example we use the following script:  
    
    Make sure to use the _Duration (time-tracking)_ template
    
    ```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.worklog.Worklog
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import com.tempoplugin.core.workattribute.api.WorkAttributeService
import com.tempoplugin.core.workattribute.api.WorkAttributeValueService

@WithPlugin("is.origo.jira.tempo-plugin")

@PluginModule
WorkAttributeService workAttributeService

@PluginModule
WorkAttributeValueService workAttributeValueService

def worklogManager = ComponentAccessor.getWorklogManager()

def worklogs = worklogManager.getByIssue(issue)

def overtimeLogs = worklogs.findAll { worklog ->
    def attribute = workAttributeService.getWorkAttributeByKey("_Overtime_").returnedValue
    workAttributeValueService.getWorkAttributeValueByWorklogAndWorkAttribute(worklog.id, attribute.id).returnedValue
}

overtimeLogs.sum { Worklog worklog ->
    worklog.timeSpent
} as Long
// if no overtime worklogs just return null
```
    
      
    
    If you need to get the ID of your tempo attribute you can use the following script:
    
    ```
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import com.tempoplugin.core.workattribute.api.WorkAttributeService
import com.tempoplugin.core.workattribute.api.WorkAttribute

@WithPlugin("is.origo.jira.tempo-plugin")

@PluginModule
WorkAttributeService workAttributeService

def attributes = workAttributeService.workAttributes.returnedValue as Collection<WorkAttribute>

def overtimeAttribute = attributes.find { 
    it.getName() == "Overtime"
}

overtimeAttribute.key
```
    
      
    

Once configured, we should be able to search for issues where the overtime has exceeded 4 hours using: `"Total Overtime" > 4h`.

### Automatically adding a worklog

See our [Example Script](https://www.scriptrunnerhq.com/help/example-scripts/create-tempo-worklog-onPrem) for this.

### Population of the dropdown

See our [Example Script](https://www.scriptrunnerhq.com/help/example-scripts/create-tempo-dynamic-dropdown-using-rest-endpoint-onPrem) for this.
