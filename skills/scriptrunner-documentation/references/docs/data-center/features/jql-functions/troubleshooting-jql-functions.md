# Troubleshooting JQL Functions

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > jql-functions
- Doc ID: doc-sr4js-442886775
- Source: https://docs.adaptavist.com/sr4js/latest/features/jql-functions/troubleshooting-jql-functions

This page covers some issues users may face when using ScriptRunner JQL functions:

-   [JQL function isn't returning any results / JQL function isn't appearing](#id-.FunctionNameClashesv9.x-name-clashes)
-   [IssueFunction is not available due to indexing problems](#id-.FunctionNameClashesv9.x-issuefunction-not-available)

ScriptRunner JQL AI

If you're not sure where to start with JQL Functions or are in need of a quick search filter, try our [ScriptRunner JQL AI](https://docs.adaptavist.com/sr4js/latest/features/jql-functions#sr-jql-ai). 

### **JQL function isn't returning any results /** **JQL function isn't appearing**

If you use multiple plugins to alter JQL functionality, you may encounter a case where function names are the same in each plugin. There are several plugins such as [Power Script](https://appfire.atlassian.net/wiki/spaces/JJUPIN/pages/13240276/Pre-defined+JQL+functions#Pre-definedJQLfunctions-subtasksOf) and [JQL Tricks](https://www.j-tricks.com/jql-tricks-plugin---dc.html) which use the same function names such as `hasAttachments()` and `subtasksOf()`. As the keys for these plugins appear first alphabetically, their functions take precedence over ScriptRunner functions, as designed by [Atlassian](https://jira.atlassian.com/browse/JRA-24219?_ga=2.230036312.533086223.1683619450-915233301.1672736716). 

In cases where function names clash, you need to disable a function because the two plugins essentially cancel each other out. For example, if two plugins use the function `subtasksOf()` you need to disable one to be able to use the other.

#### Verify the problem

Go to **ScriptRunner > JQL Functions** and verify if the function is present. If not, it is likely that there is another plugin installed and enabled on your instance which uses the same function name. 

#### Workaround

If you want to use both plugins you need to disable the clashing JQL function module for one of the plugins. To disable a module proceed as follows:

1.  Go to **Administration > Manage apps**. 
2.  Select **Manage apps**.  
    ![Image showing where manage apps is](/sr4js/files/latest/442886775/442886791/1/1758746739000/Function_clash_1.png)
3.  Expand the plugin with the module you want to disable.
4.  Select **xx of xx modules enabled**.  
    All modules display below the license information. 
5.  Find the module you want to disable.
    
    The following is an example of a ScriptRunner JQL module.
    
    You may want to use the search function (**command + F** or **Ctrl + F**) to find the module. 
    
    ![Example of JQL module](/sr4js/files/latest/442886775/442886776/1/1758746739000/JQL_disable_example.jpg)
    
6.  Select **Disable**. 
7.  Go to **ScriptRunner > JQL Functions** and verify if the function is now present where it was previously missing.

### `IssueFunction` is not available due to indexing problems

Most ScriptRunner JQL functions work by using a custom field called `[issueFunction](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial#issue-function)`. This field is managed (locked), so it can't be on any screen and has a global context.

The [Lucene indexers](https://confluence.atlassian.com/jirakb/how-indexing-works-in-jira-1167744587.html) associated with `issueFunction` maintain the index data that allows the ScriptRunner JQL functions to work.

In extremely rare circumstances, Jira decides that the `issueFunction` field is not in scope for particular issues despite its global scope. This can result in problems with the affected issues either incorrectly appearing in the results of queries (such as `linkedIssuesOf`), or being missed from those results.

It appears that the issue in recognising `issueFunction` as a global custom field is due to a referential integrity problem in Jira's database, which could be caused by another plugin, or perhaps direct database edits.

#### Verify the problem

You can verify if Jira considers `issueFunction` out of scope by running the following script in the _Script Console_. Update `ABC-1` in the script below to reference an existing issue you suspect is not being reindexed. If this script returns `true`, then reindexing is not the problem. If it returns `false`, follow the instructions in the workaround below. 

```
import com.atlassian.jira.component.ComponentAccessor

def customFieldManager = ComponentAccessor.customFieldManager
def issueManager = ComponentAccessor.issueManager

def fields = customFieldManager.getCustomFieldObjectsByName('issueFunction')
assert fields.size() == 1
def issueFunction = fields.first()

def issue = issueManager.getIssueObject('ABC-1') // CHANGE THIS ISSUE KEY

issueFunction.isInScope(issue.projectId, issue.issueTypeId)
```

##### Variation 

There is a variation of this problem where the custom field becomes hidden in a particular configuration scheme. To detect this issue, run the script below. If this script has any result, other than `No problems`, [contact support](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/21).

```
import com.atlassian.jira.component.ComponentAccessor

def field = ComponentAccessor.customFieldManager.getCustomFieldObjects().find { it.name == 'issueFunction' }
assert field

ComponentAccessor.fieldLayoutManager.getEditableFieldLayouts().findAll {
    it.getFieldLayoutItem(field.id).isHidden()
}*.name ?: 'No problems'
```

#### Workaround

The workaround is to delete the `issueFunction` field using a script, disable then enable the ScriptRunner plugin, and then re-index Jira. When the plugin starts it will recreate this field. 

Deleting and recreating the field will not cause any problems. However, you should do a full re-index after this process, so that we can index any issues that have been missed during the time this wasn't working correctly. At any stage feel free to [contact support](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/21).

1.  Enter the following script into the _Script Console_ to delete the `issueFunction` field.
    
    ```
import com.atlassian.jira.component.ComponentAccessor

def customFieldManager = ComponentAccessor.customFieldManager
def fields = customFieldManager.getCustomFieldObjectsByName('issueFunction')

assert fields.size() == 1

def field = fields.first()

customFieldManager.removeCustomField(field)
```
    
2.  Go to **Administration > Manage apps**. 
3.  Select **Manage apps**.  
    ![Image showing where manage apps is](/sr4js/files/latest/442886775/442886791/1/1758746739000/Function_clash_1.png)
4.  Expand **Adaptavist ScriptRunner for JIRA**.
5.  Select **Disable**.  
    ![Image showing how to disable ScriptRunner](/sr4js/files/latest/442886775/442886778/1/1758746739000/Disable_ScriptRunner.png)
6.  Once disabled, select **Enable**. (You could also restart Jira instead).
7.  Re-run the [verification script](#id-.FunctionNameClashesv9.x-verify). This should now return `true` where previously it returned `false`.  
    JQL functions should now work for issues created or edited after this point.
8.  Run a [full re-index of Jira](https://confluence.atlassian.com/adminjiraserver/search-indexing-938847710.html) (foreground or background) at a time convenient to you to ensure all issues are correctly indexed.  
    
    If you know which projects are affected, you can [re-index specific projects](https://confluence.atlassian.com/adminjiraserver/search-indexing-938847710.html#Searchindexing-reindexsingleRe-indexingasingleproject) rather than the entire Jira instance.
