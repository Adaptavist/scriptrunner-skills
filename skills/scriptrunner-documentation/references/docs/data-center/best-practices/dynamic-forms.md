# Dynamic Forms

- Platform: data-center
- Space: SR4JS
- Hierarchy: Best Practices
- Doc ID: doc-sr4js-97c58f41-fc36-44fd-9609-9cbc4a62d7d2-dfa506b5d26db5a1
- Source: https://docs.adaptavist.com/sr4js/latest/best-practices/dynamic-forms

Use the Dynamic Forms feature to simplify the process of adding variables to your ScriptRunner Groovy scripts.

With Dynamic Forms, you can annotate your variables in a script so they appear as selectable form fields. You can then save that script as a file to be shared with multiple users, allowing one script to be used for various use cases.

## Why is the Dynamic Forms feature useful?

Inline scripts are often copied and pasted, with minor changes made for different use cases, which requires maintenance for each script usage. Using Dynamic Forms, you can create flexible scripts with annotated variables that can be stored as files, reducing maintenance requirements while allowing for script customization. Additionally, these annotations allow variable values within a script to be changed easily by those with limited code familiarity.

## Where can you use the Dynamic Forms feature?

Dynamic Forms are everywhere! You can use them on Listeners, Jobs, and just about everywhere you can write code.

## Available dynamic form field types

The following dynamic form field types are available:

| Name | Description | Target Type |
| --- | --- | --- |
| [User picker](https://docs.adaptavist.com/sr4js/latest/best-practices/dynamic-forms#user-picker--en) | Field allowing user selection. | [com.atlassian.jira.user.ApplicationUser](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/user/ApplicationUser.html) |
| [Field picker](https://docs.adaptavist.com/sr4js/latest/best-practices/dynamic-forms#field-picker--en) | Field to select any system or custom field. | [com.atlassian.jira.issue.fields.Field](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/issue/fields/Field.html) |
| [Short text](https://docs.adaptavist.com/sr4js/latest/best-practices/dynamic-forms#short-text--en) | Field allowing a short text input. | String |
| [Number](https://docs.adaptavist.com/sr4js/latest/best-practices/dynamic-forms#number--en) | Field allowing an integer | Integer |
| [Select list](https://docs.adaptavist.com/sr4js/latest/best-practices/dynamic-forms#select-list--en) | Single-select and multi-select list field.<br>Tip: Custom Select List<br>If you cannot find an annotation that is suitable for your purpose, you can use [`optionsGenerator`](https://docs.adaptavist.com/sr4js/latest/best-practices/dynamic-forms#select-list--en__section-4207) within the select list annotation to customize your own list options. | String |
| [Checkbox](https://docs.adaptavist.com/sr4js/latest/best-practices/dynamic-forms#checkbox--en) | A checkbox field. | Boolean |
| [Project picker](https://docs.adaptavist.com/sr4js/latest/best-practices/dynamic-forms#project-picker--en) | Field allowing project selection. | [com.atlassian.jira.project.Project](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/project/Project.html) |
| [Priority picker](https://docs.adaptavist.com/sr4js/latest/best-practices/dynamic-forms#priority-picker--en) | Field allowing priority selection. | [com.atlassian.jira.issue.priority.Priority](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/issue/priority/Priority.html?_ga=2.53893480.1738914183.1601888386-1438301721.1571233418) |
| [Issue type picker](https://docs.adaptavist.com/sr4js/latest/best-practices/dynamic-forms#issue-type-picker--en) | Field allowing issue type selection. | [com.atlassian.jira.issue.issuetype.IssueType](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/issue/issuetype/IssueType.html?_ga=2.79982807.1738914183.1601888386-1438301721.1571233418) |
| [Issue link type picker](https://docs.adaptavist.com/sr4js/latest/best-practices/dynamic-forms#issue-link-type-picker--en) | Field allowing issue link type selection. | [com.atlassian.jira.issue.link.IssueLinkType](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/issue/link/IssueLinkType.html?_ga=2.79982807.1738914183.1601888386-1438301721.1571233418) |
| [Project role picker](https://docs.adaptavist.com/sr4js/latest/best-practices/dynamic-forms#project-role-picker--en) | Field allowing project role selection. | [com.atlassian.jira.security.roles.ProjectRole](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/security/roles/ProjectRole.html?_ga=2.79982807.1738914183.1601888386-1438301721.1571233418) |
| [Group picker](https://docs.adaptavist.com/sr4js/latest/best-practices/dynamic-forms#group-picker--en) | Field allowing group selection. | [com.atlassian.crowd.embedded.api.Group](https://docs.atlassian.com/atlassian-crowd/latest/index.html?com/atlassian/crowd/embedded/api/Group.html&_ga=2.79982807.1738914183.1601888386-1438301721.1571233418) |
| [Saved filter picker](https://docs.adaptavist.com/sr4js/latest/best-practices/dynamic-forms#saved-filter-picker--en) | Field allowing saved filter selection. | [com.atlassian.jira.issue.search.SearchRequest](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/issue/search/SearchRequest.html?_ga=2.79982807.1738914183.1601888386-1438301721.1571233418) |
| [Issue status picker](https://docs.adaptavist.com/sr4js/latest/best-practices/dynamic-forms#issue-status-picker--en) | Field allowing status selection. | [com.atlassian.jira.issue.status.Status](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/issue/status/Status.html?_ga=2.79982807.1738914183.1601888386-1438301721.1571233418) |
| [Custom field picker](https://docs.adaptavist.com/sr4js/latest/best-practices/dynamic-forms#custom-field-picker--en) | Field allowing custom field selection. | [com.atlassian.jira.issue.fields.CustomField](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/issue/fields/CustomField.html) |
| [Resolution picker](https://docs.adaptavist.com/sr4js/latest/best-practices/dynamic-forms#resolution-picker--en) | Field allowing resolution selection. | [com.atlassian.jira.issue.resolution.Resolution](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/issue/resolution/Resolution.html) |
| [Version picker](https://docs.adaptavist.com/sr4js/latest/best-practices/dynamic-forms#version-picker--en) | Field allowing version selection. | [com.atlassian.jira.project.version.Version](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/project/version/Version.html) |
| [Component picker](https://docs.adaptavist.com/sr4js/latest/best-practices/dynamic-forms#component-picker--en) | Field allowing component selection. | [com.atlassian.jira.project.component.ProjectComponent](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/bc/project/component/ProjectComponent.html) |
| [Permission scheme picker](https://docs.adaptavist.com/sr4js/latest/best-practices/dynamic-forms#permission-scheme-picker--en) | Field allowing scheme selection. | [com.atlassian.jira.scheme.Scheme](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/scheme/Scheme.html) |
| [Workflow scheme picker](https://docs.adaptavist.com/sr4js/latest/best-practices/dynamic-forms#workflow-scheme-picker--en) | Field allowing workflow scheme selection. | [com.atlassian.jira.scheme.Scheme](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/scheme/Scheme.html) |

Note: Don't see a field you want? Contact [Adaptavist Support](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/21) to raise a feature request.

## Creating a dynamic form

While the Dynamic Forms feature can be used however you find most useful, there are three main steps in creating a dynamic form that can be used across multiple features by multiple users:

1.  Create the dynamic form in the Script Console to make sure it works as expected.
2.  Save the dynamic form as a file.
3.  Use the saved file in a Job, Listener or other ScriptRunner feature.

The above steps are detailed in the tasks that follow.

Note: For the examples below we use a script that allows you to delete issues within a project with a specific assignee. In this example the User field is annotated to create the Assignee form field.

## Create a dynamic form

1.  Navigate to ScriptRunner.
2.  Select Console.
3.  Write your new script, annotating the variables you want to display as form fields above the script. In this example we're using the following script:
    
    ```
    import com.atlassian.jira.user.ApplicationUser
    import com.onresolve.scriptrunner.parameters.annotation.UserPicker
    
    @UserPicker(label = "Assignee", description = "Issues with this assignee will be permanently deleted")
    ApplicationUser user
    
    // issues returned from that JQL will get deleted
    final String searchQuery = "assignee = $user.name"
    Issues.search(searchQuery).each { issue ->
        issue.delete()
    }
    ```
    
      
    
      
    
    Tip: Use the [Annotations](https://docs.adaptavist.com/sr4js/latest/best-practices/dynamic-forms#dynamic_forms__dynamic_forms_annotations--en) and the [Dynamic Form Examples](https://docs.adaptavist.com/sr4js/latest/best-practices/dynamic-forms/dynamic-forms-examples) provided to help construct your own annotated script.
    

## Save the dynamic form as a file

1.  Copy the script you created in the Script Console.
2.  Go to the Script Editor to open your Scripts Root folder.
3.  Select the folder in which you want to save the script, and select the Create New File icon.
4.  Enter a file name in the Add Groovy File window.
    
    In this example, we use the name `Delete_issues_based_on_user`.
    
5.  Select Add.
    
      
    
      
    
6.  Paste your inline script into the file, and click Save.
    
    This script is now available as a file and can be shared with multiple Jira users on the same instance.  
    
      
    

## Use the dynamic form file elsewhere

1.  Navigate to the feature where you want to use the dynamic form.
2.  Enter the relevant details into the feature.
3.  Select File when you enter an inline script.
4.  Select the dynamic form file you wish to use.
    
      
    
      
    
    The form field/s automatically display. In the example image above, the Assignee form field displays.
    

## Transforming an existing inline script into a dynamic form

To enable sharing of annotated scripts, all inline scripts must be saved as files.

1.  Navigate to your existing inline script, and add in required annotations.
    
    Note: We recommend you edit the inline script in the Script Console. That way you have full visibility of the form fields.
    
2.  Copy the script.
3.  Go to the [Script Editor](https://docs.adaptavist.com/sr4js/latest/features/script-editor) to open your _Scripts Root_ folder.
4.  Select the folder in which you want to save the script, and click the Create New File icon.
5.  Enter a file name in the _Add Groovy File_ window.
6.  Select Add.
7.  Paste your inline script into the file, and select Save.
    
    This script is now available as a file and can be shared with multiple Jira users on the same instance.
    

## Using HTML to format descriptions

You can use HTML to modify the appearance of descriptions when you create a dynamic form. For example, if we take the Create a dynamic form example above and add HTML to the description:

```
import com.atlassian.jira.user.ApplicationUser
import com.onresolve.scriptrunner.parameters.annotation.UserPicker

@UserPicker(label = "Assignee", description = "<h3><b>Big: Issues with this assignee</b></h3>Small: will be permanently deleted")
ApplicationUser user

// issues returned from that JQL will get deleted
final String searchQuery = "assignee = $user.name"
Issues.search(searchQuery).each { issue ->
    issue.delete()
}
```

The HTML changes the appearance as follows:

## Annotations

### User picker

Add a user picker field into your script.

```
import com.atlassian.jira.user.ApplicationUser
import com.onresolve.scriptrunner.parameters.annotation.*
        
@UserPicker(label = "User", description = "Select a user")
ApplicationUser user
```

User multi-pickers are also supported.

```
import com.atlassian.jira.user.ApplicationUser
import com.onresolve.scriptrunner.parameters.annotation.*
        
@UserPicker(label = "Users", description = "Select users", multiple = true)
List<ApplicationUser> users
```

### Field picker

Add a field picker into your script. The field picker lets you pick from any fields (system or custom).

```
import com.atlassian.jira.issue.fields.Field
import com.onresolve.scriptrunner.parameters.annotation.*
        
@FieldPicker(label = "Field", description = "Select a field")
Field field
```

Field multi-pickers are also supported.

```
 import com.atlassian.jira.issue.fields.Field
import com.onresolve.scriptrunner.parameters.annotation.*
        
@FieldPicker(label = "Fields", description = "Select fields", multiple = true)
List<Field> fields
```

### Short text

Add a short text field to a script.

```
import com.onresolve.scriptrunner.parameters.annotation.*

@ShortTextInput(label = "Summary", description = "Enter a short issue summary")
String issueSummaryTextInput
```

### Number

Add a number field to a script.

```
import com.onresolve.scriptrunner.parameters.annotation.NumberInput
        
@NumberInput(label = 'Number of Approvals', description = 'How many approvals should be required')
Integer requiredApprovals
```

### Select list

Add a single-select list with configurable options.

```
import com.onresolve.scriptrunner.parameters.annotation.Select
import com.onresolve.scriptrunner.parameters.annotation.meta.Option

@Select(
    label = "Color",
    description = "Select color",
    placeholder = 'Just pick any color',
    options = [
        @Option(label = "Green", value = "green"),
        @Option(label = "Blue", value = "blue"),
    ]
)

String value
```

Multi-select lists are also supported.

```
import com.onresolve.scriptrunner.parameters.annotation.Select
import com.onresolve.scriptrunner.parameters.annotation.meta.Option

@Select(
    label = "Colors",
    description = "Select colors",
    options = [
        @Option(label = "Green", value = "green"),
        @Option(label = "Blue", value = "blue"),
        @Option(label = "Red", value = "red"),
    ],
    multiple = true
)

List<String> values
```

#### Using optionsGenerator in a select list

If you cannot find an annotation that is suitable for your purpose, you can provide an `optionsGenerator` closure when using `@Select` to generate a list of custom options. For example:

```
import com.onresolve.scriptrunner.parameters.annotation.Select

@Select(
    label = "Color",
    description = "Select color",
    optionsGenerator = {
        [
            ['yellow', 'Yellow'],
            ['red', 'Red'],
        ]
    }
)

String value
```

CAUTION: You must return a _List of Lists_ containing exactly two String elements:

-   The first element must be the option value (that is, what is injected into your variable).
-   The second element must be the display value.

The closure code must be completely self-contained, apart from `import` declarations. Therefore, you cannot use variables or methods declared outside the closure.

We recommend you keep the contents of these closures short and simple.

The following is a Jira example, using `optionsGenerator` that lists all projects in a specific project category:

```
import com.atlassian.jira.component.ComponentAccessor
import com.onresolve.scriptrunner.parameters.annotation.Select

@Select(
    label = "Project",
    description = "Select the Space project",
    optionsGenerator = {
        def projectManager = ComponentAccessor.projectManager
        def category = projectManager.getProjectCategoryObjectByName('Space Projects')
        projectManager.getProjectObjectsFromProjectCategory(category.id).collect { project ->
            [project.key, project.name]
        }
    }
)

String value
```

### Checkbox

Add a checkbox to a script.

```
import com.onresolve.scriptrunner.parameters.annotation.*
        
@Checkbox(label = "Clone project", description = "Select the checkbox to clone project")
Boolean projectShouldBeCloned
```

### Project picker

Add a project picker to a script.

```
import com.atlassian.jira.project.Project
import com.onresolve.scriptrunner.parameters.annotation.ProjectPicker
        
@ProjectPicker(
	label = 'Project', description = 'Pick a project', placeholder = 'Pick a project', includeArchived = false
)
Project project
```

Project multi-pickers are also supported.

```
 import com.atlassian.jira.project.Project
import com.onresolve.scriptrunner.parameters.annotation.ProjectPicker
        
@ProjectPicker(
	label = 'Projects', description = 'Pick projects', placeholder = 'Pick projects', includeArchived = false,
            multiple = true
)
List<Project> projects
```

### Priority picker

Add a priority picker to a script.

```
import com.atlassian.jira.issue.priority.Priority
import com.onresolve.scriptrunner.parameters.annotation.PriorityPicker
            
@PriorityPicker(label = 'Priority', description = 'Pick a priority', placeholder = 'Pick a priority')
Priority priority
```

Priority multi-pickers are also supported.

```
import com.atlassian.jira.issue.priority.Priority
import com.onresolve.scriptrunner.parameters.annotation.PriorityPicker
            
@PriorityPicker(
	label = 'Priorities', description = 'Pick priorities', placeholder = 'Pick priorities', multiple = true
)
List<Priority> priorities
```

### Issue type picker

Add an issue type picker to a script.

```
import com.atlassian.jira.issue.issuetype.IssueType
import com.onresolve.scriptrunner.parameters.annotation.IssueTypePicker
        
@IssueTypePicker(label = 'Issue type', description = 'Pick an issue type', placeholder = 'Select issue type')
IssueType issueType
```

Issue type multi-pickers are also supported.

```
import com.atlassian.jira.issue.issuetype.IssueType
import com.onresolve.scriptrunner.parameters.annotation.IssueTypePicker
        
@IssueTypePicker(
	label = 'Issue type', description = 'Pick issue types', placeholder = 'Select issue types',
	multiple = true
)
List<IssueType> issueTypes
```

### Issue link type picker

Add an issue link type picker to a script.

```
import com.atlassian.jira.issue.link.IssueLinkType
import com.onresolve.scriptrunner.parameters.annotation.IssueLinkTypePicker
        
@IssueLinkTypePicker(label = 'Issue link type', description = 'Pick an issue link type', placeholder = 'Pick an issue link type')
IssueLinkType issueLinkType
```

Issue link type multi-pickers are also supported.

```
import com.atlassian.jira.issue.link.IssueLinkType
import com.onresolve.scriptrunner.parameters.annotation.IssueLinkTypePicker
        
@IssueLinkTypePicker(
	label = 'Issue link types', description = 'Pick issue link types', placeholder = 'Pick issue link types',
	multiple = true
)
List<IssueLinkType> issueLinkTypes
```

### Project role picker

Add a project role picker to a script.

```
import com.atlassian.jira.security.roles.ProjectRole
import com.onresolve.scriptrunner.parameters.annotation.ProjectRolePicker
        
@ProjectRolePicker(label = 'Project role', description = 'Project role picker')
ProjectRole projectRole
```

Project role multi pickers are also supported.

```
import com.atlassian.jira.security.roles.ProjectRole
import com.onresolve.scriptrunner.parameters.annotation.ProjectRolePicker
        
@ProjectRolePicker(label = 'Project roles', description = 'Project role picker', multiple = true)
List<ProjectRole> projectRoles
```

### Group picker

Add a group Picker to a script.

```
import com.atlassian.crowd.embedded.api.Group
import com.onresolve.scriptrunner.parameters.annotation.GroupPicker
            
@GroupPicker(label = 'Group', description = 'Pick a group', placeholder = 'Pick a group')
Group group
```

Group multi-pickers are also supported.

```
import com.atlassian.crowd.embedded.api.Group
import com.onresolve.scriptrunner.parameters.annotation.GroupPicker
            
@GroupPicker(label = 'Groups', description = 'Pick groups', placeholder = 'Pick groups', multiple = true)
List<Group> groups
```

### Saved filter picker

Add a saved filter to a script.

```
import com.atlassian.jira.issue.search.SearchRequest
import com.onresolve.scriptrunner.parameters.annotation.SavedFilterPicker
        
@SavedFilterPicker(label = "Saved Filter", description = "Pick a saved filter", placeholder = "Pick a saved filter")
SearchRequest searchRequest
```

Saved filter multi-pickers are also supported.

```
import com.atlassian.jira.issue.search.SearchRequest
import com.onresolve.scriptrunner.parameters.annotation.SavedFilterPicker
        
@SavedFilterPicker(
	label = "Saved Filters", description = "Pick saved filters", placeholder = "Pick saved filters",
	multiple = true
)
List<SearchRequest> searchRequests
```

### Issue status picker

Add a status to a script.

```
import com.atlassian.jira.issue.status.Status
import com.onresolve.scriptrunner.parameters.annotation.IssueStatusPicker
        
@IssueStatusPicker(label = 'Status', description = 'Pick a status', placeholder = 'Pick a status')
Status status
```

Issue status multi pickers are also supported.

```
import com.atlassian.jira.issue.status.Status
import com.onresolve.scriptrunner.parameters.annotation.IssueStatusPicker
        
@IssueStatusPicker(
	label = 'Statuses', description = 'Pick statuses', placeholder = 'Pick statuses', multiple = true
)
List<Status> statuses
```

### Custom field picker

Add a custom field picker to a script.

```
import com.atlassian.jira.issue.fields.CustomField
import com.onresolve.scriptrunner.parameters.annotation.CustomFieldPicker
        
@CustomFieldPicker(label = 'Custom Field', description = 'Pick a custom field', placeholder='Select custom field')
CustomField customField
```

Custom field multi-pickers are also supported.

```
import com.atlassian.jira.issue.fields.CustomField
import com.onresolve.scriptrunner.parameters.annotation.CustomFieldPicker
        
@CustomFieldPicker(
	label = 'Custom Fields', description = 'Pick custom fields', placeholder='Select custom fields',
	multiple = true
)
List<CustomField> customFields
```

### Resolution picker

Add a resolution to a script.

```
import com.atlassian.jira.issue.resolution.Resolution
import com.onresolve.scriptrunner.parameters.annotation.ResolutionPicker
            
@ResolutionPicker(label = 'Resolution', description = 'Pick a resolution', placeholder = 'Pick a resolution')
Resolution resolution
```

Resolution multi-pickers are also supported.

```
import com.atlassian.jira.issue.resolution.Resolution
import com.onresolve.scriptrunner.parameters.annotation.ResolutionPicker
            
@ResolutionPicker(
	label = 'Resolutions', description = 'Pick resolutions', placeholder = 'Pick resolutions',
	multiple = true
)
List<Resolution> resolutions
```

### Version picker

Add a version to a script.

```
import com.atlassian.jira.project.version.Version
import com.onresolve.scriptrunner.parameters.annotation.VersionPicker
        
@VersionPicker(
	label = 'Version', description = 'Pick a version', 
	projectPlaceholder = 'Pick a project', placeholder = 'Pick a version'
)
Version version
```

Version multi-pickers are also supported.

```
import com.atlassian.jira.project.version.Version
import com.onresolve.scriptrunner.parameters.annotation.VersionPicker
        
@VersionPicker(
	label = 'Versions', description = 'Pick versions', 
	projectPlaceholder = 'Pick a project', placeholder = 'Pick versions', multiple = true
)
List<Version> versions
```

### Component picker

Add a component to a script.

```
import com.atlassian.jira.bc.project.component.ProjectComponent
import com.onresolve.scriptrunner.parameters.annotation.ComponentPicker
        
@ComponentPicker(
	label = 'Component', description = 'Pick a component', 
	projectPlaceholder = 'Pick a project', placeholder = 'Pick a component'
)
ProjectComponent component
```

Component multi-pickers are also supported.

```
import com.atlassian.jira.bc.project.component.ProjectComponent
import com.onresolve.scriptrunner.parameters.annotation.ComponentPicker
        
@ComponentPicker(
	label = 'Components', description = 'Pick components', 
	projectPlaceholder = 'Pick a project', placeholder = 'Pick components', multiple = true
)
List<ProjectComponent> components
```

### Permission scheme picker

Add a permission scheme to a script.

```
import com.onresolve.scriptrunner.parameters.annotation.PermissionSchemePicker
import com.atlassian.jira.scheme.Scheme
        
@PermissionSchemePicker(label = 'Permission scheme', description = 'Pick a permission scheme', multiple = false)
Scheme scheme
```

Permission scheme multi-pickers are also supported.

```
import com.onresolve.scriptrunner.parameters.annotation.PermissionSchemePicker
import com.atlassian.jira.scheme.Scheme
        
@PermissionSchemePicker(label = 'Permission schemes', description = 'Pick permission schemes', multiple = true)
List<Scheme> schemes
```

### Workflow scheme picker

Add a workflow scheme to a script.

```
import com.onresolve.scriptrunner.parameters.annotation.WorkflowSchemePicker
import com.atlassian.jira.scheme.Scheme
        
@WorkflowSchemePicker(label = 'Workflow scheme', description = 'Pick a workflow scheme', multiple = false)
Scheme scheme
```

Workflow scheme multi-pickers are also supported.

```
import com.onresolve.scriptrunner.parameters.annotation.WorkflowSchemePicker
import com.atlassian.jira.scheme.Scheme
        
@WorkflowSchemePicker(label = 'Workflow schemes', description = 'Pick workflow schemes', multiple = true)
List<Scheme> schemes
```

## Related content

-   [Dynamic Forms Examples](https://docs.adaptavist.com/sr4js/latest/best-practices/dynamic-forms/dynamic-forms-examples)
-   [Write Code](write-code.md)
-   [HAPI](../uncategorized/h/hapi.md)
