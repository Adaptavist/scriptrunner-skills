# Setting Field Defaults

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > behaviours > behaviours-examples
- Doc ID: doc-sr4js-280526855
- Source: https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples/setting-field-defaults

You can use Behaviours to set default values for system and custom fields, and you can set different defaults depending on the current user's role level or group.

You may want to set default values when you want end-users to modify them, or when you need to provide a structured template for input. You might also consider using the _Read-only_ option to lock fields instead of setting values in post-functions. This approach is more user-friendly than setting the field in a post-function as it doesn't overwrite user-provided data.

This page primarily provides code examples for setting the different types of fields.

There is a worked example covering setting a default description on the [behaviours tutorial](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-tutorial#default-description) page.

## Setting system field defaults

You can use the following script to set default values for components, affected versions, and the assignee when creating a new issue in Jira. This script is designed to be used as an **Initialiser** script and run only once when the form is first loaded when a new issue is created. It checks the current action and exits if it's not the _Create Issue_ action, ensuring it doesn't run on subsequent actions.

The script interacts with various Jira objects and fields using Jira's API and ComponentAccessor. You may need to modify the script based on your specific workflow or use action IDs (for example, `getAction()?.id == 1`) instead of names for more precise control.

1.  From ScriptRunner, navigate to **Behaviours**. 
2.  Select **Create Behaviour**.
3.  Enter a name for the behaviour. In this example we enter `Setting System Defaults`.
4.  Optional: Enter a description for the behaviour.
5.  Select **Create Mapping**.
6.  Select the project and issue type(s) to map this behaviour to. 
7.  Select **Add Mapping** to confirm the mapping.
8.  Select **Create** to create the behaviour.  
    You're taken to the **Edit Behaviour** screen where you can configure the behaviour further.
9.  Scroll to the **Initialiser** field and select **Create Script**.  
    ![](/sr4js/files/latest/280526855/441364088/1/1731342535000/Restricting_issue_type_2.png)
    
10.  Copy the following code into the inline script editor:  
     
     ```
import com.atlassian.jira.component.ComponentAccessor

import static com.atlassian.jira.issue.IssueFieldConstants.AFFECTED_VERSIONS
import static com.atlassian.jira.issue.IssueFieldConstants.ASSIGNEE
import static com.atlassian.jira.issue.IssueFieldConstants.COMPONENTS

if (underlyingIssue) {
    return // the issue already exists, therefore this is not the initial action, so don't set default values
}

// set Components. If the named components are not valid for this project, they won't be set
getFieldById(COMPONENTS).setFormValue(["Support Question", "Frontend"])

// set "Affects Versions" to the latest version
def versionManager = ComponentAccessor.getVersionManager()
def versions = versionManager.getVersions(issueContext.projectObject)
if (versions) {
    // versions.last() is the most recently created version
    getFieldById(AFFECTED_VERSIONS).setFormValue([versions.last().id])
}

// set Assignee
getFieldById(ASSIGNEE).setFormValue("admin")
```
     
11.  Select **Save Changes**. 
     

## Setting defaults for single and multiple-choice lists

You can use the following script example to set default options for single and multiple-choice lists. The same example that works for a single select list will work for a radio buttons field; in addition, you can use the multiple-choice code to set a multi-checkbox field. 

For single fields, set a single value; for multiple fields, use a `List`.

1.  From ScriptRunner, navigate to **Behaviours**. 
2.  Select **Create Behaviour**.
3.  Enter a name for the behaviour. In this example we enter `Setting List Defaults`.
4.  Optional: Enter a description for the behaviour.
5.  Select **Create Mapping**.
6.  Select the project and issue type(s) to map this behaviour to. 
7.  Select **Add Mapping** to confirm the mapping.
8.  Select **Create** to create the behaviour.  
    You're taken to the **Edit Behaviour** screen where you can configure the behaviour further.
9.  Scroll to the **Initialiser** field and select **Create Script**.  
    ![](/sr4js/files/latest/280526855/441364088/1/1731342535000/Restricting_issue_type_2.png)
    
10.  Use the following example to set default values:  
     
     ```
// set a select list value -- also same for radio buttons
def faveFruitField = getFieldByName('Favourite Fruit')
faveFruitField.setFormValue('Oranges')

// same example but setting a multiselect - also same for checkboxes fields
def subComponentField = getFieldByName("Subcomponent")
subComponentField.setFormValue(['Oranges', 'Lemons'])
```
     
11.  Select **Save Changes**. 
     

## Setting cascading select list values

You can use the following script examples to set cascading select lists. This is similar to the above example, but slightly more complex due to parent and child options.

1.  From ScriptRunner, navigate to **Behaviours**. 
2.  Select **Create Behaviour**.
3.  Enter a name for the behaviour. In this example we enter `Setting Cascading List Values`.
4.  Optional: Enter a description for the behaviour.
5.  Select **Create Mapping**.
6.  Select the project and issue type(s) to map this behaviour to. 
7.  Select **Add Mapping** to confirm the mapping.
8.  Select **Create** to create the behaviour.  
    You're taken to the **Edit Behaviour** screen where you can configure the behaviour further.
9.  Choose if you want to set cascading select list values in an [initialiser or server side script](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-tutorial#should-i-add-an-initialiser-or-server-side-script):
    1.  If you want to set values in an initialiser script:
        
        1.  Scroll to the **Initialiser** field and select **Create Script**.
            
        2.  Use the following example to set values:  
            
            ```
getFieldByName("CascadingSelect").setFormValue(['AAA', 'A2'])
```
            
              
            
    2.  If you want to set values in a **server-side** script:
        1.  Scroll to **Add Field**.
        2.  Find your cascading select list and select **Add**.  
        3.  Select **Create Script**.
        4.  Use the following example to set values:
            
            ```
field.setFormValue(["Parent option value", "Child option value"])
```
            
10.  Select **Save Changes**. 

## Set a read-only field based on another field

You can use the following example to set a read-only field (**UserPicker**) with the component lead's user name. 

1.  From ScriptRunner, navigate to **Behaviours**. 
2.  Select **Create Behaviour**.
3.  Enter a name for the behaviour. In this example we enter `Set a UserPicker field based on Component field`.
4.  Optional: Enter a description for the behaviour.
5.  Select **Create Mapping**.
6.  Select the project and issue type(s) to map this behaviour to. 
7.  Select **Add Mapping** to confirm the mapping.
8.  Select **Create** to create the behaviour.  
    You're taken to the **Edit Behaviour** screen where you can configure the behaviour further.
9.  Scroll to **Add Field**.
10.  Find your **Component/s** field and select **Add**.  
11.  Select **Create Script**. 
12.  Use the following script as a **server-side** script on the **Component** field to get the component lead:  
     
     ```
import com.atlassian.jira.bc.project.component.ProjectComponent

def formComponent = getFieldById(fieldChanged)
def formUserField = getFieldByName("UserPicker")

def components = formComponent.getValue() as List<ProjectComponent>

// if any components have been set, set the user field to the component lead of the first component
// otherwise unset it
if (components) {
    formUserField.setFormValue(components.first().lead)
} else {
    formUserField.setFormValue("")
}
```
     
13.  Scroll **Add Field** again.
14.  Find the **UserPicker** field and select **Add**.  
15.  Make the **UserPicker** field **Readonly**.  
     ![](/sr4js/files/latest/280526855/284327980/1/1724832670000/Set+read-only+field+based+on+another+field.png)  
     
16.  Select **Save Changes**. 

On selecting a component the field value should change:

If you remove all components it will be cleared.

![](/sr4js/files/latest/280526855/284327981/1/1724832842000/Set+a+read-only+field+based+on+a+nother+field+result.png)

  

* * *

## Related content

-   [Behaviours Examples](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples)
-   [Behaviours](https://docs.adaptavist.com/sr4js/latest/features/behaviours)
-   [Behaviours Tutorial](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-tutorial)
