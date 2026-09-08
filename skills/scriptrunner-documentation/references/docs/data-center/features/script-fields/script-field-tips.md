# Script Field Tips

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > script-fields
- Doc ID: doc-sr4js-442885956
- Source: https://docs.adaptavist.com/sr4js/latest/features/script-fields/script-field-tips

This page provides tips about the following:

-   [Keeping the values of a script field up to date using a Job or Listener](#id-.ScriptFieldTipsv9.x-up-to-date)
-   [Stack overflows](#id-.ScriptFieldTipsv9.x-stack)
-   [JQL searches in script fields](#id-.ScriptFieldTipsv9.x-jql)
-   [Custom templates](#id-.ScriptFieldTipsv9.x-custom)
-   [Displaying script fields in transition screens](#id-.ScriptFieldTipsv9.x-transition)

## Keeping the values of a script field up to date using a Job or Listener

The values of Script Fields are recalculated when the issue is re-indexed, which may not be ideal for time-consuming calculations or those involving external systems. To keep your Script Fields up-to-date, we recommend you use a Jira custom field and a ScriptRunner custom Job or Listener. This approach allows you to control when the field is updated.

For example, you could set up a [Custom scheduled job](https://docs.adaptavist.com/sr4js/latest/features/jobs/custom-jobs) that runs every day at 3 am:

```
// Do a long-running calculation, or a calculation that involves other services
// E.g. set a rota based on availability in a HR system, or set a deadline based on values stored elsewhere

log.warn("Beep boop, doing calculations")
def value = 5 * 3
log.warn("Calculated!")

Issues.getByKey('TEST-1').update { 
    setCustomFieldValue('Expensive to calculate field', value.toString())
}
```

Alternatively, you could set up a [Custom listener](https://docs.adaptavist.com/sr4js/latest/features/listeners/custom-listener):

You shouldn’t update the issue itself from its own listener, as that could cause a stack overflow error. This recursive update creates an infinite loop of listener calls, potentially crashing the system or causing data inconsistencies.

```
// Re-calculate fields when a particular issue is updated
 
if(event.issue.key == 'EPIC-123') {
    // Take part of the epic and use it to query an external system, for example
    def value = ... // Get value from external system
 
    // Then update the custom field with the result
    // This cannot be the issue from this listener, as that would cause a stack overflow error
    Issues.getByKey('TEST-1').update {
        setCustomFieldValue('Expensive to calculate field', value)
    }
}
```

## Stack overflows

In a calculated custom field, you cannot under any circumstances try to get the value of the same calculated custom field, otherwise the same script will execute, which will call it again, and so on, leading to a stack overflow error. So you can’t do that, or call any method which will try to evaluate all of the custom fields on the issue. If you do this, you will crash your Jira.

## JQL searches in script fields

We do not recommend running JQL searches in scripted fields. The JQL search index is not available when running a full re-index, causing delays for re-indexes, including JQL search scripted fields.

### Best practices

We recommend the following when it comes to JQL in scripted fields:

-   Consider whether you need to do a JQL search in a script field. If you do, ensure the field context is not wider than it needs to be. For example, only apply to the relevant projects and issue types. The screens are irrelevant when considering a full re-index.
-   Where possible, replace JQL with standard issue methods. For example, instead of finding issues related to the issue the field relates to using JQL, try finding them using `issue.outwardLinks` which works without JQL.

### Check index availability

Before a full re-index, you must ensure scripted fields that contain JQL searches do not get indexed. You should use `indexLifecycleManager.isIndexAvailable()` to check that the index is available. For example:

```
/*
 The JQL search index is not available when running a "Lock Jira and rebuild index" re-index.
 If you try to run JQL searches, a 30-second index delay occurs for every attempt.
 To avoid this use indexLifecycleManager.isIndexAvailable() to check the index is available.
 Note: To add the values of scripted fields that use JQL searches to the JQL index, you must run a background re-index.
*/

import com.atlassian.jira.util.index.IndexLifecycleManager
import org.apache.log4j.Level
import com.atlassian.jira.component.ComponentAccessor

log.setLevel(Level.INFO)

def indexLifecycleManager = ComponentAccessor.getComponent(IndexLifecycleManager)

// Use this if block to exit the script and return nothing when running a "Lock Jira and rebuild index" re-index
if (!indexLifecycleManager.isIndexAvailable()) {

    def fieldName = customField?.name

    log.info("The JQL index is not available for searching during a \"Lock Jira and rebuild index\" so this Script field [$fieldName]  is not indexed.")
    return
}

// Run the rest of your scripted field logic below here.
```

### Reindex all issues with script fields

After conducting a full re-index, run a background re-index to add the values of the fields that did not get re-indexed during the full lock re-index. To background reindex all issues containing script fields you can use the following script, which you could either run in the console or attach to the  `ReindexAllCompletedEvent`  using a script listener:

Tips when using this script

-   When running this as a listener, it is normal for indexing to remain at 97% for long periods of time. The Jira reindex process emits the `ReindexAllCompletedEvent` at 97% and waits for all listeners to complete before marking the reindex as complete. So if many issues are found this listener may take a long time to finish, which is why it looks like it might be stuck on 97%.
-   To show the progress of this reindex you can check the `atlassian-jira.log` using our [View Server Log Files](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/view-server-log-files) built-in script and search for `Indexing script field`.

```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.index.IssueIndexingService
import com.atlassian.jira.issue.search.SearchProvider
import com.atlassian.jira.issue.util.IssueIdsIssueIterable
import com.atlassian.jira.jql.builder.JqlQueryBuilder
import com.atlassian.jira.jql.query.IssueIdCollector
import com.atlassian.jira.task.context.LoggingContextSink
import com.atlassian.jira.task.context.PercentageContext
import com.atlassian.jira.issue.search.SearchQuery
import org.apache.log4j.Level

def customFieldManager = ComponentAccessor.getCustomFieldManager()
def searchProvider = ComponentAccessor.getComponent(SearchProvider)
def user = ComponentAccessor.jiraAuthenticationContext.getLoggedInUser()
def issueIndexingService = ComponentAccessor.getComponent(IssueIndexingService)
def issueManager = ComponentAccessor.getIssueManager()

/*
 Loop through all script fields and get their contexts
 Create a query and execute it
 Reindex all results
*/

def builder = JqlQueryBuilder.newBuilder().where().defaultOr()

def scriptFields = customFieldManager.getCustomFieldObjects().findAll {
    it.customFieldType.descriptor.completeKey == "com.onresolve.jira.groovy.groovyrunner:scripted-field"
}

if (scriptFields.find {
    it.allProjects && it.allIssueTypes
}) {
    log.warn("A full background reindex is required at least one script field has global scope")
} else {
    scriptFields.each {
        def clauseBuilder = JqlQueryBuilder.newClauseBuilder().defaultAnd()

        if (!it.allProjects) {
            clauseBuilder.project(*it.associatedProjectObjects*.id).buildClause()
        }
        if (!it.allIssueTypes) {
            clauseBuilder.issueType(*it.associatedIssueTypes*.id).buildClause()
        }

        builder.addClause(clauseBuilder.buildClause())
    }
}

def query = builder.buildQuery()

def issueIdCollector = new IssueIdCollector()

searchProvider.search(SearchQuery.create(query, user), issueIdCollector)

def total = issueIdCollector.issueIds.size()
def issuesIdsIterable = new IssueIdsIssueIterable(issueIdCollector.issueIds*.toLong(), issueManager)
def loggingContextSink = new LoggingContextSink(log, "Indexing script field issues {0}% ($total total)", Level.DEBUG)
issueIndexingService.reIndexIssues(issuesIdsIterable, new PercentageContext(total, loggingContextSink))
```

Previous Jira versions may throw a `SearchUnavailableException`. It’s possible that this only happens when indexes are corrupt. If this is the case disable ScriptRunner, do a full re-index, enable ScriptRunner, then re-index again.

#### Scripting

There is not much available in the binding for this one, just:

 

componentManager

Instance of  [com.atlassian.jira.ComponentManager](http://docs.atlassian.com/jira/latest/com/atlassian/jira/ComponentManager.html)  This is here for backward compatibility. You should really use the  [ComponentAccessor](https://docs.atlassian.com/jira/server/com/atlassian/jira/component/ComponentAccessor.html)  instead.

log

logger so you can do eg log.warn("…​")

getCustomFieldValue

closure - a utility method to let you look you get the value of a custom field on this issue, by name or by id (as Long). Eg  **getCustomFieldValue("mytextfield")**

## Custom templates

As of plugin version 2.0.4 you can write your own template. Select custom, and a textbox will drop down for you to enter the template.

Whatever you returned from the script part of the field will be available in **$value**. You could use a custom template if you want to display the field differently from the way it is stored, or the way one of the default templates displays it. As usual, experiment using the **preview** facility.

These are the items available in the velocity context:

-   groovyCustomField - an instance of the com.onresolve.scriptrunner.customfield.GroovyCustomField
    
-   issue - the current  [Issue](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/issue/Issue.html)
    
-   customField - the  [CustomField](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/issue/fields/CustomField.html)  object
    
-   field - synonym for customField (above)
    
-   fieldLayoutItem - the  [FieldLayoutItem](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/issue/fields/layout/field/FieldLayoutItem.html)
    
-   value - the value of the custom field
    
-   numberTool - a  [NumberTool](https://docs.atlassian.com/jira/server/com/atlassian/jira/util/velocity/NumberTool.html)
    
-   dateFieldFormat -  [DateFieldFormat](https://docs.atlassian.com/jira/server/com/atlassian/jira/util/DateFieldFormat.html)
    
-   ComponentAccessor - the almighty  [ComponentAccessor](https://docs.atlassian.com/jira/server/com/atlassian/jira/component/ComponentAccessor.html)
    
-   iso8601Formatter - a  [DateTimeFormatter](https://docs.atlassian.com/jira/server/com/atlassian/jira/datetime/DateTimeFormatter.html)  with the ISO 8601 style.
    
-   datePickerFormatter - a  [DateTimeFormatter](https://docs.atlassian.com/jira/server/com/atlassian/jira/datetime/DateTimeFormatter.html)  with the  [DATE\_TIME\_PICKER](https://docs.atlassian.com/jira/server/com/atlassian/jira/datetime/DateTimeStyle.html#DATE_TIME_PICKER)  style
    
-   dateFormatterWithoutTime - a  [DateTimeFormatter](https://docs.atlassian.com/jira/server/com/atlassian/jira/datetime/DateTimeFormatter.html)  with the  [RELATIVE\_WITHOUT\_TIME](https://docs.atlassian.com/jira/server/com/atlassian/jira/datetime/DateTimeStyle.html#RELATIVE_WITHOUT_TIME)  style
    
-   titleFormatter - a  [DateTimeFormatter](https://docs.atlassian.com/jira/server/com/atlassian/jira/datetime/DateTimeFormatter.html)  with the  [COMPLETE](https://docs.atlassian.com/jira/server/com/atlassian/jira/datetime/DateTimeStyle.html#COMPLETE)  style
    
-   hasAdminPermission - a boolean indicating whether the user has admin permissions
    
-   [jiraDurationUtils](https://docs.atlassian.com/jira/server/com/atlassian/jira/util/JiraDurationUtils.html)
    
-   [jiraAuthenticationContext](https://docs.atlassian.com/jira/server/com/atlassian/jira/security/JiraAuthenticationContext.html)
    
-   DateUtils - an instance of Atlassian’s  [DateUtils](https://developer.atlassian.com/static/javadoc/atlassian-core/latest/reference/com/atlassian/core/util/DateUtils.html)  class
    

## Displaying script fields in transition screens

Jira does not display calculated custom fields on transition screens.

A possibility is to override one of the other custom fields, eg GenericTextCFType, however then you need to match the base class to the type of value that the calculated field produces, for instance a text or number or user type. This massively increases complexity and reduces flexibility.

My preferred solution therefore is to use javascript to do this.

The downside is that as there is no public API for the Jira frontend, so it’s possible that presentation issues will appear from one version to the next.

To make your calculated field appear on transition screens, paste the following javascript into the description (Admin → Field Configurations) of any field that appears on the transition screen(s) you care about, eg Resolution, **NOT** the calculated field itself. You only need to modify the two values in the  _mandatory config_  section.

```
<script type="text/javascript">
(function ($) {

    // ---------------------------------- MANDATORY CONFIG ----------------------------------
    var fieldName = "Scripted Field" // display name - does not have to match the name of the field
    var fieldId = "customfield_14013" // field Id
    // ---------------------------------- END MANDATORY CONFIG ------------------------------

    function addCalculatedField(e, context) {
        var $context = $(context);

        // if you want you can limit this to certain actions by checking to see if this value is in a list of action IDs
        if (!$("input[name='action']").val()) {
            return;
        }

        // multiple handlers can be added if you do an action, then cancel repeatedly
        if ($context.find("#scriptedfield_" + fieldId).length > 0) {
            return;
        }

        var issueKey = $("meta[name='ajs-issue-key']").attr("content");
        if (!issueKey) {
            issueKey = $("#key-val").attr("rel"); // transition screens in full page mode
        }

        var paddingTop = AJS.$("meta[name='ajs-build-number']").attr("content") < 6000 ? "1" : "5";

        var fieldGroupHtml = '<div class="field-group">' +
            '<label for="' + fieldId + '">' + fieldName + '</label>' +
            '<div style="padding-top: ' + paddingTop + 'px" id="scriptedfield_' + fieldId + '"> ' +
            '<span class="aui-icon aui-icon-wait">Loading, please wait</span></div>' +
            '</div> ';

        // Modify this select if you want to change the positioning of the displayed field
        $context.find("div.field-group:first").before(fieldGroupHtml);

        $.ajax({
            type: "GET",
            "contentType": "application/json",
            url: AJS.params.baseURL + "/rest/api/2/issue/" + issueKey + "?expand=renderedFields&fields=" + fieldId,
            success: function (data) {
                if ("fields" in data && fieldId in data.fields) {
                    var fieldValue = data.fields[fieldId];
                    $context.find("#scriptedfield_" + fieldId).empty().append(fieldValue);
                }
                else {
                    $context.find("#scriptedfield_" + fieldId).empty().append("ERROR - bad field ID");
                }
            },
            error: function () {
                $context.find("#scriptedfield_" + fieldId).empty().append("ERROR");
            }
        });
    }

    JIRA.bind(JIRA.Events.NEW_CONTENT_ADDED, function (e, context) {
        addCalculatedField(e, context);
    });

})(AJS.$);
</script>
```

Note that the plain value is returned, the renderer is not respected. If you know how to get the rendered value let me know. The REST API does not seem to provide this for calculated fields even with  _expand=renderedFields_.
