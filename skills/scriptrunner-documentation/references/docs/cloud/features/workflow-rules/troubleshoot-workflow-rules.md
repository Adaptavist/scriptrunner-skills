# Troubleshoot Workflow Rules

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > workflow-rules
- Doc ID: doc-sr4jc-409798226
- Source: https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/troubleshoot-workflow-rules

You can view Workflows in ScriptRunner for Jira Cloud if you have created a restriction, validator, or workflow action from the Workflows within the Jira Administration menus. Once added in Jira, the workflow then appears in the Workflows section of ScriptRunner for Jira Cloud, from where you can edit or disable it.

## Limitations on restrictions and validators

ScriptRunner for Jira Cloud provides workflow restrictions and validators using the [Jira Expression Framework](https://developer.atlassian.com/cloud/jira/platform/jira-expressions). It is not possible to use the REST API.

Some restrictions apply to evaluating expressions using the [Jira Expression Framework](https://developer.atlassian.com/cloud/jira/platform/jira-expressions). An expression can execute up to 10 expensive operations. Expensive operations are those that load additional data, such as entity properties, comments, or custom fields. 

Atlassian provides information on [Jira Expressions Types](https://developer.atlassian.com/cloud/jira/software/jira-expressions-type-reference/#issuetype) and lists the properties and functions which trigger expensive operations so that users can determine the operation complexity of expressions being evaluated. 

You can execute expressions using the [Evaluate Jira expression REST API operation](https://developer.atlassian.com/cloud/jira/platform/rest/#api-rest-api-2-expression-eval-post) and use the meta.complexity [expand](https://developer.atlassian.com/cloud/jira/platform/rest/#expansion) parameter to see the runtime complexity and number of expensive operations triggered.

## Perform actions workflow rules limitations

Perform actions rules in ScriptRunner for Jira Cloud are implemented as asynchronous webhooks. This means that:

-   Workflow actions cannot cancel a transition.
-   The work item may be displayed to the user before all the workflow actions have executed. ScriptRunner attempts to indicate to the user that the work item has been updated in the background, but this is not guaranteed.
-   The order of workflow action execution is not defined (one action cannot rely on the output of another).
    
-   If you add a workflow action for creating a transition, then it must be ordered below the workflow action named 'Re-index a work item to keep indexes in sync with the database' to ensure the work item gets created before the workflow action runs.
    
    An epic Perform actions rule can be cloned; however, the work items contained within that epic are not cloned. You will, therefore, need to recreate any associated work.
    

## Post Function best practices

Avoid errors around saving or loading caused by post function size and hitting timeouts due to long-running scripts:

-   Do not use inline scripts in any code boxes. Instead, load scripts from Script Manager, as it stores only a reference to a file rather than the entire script, which will significantly reduce the post function size.
    
-   Re-use scripts between post functions using Script Manager files to avoid duplicating code in inline scripts.
    
-   Keep description names short and avoid long names to reduce the post function size.
    
-   Avoid making bulk operations from post functions and instead use other features such as listeners or scheduled jobs.
    

## Troubleshooting tips

### Known issue error for the clone work item workflow action

**Issue description:** When cloning a work item with attachments in the rich text field, you may encounter an error if you _have enabled_ [Atlassian's new transition experience](https://community.atlassian.com/forums/Jira-articles/Now-GA-try-the-new-issue-transition-experience-in-Jira/ba-p/2734436). Read more in our [Breaking Changes](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/compatibility-of-atlassian-s-new-transition-experience-with-jira-expressions) documentation. For example:  

```
2025-03-14 18:34:49.554 WARN - POST request to /rest/api/3/issue returned an error code: status: 400 - Bad Request
body: {errorMessages=[], errors={description=We don't recognise the format of a file you added or the data in it. Remove and try again.}}
```

This is a known issue related to an Atlassian bug ([JRACLOUD-93305](https://jira.atlassian.com/browse/JRACLOUD-93305)). Below is a workaround to mitigate its impact: either clear the field or replace its content manually.

**Workaround:** We recommend checking the field value's **format type (**`Map` **or** `String`**)** before clearing or setting it. This ensures that both sets of users, those who have/do not have the new transition experience enabled, are supported. For example, we can use the `Description` field as shown below:

```
def originalDescription = issue.fields.description

if (originalDescription instanceof Map) { // New experience (ADF)
    issueInput.fields.description = new groovy.json.JsonSlurper().parseText("""
      Your ADF format
    """)
} else if (originalDescription instanceof String) { // Old experience (plain text)
    issueInput.fields.description = "Your plain text value"
}
```

We recommend this approach as necessary due to the following reasons:

-   For users of the new transition experience, **API** **v3** (`/rest/api/3/issue`) expects the description in **ADF** (Atlassian Document Format) and will fail if a plain string is passed.
    
-   For users of the old transition experience, **API v2** (`/rest/api/2/issue`) expects the description in **plain text** and will fail if ADF is passed.
    

Rather than leaving blank content, you can include custom content using Atlassian’s [ADF Builder Playground](https://developer.atlassian.com/cloud/jira/platform/apis/document/playground/ "https://developer.atlassian.com/cloud/jira/platform/apis/document/playground/") to enter values in the editor and generate content in ADF format. Since it outputs JSON, you can directly parse it in the console, similar to this [Scripted Fields](https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields#return-types:~:text=appears%20as%20follows%3A-,JSON%20notations,-Atlassian%E2%80%99s%20Document%20Format) example:

```
issueInput.fields.description = new groovy.json.JsonSlurper().parseText("""
Your ADF
""")
```

### Same UUID in sandbox copy and original instance causes drafts

When copying a workflow from one instance to another, for example, creating a sandbox copy of a production instance, workflow actions retain the same UUID as in the original instance.

As a result, when you edit the sandbox instance, the workflow action in the production instance is also updated, causing unintended changes.

#### Steps to reproduce

1.  Copy a workflow from a production instance to a sandbox instance.
    
2.  Ensure that the workflow includes a workflow action.
    
3.  Edit the workflow action in the sandbox instance.
    

#### Expected result

Changes made in the sandbox instance should not affect the production instance, and vice versa.

#### Actual result

Editing the workflow action in the sandbox instance also updates it in the production instance because of the shared UUID.

#### Workaround

You need to manually configure new workflow actions in the original source instance to prevent this issue. The source can be either the sandbox or production instance.
