# Restricting Comment Visibility

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > behaviours > behaviours-examples
- Doc ID: doc-sr4js-442889075
- Source: https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples/restricting-comment-visibility

Behaviours allow you to control comment visibility by configuring the `commentLevel` field. You can either set specific options for this field or lock it to a fixed value. This feature is particularly useful when you want to restrict the visibility of comments added during issue editing or transitions to certain users only.

Due to the [limitations of Behaviours](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviour-limitations), you can only restrict comment visibility on the _Update/Edit Issue_, _Assign Issue_, and _Workflow Transition_ screens. You will not be able to restrict comment visibility if a user adds a comment through the view screen.

## Set comment visibility for certain roles

You can use the following example to restrict the visibility of comments Administrators make to _Administrators_ only when they're editing or transitioning an issue. 

1.  From ScriptRunner, navigate to **Behaviours**. 
2.  Select **Create Behaviour**.
3.  Enter a name for the behaviour. In this example we enter `Set comment visibility for Administrators`.
4.  Optional: Enter a description for the behaviour.
5.  Select **Create Mapping**.
6.  Select the project and issue type(s) to map this behaviour to. 
7.  Select **Add Mapping** to confirm the mapping.
8.  Select **Create** to create the behaviour.  
    ![](/sr4js/files/latest/442889075/441364073/1/1730392146000/Set_comment_visibility.png)  
    You're taken to the **Edit Behaviour** screen where you can configure the behaviour further.
9.  Scroll to the **Initialiser** field and select **Create Script**.  
    ![](/sr4js/files/latest/442889075/441364075/1/1730388989000/Restricting_issue_type_2.png)  
    
10.  Copy the following code into the inline script editor:  
     
     ```
getFieldById('commentLevel')
    .setFormValue('role:Administrators')
    .setReadOnly(true)
```
     
       
     
      You can easily customize this script to a different project role.
     
11.  Select **Save Changes**. 
     
     To check this behaviour works as expected, log in as an Administrator and try updating, editing, assigning, or transitioning an issue in your selected project.
     
     ![](/sr4js/files/latest/442889075/441364072/1/1730393672000/Set_comment_visibility_2.png)
     

## Restrict comment by role and/or group

You can use the following example to limit the visibility of Administrator comments to only those in the Administrators role or jira-administrators group. This approach can be particularly useful when configuring workflow steps, especially if you want to require Administrators to comment before proceeding with a transition while keeping these comments restricted.

This can be easily accomplished by using the `[setFieldOptions](https://docs.adaptavist.com/sr4js/latest/features/behaviours/api-quick-reference#formfieldsetfieldoptionsiterable)` method on the `commentLevel` field. This approach allows you to enforce comment requirements while also controlling who can view these comments, ensuring sensitive information remains visible only to authorized personnel.

1.  From ScriptRunner, navigate to **Behaviours**. 
2.  Select **Create Behaviour**.
3.  Enter a name for the behaviour. In this example we enter Restrict comment to admin only.
4.  Optional: Enter a description for the behaviour.
5.  Select **Create Mapping**.
6.  Select the project and issue type(s) to map this behaviour to. 
7.  Select **Add Mapping** to confirm the mapping.
8.  Select **Create** to create the behaviour.  
    ![](/sr4js/files/latest/442889075/441364071/1/1730466002000/Restrict_comment_by_role_group_1.png)  
    You're taken to the **Edit Behaviour** screen where you can configure the behaviour further.
9.  Scroll to the **Initialiser** field and select **Create Script**.  
    ![](/sr4js/files/latest/442889075/441364075/1/1730388989000/Restricting_issue_type_2.png)  
    
10.  Copy the following code into the inline script editor:  
     
     ```
def formField = getFieldById("commentLevel")

formField.setRequired(true)
formField.setFieldOptions(['group:jira-administrators', 'role:Administrators'])
```
     
       
     
     The above passes a list of strings which have the form `group:groupName`  or `role:roleName`.
     
     To pass a list (or any Iterable) of `Role` or `Group` objects you can use the following script instead. 
     
     ```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.security.roles.ProjectRoleManager

def projectRoleManager = ComponentAccessor.getComponent(ProjectRoleManager)
def groupManager = ComponentAccessor.getGroupManager()

def group = groupManager.getGroup("jira-administrators")
def role = projectRoleManager.getProjectRole("Administrators")

def formField = getFieldById("commentLevel")

formField.setRequired(true)
formField.setFieldOptions([group, role])
```
     
11.  Select **Save Changes**. 
     
     To check this behaviour works as expected, log in as an administrator and try updating, editing, assigning, or transitioning an issue in your selected project. The administrator must enter a comment and select the required restriction for their comment. 
     
     ![](/sr4js/files/latest/442889075/441364070/1/1730466120000/Restrict_comment_by_role_group_2.png)
     

  

* * *

## Related content

-   [Behaviours](https://docs.adaptavist.com/sr4js/latest/features/behaviours)
-   [Behaviours Tutorial](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-tutorial)
-   [Behaviours Examples](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples)
