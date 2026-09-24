# Dynamic Forms

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Best Practices and App Management
- Doc ID: doc-sr4c-d731a48e-a225-4ce6-a23d-1ee83d7fac14-8d64cc372e64511b
- Source: https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management#dynamic-forms--en

Use the Dynamic Forms feature to simplify the process of adding variables to your ScriptRunner Groovy scripts

With Dynamic Forms, you can annotate your variables in a script so they appear as selectable form fields. You can then save that script as a file to be shared with multiple users, allowing one script to be used for various use cases.

## Why is the Dynamic Forms feature useful?

Inline scripts are often copied and pasted, with minor changes made for different use cases, which requires maintenance for each script usage. Using Dynamic Forms, you can create flexible scripts with annotated variables that can be stored as files, reducing maintenance requirements while allowing for script customization. Additionally, these annotations allow variable values within a script to be changed easily by those with limited code familiarity.

## Where can you use the Dynamic Forms feature?

Dynamic Forms are everywhere! You can use them on [Jobs](https://docs.adaptavist.com/sr4c/latest/features/jobs), [Listeners](https://docs.adaptavist.com/sr4c/latest/features/event-listeners), [Fragments](https://docs.adaptavist.com/sr4c/latest/features/fragments), and just about everywhere you can write code.

## Available dynamic form field types

The following dynamic form field types are available:

| Name | Description | Target Type |
| --- | --- | --- |
| Short text | Field allowing a short text input | String |
| Number | Feud allowing an integer | Integer |
| Select list | Single-select list field<br>Custom select list<br>Tip: Custom select list<br>If you cannot find an annotation that is suitable for your purpose, you can use [`optionsGenerator`](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/dynamic-forms#select-list--en__section-13400) within the select list annotation to customize your own list options. | String |
| Checkbox | A checkbox field | Boolean |
| Space picker | Field allowing space selection | com.atlassian.confluence.spaces.Space |
| User picker | Field allowing user selection | com.atlassian.confluence.User |

Note: Interested in more dynamic forms types? Raise a support request [here](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/13).

## Creating a dynamic form

There are three main steps in creating a dynamic form that can be used across multiple features by multiple users:

The steps below describe how we expect most users to use the Dynamic Forms feature. This feature can be used in whatever way you find most useful.

1.  Create the dynamic form in the Script Console to make sure it works as expected.
2.  Save the dynamic form as a file.
3.  Use the saved file in a Job, Listener or other ScriptRunner feature.

The above steps are detailed below.

Note: For the examples below we use a script that allows you to delete pages within a space by a specific author. In this example, the dynamic form annotation shows the _query_ variable as a form field.

This is useful because instead of hardcoding the _query_ variable, you can use the dynamic form annotation, meaning the query can be changed without needing to re-write the script.

1.  Create a dynamic form
    
    1.  Navigate to ScriptRunner.
    2.  Select Console.
    3.  Write your new script, annotating the variables you want to display as form fields above the script. In this example we're using the following script: 
        
        ```
        import com.atlassian.confluence.api.model.Expansion
        import com.atlassian.confluence.api.model.content.Content
        import com.atlassian.confluence.api.model.pagination.PageResponse
        import com.atlassian.confluence.api.model.pagination.SimplePageRequest
        import com.atlassian.confluence.api.model.search.SearchContext
        import com.atlassian.confluence.api.service.search.CQLSearchService
        import com.atlassian.confluence.core.DefaultDeleteContext
        import com.atlassian.confluence.pages.PageManager
        import com.onresolve.scriptrunner.parameters.annotation.ShortTextInput
        import com.onresolve.scriptrunner.runner.customisers.PluginModule
         
        @ShortTextInput(label = "CQL", description = "CQL query to determine which pages to delete")
        String cqlQuery
         
        @PluginModule
        PageManager pageManager
         
        @PluginModule
        CQLSearchService cqlSearchService
         
        def maxResults = 100
        def pageRequest = new SimplePageRequest(0, maxResults)
        def searchResult = cqlSearchService.searchContent(cqlQuery, SearchContext.builder().build(), pageRequest, Expansion.combine("space")) as PageResponse<Content>
         
        searchResult.results.collect { result ->
         def page = pageManager.getPage(result.space.key, result.title)
         if (page) {
                pageManager.trashPage(page, DefaultDeleteContext.SUPPRESS_NOTIFICATIONS)
         return result.title
            }
        }
        ```
        
        Tip: Use the [Annotations](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/dynamic-forms#dynamic_forms__dynamic_forms_annotations--en) provided to help construct your own annotated script.
        
    
2.  Save the dynamic form as a file
    1.  Copy the script You created in the _Script Console_.
    2.  Go to the Script Editor to open your _Scripts Root_ folder.
    3.  Select the folder in which you want to save the script, and select the Create New File icon.
    4.  Enter a file name in the Add Groovy File window. In this example we use the name `Delete_pages_by_user`.
    5.  Select Add.
    6.  Paste your inline script into the file, and click Save. This script is now available as a file and can be shared with multiple Jira users on the same instance.
3.  Use the dynamic form file elsewhere
    1.  Navigate to the feature where you want to use the dynmaic form.
    2.  Enter the relevant details into the feature.
    3.  Select File when going to enter an Inline script.
    4.  Select the dynamic form file you wish to use.
    5.  The form field/s automatically display.

## Transforming an existing inline script into a dynamic form

To enable sharing of annotated scripts, all inline scripts must be saved as files.

1.  Navigate to your existing inline script, and add in required annotations (below).
2.  Copy the script.
3.  Use the _[Script Editor](https://docs.adaptavist.com/sr4c/latest/features/script-editor)_ to open your _Scripts Root_ folder.
4.  Select the folder in which you want to save the script, and click the Create New File icon.
5.  Enter a file name in the _Add Groovy File_ window.
6.  Select Add.
7.  Paste your inline script into the file, and click Save
    
    This script is now available as a file and can be shared with multiple Confluence users on the same instance.
    

## Annotations

### Short text

#### Add a short text field to a script

```
import com.onresolve.scriptrunner.parameters.annotation.* 
 
@ShortTextInput(label = "Page name", description = "Enter a name for your page") 
String pageNameTextInput
```

### Number

#### Add a number field to a script

```
import com.onresolve.scriptrunner.parameters.annotation.NumberInput 
 
@NumberInput(label = "Number of child pages", description = "How many child pages to create") Integer numberOfChildPages
```

### Select list

Add a single-select list with configurable options

```
import com.onresolve.scriptrunner.parameters.annotation.*
import com.onresolve.scriptrunner.parameters.annotation.meta.*
 
@Select(
    label = "Color",
    description = "Select color",
    options = [
        @Option(label = "Green", value = "green"),
        @Option(label = "Blue", value = "blue"),
    ]
)
String value
```

#### Using `optionsGenerator` in a select list

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

The following is a Jira example, using `optionsGenerator`, that lists all projects in a specific project category:

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

Add a checkbox to the script

```
import com.onresolve.scriptrunner.parameters.annotation.* 
 
@Checkbox(label = "Clone space", description = "Select the checkbox to clone a space") 
Boolean spaceShouldBeCloned
```

### User picker

#### Add a user picker into your script

```
import com.atlassian.user.User
import com.onresolve.scriptrunner.parameters.annotation.*
 
@UserPicker(label = "User", description = "User for test")
User user
```

#### Add a user multi-picker

```
import com.atlassian.user.User
import com.onresolve.scriptrunner.parameters.annotation.*
 
@UserPicker(label = "Users", description = "Users for test", multiple = true)
List<User> users
```

### Space picker

Add a space picker to your script

```
import com.atlassian.confluence.spaces.Space
import com.onresolve.scriptrunner.parameters.annotation.SpacePicker
 
@SpacePicker(label = "Space", description = "Pick a space")
Space space
```

Add a space multi-picker to your script

```
import com.atlassian.confluence.spaces.Space
import com.onresolve.scriptrunner.parameters.annotation.SpacePicker
 
@SpacePicker(label = "Spaces", description = "Pick spaces", multiple = true)
List<Space> spaces
```
