# Feature Parity and Script Alternatives

- Platform: cloud
- Space: SR4JC
- Hierarchy: scriptrunner-migration-to-cloud
- Doc ID: doc-sr4jc-101629509
- Source: https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/feature-parity-and-script-alternatives

ScriptRunner for Jira Cloud does not have the same feature set as the Server/Data Center version. We have noted below the parity of each ScriptRunner for Server/Data Center feature, along with any script/function alternatives where there is currently no value parity.

ScriptRunner for Server/Data Center features, which are not supported in ScriptRunner for Jira Cloud, are also listed in the parity tables for full transparency to allow an informed decision when migrating from Server/Data Center to Cloud.

Jira REST API and UI Modifications API

The varying parities between Cloud and Server/Data Center exist due to the limitations of the Jira REST API and [UI Modifications API](https://developer.atlassian.com/platform/forge/custom-ui-jira-bridge/uiModifications/?_ga=2.14988342.1096160938.1691399951-2016015256.1672998146), which ScriptRunner relies on to allow certain functionality. Unfortunately, it is likely that some features cannot be part of the Cloud feature set due to restrictions in the Cloud platform. There are also some general [limitations](https://docs.adaptavist.com/sr4jc/latest/get-started/limitations) within ScriptRunner Cloud, such as script execution timeouts and script storage, which we recommend reviewing. 

Try our migration tools!

The ScriptRunner Migration Suite is a suite of tools that helps you plan, analyse, convert and deploy scripts with confidence, significantly reducing the manual migration effort. It supports (not replaces) your expertise. The suite is made up of three tools: 

-   [ScriptRunner Migration Analyse and Assess Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-analyse-and-assess-tool): Use this tool to review your ScriptRunner Data Center scripts and configurations for risks and cloud readiness.
-   [The ScriptRunner Migration Agent](https://docs.adaptavist.com/sms/latest/scriptrunner-migration-suite-web-app/scriptrunner-migration-agent): Use our specialised AI chat agent to create, convert, and optimise scripts, or you can use it to answer a variety of different questions about ScriptRunner.
-   [ScriptRunner Dev and Deployment Tool](https://docs.adaptavist.com/sms/latest/scriptrunner-dev-and-deployment-tool): Use this tool to organise and deploy ScriptRunner Cloud scripts. It is focused on making it easier and faster for consultants and developers to migrate, test, and deploy scripts from ScriptRunner DC to Cloud.

If you have any questions, need help, or would like to request access, the quickest way to get assistance is through our [dedicated support portal](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/1069/user/login?destination=portal%2F1069).

 

Key

Definition

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

Full value parity.

**◐** 

Partial value parity. 

ALT

No value parity, but custom script alternatives are available.

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

No value parity or alternatives are available.

## Behaviours

### Parity summary

The Behaviours feature allows you to implement various common use cases, such as:

-   [Restricting issue type based on user role](https://www.scriptrunnerhq.com/help/example-scripts/Limit-issue-types-based-on-roles-cloud?_gl=1*i9rip*_gcl_aw*R0NMLjE3NTAzNDM0MDYuQ2p3S0NBanc2czdDQmhBQ0Vpd0F1SFFja2tfYl9ucjExcElFVGI3R3BjN2diOVltTVNhbDBReDQ3cnMtd3lVM3F0NllQdDhVUmlGb1dSb0Nvd29RQXZEX0J3RQ..*_gcl_au*OTQwNDY4MDI4LjE3NTAyMzQwOTguNjY0MDYyNTYxLjE3NTIyMzEzNTIuMTc1MjIzMTM1MQ..*_ga*MTYzNTU0NTI3OC4xNzQyMjI2ODg5*_ga_C6V1F2HSMM*czE3NTU1MTE2NzgkbzExMjgkZzEkdDE3NTU1MTQyNTgkajYwJGwwJGgxMTY3NDMzMzcy)
-   [Making a field required when a value is selected inside a select list field](https://www.scriptrunnerhq.com/help/example-scripts/make-field-required-when-another-field-selected-cloud)
-   [Adding a default description](https://www.scriptrunnerhq.com/help/example-scripts/set-default-description-upon-issue-creation-cloud)

See our [Example Scripts](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=behaviours&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud) for a complete collection of pre-written scripts that address common use cases. 

### Parity details

Server/DC Feature

Cloud Parity

Parity Notes/Alternatives

Cloud Links

[Behaviours](https://docs.adaptavist.com/sr4js/latest/features/behaviours)

◐

Atlassian created an API called [UI Modifications](https://developer.atlassian.com/platform/forge/custom-ui-jira-bridge/uiModifications/) on the Forge platform, which made it possible for ScriptRunner to build Behaviours. As more capabilities become available in the UI Modifications API, more functionality can be built in ScriptRunner's Behaviours feature. Behaviours is a key focus within ScriptRunner's product development roadmap. We are actively enhancing this feature by integrating new capabilities as Atlassian releases them. 

**Differences**

Notable differences for Behaviours on Cloud:  

 **![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**You can apply Behaviours to the Create, Issue, and Transition views (Create, View/Edit, Transition view types) of a Jira issue. Refer to [Behaviours Supported Fields and Products](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-supported-fields-and-products) for details.

 **![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**Behaviours may be applied to [certain supported fields only](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-supported-fields-and-products), as not all fields are currently supported in all available views.

 ![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)Currently, you cannot select all projects and all issue types simultaneously. You may, however, select all projects OR all issue types.

**Parity**

Notable parity for Behaviours on Cloud:

 ****![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)****Compatible with Jira Software and JSM.

 ****![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)****Company and team-managed projects are supported.

 ****![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)****Support for over 30 system and custom field types across all three Create, Issue, and Transition views (Create, View/Edit, Transition view types).

[Cloud Behaviours documentation](https://docs.adaptavist.com/sr4jc/latest/features/behaviours)

[Cloud Behaviours example scripts](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=behaviours&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud)

## Built-In Scripts

### Parity summary

ScriptRunner for Jira Cloud offers a limited selection of built-in scripts compared to the Data Center version. However, alternative scripts that can be executed through the Script Console are available in Cloud. Where applicable, links to these script alternatives are provided in the table below.

See our [Example Scripts](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=script-console&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud) for a complete collection of pre-written scripts that can be run from the Script Console.

### Parity details

Server/DC Feature

Cloud Parity

Parity Notes/Alternatives

Cloud Links

[Bulk Copy SLA Configuration](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/bulk-copy-slas)

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

This is not applicable in the Jira Cloud environment.

SLA configurations are managed through Jira Service Management's native interface in Cloud. The REST API doesn't provide endpoints for bulk SLA configuration operations, and this is considered an administrative setup task rather than a scripting use case.

[Cloud Built-In Scripts documentation](https://docs.adaptavist.com/sr4jc/latest/features/built-in-scripts)

[Cloud example scripts](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=script-console&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud)

  

[Bulk Fix Resolution](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/bulk-fix-resolutions)

◐

The [Bulk fix resolutions](https://docs.adaptavist.com/sr4jc/latest/features/built-in-scripts/bulk-fix-resolutions) built-in script is available in ScriptRunner for Jira Cloud. This feature is marked as having partial parity because Jira Cloud does not allow clearing resolutions (selecting None option).

[Bulk Import Custom Fields](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/bulk-import-custom-field-values)

ALT

The same function can be achieved by writing your own script in the [Script Console](https://docs.adaptavist.com/sr4jc/latest/features/script-console) but with all the caveats of time limitations, API availability, etc.

We have provided an alternative example script below that works for Select List, Multi Select List, Checkbox and Radio button fields to import in options. It creates new options if they don't exist and emits options that already exist.

bulkImportCustomFieldOptions.groovy...

```
/*
 * This script provides an example of how in the Script Console you can bulk import custom field options.
 * Options which already exist for a field are skipped and only new options are added. 
 * This works for the following field types: Single Select List, Multi Select List, Radio Buttons, Checkboxes
 *
 * All right, title and interest in this code snippet shall remain the exclusive intellectual property of Adaptavist Group Ltd and its affiliates. Customers with a valid ScriptRunner 
 * license shall be granted a  non-exclusive, non-transferable, freely revocable right to use this code snippet only within their own instance of Atlassian products. This licensing notice cannot be removed
 * or amended and must be included in any circumstances where the code snippet is shared by You or a third party." 
*/ 

// Specify the ID of your custom field below
def customfieldId = 'customfield_12345'  // Note supported field types are: Single Select List, Multi Select List, Radio Buttons, Checkboxes 

// Specify the ID of your custom field's context to add the option values to
def customfieldContextId = 12345            

// Define the new options to add in the array below
def newFieldOptions = ['Option A', 'Option B', 'Option C',"Option D", "Option E"]

// Get existing options for this context
def getExistingFieldOptions = get("/rest/api/3/field/${customfieldId}/context/${customfieldContextId}/option")
    .queryString('maxResults', 1000)
    .header('Content-Type', 'application/json')
    .asObject(Map)

if (getExistingFieldOptions.status != 200) {
    return "Failed to retrieve existing options. Status: ${getExistingFieldOptions.status}"
}

// Extract the values of existing options
def existingOptionValues = (getExistingFieldOptions.body as Map).values?.collect { (it as Map).value } ?: []

// Filter out options that already exist
def optionsToCreate = newFieldOptions.findAll { !existingOptionValues.contains(it) }
def alreadyExisting = newFieldOptions.findAll { existingOptionValues.contains(it) }

// If there are no new options to create, return early
if (optionsToCreate.isEmpty()) {
    return "All options already exist: ${alreadyExisting.join(', ')}"
}

// Construct the payload for the new options to be added
def fieldOptionsRequestBody = [
    options: optionsToCreate.collect { optionValue ->
        [
            value: optionValue,
            disabled: false
        ]
    }
]

// Add the new custom field options
def addCustomFieldOptions = post("/rest/api/3/field/${customfieldId}/context/${customfieldContextId}/option")
    .header('Content-Type', 'application/json')
    .body(fieldOptionsRequestBody)
    .asObject(Map)

// Check the response to confirm the options were created successfully
if (addCustomFieldOptions.status == 200) {
    def createdOptions = addCustomFieldOptions.body as Map
    def optionsList = createdOptions.options as List<Map>
    def createdOptionsSummary = "Successfully created ${optionsList?.size() ?: 0} option(s): ${optionsToCreate.join(', ')}."
    
    if (alreadyExisting) {
       createdOptionsSummary += "These options already existed: ${alreadyExisting.join(', ')} so were not created"
    }
    
    return createdOptionsSummary
} else {
    return "Failed to create options. Status: ${addCustomFieldOptions.status}"
}
```

The example script below works for bulk import cascading select list field options. It creates new options if they don't exist and omits options that already exist.

bulkImportCasscadingSelectCustomFieldOptions.groovy...

```
/*
 * This script provides an example of how in the Script Console you can bulk import cascading select list field options.
 * Options which already exist are skipped and only new options are added. 
 *
 * All right, title and interest in this code snippet shall remain the exclusive intellectual property of Adaptavist Group Ltd and its affiliates. Customers with a valid ScriptRunner 
 * license shall be granted a  non-exclusive, non-transferable, freely revocable right to use this code snippet only within their own instance of Atlassian products. This licensing notice cannot be removed
 * or amended and must be included in any circumstances where the code snippet is shared by You or a third party." 
*/

// Specify the ID of your cascading select custom field below
def customfieldId = 'customfield_12345'

// Specify the ID of your custom field's context to add the option values to
def customfieldContextId = 12345

// Define cascading options as a map using the sture: [ParentValue: [Child1, Child2]]
// Use an empty list [] for parents with no children
def cascadingSelectListFieldOptions = [
    'Parent1': ['child1', 'child2', 'child3'],
    'Parent2': ['child4', 'child5', 'child6'],
    'Parent3': ['child7', 'child8', 'child9'],
    'emptyParent': []  // Parent with no children
]

// Get existing options for this context
def getExistingOptions = get("/rest/api/3/field/${customfieldId}/context/${customfieldContextId}/option")
    .queryString('maxResults', 1000)
    .header('Content-Type', 'application/json')
    .asObject(Map)

if (getExistingOptions.status != 200) {
    return "Failed to retrieve existing options. Status: ${getExistingOptions.status}"
}

def existingOptions = (getExistingOptions.body as Map).values as List<Map>

// Build maps of existing parent and child options
def existingParents = existingOptions
    .findAll { !it.optionId } 
    .collectEntries { [(it.value): it.id] }

def existingChildren = existingOptions
    .findAll { it.optionId }  
    .collect { [value: it.value, parentId: it.optionId] }

def parentsToCreate = cascadingSelectListFieldOptions.keySet().findAll { !existingParents.containsKey(it) }

def createdParents = [:]
def skippedParents = []

// Create the parent options
if (parentsToCreate) {
    
    def parentRequestBody = [
        options: parentsToCreate.collect { parentValue ->
            [
                value: parentValue,
                disabled: false
            ]
        }
    ]
    
    def createParentOptionValues = post("/rest/api/3/field/${customfieldId}/context/${customfieldContextId}/option")
        .header('Content-Type', 'application/json')
        .body(parentRequestBody)
        .asObject(Map)
    
    if (createParentOptionValues.status == 200) {
        def createdParentOptions = (createParentOptionValues.body as Map).options as List<Map>
        createdParents = createdParentOptions.collectEntries { [(it.value): it.id] }
    } else {
        return "Failed to create parent options. Status: ${createParentOptionValues.status}"
    }
} else {
    logger.info("All parent options already exist")
}

// Combine existing and newly created parents
def allParents = existingParents + createdParents
skippedParents = cascadingSelectListFieldOptions.keySet().findAll { existingParents.containsKey(it) }

// Create the child options
def childrenToCreate = []

cascadingSelectListFieldOptions.each { parentValue, children ->
    def parentId = allParents[parentValue]
    
    if (!parentId) {
        logger.warn("Parent '${parentValue}' not found, skipping its children")
        return
    }
    
    children.each { childValue ->
        // Check if the option already exists under the parent
        def alreadyExists = existingChildren.any { 
            it.value == childValue && it.parentId == parentId 
        }
        
        if (!alreadyExists) {
            childrenToCreate << [
                value: childValue,
                disabled: false,
                optionId: parentId  
            ]
        }
    }
}

def createdChildren = []
def skippedChildren = []

if (childrenToCreate) {
    
    def childRequestBody = [
        options: childrenToCreate
    ]
    
    def createChildOptionValues = post("/rest/api/3/field/${customfieldId}/context/${customfieldContextId}/option")
        .header('Content-Type', 'application/json')
        .body(childRequestBody)
        .asObject(Map)
    
    if (createChildOptionValues.status == 200) {
        createdChildren = (createChildOptionValues.body as Map).options as List<Map>
    } else {
        return "Failed to create child options. Status: ${createChildOptionValues.status}"
    }
} else {
    logger.info("All child options already exist")
}

// Collect all API responses and update on what options were created
def createdOptionsSummary= []

if (createdParents) {
    createdOptionsSummary << "Created ${createdParents.size()} parent option(s): ${createdParents.keySet().join(', ')}"
}

if (skippedParents) {
    createdOptionsSummary << "Skipped ${skippedParents.size()} existing parent(s): ${skippedParents.join(', ')}"
}

if (createdChildren) {
    def childValues = (createdChildren as List<Map>).collect { (it as Map).value }
    createdOptionsSummary << "Created ${createdChildren.size()} child option(s): ${childValues.join(', ')}"
}

def totalExistingChildren = cascadingSelectListFieldOptions.values().flatten().size() - childrenToCreate.size()
if (totalExistingChildren > 0) {
    createdOptionsSummary << "Skipped ${totalExistingChildren} existing child option(s)"
}

// Return an update on what cascading select list options were created
return createdOptionsSummary ? createdOptionsSummary.join('\n') : 'No changes made - all options already exist'
```

[Change Dashboard, Filter or Board Ownership](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/change-dashboard-filter-or-board-ownership)

ALT

Similar functionality can be achieved by writing a script in the [Script Console](https://docs.adaptavist.com/sr4jc/latest/features/script-console) to call the [Change Filter Owner](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-filters/#api-rest-api-3-filter-id-owner-put) and the [Bulk edit dashboards](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-dashboards/#api-rest-api-3-dashboard-bulk-edit-put) APIs to update and filter dashboard owners.  

We have created a [Change owner of Filter or Dashboard](https://www.scriptrunnerhq.com/help/example-scripts/Change-filter-Or-Dashboard-Ownership-cloud?_gl=1*gc3eb4*_gcl_aw*R0NMLjE3NTAzNDM0MDYuQ2p3S0NBanc2czdDQmhBQ0Vpd0F1SFFja2tfYl9ucjExcElFVGI3R3BjN2diOVltTVNhbDBReDQ3cnMtd3lVM3F0NllQdDhVUmlGb1dSb0Nvd29RQXZEX0J3RQ..*_gcl_au*OTQwNDY4MDI4LjE3NTAyMzQwOTguNjY0MDYyNTYxLjE3NTIyMzEzNTIuMTc1MjIzMTM1MQ..*_ga*MTYzNTU0NTI3OC4xNzQyMjI2ODg5*_ga_C6V1F2HSMM*czE3NTU1OTk2NTgkbzExMzMkZzEkdDE3NTU2MDI0NzMkajU4JGwwJGgzMjQwODcwMzA.) example script for this.

[Clean Workflows](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/clean-workflows)

ALT

The same function can be achieved by writing a script to call the [workflows search API](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-workflows/#api-rest-api-3-workflows-search-get) to search for workflows adding a `queryString` of `isActive:false` to return inactive worklows, and then for each workflow returned, call the [delete inactive workflow API](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-workflows/#api-rest-api-3-workflow-entityid-delete).

[Clear Groovy Class Loader](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/clear-groovy-class-loader)

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

This is not applicable in the Jira Cloud environment.

This is a server-level operation that clears cached Groovy classes from memory. In Cloud, ScriptRunner runs in a separate process managed by Atlassian's infrastructure, and class loading is handled automatically. Users don't have access to server-level memory management.

[Configuration Exporter](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/configuration-exporter)

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

This is not possible in Jira Cloud. A third-party tool such as [salto.io](http://Salto.io) can provide this.

This Data Center tool exports Jira configuration data directly from the server. Cloud instances are managed by Atlassian, and configuration exports are handled through Atlassian's native Cloud migration tools and backup services, not through third-party apps.

[Copy Custom Field Values](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/copy-field-values)

◐

The [Copy custom field values to another field](https://docs.adaptavist.com/sr4jc/latest/features/built-in-scripts/copy-custom-field-values-to-another-field) built-in script is available in ScriptRunner for Jira Cloud. This feature is marked as having partial parity because it does not support the same number of fields as ScriptRunner for Jira Data Center. Jira Cloud currently supports: 

-   Single to multi, for example, single select to multi-select, single user picker to multi-user picker.
-   Multi to single, however, only the first value will be retained.
-   Multi to text, the values are concatenated with a comma.
-   Short text to unlimited text.

[Copy Project](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/copy-project)

ALT

You can achieve the same functionality in Jira Cloud by using the [Script Console](https://docs.adaptavist.com/sr4jc/latest/features/script-console) and a custom script. There is a limit of 240 seconds for script executions. After running for 240 seconds, the logs will be collected, and the code will be terminated.

[Generate Events](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/generate-events)

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

This is not possible in Jira Cloud.

Cloud's asynchronous execution model doesn't support manually triggering Jira events. Events are fired automatically by Jira when actions occur, and the Connect framework doesn't provide a mechanism to artificially generate events.

[Guardrails - Maximum number of comments per issue.](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/guardrails-built-in-scripts/maximum-comments-per-issue)  

ALT

You can use the [numberOfComments](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/jql-keywords#numberofcomments) JQL Keyword to search for issues that exceed a maximum number of comments using a JQL query similar to the one below.

`numberOfComments > 5`

You can then manually review these issues and delete the comments if needed.

To automate this, you could run this query in the [Script Console](https://docs.adaptavist.com/sr4jc/latest/features/script-console) calling the [Archive Issues by JQL](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-issues/#api-rest-api-3-issue-archive-post) API with this JQL to archive all issues returned that exceed this threshold.

[Guardrails - Maximum number of unarchived projects](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/guardrails-built-in-scripts/maximum-number-of-unarchived-projects)  

ALT

Similar functionality can be achieved by writing a script in the [Script Console](https://docs.adaptavist.com/sr4jc/latest/features/script-console) to call the [Get Projects Paginated API](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-projects/#api-rest-api-3-project-search-get) and filter out results where the `insights.lastIssueUpdateTime` Property is older than a specified timeframe, such as two years.  

You can then call the [Archive project](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-projects/#api-rest-api-3-project-projectidorkey-archive-post) API for every project returned by this API.

We have created a [Archive unused projects](https://www.scriptrunnerhq.com/help/example-scripts/archive-unused-projects-cloud?_gl=1*12nsf4x*_gcl_aw*R0NMLjE3NTAzNDM0MDYuQ2p3S0NBanc2czdDQmhBQ0Vpd0F1SFFja2tfYl9ucjExcElFVGI3R3BjN2diOVltTVNhbDBReDQ3cnMtd3lVM3F0NllQdDhVUmlGb1dSb0Nvd29RQXZEX0J3RQ..*_gcl_au*OTQwNDY4MDI4LjE3NTAyMzQwOTguNjY0MDYyNTYxLjE3NTIyMzEzNTIuMTc1MjIzMTM1MQ..*_ga*MTYzNTU0NTI3OC4xNzQyMjI2ODg5*_ga_C6V1F2HSMM*czE3NTU2MTEyNDIkbzExMzUkZzEkdDE3NTU2MTMzNDMkajYwJGwwJGg3MzE3MzExNTU.) example script for this, which can be run on the script console.

[Guardrails - Maximum Number of Issue Links Per Issue](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/guardrails-built-in-scripts/maximum-number-of-issue-links-per-issue)

ALT

You can use the [numberOfLinks](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/jql-keywords#numberoflinks) JQL Keyword to search for issues that exceed a maximum number of links using a JQL query similar to the one below.

`numberOfLinks > 5`

You can then manually review these issues and delete the links if needed.

If you wanted to automate this, you could run this query in the [Script Console](https://docs.adaptavist.com/sr4jc/latest/features/script-console) calling the [Archive Issues by JQL](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-issues/#api-rest-api-3-issue-archive-post) API with this JQL to archive all issues returned that exceed this threshold.

[Guardrails - Maximum Attachment Size](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/guardrails-built-in-scripts/maximum-attachment-size)

  

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

This is not possible in Jira Cloud.

Attachment size limits in Cloud are controlled at the Atlassian infrastructure level, not through individual instance configuration. The REST API doesn't expose endpoints to query or enforce custom attachment size limits.

[Guardrails - Maximum Change History Records Per Issue](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/guardrails-built-in-scripts/maximum-change-history-records-per-issue)

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

This is not possible in Jira Cloud.

Change history is managed by Atlassian's Cloud infrastructure. There's no REST API endpoint to query the number of history records per issue or to enforce limits on history retention.

[List Scheduled Jobs](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/list-scheduled-jobs)

ALT

Cloud's Atlassian Connect framework doesn't provide REST API access to query Jira's internal job scheduling system.

Cloud does not have the same internal scheduler as Jira Data Center, and in Cloud scheduled tasks are completed using automation rules configured on a scheduled trigger.  
  
As an alternative, you could write a script to call the [Automation API](https://docs.adaptavist.com/developer.atlassian.com/cloud/automation/rest/api-group-rule-management/#api-rest-v1-rule-summary-post) to search and return all scheduled rules and return them.

[Re-index Issues](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/re-index-issues)

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

This is not applicable in the Jira Cloud environment.

Reindexing in Cloud is managed entirely by Atlassian's infrastructure. Unlike Data Center where admins have direct control over indexing, Cloud automatically handles index maintenance. Users cannot and should not manually trigger reindexing operations.

[Script Registry](https://docs.adaptavist.com/sr4js/latest/features/script-registry)

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

Update coming soon...

[Service Desk Template Comments](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/template-comments-service-management)

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

This is not possible in Jira Cloud.

This functionality relates to Jira Service Management's internal comment templating system. The Cloud REST API doesn't expose endpoints for managing comment templates in the same way Data Center's Java API does.

[Split Custom Field Contexts](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/split-custom-field-context)

ALT

Similar functionality can be achieved by writing a script in the [Script Console](https://docs.adaptavist.com/sr4jc/latest/features/script-console "https://docs.adaptavist.com/sr4jc/latest/features/script-console") as shown in this example [script](https://library.adaptavist.com/entity/Split-Custom-Fields "https://library.adaptavist.com/entity/Split-Custom-Fields").

[Switch to a Different User](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/switch-user)

ALT

Cloud scripts cannot impersonate users for security reasons. Scripts execute as either:

-   The user who triggered the action, OR
-   The ScriptRunner add-on user (for system-level operations)

User impersonation would violate Cloud's security model and Atlassian's multi-tenant architecture.

Atlassian does not provide impersonation APIs so this cannot be built in Jira Cloud. However, Jira Cloud organization admins can switch to different users by using the built in feature as [documented by Atlassian](https://support.atlassian.com/user-management/docs/log-in-as-another-user/).

[Test Runner](https://docs.adaptavist.com/sr4js/latest/best-practices/write-and-run-tests?utm_source=product-help#running-tests)

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

This is not applicable in the Jira Cloud environment.

This Data Center tool runs automated tests against ScriptRunner scripts using server-side testing frameworks. Cloud's execution environment doesn't support the same testing infrastructure. Testing must be done through the Script Console or by running scripts in development environments.

[View Server Log Files](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/view-server-log-files)

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

This is not applicable in the Jira Cloud environment.

Cloud users don't have access to server log files - Atlassian manages the infrastructure. You can, however, [Review logs](https://docs.adaptavist.com/sr4jc/latest/manage-app/review-logs) in ScriptRunner for Jira Cloud. 

## HAPI

### Parity summary

In ScriptRunner for Jira Cloud, HAPI is available but has a limited scope due to the constraints of the Jira Cloud platform and REST-based architecture. This means that not all the methods available in DC are available in Cloud, as outlined in the table below:

Scripts that are built using HAPI will be easier to migrate if you decide to move to Jira Cloud. These scripts will likely need far fewer modifications to be compatible with ScriptRunner for Jira Cloud, streamlining the transition process.

### Parity details

Server/DC Feature

Cloud Parity

Parity Notes/Alternatives

Cloud Links

[Application links](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-linked-applications)

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

This is not applicable in the Jira Cloud environment.

  
Application Links is a Server/Data Center feature for connecting different Atlassian applications (Jira to Confluence, Bitbucket, etc.). In Jira Cloud, this concept doesn't exist in the same way—Cloud products automatically link when they're in the same Atlassian organization. There's no configurable "Application Links" feature to script against, so HAPI support isn't relevant.

[Cloud HAPI documentation](https://docs.adaptavist.com/sr4jc/latest/hapi)

  

  

  

  

  

  

  

  

  

  

  

  

[Assets](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-assets-insight)

ALT

While Assets/Insight exists in Cloud, ScriptRunner cannot integrate with Asset automation triggers and actions. The feature parity documentation shows all Asset-related automation features (Asset Object Created Trigger, Asset Object Updated Trigger, Create Asset Action, Lookup Asset Object Action) have no parity.

As an alternative, you could use the [Asset REST API](https://developer.atlassian.com/cloud/assets/rest/api-group-aql/#api-group-aql) to write scripts.

[Attachments](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-attachments)

**◐**

  

Cloud includes:

-   Retrieve attachments.

[Comments](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-comments)

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

Cloud includes:

-   Retrieve comments.
-   Add comments.

See the Cloud [Work with Comments](https://docs.adaptavist.com/sr4jc/latest/hapi/work-with-comments) page for more details. 

[Entity properties](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-issue-and-entity-properties)

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

Cloud includes:

-   ProjectEntityProperties
-   IssueEntityProperties
-   UserEntityProperties
-   CommentEntityProperties

For each of the above you can:

-   set the value of an entity property (as strings, JSON, integer, long, LocalDate, LocalDateTime, boolean)
-   retrieve the value of an entity property
-   check for the existence of an entity property
-   retrieve the keyset of all entity properties stored against an entity

See the Cloud [Work with Entity Properties](https://docs.adaptavist.com/sr4jc/latest/hapi/work-with-entity-properties) page for more details. 

[Fields](https://docs.adaptavist.com/sr4js/latest/hapi/update-fields)

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

Cloud includes:

-   Create, read, update, and delete system fields.
-   Create, read, update, and delete custom fields. 

See the Cloud [Update Fields](https://docs.adaptavist.com/sr4jc/latest/hapi/update-fields) page for more details.

[Filters](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-filters)

ALT

The Jira Cloud REST API does not provide adequate endpoints for programmatically managing filters. While you can execute JQL searches, you cannot script filter management operations like you can in Data Center.

As an alternative, you can use the [Jira Cloud REST API](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-filters/#api-group-filters) to create, update, and delete filters.

[Groups](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-groups)

**◐**

  

Cloud includes:

-   Retrieve groups and group members.
-   Add users to a group.

See the Cloud [Work with Groups](https://docs.adaptavist.com/sr4jc/latest/hapi/work-with-groups) page for more details. 

[Issues](https://docs.adaptavist.com/sr4js/latest/hapi/create-issues)

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

Cloud includes:

-   Create, read, update, and delete issues. 
-   Transition issues.
-   Search for issues.

See the Cloud [Work with Work Items](https://docs.adaptavist.com/sr4jc/latest/hapi/work-with-work-items) page for more details. 

[Permission schemes](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-permission-schemes)

ALT

The Jira Cloud REST API does not expose endpoints for managing permission schemes. You cannot programmatically create, modify, or assign permission schemes to projects. This is a significant platform limitation—permission scheme management must be done manually through the Jira UI.

Alternatively, you can write scripts to assign permission schemes using the [REST API](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-project-permission-schemes/#api-rest-api-3-project-projectkeyorid-permissionscheme-put).

[Projects](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-projects)

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

Cloud includes:

-   Create, read, update, and delete projects.

See the Cloud [Work with Spaces](https://docs.adaptavist.com/sr4jc/latest/hapi/work-with-spaces) page for more details. 

[Send emails](https://docs.adaptavist.com/sr4js/latest/hapi/send-emails)

ALT

While a notification API exists in Cloud, it has critical restrictions:

-   Can notify Jira users, groups, or user fields (assignee, reporter)
-   Cannot send emails to external email addresses
-   Users cannot send notifications to themselves (API validation prevents this) unless they turn on the **You make changes to work items** checkbox option in the _Send me emails for work item activity_ section of the _Notifications for spaces and work items_ settings page.
    

This makes it unsuitable for many common email automation scenarios that worked in Server/Data Center.

Alternatively, as ScriptRunner provides the send notification post function, you can call the [Notify API](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-issues/#api-rest-api-3-issue-issueidorkey-notify-post) in a script to send a notification. 

[Users](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-users)

**◐**

  

Cloud includes:

-   Retrieve users.
-   Retrieve user group membership.

See the Cloud [Work with Users](https://docs.adaptavist.com/sr4jc/latest/hapi/work-with-users) page for more details. 

[Watchers](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-watchers)

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

There is no HAPI support for managing watchers. However, the Jira Cloud REST API does provide endpoints for watcher operations:

\- GET /rest/api/3/issue/{issueIdOrKey}/watchers (retrieve watchers)  
\- POST /rest/api/3/issue/{issueIdOrKey}/watchers (add watchers)  
\- DELETE /rest/api/3/issue/{issueIdOrKey}/watchers (remove watchers)

You can implement watcher management using direct REST API calls with Unirest, but there's no simplified HAPI wrapper for these operations.

## Integrations

If you need to call external systems to import data into Jira, consider using **[ScriptRunner Connect](https://www.scriptrunnerhq.com/scriptrunner-connect/connectors)**, our powerful integration platform that offers this capability and much more.

Server/DC Feature

Cloud Parity

Parity Notes/Alternatives

[Automation for Jira: Asset Object Created Trigger](https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira/asset-object-created-trigger)

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

  

Automation for Jira offers a range of built-in Asset and Jira actions that are readily available in Jira Cloud.

Note that ScriptRunner Automation for Jira triggers and actions are currently unsupported on Cloud.

[Automation for Jira: Asset Object Updated Trigger](https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira/asset-object-updated-trigger)

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

[Automation for Jira: Create Asset Action](https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira/create-asset)

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

[Automation for Jira: Execute a ScriptRunner Script Action](https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira/execute-a-scriptrunner-script)

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

[Automation for Jira: Lookup Asset (Insight) Object Action](https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira/lookup-asset-insight-object)

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

[Automation for Jira: Lookup Asset (Insight) Objects from AQL (IQL) Action](https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira/lookup-asset-insight-objects-from-aql-iql)

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

[Automation for Jira: Update Asset Action](https://docs.adaptavist.com/sr4js/latest/integrations/automation-for-jira/update-asset)

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

[Vendors API](https://docs.adaptavist.com/sr4js/latest/integrations/vendors-api)

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

  

## Jobs

### Parity summary

This feature is known as [Scheduled Jobs](https://docs.adaptavist.com/sr4jc/latest/features/scheduled-jobs) and [Escalation Service](https://docs.adaptavist.com/sr4jc/latest/features/escalation-service) in ScriptRunner for Jira Cloud. While this feature has certain limitations in the Cloud environment (detailed in the table below), you can still implement various common use cases.

See our [Example Scripts](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=jobs&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud) for a complete collection of pre-written scripts that can be used with Scheduled Jobs.

### Parity details

Server/DC Feature

Cloud Parity

Parity Notes/Alternatives

  

Cloud links

Custom Scheduled Job

**◐**

  

The [Scheduled Jobs](https://docs.adaptavist.com/sr4jc/latest/features/scheduled-jobs) feature is available in ScriptRunner for Jira Cloud. 

Jira Cloud supports: 

-   A minimum interval of 1 hour. 
-   There is a limit of 240 seconds for script executions. After running for 240 seconds, the logs will be collected, and the code will be terminated.

[Cloud Jobs example scripts](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=jobs&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud)

Escalation Service

**◐**

  

The [Escalation Service](https://docs.adaptavist.com/sr4jc/latest/features/escalation-service) feature is available in ScriptRunner for Jira Cloud.

Jira Cloud supports:

-   The maximum number of issues you can modify in any execution of an Escalation Service job is 50. In other words, we limit the number of issues returned by each JQL query to 50 issues.
-   A minimum interval of 1 hour.

[Cloud Escalation Service example scripts](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=escalation-services&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud)

Issue Archiving Job

ALT

This can be achieved by writing a custom escalation service that calls the [Archive issue](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-issues/#api-rest-api-3-issue-archive-put) API to archive any issues returned by the JQL query specified on the schedule specified. You can also run the [Archive issues returned by a JQL Search](https://www.scriptrunnerhq.com/help/example-scripts/Archive-Issues-Retunred-By-A-Jql-Search-cloud) example script to archive issues. 

  

## JQL Functions

### Parity summary

Both versions of ScriptRunner use JQL Functions. However, this feature has been implemented as [Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search) within ScriptRunner for Jira Cloud.

Enhanced Search and ScriptRunner Enhanced Search

If you purchase ScriptRunner for Jira Cloud, you will automatically receive [ScriptRunner Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search) for free - this is included as part of your license. However, if you find that you're not using any of the other features offered by ScriptRunner for Jira Cloud, and you're only using Enhanced Search functionality, you can purchase [Enhanced Search](https://docs.adaptavist.com/es/latest) as a standalone product instead.

Please note that both apps are not designed to be used simultaneously as the data is stored separately. Although both products work independently, you will only see filters in the app it was created from and could duplicate work. If you currently have both products installed, or if you would like to switch from one to the other please contact our [Support](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/27/user/login?destination=portal%2F27) team who can manually transfer your data on your behalf. 

JQL Query Comparison

See our Enhanced Search documentation for [JQL Query Comparisons](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/comparison-with-scriptrunner-for-jira-server#jql-query-comparison) between ScriptRunner for Jira Server/DC and Cloud.

When ScriptRunner Enhanced Search for Jira Cloud is installed, an administrator **must** perform an [initial synchronisation](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords-synchronization) before the [ScriptRunner Enhanced Search JQL keywords](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords) work in Jira's native JQL search. Note that initial synchronization is also required after migrating from ScriptRunner for Jira Data Center to Cloud.

### Parity details

Server/DC Feature

Cloud Parity

Parity Notes/Alternatives

  

`[addedAfterSprintStart](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/sprint#addedAfterSprintStart)`

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

`[addedAfterSprintStart](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/agile-and-sprint-management#addedaftersprintstart)` is available in ScriptRunner Enhanced Search. 

This [JQL function](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions) will identify issues that were added to an open sprint after the feature was released (21st December 2020). Historical searches for issues added to open sprints prior to that date are not supported.

`[aggregateExpression](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/calculations#aggregateExpression)`

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

The DC implementation calculates aggregates (sum, count, etc.) across issue data and displays results in a separate panel. Native Jira doesn't support displaying aggregate summaries in a UI panel in search results.

Also, there are performance considerations because aggregate expressions require complex calculations across large datasets.

`[archivedVersions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/versions#archivedVersions)`

ALT

There is no like-for-like function in Jira Cloud, but depending on what you want to achieve, you could implement a new function in Cloud.

Cloud's version API (`/rest/api/3/project/{projectIdOrKey}/version`) should return version data, including archived status, and would need to fetch all versions and filter by `archived: true.`

`[commented](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/comments#commented)`

ALT

There is no like-for-like function in Jira Cloud, but depending on what you want to achieve, you could use some ScriptRunner [JQL Keywords](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords) to achieve the same:

-   `[firstCommentedDate](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords/time-tracking#firstcommenteddate)`
-   `[lastCommentedDate](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords/time-tracking#lastcommenteddate)`
-   `[commentedOn](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords/time-tracking#commentedon)`
-   `[commentedBy](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords/issue-management#commentedby)`
-   `[lastCommentBy](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords/time-tracking#lastcommentby)`

`[completeInSprint](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/sprint#completeInSprint)`

ALT

There is no like-for-like match here, but the `[inSprint](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/agile-and-sprint-management#insprint)` JQL function can be used to search for issues in the sprint that have a completed status to get a similar query.

`[componentMatch](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/match-functions#componentMatch)`

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

`[componentMatch](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/match-functions#componentmatch)` is available in ScriptRunner Enhanced Search. 

`[dateCompare](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/date#dateCompare)`

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

 `[dateCompare](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/date-and-time-management#datecompare)` is available in ScriptRunner Enhanced Search. 

`[earliestUnreleasedVersionByReleaseDate](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/versions#earliestUnreleasedVersionByReleaseDate)`

ALT

The Server/DC implementation finds the earliest unreleased version by release date for a project.  
  
For Cloud, it is possible to access the version `releaseDate` and `released` status, these fields are available from the Cloud API.

`[epicsOf](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#epicsOf)`

**◐**

`[epicsOf](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/links-and-relationships#epicsof)` is available in ScriptRunner Enhanced Search. 

This function is available for Jira company-managed projects but not for team-managed projects. 

`[expression](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/calculations#expression)`

**◐**

The Server/DC implementation allows arbitrary Groovy expressions to be evaluated against issue data and can compare duration, date, number, picker, and user fields, and perform mathematical operations on them.

In Cloud, Jira expressions are used and cannot be embedded in JQL functions the same way. The expression function can compare duration, date, number, pickers, and user fields (and perform mathematical operations on them), making it too complex to parse automatically and determine the type of field without querying Jira.  
  
For **date field types only**, there is a potential partial conversion to the `dateCompare` function:

-   `issue in dateCompare(<JQL>, <expression>)` for expressions where date field types are encountered. However, the syntax is different, and the migration would require extra manual changes.
    

`[fileAttached](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/attachments#fileattached)`

ALT

There is no like-for-like function in Jira Cloud, but depending on what you want to achieve, you could use some ScriptRunner [JQL Keywords](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords) to achieve the same result:

-   `[numberOfAttachments](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords/issue-management#numberofattachments)`
-   `[attachmentType](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords/issue-management#attachmenttype)`
-   `[firstAttachmentDate](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords/time-tracking#firstattachmentdate)`
-   `[lastAttachmentDate](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords/time-tracking#lastattachmentdate)`
-   `[fileAttachedBy](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords/issue-management#fileattachedby)`

`[hasAttachments](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/attachments#hasattachments)`

ALT

There is no like-for-like function in Cloud, but depending on what you want to achieve, you could use the `[numberOfAttachments](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords/issue-management#numberofattachments)` ScriptRunner JQL keyword to achieve the same result.

`[hasComments](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/comments#hasComments)`

ALT

There is no like-for-like function in Cloud, but depending on what you want to achieve, you could use the `[numberOfComments](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords/issue-management#numberofcomments)` ScriptRunner JQL keyword to achieve the same result.

`[hasLinks](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#hasLinks)`

ALT

There is no like-for-like function in Jira Cloud, but depending on what you want to achieve, you can use native Jira keywords `[workItemLink](https://support.atlassian.com/jira-software-cloud/docs/jql-fields/#Work-item-link)` and `[workItemLinkType](https://support.atlassian.com/jira-software-cloud/docs/jql-fields/#Work-item-link-type)`. 

`[hasLinkType](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#hasLinkType)`

ALT

There is no like-for-like function in Jira Cloud, but depending on what you want to achieve, you can use the native Jira keyword `[workItemLinkType](https://support.atlassian.com/jira-software-cloud/docs/jql-fields/#Work-item-link-type)`. 

`[hasRemoteLinks](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#hasRemoteLinks)`

ALT

The Server/DC implementation searches for issues with remote links (links to external systems like Confluence and Bitbucket).

Cloud has a remote link: `/rest/api/3/issue/{issueIdOrKey}/remotelink`

Implementing for Cloud would require fetching issues and checking each issue for remote links, although it could be slow/expensive.

`[hasSubtasks](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/sub-tasks#hasSubtasks)`

ALT

There is no like-for-like function in Cloud, but depending on what you want to achieve, you could use the `[numberOfSubtasks](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords/issue-management#numberofsubtasks)` ScriptRunner JQL keyword to achieve the same result.

`[inactiveUsers](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/user-functions#inactiveUsers)`

ALT

The Server/DC implementation returns all users who have been marked inactive in the system.

For Cloud:  

-   Cloud has `/rest/api/3/user/search/query` endpoint ([Jira Cloud API docs](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-user-search/#api-rest-api-3-user-search-query-get)) that we could use to return users with `active: false` status in response objects.
    
-   There is a constraint mentioned in the documentation: _"Note that the operations in this resource only return users found within the first 1000 users"._ The function would work correctly for small instances (<1000 inactive users), but could potentially create inconsistent behaviour for larger instances.
    
-   Atlassian recommends using the paginated endpoint [/rest/api/3/users/search](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-users/#api-rest-api-3-users-search-get), which includes the status of each user (`"active": true/false`) that we could filter on the client side.
    

`[incompleteInSprint](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/sprint#incompleteInSprint)`

ALT

There is no like-for-like match here, but the `[inSprint](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/agile-and-sprint-management#insprint)` JQL function can be used to search for issues in the sprint which have an incomplete status to get a similar query. 

`[issueFieldExactMatch](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/match-functions#issueFieldExactMatch)`

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

`[issueFieldExactMatch](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/match-functions#issuefieldexactmatch)` is available in ScriptRunner Enhanced Search. 

`[issueFieldMatch](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/match-functions#issueFieldMatch)`

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

`[issueFieldMatch](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/match-functions#issuefieldmatch)` is available in ScriptRunner Enhanced Search. 

`[issuePickerField](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#issuePickerField)`

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

**Cloud Status**: not possible to migrate

-   Unlike Server/DC's Lucene indexing, Cloud's API doesn't expose indexed custom field relationships in a way that supports efficient reverse queries.
    
-   Cloud's `/rest/api/3/search` API can query custom fields directly (e.g., `cf[12345] = "PROJ-123"`), but fetching all issues that reference a specific issue in a custom field would require expensive operations and perform reverse relationship queries, which wouldn't perform well and would likely result in timeouts.
    
-   In terms of performance, this would require fetching all issues with the custom field populated and checking if each issue matches the query, which could be quite expensive, especially for large instances.
    

`[issuesInEpics](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#issuesInEpics)`

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

`[issuesInEpics](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/links-and-relationships#issuesinepics)` is available in ScriptRunner Enhanced Search. 

This function is available for Jira company-managed projects but not for team-managed projects.

`[jiraUserPropertyEquals](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/user-functions#jiraUserPropertyEquals)`

**◐**

The Server/DC implementation returns users with matching Jira user property values (custom key-value pairs stored on user accounts).

**Cloud Status**: not possible to migrate without limitations

-   Cloud has `/rest/api/3/user/search/query` endpoint which supports querying by entity properties using syntax: `[propertyKey].entity.property.path is "<property value>"`
    
-   The API documentation states: _"Note that the operations in this resource only return users found within the first 1000 users." (_Same limitation as `inactiveUsers,`and would return incomplete results for larger instances)
    
-   Cloud's entity properties would also match Server/DC's user properties format. In Server/DC, user properties use the `jira.meta.` prefix (e.g., "jira.meta.region"). We would need to verify that all Cloud's entity properties follow this format.
    

`[lastComment](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/comments#lastComment)`

ALT

There is no like-for-like function in Cloud, but depending on what you want to achieve, you could use the `[lastCommentBy](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords/time-tracking#lastcommentby)` or `[lastCommentedDate](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords/time-tracking#lastcommenteddate)` ScriptRunner JQL keyword to achieve the same result.

  

`[lastUpdated](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/date#lastUpdated)`

ALT

There is no like-for-like function in Cloud, but depending on what you want to achieve, you could use the `[updated](https://support.atlassian.com/jira-software-cloud/docs/jql-fields/#Updated)` native Jira keyword to search for issues last updated within a certain time frame. 

`[linkedIssuesOf](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#linkedIssuesOf)`

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

`[linkedIssuesOf](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/links-and-relationships#linkedissuesof)` is available in ScriptRunner Enhanced Search. 

This function can be used in Jira Server/Data Center to search for issues linked with the parent-child hierarchy provided by Advanced Roadmaps/Portfolio but not in Jira Cloud Enhanced Search.

`[linkedIssuesOfAll](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#linkedIssuesOfAll)`

ALT

There is no like-for-like function in Jira Cloud, but depending on what you want to achieve, you could combine regular issue links, epic links, and subtask links via `parent` field.

`[linkedIssuesOfAllRecursive](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#linkedIssuesOfAll)`

ALT

There is no like-for-like function in Jira Cloud, but depending on what you want to achieve, you could combine regular issue links, epic links, and subtask links via `parent` field.

`[linkedIssuesOfAllRecursiveLimited](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#linkedIssuesOfAll)`

ALT

There is no like-for-like function in Jira Cloud, but depending on what you want to achieve, you could combine regular issue links, epic links, and subtask links via `parent` field.

`[linkedIssuesOfRecursive](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#linkedIssuesOfRecursive)`

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

`[linkedIssuesOfRecursive](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/links-and-relationships#linkedissuesofrecursive)` is available in ScriptRunner Enhanced Search. 

`[linkedIssuesOfRecursiveLimited](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#linkedIssuesOfRecursiveLimited)`

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

`[linkedIssuesOfRecursiveLimited](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/links-and-relationships#linkedissuesofrecursivelimited)` is available in ScriptRunner Enhanced Search. 

`[linkedIssuesOfRemote](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#linkedIssuesOfRemote)`

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

The Cloud API doesn't provide indexed access to remote link properties for efficient searching, and the `/rest/api/3/issue/{issueIdOrKey}/remotelink` endpoint:

-   doesn’t support searching or filtering remote links by properties
-   requires fetching all issues, then checking each issue's remote links individually, which would impact performance.

`[memberofRole](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/user-functions#memberOfRole)`

**◐**

  

**Cloud status**: possible with significant limitations

-   Server/DC behaviour:
    
    -   Takes field name and one or more role names as arguments, e.g. `issueFunction in memberOfRole("Reporter", "Administrators")`, and can be used with all User fields (reporter, creator, assignee, user custom fields, script fields).
        
-   Cloud has project role endpoints, which can retrieve users/groups directly assigned to roles, or role membership per project:
    
    -   `/rest/api/3/project/{projectIdOrKey}/role` - Get all roles for a project.
        
    -   `/rest/api/3/project/{projectIdOrKey}/role/{roleId}` - Get role details, including users and groups assigned to that role.
        
-   It might not be practical in the Cloud due to the following reasons:
    
    -   Project scope complexity: the function would need to determine which projects to query (from the query context or all projects). For queries without project restrictions, we would need to query _all_ projects, and each project requires an API call to get each role membership.
        
        -   Refer to the [documentation](https://docs.adaptavist.com/sr4js/8.x/features/jql-functions/included-jql-functions/user-functions#memberOfRole) where we mention this limitation '_If you have a large number of projects each having a large number of role memberships, the function will fail'_, which could likely occur in the Cloud.
            
    -   There might be a need to resolve group members in some cases, which could require additional API calls to `/rest/api/3/group/member` for each group.
        
-   Cloud has the native `membersOf()` JQL function for group-based searches, but this doesn't work for project-specific project roles.
    

`[myProjects](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/projects#myProjects)`

**◐**

**Cloud Status**: possible to implement, with significant limitations.

-   Server/DC behaviour:
    
    -   `project in myProjects()` returns projects where the user is in any role, except projects where the user only has access via global permission groups (e.g., `jira-users`, `jira-admins`).
        
        -   Refer to the [documentation](https://docs.adaptavist.com/sr4js/8.x/features/jql-functions/included-jql-functions/projects#myProjects) where we mention: '_being a member means being in any role, except where that is by virtue of being in a group with a global permission'._
            
-   Cloud has project-related endpoints to retrieve projects and check role membership per project:
    
    -   `/rest/api/3/project/search` - Returns projects visible to the authenticated user (i.e. has Browse Projects permission).
        
    -   `/rest/api/3/project/{projectIdOrKey}/role` - Get all roles for a project.
        
    -   `/rest/api/3/project/{projectIdOrKey}/role/{roleId}` - Get role details including users and groups assigned to that role.
        
-   This wouldn’t be as practical in Cloud, since [/rest/api/3/project/search](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-projects/#api-rest-api-3-project-search-get) returns projects where user has specific permissions, which is not the same as "projects where user is in a role". To replicate the exact behavior, we’d need to check role membership (not just browse permission), adding overhead to the query:
    
    -   Get all projects (or use `/rest/api/3/project/search` to get visible projects)
        
    -   For each project, get all roles: `/rest/api/3/project/{projectIdOrKey}/role`
        
    -   For each role, check if current user is in that role
        

`[nextSprint](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/sprint#nextSprint)`

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

`[nextSprint](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/agile-and-sprint-management#nextsprint)` is available in ScriptRunner Enhanced Search. 

`[overdue](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/versions#overdue)`

ALT

**Cloud Status**: could be implemented as a new function

-   Server/DC behaviour:
    
    -   Returns versions that are: a) unreleased, and b) have a release date in the past.
        
        -   Example: `fixVersion in overdue()` - finds issues with fix versions that are overdue
            
    -   Can optionally filter by release date: `fixVersion in overdue("before -14d")` (at least 14 days overdue).
        
        -   Example: `fixVersion in overdue("before -14d")` - finds issues with fix versions at least 2 weeks overdue.
            
-   Similar to `archivedVersions`, `overdue` could be implemented in the Cloud as a separate function:
    
    1.  Use Cloud's version API (`/rest/api/3/project/{projectIdOrKey}/version`) to get all versions.
        
    2.  Filter versions where:
        
        -   `released: false` (unreleased)
            
        -   `releaseDate` exists and is in the past (before the current date)
            
    3.  (Optional) Apply date filtering if an argument is provided.
        
    4.  Return version IDs.
        

`[parentsOf](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/sub-tasks#parentsOf)`

ALT

`[parentsOf](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/links-and-relationships#parentsof)` is available in ScriptRunner Enhanced Search. 

`[portfolioChildrenof](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/portfolio#portfolioChildrenOf)`

**◐**

  

`[childrenOf](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/links-and-relationships#childrenof)` can be used to find all descendant issues of a given subquery, including children, grandchildren, and beyond.

**Second parameter (optional):** You can use a second JQL query for childrenOf(Subquery) that acts as a filter on descendant issues. We _**strongly recommend**_ using this option to avoid filters that require significantly longer processing times because of their recursive nature.

For example, you could use:  

```
issueFunction in childrenOf("issue = EXAMPLE-1")
```

 And then narrow the search results:

```
issueFunction in childrenOf("project = DEMO", "issueType != Subtask")
```

`[portfolioParentOf](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/portfolio#portfolioParentsOf)`

**◐**

  

`[parentsOf](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/links-and-relationships#parentsof)` can be used to find all ancestor issues of a given subquery, including parents, grandparents, and beyond.

`[previousSprint](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/sprint#previousSprint)`

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

`[previousSprint](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/agile-and-sprint-management#previoussprint)` is available in ScriptRunner Enhanced Search. 

`[projectMatch](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/match-functions#projectMatch)`

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

`[projectMatch](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/match-functions#projectmatch)` is available in ScriptRunner Enhanced Search. 

In Jira Cloud this function uses the `projectKey`, whereas in server/data centre it uses project name.

`[projectsOfType](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/projects#projectsOfType)`

ALT

There is no like-for-like match here, but you can use the native Jira keyword of `[projectType](https://support.atlassian.com/jira-software-cloud/docs/jql-fields/#Project-type)` to return all issues from projects of a certain type such as Software.

`[recentProjects](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/projects#recentProjects)`

ALT

There is no like-for-like match here, but you can use the native Jira keyword of `[lastViewed](https://support.atlassian.com/jira-software-cloud/docs/jql-fields/#Last-viewed)` to return issues you last viewed in the past x days to see what projects you interacted with in that timeframe. 

`[releaseDate](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/versions#releaseDate)`

ALT

**Cloud Status**: possible to implement (could be implemented as a separate function, similar to `archivedVersions` and `overdue`)

-   Server/DC behaviour:
    
    -   Takes a date query argument with predicates: `after`, `before`, `on`
        
    -   Example: `fixVersion in releaseDate("after now() before 10d")` - finds issues with fix versions due in the next 10 days.
        
    -   Example: `fixVersion in releaseDate("on 2016/09/07")` - finds issues with fix versions released on a specific day.
        
    -   Can be used with fix versions, affects versions, and version custom fields.
        
    -   Supports date expressions like `-5d`, `-8w`, or date functions like `startOfMonth().`
        
-   Cloud's API (`/rest/api/3/project/{projectIdOrKey}/version`) returns version objects, including `releaseDate`, so it would be feasible in the Cloud by following a similar approach to `archivedVersions`:
    
    -   Use Cloud's version API (`/rest/api/3/project/{projectIdOrKey}/version`) to get all versions.
        
    -   Parse the date query argument and its expressions (relative dates like `-5d`, `10d`, absolute dates, date functions, etc).
        
    -   Filter versions where `releaseDate` matches the date predicates:
        
        -   `after date`: `releaseDate > date`
            
        -   `before date`: `releaseDate < date`
            
        -   `on date`: `releaseDate == date` (at day level)
            
    -   Handle multiple predicates (e.g., "after now() before 10d" means `releaseDate > now() AND releaseDate < now() + 10 days`).
        
    -   Return version IDs.
        
-   For large instances with many projects, project restrictions may be required, although the same limitation would apply to other functions, such as `archivedVersions` and `overdue.`
    

`[removedAfterSprintStart](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/sprint#removedAfterSprintStart)`

ALT

**Cloud Status**: possible to implement, but with additional complexity, similar to Cloud’s `addedAfterSprintStart.`

-   Server/DC behaviour:
    
    -   Example: `removedAfterSprintStart("Development Scrum", "Sprint 25")` - finds issues removed after Sprint 25 started.
        
    -   Example: `removedAfterSprintStart("Product Overview")` - finds issues removed after all active sprints started.
        
    -   Used to track sprint scope changes (issues removed after sprint planning).
        
-   Cloud's `addedAfterSprintStart` uses the issue changelog to detect when issues were added to sprints. For `removedAfterSprintStart`:
    
    -   Find issues that were removed from the sprint (not currently in it).
        
    -   Use a similar changelog-based approach but in reverse:
        
        1.  Get all issues that were in the sprint.
            
        2.  Check the changelog for Sprint field changes for each issue.
            
        3.  Look for changelog entries where:
            
            -   `field === "Sprint"`
                
            -   Sprint ID is in `from` field but not in `to` field (removed from sprint)
                
            -   Change date is after the sprint start date
                
        4.  Return matching issue IDs.
            
-   Similar performance profile to `addedAfterSprintStart` (but with potentially more issues to check, since we need to find issues that might have been removed).
    
-   Could be optimised by using project/board scope and date ranges to limit candidate issues, or caching changelog data where possible.
    

`[startDate](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/versions#startDate)`

ALT

**Cloud Status**: possible to implement as a separate function, identical to `releaseDate` but using `startDate` field.

-   Server/DC behavior:
    
    -   Takes a date query argument with predicates: `after`, `before`, on.
        
    -   Example: `fixVersion in startDate("after 14d")` - finds issues with fix versions starting in more than 14 days.
        
-   Feasible in Cloud, since this is the exact same approach that works for `archivedVersions`, `releaseDate`, and `overdue`. The only difference would be using `startDate` instead. Aside from that the implementation would be identical.
    
    -   Cloud's API (`/rest/api/3/project/{projectIdOrKey}/version`) returns _version_ objects which include startDate.
        
    -   Parse the date query argument (e.g., "after 14d").
        
    -   Filter versions where `startDate` matches the date predicates:
        
        -   `after date`: `startDate > date`
            
        -   `before date`: `startDate < date`
            
        -   `on date`: `startDate == date`
            

`[subtasksOf](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/sub-tasks#subtasksOf)`

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

`[subtasksOf](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/links-and-relationships#subtasksof)` is available in ScriptRunner Enhanced Search. 

`[versionMatch](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/match-functions#versionMatch)`

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

`[versionMatch](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/match-functions#versionmatch)` is available in ScriptRunner Enhanced Search. 

`[workLogged](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/worklogs#workLogged)`

**◐**

  

**Cloud Status**: partial native support for date queries only; `author/role/group` queries not supported natively.

-   Server/DC behavior:
    
    -   Supports date queries: `on`, `after`, `before` dates; e.g. `issueFunction in workLogged("on 2025/03/28 by admin")`
        
    -   Supports user queries: `by` username or user function (e.g., `by admin`, `by currentUser()`)
        
    -   Supports role queries: `inRole` role (e.g., `inRole Administrators`)
        
    -   Supports group queries: `inGroup` group (e.g., `inGroup jira-administrators`)
        
-   In Cloud:
    
    -   Date queries are already supported natively via `worklogDate`
        
    -   `Author/role/group` queries aren’t natively supported in Cloud. It is possible to implement but potentially expensive (similar to `inactiveUsers` and `jiraUserPropertyEquals`).
        
        -   To carry this out, you need to:
            
            1.  Get candidate issues (from JQL query scope).
                
            2.  Fetch worklogs via `/rest/api/3/issue/{issueIdOrKey}/workload f`or each issue.
                
            3.  Filter worklogs by: Author (for `by` queries), role (for `inRole` queries) or group (for `inGroup` queries).
                
            4.  Return issue IDs that have matching worklogs.
                

## Listeners

### Parity summary

This feature is known as [Script Listeners](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners) in ScriptRunner for Jira Cloud. While built-in script listeners are available in the Data Center version and not currently in Cloud, there are many script alternatives that can be executed using a [custom script listener](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners#create-a-script-listener). Where applicable, links to these script alternatives are provided in the table below.

See our [Example Scripts](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=listeners&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud) for a complete collection of pre-written scripts that can be used with Script Listeners.

### Parity details

Server/DC Feature

Cloud Parity

Parity Notes/Alternatives

  

Cloud Links

[Adds the current user as a watcher](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/adds-the-current-user-as-a-watcher)

ALT

You can achieve the same result by creating a [custom script listener](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners#create-a-script-listener) and using the [Add the current user as a watcher](https://www.scriptrunnerhq.com/help/example-scripts/add-current-user-as-a-watcher-cloud) example script. 

[Cloud Listener Example Scripts](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=listeners&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud)

[Cloud Script Listeners Documentation](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners)

[Clone an issue and links](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/clones-an-issue-and-links)

ALT

You can achieve the same result by creating a [custom script listener](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners#create-a-script-listener) and using the [Clone an issue and link to it](https://www.scriptrunnerhq.com/help/example-scripts/Clone-Issue-And-Link-cloud) example script. 

Please note that this alternative is subject to the constraints of the Cloud environment, such as time limitations and API availability. Check out our page on [Scripting in ScriptRunner for Jira Cloud](https://docs.adaptavist.com/sr4jc/latest/get-started/scripting-in-scriptrunner-for-jira-cloud) for tips. 

[Create a sub-task](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/create-a-sub-task)

ALT

You can achieve the same result by creating a [custom script listener](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners#create-a-script-listener) and using and/or adapting the [Create sub-tasks when an issue is created](https://www.scriptrunnerhq.com/help/example-scripts/create-subtasks-when-issue-created-cloud) example script. 

[Custom Listener](https://docs.adaptavist.com/sr4js/latest/features/listeners/custom-listener)

**◐**

The [Custom script listener](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners#create-a-script-listener) feature is available in ScriptRunner for Jira Cloud.

Please note that this feature is subject to the constraints of the Cloud environment. There is a limit of 240 seconds for script executions. After running for 240 seconds, the logs will be collected, and the code will be terminated.  

Currently, a custom event may not be created and used to trigger listener actions.

**Events supported in Cloud**

The list below shows the list of events that Jira Cloud supports to trigger listener actions from:

Supported Events

-   Attachment Created
-   Attachment Deleted
-   Board Configuration Changed
-   Board Created
-   Board Deleted
-   Board Updated
-   Comment Created
-   Commented Deleted
-   Comment Updated
-   Filter Created
-   Filter Updated
-   Filter Deleted
-   Issue Created
-   Issue Updated
-   Issue Deleted
-   IssueLink Created
-   IssueLink Deleted
-   IssueType Created
-   IssueType Updated
-   IssueType Deleted
-   Option Attachments Changed
-   Option Issulinks Changed
-   Option TimeTracking Changed
-   Option SubTasks Changed
-   Option UnAssignedIssues Changed
-   Option Voting Changed
-   Option Watching Changed
-   Project Created
-   Project Deleted
-   Project Soft Deleted (Archived)
-   Project Updated
-   Sprint Closed
-   Sprint Started
-   Sprint Deleted
-   Sprint Created
-   Sprint Updated
-   User Created
-   User Updated
-   User Deleted
-   Version Created
-   Version Updated
-   Version Deleted
-   Version Released
-   Version Moved
-   Version Unreleased
-   Worklog Created
-   Worklog Updated
-   Worklog Deleted

[Execution failure notifier](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/execution-failure-notifier)

ALT

In Jira cloud, the [Notifications group setting](https://docs.adaptavist.com/sr4jc/latest/get-started/settings#notification-groups) allows you to specify a group of users who will get an email each time a script fails, but this can't be configured to send to other messaging services such as Slack because the notify API doesn’t allow you to email external emails.

[Fast-track transition an issue](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/fast-track-transition-an-issue)

ALT

You can achieve a similar result by creating a [custom script listener](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners#create-a-script-listener) and using [HAPI](https://docs.adaptavist.com/sr4jc/latest/hapi/work-with-issues#update-fields-while-transitioning-issues). 

[Fires an event when a condition is true](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/fires-an-event-when-condition-is-true)

ALT

In Data Center this listener enables you to trigger a specific [Jira event](https://confluence.atlassian.com/adminjiraserver073/adding-a-custom-event-861253643.html) based on a custom condition. Once fired, the event can be picked up by a [notification scheme](https://confluence.atlassian.com/adminjiraserver0820/creating-a-notification-scheme-1095777110.html), determining who gets alerted.

It is not possible to fire a custom event in Cloud therefore this built-in script cannot be directly replicated in ScriptRunner for Jira Cloud. However, you could use the [Send Notification](https://docs.adaptavist.com/sr4jc/latest/features/workflow-extensions/post-functions/built-in-post-functions#send-notification) built-in post function that is available.

[Post a message to slack](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/post-a-message-to-slack)

ALT

You can achieve the same result by creating a [custom script listener](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners#create-a-script-listener) and using and/or adapting the [Post a message to Slack](https://www.scriptrunnerhq.com/help/example-scripts/post-to-slack-when-issue-created-cloud) example script. 

[Send a custom email (non-issue events)](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/send-a-custom-email-non-issue-events)

ALT

You can achieve a similar result by creating a [custom script listener](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners#create-a-script-listener) and using and/or adapting the [Notify on priority change](https://www.scriptrunnerhq.com/help/example-scripts/notify-on-priority-change-cloud) example script. 

The notify API doesn’t allow you to email external emails and only allows you to notify users, groups, or user fields (such as assignee or reporter) on an issue.

[Send a custom email](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/send-a-custom-email)

ALT

You can achieve a similar result by creating a [custom script listener](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners#create-a-script-listener) and using and/or adapting the [Notify on priority change](https://www.scriptrunnerhq.com/help/example-scripts/notify-on-priority-change-cloud) example script. 

The notify API doesn’t allow you to email external emails and only allows you to notify users, groups, or user fields (such as assignee or reporter) on an issue.

[Version Synchronizer](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/version-synchroniser)

ALT

You can achieve a similar result by creating a [custom script listener](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners#create-a-script-listener) and using and/or adapting the [Copy versions from one project to another](https://www.scriptrunnerhq.com/help/example-scripts/copy-project-versions-cloud) example script. 

Please note that this alternative is subject to the constraints of the Cloud environment, such as time limitations and API availability. Check out our page on [Scripting in ScriptRunner for Jira Cloud](https://docs.adaptavist.com/sr4jc/latest/get-started/scripting-in-scriptrunner-for-jira-cloud) for tips. 

## Mail Handler

The [Mail Handler](https://docs.adaptavist.com/sr4js/latest/features/mail-handler) Data Center feature is not currently available in ScriptRunner for Jira Cloud. 

Server/DC Feature

Cloud Parity

Parity Notes/Alternatives

Mail Handler

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

  

## Resources

### Parity summary

The Resources feature is not currently available in ScriptRunner for Jira Cloud, however some Resources have script alternatives that can be executed in the [Script Console](https://docs.adaptavist.com/sr4jc/latest/features/script-console) in ScriptRunner for Jira Cloud. Where applicable, links to these script alternatives are provided in the table below.

### Parity details

Server/DC Feature

Cloud Parity

Parity Notes/Alternatives

[Database Connection](https://docs.adaptavist.com/sr4js/latest/features/resources/database-connection)

ALT

You can connect to databases in scripts and link to the examples we have in the [Script Console examples](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=script-console&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud).

[LDAP Connection](https://docs.adaptavist.com/sr4js/latest/features/resources/ldap-connection)

ALT

If the LDAP service exposes a REST API, you could connect to this in Scripts by making a REST API call.

[Local Database Connection](https://docs.adaptavist.com/sr4js/latest/features/resources/local-database-connection)

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

This is not possible in Jira Cloud.

"Local" databases are on-premises behind your firewall. Cloud runs in Atlassian's AWS infrastructure and cannot access your internal network due to security isolation. ScriptRunner Cloud runs as a separate service with no direct network access to customer infrastructure.

[Slack Connection](https://docs.adaptavist.com/sr4js/latest/features/resources/slack-connection)

ALT

You can connect to Slack in scripts via the REST API and link to the examples we have in the [Script Console examples](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=script-console&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud).

## REST Endpoints

The Rest Endpoints feature is not currently available in ScriptRunner for Jira Cloud.

If you need to call external systems to import data into Jira, consider using **[ScriptRunner Connect](https://www.scriptrunnerhq.com/scriptrunner-connect/connectors)**, our powerful integration platform that offers this capability and much more.

Server/DC Feature

Cloud Parity

Parity Notes/Alternatives

[Rest Endpoints](https://docs.adaptavist.com/sr4js/latest/features/rest-endpoints)

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

Unlike Data Center, Jira Cloud does not offer custom endpoints. Instead it uses the Atlassian REST API. However, with ScriptRunner, you can still connect and interact with other systems by calling their external APIs.

## Script Console

The Script Console feature is available in both Data Center and Cloud versions of ScriptRunner. However, there are some [limitations](https://docs.adaptavist.com/sr4jc/latest/get-started/limitations) applied to scripts on Cloud you should be familiar with. 

See our [Example Scripts](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=script-console&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud) for a complete collection of pre-written scripts that can be ran from the the [Script Console](https://docs.adaptavist.com/sr4jc/latest/features/script-console) in ScriptRunner for Jira Cloud.

Server/DC Feature

Cloud Parity

Parity Notes/Alternatives

Cloud Links

[Script Console](https://docs.adaptavist.com/sr4js/latest/features/script-console)

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

Execution limitation:

-   There is a limit of 240 seconds for Cloud script executions. After running for 240 seconds, the logs will be collected, and the code will be terminated.

[Script Console Cloud Documentation](https://docs.adaptavist.com/sr4jc/latest/features/script-console)

[Cloud Script Console Example Scripts](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=script-console&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud)

## Script Editor

The Script Editor feature is available in ScriptRunner for Jira Cloud as the Script Manager.

Server/DC Feature

Cloud Parity

Parity Notes/Alternatives

[Script Editor](https://docs.adaptavist.com/sr4js/latest/features/script-editor)

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

ScriptRunner for Jira Cloud's _[Script Manager](https://docs.adaptavist.com/sr4jc/latest/features/script-manager)_ feature allows you to create and manage saved `.groovy` and `.jel` scripts and folders directly from the ScriptRunner front-end, without relying on FTP services or server administrators. 

Script Manager is available for Groovy and Jira Expression Language code editors **only** and is not available for use with Behaviours.

Coming soon...  
We are working on creating further Script Manager enhancements, including:

-   Data residency support:
    -   Support for realm-to-realm migrations - we recommend **not** using Script Manager if you are planning a realm-to-realm migration before our next iteration of this feature. Keep up to date with our [Release Notes](https://docs.adaptavist.com/sr4jc/latest/release-notes).

## UI Fragments

### Parity summary

This feature is known as [Script Fragments](https://docs.adaptavist.com/sr4jc/latest/features/script-fragments) in ScriptRunner for Jira Cloud; however, **only Web Panels are available.** 

### Parity details

Server/DC Feature

Cloud Parity

Parity Notes/Alternatives

Cloud Links

[Custom web item](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-item)

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

This is not possible in Jira Cloud.

Web Items (buttons, menu items, links) are not supported by the UI Modifications API. You cannot add custom buttons or menu items to Jira's UI through ScriptRunner Cloud.

[Cloud Script Fragments Documentation](https://docs.adaptavist.com/sr4jc/latest/features/script-fragments)

[Show a web panel](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-panel)

**◐**

You can [create web panels](https://docs.adaptavist.com/sr4jc/latest/features/script-fragments#how-to-use-script-fragments) in ScriptRunner for Jira Cloud, however there are limitations, such as:

-   The script source must be specified (and accessible to Jira). Inline script is not available. 

[Create a custom web section](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-section)

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

This is not possible in Jira Cloud.

As Cloud doesn't support web items, it also doesn't support the sections that would contain them.

[Hide system or plugin UI element](https://docs.adaptavist.com/sr4js/latest/features/fragments/hide-ui-element-built-in-script)

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

This is not possible in Jira Cloud.  

[Constrained create issue dialog](https://docs.adaptavist.com/sr4js/latest/features/fragments/create-constrained-issue)

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

This is not possible in Jira Cloud.  

[Planning board context menu item](https://docs.adaptavist.com/sr4js/latest/features/fragments/board-context-menu-item)

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

This is not possible in Jira Cloud.

We cannot add custom menu items to boards, backlogs, or other agile views.

[Install web resource](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-resource)

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

This is not possible in Jira Cloud.

Web Resources (CSS, JavaScript files bundled with plugins) are a P2 framework concept that doesn't exist in Cloud. Cloud apps cannot install global resources into Jira's UI. Script Fragments must reference external URLs for resources instead.

[Custom web item provider](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-item-provider-built-in-script)

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

This is not possible in Jira Cloud.

Web Item Providers (dynamic generation of multiple web items) are not supported since basic web items aren't supported.

[Raw XML module](https://docs.adaptavist.com/sr4js/latest/features/fragments/raw-xml-module-built-in-script)

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

This is not possible in Jira Cloud.

Raw XML modules were used in Server/DC's P2 plugin framework to define plugin modules via atlassian-plugin.xml. Cloud uses the Atlassian Connect framework, which uses JSON descriptors instead. There is no XML-based plugin configuration in Cloud.

## Script Fields

### Parity summary

This feature is known as [Scripted Fields](https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields) in ScriptRunner for Jira Cloud. While built-in scripted fields are available in the Data Center version and not currently in Cloud, there are many script alternatives that can be executed using a [custom scripted field](https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields#create-a-scripted-field). 

See our [Example Scripts](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=script-fields&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud) for a complete collection of pre-written scripts that can be used with Scripted Fields.

### Parity details

Server/DC Feature

Cloud Parity

Parity Notes/Alternatives

Cloud Links

[Custom Script Fields](https://docs.adaptavist.com/sr4js/latest/features/script-fields/custom-script-field)

  
**◐**

The [Custom Scripted Field](https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields) feature is available in ScriptRunner for Jira Cloud.

Additional details:

-   The value of Scripted Fields refreshes on issue view and when an issue containing a Scripted Field is updated.
-   It is not possible to perform a full re-index in Jira Cloud.

The following Scripted Fields template types cannot be migrated and will require a modification:

**Custom template fields**

Typically used to render complex objects (tables, lists, linked issues).

In Cloud, you could achieve the same result using a [Paragraph Scripted Field](https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields/return-types#id-.ReturnTypesvDraft-richtext) returning [Atlassian Document Format (ADF)](https://developer.atlassian.com/cloud/jira/platform/apis/document/structure/). ADF supports tables, paragraphs, links, bold text, and more.

**HTML template fields**

You could migrate it to a [Text Field](https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields/return-types#id-.ReturnTypesvDraft-richtext:~:text=For%20a-,text%20field,-%2C%20the%20script%20must) (for short strings) or a [Paragraph Field](https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields/return-types#id-.ReturnTypesvDraft-richtext) (for longer content). If the script was generating HTML markup, rewrite it to return ADF instead.

**Duration template fields**

Typically returns a number of milliseconds or seconds representing elapsed time.

In Cloud, the best approach is to:

-   Return the duration as a formatted `String` (e.g., `"2h 30m"`) using a Text Field, or
    
-   Return it as a number field (raw seconds/minutes) if you need it to be searchable and/or sortable.
    

[Cloud Scripted Fields Documentation](https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields)

[Cloud Scripted Fields Example Scripts](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=script-fields&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud)

[Custom Picker](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/custom-picker)

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

This is not possible in Jira Cloud.

Jira Cloud's REST API doesn't support creating picker field types through apps.

[Database Picker](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/database-picker)

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

You can connect to databases in scripts and link to the examples we have in the [Script Console examples](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=script-console&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud).

[Date of the first transition](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/date-of-first-transition)

ALT

You can achieve the same result by creating a [Custom Scripted Field](https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields) and using the [Date of the first transition](https://www.scriptrunnerhq.com/help/example-scripts/date-of-the-first-transition-cloud) example script. 

[Issue(s) Picker](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/issue-picker)

ALT

This is not possible in Jira Cloud.

Jira Cloud's REST API doesn't support creating picker field types through apps.

Alternative: Use native Jira Issue Links or display issue references as read-only text/links in Scripted Fields. You could write a script to search for the issue to return and render a link to an issue in a rich text field using Atlassian Document Format.

[LDAP Picker Field](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/ldap-picker)

  
**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

This is not possible in Jira Cloud.

Jira Cloud's REST API doesn't support creating picker field types through apps.

Alternative: If LDAP exposes a REST API, you could display LDAP data in read-only Scripted Fields, but not create an interactive picker.

[No. of times in a status](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/number-of-times-in-status)

ALT

You can achieve the same result by writing your own script in the [Custom Scripted Field](https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields) but with all the caveats of time limitations, API availability, etc. 

You can use the example script outlined below as an alternative:

numberOfTimesInAStatus.groovy...

```
/*
 * This script provides an example of how in Scripted Fields you can configure a field to display a table showing the number of times an issue has been in a set of specified statuses.
 *
 * All right, title and interest in this code snippet shall remain the exclusive intellectual property of Adaptavist Group Ltd and its affiliates. Customers with a valid ScriptRunner 
 * license shall be granted a  non-exclusive, non-transferable, freely revocable right to use this code snippet only within their own instance of Atlassian products. This licensing notice cannot be removed
 * or amended and must be included in any circumstances where the code snippet is shared by You or a third party." 
*/ 

// Define the statuses you want to track
def targetStatuses = ['To Do', 'In Progress']

// Get the issue key from the current issue
def issueKey = issue.key

// Initialize a map to store counts for each status
def statusCounts = [:] as Map<String, Integer>
targetStatuses.each { status ->
    statusCounts[status] = 0
}

// Fetch changelog with pagination support
def startAt = 0
def maxResults = 100
def isLast = false

while (!isLast) {
    def changelogResponse = get("/rest/api/3/issue/${issueKey}/changelog")
        .queryString('startAt', startAt)
        .queryString('maxResults', maxResults)
        .header('Content-Type', 'application/json')
        .asObject(Map)
        .body 
        
    // Get the list of changelog entries
    def changelogs = changelogResponse.values

    // Iterate through each changelog entry
    changelogs.each { Map changelog ->
        def items = changelog.items
        
        // Check each item in the changelog
        items.each { Map item ->
            // Check if this is a status change
            if (item.field == 'status') {
                def newStatus = item.toString()
                
                // Check if the new status is in our target list
                if (statusCounts.containsKey(newStatus)) {
                    statusCounts[newStatus] = statusCounts[newStatus] + 1
                }
            }
        }
    }

    // Check if there are more pages
    isLast = changelogResponse.isLast
    if (!isLast) {
        startAt += maxResults
    }
}

// Build ADF table structure
def tableRows = []

// Add header row
tableRows.add([
    type: 'tableRow',
    content: [
        [
            type: 'tableHeader',
            attrs: [:],
            content: [
                [
                    type: 'paragraph',
                    content: [
                        [
                            type: 'text',
                            text: 'Status'
                        ]
                    ]
                ]
            ]
        ],
        [
            type: 'tableHeader',
            attrs: [:],
            content: [
                [
                    type: 'paragraph',
                    content: [
                        [
                            type: 'text',
                            text: 'Count'
                        ]
                    ]
                ]
            ]
        ]
    ]
])

// Add data rows for each status
statusCounts.each { String status, Integer count ->
    tableRows.add([
        type: 'tableRow',
        content: [
            [
                type: 'tableCell',
                attrs: [:],
                content: [
                    [
                        type: 'paragraph',
                        content: [
                            [
                                type: 'text',
                                text: status
                            ]
                        ]
                    ]
                ]
            ],
            [
                type: 'tableCell',
                attrs: [:],
                content: [
                    [
                        type: 'paragraph',
                        content: [
                            [
                                type: 'text',
                                text: count.toString()
                            ]
                        ]
                    ]
                ]
            ]
        ]
    ])
}

// Build the complete ADF document
def numberOfTimesInStatusTable = [
    version: 1,
    type: 'doc',
    content: [
        [
            type: 'table',
            attrs: [
                isNumberColumnEnabled: false,
                layout: 'default'
            ],
            content: tableRows
        ]
    ]
]


return numberOfTimesInStatusTable
```

  

[Remote issue(s) picker](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/remote-issue-picker)

ALT

You can link to issues in a remote Jira instance using the [Create remote issue link](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-issue-remote-links/#api-rest-api-3-issue-issueidorkey-remotelink-post) API inside a script. We have an example of using this API [here](https://library.adaptavist.com/entity/create-remote-link).

[Show parent issue in a hierarchy](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/show-parent-issue-in-hierarchy)

ALT

You can achieve the same result by writing your own script in the [Custom Scripted Field](https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields) but with all the caveats of time limitations, API availability, etc. 

You can use the example script outlined below as an alternative:

Show parent issue in a hierarchy...

```
// Set your target parent issue type (e.g., "Theme", "Initiative", "Epic")
final String TARGET_ISSUE_TYPE = "Task"

final int MAX_DEPTH = 10

Map findParentOfType(String currentIssueKey, String targetType, int maxDepth, int depth = 0) {
    if (depth >= maxDepth) {
        return null
    }
    
    def issueResp = get("/rest/api/3/issue/${currentIssueKey}")
        .queryString('fields', 'parent,issuetype,summary,key')
        .asObject(Map)
    
    if (issueResp.status != 200) {
        return null
    }
    
    def currentIssue = issueResp.body as Map
    def fields = currentIssue.fields as Map
    
    // Only check the current issue's type if we're not on the first call (depth > 0)
    // This ensures we never return the starting issue, only its parents/ancestors
    if (depth > 0) {
        def issueType = fields.issuetype as Map
        
        if (issueType.name == targetType) {
            return [
                key: currentIssue.key,
                summary: fields.summary
            ]
        }
    }
    
    // Check for parent
    def parent = fields.parent as Map

    if (!parent) {
        return null
    }
    
    // Recurse with the parent's key
    return findParentOfType(parent.key as String, targetType, maxDepth, depth + 1)
}

// Use the current issue from the scripted field binding
def parentIssue = findParentOfType(issue.key as String, TARGET_ISSUE_TYPE, MAX_DEPTH)

if (parentIssue) {
    def parentKey = parentIssue.key
    def parentSummary = parentIssue.summary as String
    
    return [
        version: 1,
        type: "doc",
        content: [
            [
                type: "paragraph",
                content: [
                    [
                        type: "text",
                        text: "${parentKey} - ${parentSummary}",
                        marks: [
                            [
                                type: "link",
                                attrs: [
                                    href: "${baseUrl}/browse/${parentKey}"
                                ]
                            ]
                        ]
                    ]
                ]
            ]
        ]
    ]
} else {
    return [
        version: 1,
        type: "doc",
        content: [
            [
                type: "paragraph",
                content: [
                    [
                        type: "text",
                        text: "No Parent Found"
                    ]
                ]
            ]
        ]
    ]
}
```

  

  

[Time of Last status Change](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/time-of-last-status-change)

ALT

You can achieve the same result by creating a [Custom Scripted Field](https://docs.adaptavist.com/sr4jc/latest/features/scripted-fields) and using the [Time of last status change](https://www.scriptrunnerhq.com/help/example-scripts/time-of-last-status-change-cloud) example script. 

## Settings

Server/DC Feature

Cloud Parity

Parity Notes/Alternatives

[Script Edit Permissions](https://docs.adaptavist.com/sr4js/latest/get-started/settings/system-admin-only-script-edit-permission)  

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

  

[Hapi Code Helper](https://docs.adaptavist.com/sr4js/latest/get-started/settings/hapi-code-helper)  

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

  

[In-App Communications](https://docs.adaptavist.com/sr4js/latest/get-started/settings/in-app-communications)  

**◐**

There is no opt-in for this, but we use in-app banners and popups to communicate information relating to Scriptrunner for Jira Cloud.

[Switch User Function](https://docs.adaptavist.com/sr4js/latest/get-started/settings/switch-user-function)  

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

This is not possible in Jira Cloud.

Apps cannot bypass authentication or run as arbitrary users. Scripts can only execute as:  
\- The add-on user (ScriptRunner's service account)  
\- The initiating user (whoever triggered the script)

This security restriction is fundamental to Cloud's multi-tenant architecture.

Atlassian does not provide the API so this cannot be built in Jira Cloud. However, Jira Cloud organization admins can switch to different users by using the built in feature as [documented by Atlassian](https://support.atlassian.com/user-management/docs/log-in-as-another-user/).

[Anonymous Analytics](https://docs.adaptavist.com/sr4js/latest/get-started/settings/anonymous-analytics)  

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

  

[User Editor Settings](https://docs.adaptavist.com/sr4js/latest/get-started/settings/user-editor-settings)  

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

  

## Workflow Conditions

### Parity summary

ScriptRunner Workflow functions are available in ScriptRunner for Jira Cloud as [Workflow Rules](https://docs.adaptavist.com/sr4jc/current/features/workflow-rules). ScriptRunner Script Conditions are present in Jira Cloud but rely on [Jira expressions](https://developer.atlassian.com/cloud/jira/software/jira-expressions/) rather than Groovy, and it is not possible to use the REST API.

While built-in script conditions aren't directly accessible in ScriptRunner for Jira Cloud, you can replicate their functionality using [ScriptRunner Restrict Transitions](https://docs.adaptavist.com/sr4jc/current/features/workflow-rules/restrict-transitions) with [Jira expressions](https://docs.adaptavist.com/sr4jc/current/features/workflow-rules/example-restrictions-and-validators). 

### Parity details

Server/DC Feature

Cloud Parity

Parity Notes/Alternatives

  

Cloud Links

[All sub-tasks must be resolved](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/all-sub-tasks-resolved-condition)

ALT

You can achieve the same result by creating a [custom script restrict transitions rule](https://docs.adaptavist.com/sr4jc/current/features/workflow-rules/restrict-transitions) and using the [Sub-tasks must be done](https://docs.adaptavist.com/sr4jc/current/features/workflow-rules/example-restrictions-and-validators/#require-sub-tasks) Jira expression example. 

[Cloud Workflow Rules Documentation](https://docs.adaptavist.com/sr4jc/current/features/workflow-rules)

[Cloud Restrict Transitions Documentation](https://docs.adaptavist.com/sr4jc/current/features/workflow-rules/restrict-transitions)

[Jira expressions examples](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/example-restrictions-and-validators)

  

[Checks the issue has been in a status previously](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/checks-if-this-issue-has-been-in-a-status-previously-condition)

ALT

You can achieve the same result by creating a [custom restrict transitions rule](https://docs.adaptavist.com/sr4jc/current/features/workflow-rules/restrict-transitions) and using the [Checks the work item has been in a status previously](https://docs.adaptavist.com/sr4jc/current/features/workflow-rules/example-restrictions-and-validators/#checks-if-the-work-item-has-been-in-a-status-previously) Jira expression example.

[Custom script condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/custom-script-condition)

ALT

The [ScriptRunner Script Restrict Transitions](https://docs.adaptavist.com/sr4jc/current/features/workflow-rules/restrict-transitions/#create-a-restrict-transitions-rule) feature is available in ScriptRunner for Jira Cloud, however this feature relies on [Jira Expressions](https://developer.atlassian.com/cloud/jira/software/jira-expressions/) in Cloud. It does not use Groovy and it is not possible to use the REST API.

Incompatible fields that should be discarded:

-   Test Against - Used for testing scripts when creating or editing validators only, so can be safely discarded.
    

[Field(s) required condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/field-s-required-condition)

ALT

You can achieve the same result by creating a [custom restrict transition rule](https://docs.adaptavist.com/sr4jc/current/features/workflow-rules/restrict-transitions/#create-a-restrict-transition-rule) and using the [Field(s) required](https://docs.adaptavist.com/sr4jc/latest/features/workflow-extensions/jira-expression-examples#fieldsrequired) Jira expression example.

[Group(s) condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/group-s-condition)

ALT

You can achieve the same result by creating a [custom restrict transition rule](https://docs.adaptavist.com/sr4jc/current/features/workflow-rules/restrict-transitions) and using the [Specify the current user must be in a defined list of users](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/example-restrictions-and-validators#id-.ExampleConditionsandValidatorsvCurrent-Specifythecurrentusermustbeinadefinedlistofusersspecifycurrentuserinagroup) Jira expression example.

[JQL query matches condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/jql-query-matches-condition)

**![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)**

This is not possible in Jira Cloud.

Cloud workflow conditions are restricted to the Jira Expression Framework only, which cannot execute arbitrary JQL queries like Data Center's Groovy-based conditions could.

You can achieve similar functionality using custom script conditions with Jira Expressions, but you must work within the expression language's constraints rather than executing full JQL queries.

[Linked issues condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/linked-issues-condition)

ALT

You can achieve the same result by creating a [custom restrict transition rule](https://docs.adaptavist.com/sr4jc/current/features/workflow-rules/restrict-transitions/#create-a-restrict-transition-rule) and using the [Linked work item](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/example-restrictions-and-validators#id-.ExampleConditionsandValidatorsvCurrent-Requireonelinkedworkitem) Jira expression example.

[Project role(s) condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/project-role-s-condition)

ALT

You can achieve the same result by creating a [custom restrict transition rule](https://docs.adaptavist.com/sr4jc/current/features/workflow-rules/restrict-transitions/#create-a-restrict-transition-rule) and using the [Restrict to project role](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/example-restrictions-and-validators#id-.ExampleConditionsandValidatorsvCurrent-Requirespecificusersinaspacecancreateworkofaspecifiedtype) Jira expression example.

[Regular expression condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/regular-expression-condition)

ALT

You can achieve the same result by creating a [custom restrict transition rule](https://docs.adaptavist.com/sr4jc/current/features/workflow-rules/restrict-transitions/#create-a-restrict-transition-rule) and using and/or adapting the [Regular expression](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/example-restrictions-and-validators#id-.ExampleConditionsandValidatorsvCurrent-Regularexpressionsregularexpressions) Jira expression example.

[Simple scripted condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/simple-scripted-condition)

**◐**

The [ScriptRunner Restrict Transition](https://docs.adaptavist.com/sr4jc/current/features/workflow-rules/restrict-transitions/#create-a-restrict-transition-rule) feature is available in ScriptRunner for Jira Cloud, however this feature relies on [Jira Expressions](https://developer.atlassian.com/cloud/jira/software/jira-expressions/) in Cloud. It does not use Groovy and it is not possible to use the REST API.

[User in field(s) condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/user-in-field-s-condition)

ALT

You can achieve the same result by creating a [custom restrict transition rule](https://docs.adaptavist.com/sr4jc/current/features/workflow-rules/restrict-transitions/#create-a-restrict-transition-rule) and using and/or adapting the [User in field(s)](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/example-restrictions-and-validators#id-.ExampleConditionsandValidatorsvCurrent-Userinfield\(s\)userinfield) Jira expression example.

[User(s) condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/conditions/user-s-condition)

ALT

You can achieve the same result by creating a [custom restrict transition rule](https://docs.adaptavist.com/sr4jc/current/features/workflow-rules/restrict-transitions/#create-a-restrict-transition-rule) and using and/or adapting the [User(s) and user group(s)](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/example-restrictions-and-validators#id-.ExampleConditionsandValidatorsvCurrent-User\(s\)andusergroup\(s\)userandusergroup) Jira expression example.

## Workflow Post Functions

### Parity summary

ScriptRunner Workflow functions are available in ScriptRunner for Jira Cloud as [Workflow Rules](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules). ScriptRunner Post Functions are available in Jira Cloud as Perform Actions.

While some built-in script post functions are not currently available in the ScriptRunner for Jira Cloud environment, many of them have script alternatives that can be executed using a [ScriptRunner Script Perform Actions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions).

See our [Example Scripts](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=post-functions&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud) for a complete collection of pre-written scripts that used with Workflow post functions.

### Parity details

Server/DC Feature

Cloud Parity

Parity Notes/Alternatives

Cloud Links

[Add a comment to this issue](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/add-a-comment-to-this-issue)

ALT

You can achieve the same result by creating a [custom perform actions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions) and using and/or adapting the [Add comment to this work item](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions/example-custom-scripts#add-a-comment-to-this-work-item) script.

[Cloud Workflow Rules Documentation](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules)

[Cloud Perform Actions Documentation](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions)

[Cloud Perform Actions Example Scripts](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions/example-custom-scripts)

  

  

[Add/remove from sprint](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/add-remove-from-to-active-sprint)

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

The [Add/remove from sprint](https://docs.adaptavist.com/sr4jc/latest/features/workflow-extensions/post-functions/built-in-post-functions#addremove-tofrom-sprint) built-in post function is available in ScriptRunner for Jira Cloud.

Incompatible fields that should be discarded:

-   Return user to Execute As. In Cloud, users can run as the Add-on or initiating user only and cannot choose a specific user to run the post function.
    

[Adds a comment to linked issues when this issue is transitioned](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/adds-a-comment-to-linked-issues-when-this-issue-is-transitioned)

ALT

You can achieve the same result by using the [Run Script](https://docs.adaptavist.com/sr4jc/latest/features/workflow-extensions/post-functions/built-in-post-functions#run-script) post function and the [Add a comment to linked issues when this issue is transitioned](https://docs.adaptavist.com/sr4jc/latest/features/workflow-extensions//post-functions/example-custom-scripts#addcommenttolinkedissueswhentransitioned) script.

[Adds the current user as a watcher](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/adds-the-current-user-as-a-watcher)

ALT

You can achieve the same result by using the [Run Script](https://docs.adaptavist.com/sr4jc/latest/features/workflow-extensions/post-functions/built-in-post-functions#run-script) post function and the [Add the current user as a watcher](https://docs.adaptavist.com/sr4jc/latest/features/workflow-extensions//post-functions/example-custom-scripts#addcurrentuseraswatcher) script.

[Archive this issue](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/archive-this-issue)

ALT

You can achieve the same result by using the [Run Script](https://docs.adaptavist.com/sr4jc/latest/features/workflow-extensions/post-functions/built-in-post-functions#run-script) post function and writing a script to call the [Archive issue](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-issues/#api-rest-api-3-issue-archive-put) API to achieve this.

To use this API, you need to be on the Premium or Enterprise tiers of Jira Cloud.

[Assign to first member of role](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/assign-to-first-member-of-role)

ALT

The [Assign Issue](https://docs.adaptavist.com/sr4jc/latest/features/workflow-extensions/post-functions/built-in-post-functions#assign-issue) built-in post function is available in ScriptRunner for Jira Cloud.

Incompatible fields that should be discarded:

-   Include Reporter
-   Include Assignee
-   Force Assignee

[Assign to last role member](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/assign-to-last-role-member)

ALT

The [Assign Issue](https://docs.adaptavist.com/sr4jc/latest/features/workflow-extensions/post-functions/built-in-post-functions#assign-issue) built-in post function is available in ScriptRunner for Jira Cloud.

Incompatible fields that should be discarded:

-   Include Reporter
-   Include Assignee
-   Force Assignee

[Clear field(s)](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/clear-field-s)

ALT

You can achieve the same result by using the [Run Script](https://docs.adaptavist.com/sr4jc/latest/features/workflow-extensions/post-functions/built-in-post-functions#run-script) post function and the [Clear field(s)](https://docs.adaptavist.com/sr4jc/latest/features/workflow-extensions//post-functions/example-custom-scripts#clearfieldpostfunction) script.

[Clones an issue, and links](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/clones-an-issue-and-links)

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

The [Clone Issue](https://docs.adaptavist.com/sr4jc/latest/features/workflow-extensions/post-functions/built-in-post-functions#clone-issue) built-in post function is available in ScriptRunner for Jira Cloud.

Incompatible fields that should be discarded:

-   Fields to copy
    
-   Copy Comments
    
-   Copy Subtasks
    
-   As User - In Cloud, users can run as the Add-on or initiating user only and cannot choose a specific user to run the post function.
    

[Copy field values](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/copy-field-values)

ALT

You can achieve the same result by using the [Run Script](https://docs.adaptavist.com/sr4jc/latest/features/workflow-extensions/post-functions/built-in-post-functions#run-script) post function but with all the caveats of time limitations, API availability, etc. Check out our page on [Scripting in ScriptRunner for Jira Cloud](https://docs.adaptavist.com/sr4jc/latest/get-started/scripting-in-scriptrunner-for-jira-cloud) for tips.

In Cloud there is already a [Copy Value From Other Field](https://support.atlassian.com/jira-cloud-administration/docs/configure-advanced-issue-workflows/#Post-functions) post function built in.

[Create a sub-task](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/create-a-sub-task)

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

The [Create Sub-task](https://docs.adaptavist.com/sr4jc/latest/features/workflow-extensions/post-functions/built-in-post-functions#create-sub-task) built-in post function is available in ScriptRunner for Jira Cloud.

Incompatible fields that should be discarded:

-   Fields to copy
    
-   As User - In Cloud, users can run as the Add-on or initiating user only and cannot choose a specific user to run the post function.
    

[Custom script post-function](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/custom-post-functions)

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

The [Run Script](https://docs.adaptavist.com/sr4jc/latest/features/workflow-extensions/post-functions/built-in-post-functions#run-script) post function is available in ScriptRunner for Jira Cloud.

[Fast-track transition an issue](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/fast-track-transition-an-issue)

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

The [Fast-Track Transition Issue](https://docs.adaptavist.com/sr4jc/latest/features/workflow-extensions/post-functions/built-in-post-functions#fast-track-transition-issue) built-in post function is available in ScriptRunner for Jira Cloud.

Incompatible fields that should be discarded:

-   Transition Options
    

[Fires an event when condition is true](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/fires-an-event-when-condition-is-true)

ALT

In Data Center this post function enables you to trigger a specific [Jira event](https://confluence.atlassian.com/adminjiraserver073/adding-a-custom-event-861253643.html) based on a custom condition. Once fired, the event can be picked up by a [notification scheme](https://confluence.atlassian.com/adminjiraserver0820/creating-a-notification-scheme-1095777110.html), determining who gets alerted.

It is not possible to fire a custom event in Cloud therefore this built-in script cannot be directly replicated in ScriptRunner for Jira Cloud. However, you could use the [Send Notification](https://docs.adaptavist.com/sr4jc/latest/features/workflow-extensions/post-functions/built-in-post-functions#send-notification) built-in post function that is available.

[Post a message to Slack](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/post-a-message-to-slack)

ALT

You can achieve the same result by using the [Run Script](https://docs.adaptavist.com/sr4jc/latest/features/workflow-extensions/post-functions/built-in-post-functions#run-script) post function and the [post to Slack](https://docs.adaptavist.com/sr4jc/latest/features/workflow-extensions//post-functions/example-custom-scripts#posttoslack) script.

[Send a custom email](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/send-a-custom-email)

**![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)**

The [Send Notification](https://docs.adaptavist.com/sr4jc/latest/features/workflow-extensions/post-functions/built-in-post-functions#send-notification) built-in post function is available in ScriptRunner for Jira Cloud.

[Set issue security level depending on the provided condition](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/set-issue-security)

ALT

You can achieve the same result by using the [Run Script](https://docs.adaptavist.com/sr4jc/latest/features/workflow-extensions/post-functions/built-in-post-functions#run-script) post function and writing a script that, if the condition matches, calls the [Edit Issue](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-issues/#api-rest-api-3-issue-issueidorkey-put) API and updates the issue to set the **security** field on an issue. You could use and adapt the [Set Issue Security Level](https://bitbucket.org/Adaptavist/workspace/snippets/97EobE) script example.

[Transition parent when all subtasks are resolved](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/transition-parent-when-all-sub-tasks-are-resolved)

**◐**

The [Transition Parent Issue](https://docs.adaptavist.com/sr4jc/latest/features/workflow-extensions/post-functions/built-in-post-functions#transition-parent-issue) built-in post function is available in ScriptRunner for Jira Cloud.

## Workflow Validators

### Parity summary

ScriptRunner Workflow functions are available in ScriptRunner for Jira Cloud as [Workflow Rules](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules). ScriptRunner for Server/Data Center Validators are present in Jira Cloud as Validate Details, but rely on [Jira expressions](https://developer.atlassian.com/cloud/jira/software/jira-expressions/) rather than Groovy, and it is not possible to use the REST API.

While built-in validators aren't directly accessible in ScriptRunner for Jira Cloud, you can replicate their functionality using [Validate Details](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/validate-details) with [Jira expressions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-extensions/jira-expression-examples). 

### Parity details

Server/DC Feature

Cloud Parity

Parity Notes/Alternatives

  

Cloud Links

[Custom script validator](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/custom-validators)

ALT

The [Validate Details](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/validate-details) feature is available in ScriptRunner for Jira Cloud, however this feature relies on [Jira Expressions](https://developer.atlassian.com/cloud/jira/software/jira-expressions/) in Cloud. It does not use Groovy and it is not possible to use the REST API.

Incompatible fields that should be discarded:

-   Test Against - Used for testing scripts when creating or editing validators only, so can be safely discarded.
    

[Cloud Workflow Rules Documentation](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules)

[Cloud Validate Details Documentation](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/validate-details)

[Jira expressions examples](https://docs.adaptavist.com/sr4jc/latest/features/workflow-extensions/jira-expression-examples)

  

[Field(s) changed validator](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/field-s-changed-validator)

ALT

You can achieve the same result by creating a [custom validate details](<http://Validate Details>) and using the [Field(s) changed](https://docs.adaptavist.com/sr4jc/latest/features/workflow-extensions/jira-expression-examples#fieldschanged) Jira expression example. 

[Field(s) required validator](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/field-s-required-validator)

ALT

You can achieve the same result by creating a [custom validate details](<http://Validate Details>) and using the [Field(s) required](https://docs.adaptavist.com/sr4jc/latest/features/workflow-extensions/jira-expression-examples#fieldsrequired) Jira expression example. 

[Regular expression validator](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/regular-expression-validator)

ALT

You can achieve the same result by creating a [custom validate details](<http://Validate Details>) and [Regular expressions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-extensions/jira-expression-examples#regularexpressions).

[Require a comment on transition](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/require-a-comment-on-transition)

ALT

You can achieve the same result by creating a [custom validate details](<http://Validate Details>) and using the [Require a comment on transition](https://docs.adaptavist.com/sr4jc/latest/features/workflow-extensions/jira-expression-examples#requirecommentontransition) Jira expression example. 

[Simple scripted validator](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/simple-scripted-validators)

**◐**

The [Validate Details](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/validate-details) feature is available in ScriptRunner for Jira Cloud, however this feature relies on [Jira Expressions](https://developer.atlassian.com/cloud/jira/software/jira-expressions/) in Cloud. It does not use Groovy and it is not possible to use the REST API.

[User in field(s) validator](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/user-in-field-s-validator)

ALT

You can achieve the same result by creating a [custom validate details](<http://Validate Details>) and using the [User in field(s)](https://docs.adaptavist.com/sr4jc/latest/features/workflow-extensions/jira-expression-examples#userinfield) Jira expression example.
