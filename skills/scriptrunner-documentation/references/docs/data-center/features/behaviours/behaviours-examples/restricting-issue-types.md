# Restricting Issue Types

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > behaviours > behaviours-examples
- Doc ID: doc-sr4js-442889097
- Source: https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples/restricting-issue-types

Jira issue type schemes are not very flexible, as you cannot limit the available issue types in a project. Typically, if someone has permission to create an issue in a project, they can create every issue type in the project's issue type scheme.

You can use Behaviours to restrict which issue types are available to different categories of users. On this page, we provide you with the following examples of restricting issue types:

-   [Restricting available issue types based on user role](#id-.RestrictingIssueTypesv9.x-restricting-issue-type)
-   [Restricting issue type to a single issue based on user role](#id-.RestrictingIssueTypesv9.x-restricting-single-issue)

## Restricting available issue types based on user role

You can use the following example to restrict the issue types available to a user based on their role in the project. In this example, we restrict those in the _Users_ role to only see _Query_ and _General Request_ issue types when they create new issues in a specific project. We also restrict those in the _Developers_ role to only see _Bugs_, _Tasks_, and _New Features_.

Those who aren't assigned to the _Users_ or _Developers_ role will not be able to create an issue in the chosen project as they will not be able to see any issue types. However, you can update the script in this example to work as you need. 

When creating your own script you can use [`setFieldOptions`](https://docs.adaptavist.com/sr4js/latest/features/behaviours/api-quick-reference#formfieldsetfieldoptionsiterable) on the issue type field and restrict the available issue types accordingly.

### Step-by-step instructions

1.  From ScriptRunner, navigate to **Behaviours**. 
2.  Select **Create Behaviour**.
3.  Enter a name for the behaviour. In this example we enter `Restricting Available Issue Types`.
4.  Optional: Enter a description for the behaviour.
5.  Select **Create Mapping**.
6.  Select the project and issue type(s) to map this behaviour to. 
7.  Select **Add Mapping** to confirm the mapping.
8.  Select **Create** to create the behaviour.  
    ![](/sr4js/files/latest/442889097/441364061/1/1730222779000/Restricting_issue_type_1.png)  
    You're taken to the **Edit Behaviour** screen where you can configure the behaviour further.
9.  Scroll to the **Initialiser** field and select **Create Script**.  
    ![](/sr4js/files/latest/442889097/441364060/1/1730222780000/Restricting_issue_type_2.png)  
    
10.  Copy the following code into the inline script editor:  
     
     ```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.security.roles.ProjectRoleManager

import static com.atlassian.jira.issue.IssueFieldConstants.ISSUE_TYPE

def projectRoleManager = ComponentAccessor.getComponent(ProjectRoleManager)

def user = ComponentAccessor.jiraAuthenticationContext.getLoggedInUser()
def issueTypeField = getFieldById(ISSUE_TYPE)

def userRoles = projectRoleManager.getProjectRoles(user, issueContext.projectObject)*.name
def availableIssueTypes = []

if ("Users" in userRoles) {
    availableIssueTypes.addAll(["Query", "General Request"])
}

if ("Developers" in userRoles) {
    availableIssueTypes.addAll(["Bug", "Task", "New Feature"])
}

issueTypeField.setFieldOptions(availableIssueTypes)
```
     
      You can easily customize this script with your own project roles and issues types.
     
11.  Select **Save Changes**. 

### Test this behaviour

The following four outcomes are possible when testing this behaviour:

-   Those in the _Users_ role see _Query_ and _General Request  
    _![](/sr4js/files/latest/442889097/441364064/1/1730222779000/Restricting_issue_type_4.png)
-   Those that don't belong to either _Users_ or _Developers_ roles will not see any issue types  
    _![](/sr4js/files/latest/442889097/441364063/1/1730222779000/Restricting_issue_type_5.png)_
-   Those in the _Developers_ role see _Bug_, _Task_ and _New Feature  
    _![](/sr4js/files/latest/442889097/441364059/1/1730222780000/Restricting_issue_type_3.png)
-   Those in both the _Users_ and _Developers_ roles see _Query,_ _General Request,_ _Bug_, _Task_ and _New Feature_  
    ![](/sr4js/files/latest/442889097/441364062/1/1730222779000/Restricting_issue_type_6.png)

## Restricting issue type to a single issue based on user role

In a different scenario to the above, where there is only one issue type allowed, we can set that issue type and lock the field.

You can use the following example to make sure members of the `Users` role can only set the issue type to _Task_ and lock the field.

### Step-by-step instructions

1.  From ScriptRunner, navigate to **Behaviours**. 
2.  Select **Create Behaviour**.
3.  Enter a name for the behaviour. In this example we enter `Restrict issue type to a single issue based on user role`.
4.  Optional: Enter a description for the behaviour.
5.  Select **Create Mapping**.
6.  Select the project and issue type(s) to map this behaviour to. 
7.  Select **Add Mapping** to confirm the mapping.
8.  Select **Create** to create the behaviour.  
    ![](/sr4js/files/latest/442889097/441364058/1/1730310912000/Restrict_user_issue_type_1.png)You're taken to the **Edit Behaviour** screen where you can configure the behaviour further.
9.  Scroll to the **Initialiser** field and select **Create Script**.  
    ![](/sr4js/files/latest/442889097/441364060/1/1730222780000/Restricting_issue_type_2.png)  
    
10.  Copy the following code into the inline script editor:  
     
     ```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.security.roles.ProjectRoleManager

import static com.atlassian.jira.issue.IssueFieldConstants.ISSUE_TYPE

// if the current user is in the Users role only, set the issue type to "Query", and lock it
def projectRoleManager = ComponentAccessor.getComponent(ProjectRoleManager)
def user = ComponentAccessor.jiraAuthenticationContext.getLoggedInUser()

def usersRoles = projectRoleManager.getProjectRoles(user, issueContext.projectObject)*.name
if (usersRoles == ['Users']) {
    getFieldById(ISSUE_TYPE)
        .setFormValue('Task')
        .setReadOnly(true)
}
```
     
       
     
      You can easily customize this script with your own project roles and issues types.
     
11.  Select **Save Changes**. 

### Test this behaviour

The following four outcomes are possible when testing this behaviour:

-   Those not in the _Users_ role will see all available issue types  
    ![](/sr4js/files/latest/442889097/441364056/1/1730311306000/Restrict_user_issue_type_2.png)
-   Those in the _Users_ role will be restricted to the _Task_ issue type only.  
    ![](/sr4js/files/latest/442889097/441364057/1/1730311306000/Restrict_user_issue_type_3.png)

If enforcing specific issue types is critical, we recommend you implement a workflow validator (such as a [simple scripted validator](https://docs.adaptavist.com/sr4js/latest/features/workflows/validators/simple-scripted-validators)) on the **Create** transition. This adds an extra layer of security beyond Behaviours, which only affect the browser interface and not the REST API.

  

* * *

## Related content

-   [Behaviours](https://docs.adaptavist.com/sr4js/latest/features/behaviours)
-   [Behaviours Tutorial](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-tutorial)
-   [Behaviours Examples](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples)
