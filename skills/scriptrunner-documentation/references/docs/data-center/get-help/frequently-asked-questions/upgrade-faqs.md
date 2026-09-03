# Upgrade FAQs

- Platform: data-center
- Space: SR4JS
- Hierarchy: get-help > frequently-asked-questions
- Doc ID: doc-sr4js-442888314
- Source: https://docs.adaptavist.com/sr4js/latest/get-help/frequently-asked-questions/upgrade-faqs

### How do I downgrade ScriptRunner?

We recommend that you **DO** **NOT** downgrade ScriptRunner. If you think it is essential to downgrade, please contact [Adaptavist Support](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/21) for help.

### The Manage apps screen became unresponsive during an update. Did something go wrong?

No. When you update ScriptRunner, enabling the app can take several minutes while it recompiles scripts and re-registers workflow functions, listeners, and REST endpoints. During this time, the Manage apps screen may appear unresponsive or return errors. This is expected. Allow it to complete rather than reloading the page or stopping the process.

### Should I restart Jira after updating ScriptRunner?

Yes. Once the update is complete, restart Jira to ensure ScriptRunner is fully enabled. On Data Center, restart nodes one at a time, letting each rejoin the cluster before restarting the next.

### Why do I have a DocValuesField error when re-indexing?

#### Problem

If you have recently upgraded Jira to version 8.10 or above, and have ScriptRunner installed, you may see an error like the following when you re-index:

```
DocValuesField "sr_num_atch" appears more than once in this document (only one value is allowed per field)
```

This error does not show for everyone who upgrades. The problem only shows for users who have ended up with multiple issueFunction fields as a result of past bugs. This is a field added by ScriptRunner for JQL functions and if there are duplicates, they **do not** **show** on the custom fields admin area.

#### Diagnosis

Run the following script in the script console to see if there are multiple versions of this indexer field added:

```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.search.managers.IssueSearcherManager
import com.onresolve.jira.groovy.jql.ScriptFunctionSearcher
 
def searcherManger = ComponentAccessor.getComponent(IssueSearcherManager)
def issueFunctionSearcherCount = searcherManger.allSearchers.count { it instanceof ScriptFunctionSearcher }
 
"Searcher count: ${issueFunctionSearcherCount}"
```

If the script returns a "Searcher" count higher than 1, then you have multiple issueFunction fields added to your server. The `issueFunction` field should only be added once (`issueFunction` is a field added by ScriptRunner to allow JQL functions to work). This has not caused any problems up until Jira 8.9, but a change in the implementation of how field indexers are tracked in Jira 8.10 means that Jira now registers indexers for each `issueFunction` field. This is what causes the indexing problem with the `sr_num_atch` index field.

#### Solution

Please take a backup of your Jira Server before you run the next script. The script deletes the additional i`ssueFunction` fields found on your Jira instance. 

To fix this issue, run the following script in the script console:

```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.search.managers.IssueSearcherManager
import com.onresolve.jira.groovy.jql.ScriptFunctionSearcher
 
def customFieldManager = ComponentAccessor.customFieldManager
def issueFunctionFields = customFieldManager.getCustomFieldObjectsByName("issueFunction")
def fieldsToBeDeleted = issueFunctionFields.size() - 1
 
log.error("Fields to be deleted: ${fieldsToBeDeleted}")
 
if (fieldsToBeDeleted) {
    issueFunctionFields.takeRight(fieldsToBeDeleted).each { field ->
        customFieldManager.removeCustomField(field)
        log.error("Successfully removed custom field: ${field.id}")
    }
 
    log.error("Successfully removed ${fieldsToBeDeleted} custom field(s)")
}
```

After you run this script, and switch to the **Log** tab of the script console, you should see the following on the last line:

```
Successfully removed n custom field(s)
```

If the above displays then you should perform a full re-index at a time convenient for you. Please let us know afterwards if the issue was fixed and you were able to successfully reindex.

### What happens to ScriptRunner scripts and features when you upgrade your Jira instance?

Upgrading your Jira instance will not affect your ScriptRunner scripts and features at all. However, Jira API deprecations could impact scripts. We therefore recommend you test upgrades in a UAT/Sandbox environment if possible. We recommend you check the [Compatibility with Jira](https://docs.adaptavist.com/sr4js/latest/get-started/update-scriptrunner/compatibility-with-jira) page for more information.

HAPI will always be maintained to so it will not be affected by deprecated Jira API methods.

  

* * *

## Related content

-   Upgrade FAQs
-   [Compatibility with Jira](https://docs.adaptavist.com/sr4js/latest/get-started/update-scriptrunner/compatibility-with-jira)
-   [Navigation](https://docs.adaptavist.com/sr4js/latest/get-started/navigation)
