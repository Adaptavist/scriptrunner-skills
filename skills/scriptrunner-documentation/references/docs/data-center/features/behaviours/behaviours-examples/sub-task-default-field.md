# Sub-task Default Field

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > behaviours > behaviours-examples
- Doc ID: doc-sr4js-442889011
- Source: https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples/sub-task-default-field

You can use Behaviors to automatically populate sub-task fields with data from the parent issue when creating new sub-tasks.

You can get the parent issue ID via the **`parentIssueId`** form field. Once you have that you can load that issue, get the fields, and set them in the _Create Issue_ dialog.

## Setting sub-task fields from the parent issue

You can use the following example to do the following:

-   Copy the parent issue summary to the sub-task summary field.
-   Copy common system field values to the sub-task and copy custom field values to the sub-task.

1.  From ScriptRunner, navigate to **Behaviours**. 
2.  Select **Create Behaviour**.
3.  Enter a name for the behaviour.
4.  Optional: Enter a description for the behaviour.
5.  Select **Create Mapping**.
6.  Select the project and issue type(s) to map this behaviour to. 
7.  Select **Add Mapping** to confirm the mapping.
8.  Select **Create** to create the behaviour.  
    You're taken to the **Edit Behaviour** screen where you can configure the behaviour further.
9.  Scroll to the **Initialiser** field and select **Create Script**.  
    ![](/sr4js/files/latest/442889011/441364110/1/1732118446000/Restricting_issue_type_2.png)
    
10.  Use one of the following example scripts, depending on what field defaults you want to set:  
     
     You can select **Example scripts** in the code editor for further examples.  
     
       
     
     1.  Copy the parent issue's summary to the sub-task summary field.  
         
         ```
import com.atlassian.jira.component.ComponentAccessor
import com.onresolve.jira.groovy.user.FieldBehaviours
import groovy.transform.BaseScript

import static com.atlassian.jira.issue.IssueFieldConstants.SUMMARY

@BaseScript FieldBehaviours fieldBehaviours

def parent = getFieldById("parentIssueId")
def parentIssueId = parent.getFormValue() as Long
def summary = getFieldById(SUMMARY)

if (!parentIssueId || underlyingIssue) {
    // this is not a subtask, or issue already exists, so don't set default values
    return
}

def issueManager = ComponentAccessor.getIssueManager()
def parentIssue = issueManager.getIssueObject(parentIssueId)

summary.setFormValue(parentIssue.summary)
```
         
     2.  Copy common system field values to the sub-task and copy custom field values to the sub-task.  
         
         This sample code demonstrates copying all fields from the parent to the new sub-task. In practice, you will edit this example and select the system and custom fields you need.
         
         ```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.datetime.DateTimeFormatterFactory
import com.atlassian.jira.datetime.DateTimeStyle
import com.atlassian.jira.issue.customfields.option.Option
import com.atlassian.jira.issue.fields.CustomField
import com.onresolve.jira.groovy.user.FieldBehaviours
import groovy.transform.BaseScript

import java.sql.Timestamp

import static com.atlassian.jira.issue.IssueFieldConstants.AFFECTED_VERSIONS
import static com.atlassian.jira.issue.IssueFieldConstants.ASSIGNEE
import static com.atlassian.jira.issue.IssueFieldConstants.COMPONENTS
import static com.atlassian.jira.issue.IssueFieldConstants.DESCRIPTION
import static com.atlassian.jira.issue.IssueFieldConstants.DUE_DATE
import static com.atlassian.jira.issue.IssueFieldConstants.ENVIRONMENT
import static com.atlassian.jira.issue.IssueFieldConstants.FIX_FOR_VERSIONS
import static com.atlassian.jira.issue.IssueFieldConstants.LABELS
import static com.atlassian.jira.issue.IssueFieldConstants.PRIORITY
import static com.atlassian.jira.issue.IssueFieldConstants.SUMMARY

@BaseScript FieldBehaviours fieldBehaviours

def parent = getFieldById("parentIssueId")
def parentIssueId = parent.getFormValue() as Long

if (!parentIssueId || underlyingIssue) {
    // this is not a subtask, or issue already exists, so don't set default values
    return
}

def issueManager = ComponentAccessor.getIssueManager()
def parentIssue = issueManager.getIssueObject(parentIssueId)
def customFieldManager = ComponentAccessor.getCustomFieldManager()

// REMOVE OR MODIFY THE SETTING OF THESE FIELDS AS NECESSARY
getFieldById(SUMMARY).setFormValue(parentIssue.summary)
getFieldById(PRIORITY).setFormValue(parentIssue.priority.id)

def dateTimeFormatterFactory = ComponentAccessor.getComponent(DateTimeFormatterFactory)
def defaultLocaleFormatter = dateTimeFormatterFactory.formatter().withStyle(DateTimeStyle.DATE).withDefaultLocale()
getFieldById(DUE_DATE).setFormValue(defaultLocaleFormatter.format(parentIssue.getDueDate()))

getFieldById(COMPONENTS).setFormValue(parentIssue.components*.id)
getFieldById(AFFECTED_VERSIONS).setFormValue(parentIssue.affectedVersions*.id)
getFieldById(FIX_FOR_VERSIONS).setFormValue(parentIssue.fixVersions*.id)
getFieldById(ASSIGNEE).setFormValue(parentIssue.assignee?.name)
getFieldById(ENVIRONMENT).setFormValue(parentIssue.environment)
getFieldById(DESCRIPTION).setFormValue(parentIssue.description)
getFieldById(LABELS).setFormValue(parentIssue.labels*.label)

// IF YOU DON'T WANT CUSTOM FIELDS COPIED REMOVE EVERYTHING BELOW HERE
// IF YOU ONLY WANT SOME FIELDS INHERITED ADD THEM TO THE LIST BELOW, OR LEAVE EMPTY FOR ALL
// eg ['Name of first custom field', 'Name of second custom field']
List copyCustomFields = []

List<CustomField> parentFields = customFieldManager.getCustomFieldObjects(parentIssue)

parentFields.each { cf ->
    if (copyCustomFields && !copyCustomFields.contains(cf.name)) {
        return
    }

    def parentValue = cf.getValue(parentIssue)

    if (!parentValue) {
        return
    }

    if (parentValue instanceof Timestamp) {
        getFieldById(cf.id).setFormValue(defaultLocaleFormatter.format(parentValue))
    } else if (parentValue instanceof Option) {
        getFieldById(cf.id).setFormValue(parentValue.optionId)
    } else if (parentValue instanceof List<Option>) {
        parentValue = parentValue as List<Option> //This cast is just to placate the static type checker
        getFieldById(cf.id).setFormValue(parentValue.collect { it.optionId })
    } else {
        getFieldById(cf.id).setFormValue(parentValue)
    }
}
```
         
           
         
     
       
     
11.  Select **Save Changes**. 
     
     You can now test your behaviour works by creating a sub-task and checking the chosen fields are set.
     
     ![](/sr4js/files/latest/442889011/441364109/1/1732118789000/Set_sub_task_field_example.gif)
     

  

* * *

## Related content

-   [Behaviours Examples](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples)
-   [Behaviours](https://docs.adaptavist.com/sr4js/latest/features/behaviours)
-   [Behaviours Tutorial](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-tutorial)
