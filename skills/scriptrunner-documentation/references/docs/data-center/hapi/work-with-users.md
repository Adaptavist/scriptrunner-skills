# Work with Users

- Platform: data-center
- Space: SR4JS
- Hierarchy: HAPI
- Doc ID: doc-sr4js-575cf206-1a4d-4f32-8e77-61e3d365fc66-de22c094d713c381
- Source: https://docs.adaptavist.com/sr4js/latest/hapi#work-with-users--en

|  |  |
| --- | --- |
|  | Migrating to Jira Cloud? This feature is available in Cloud.<br>[HAPI Cloud documentation](https://docs.adaptavist.com/sr4jc/latest/hapi/work-with-users) |

With HAPI, we've made it easy for you to work with users.

## Running code as another user

You can run code as another user with the `Users` top-level object. For example, you may wish to create an issue in a post-function in a project that the current user may not have _create issue_ permissions in.

Run the following script from the script console:

Note: In this example we're creating an issue as another user.

```
def issue = Users.runAs('anuser') {
    Issues.create('SR', 'Bug') {
        setSummary('created by another user')
    }
}
assert issue.reporter.name == 'anuser'
```

## Creating and modifying users

With HAPI we've made it easy for you to create and modify users.

### Create a new user

You can create a user as follows:

```
Users.create('jdoe', 'jdoe@example.com', 'Jane Doe')
```

You can control the user creation process further by specifying a closure:

Note: In this example we're creating a user and adding a password, directory ID and application access.

```
import com.atlassian.jira.application.ApplicationKeys

Users.create('jdoe', 'jdoe@example.com', 'Jane Doe') {
    password = 'secret'
    directoryId = 10_001
    withApplicationAccess(ApplicationKeys.SERVICE_DESK, ApplicationKeys.SOFTWARE)
}
```

### Update a user

You can update an existing user as follows:

Note: The user type has to be of `ApplicationUser`.

```
Users.getByKey('User Key').update {
    setDisplayName('New Display Name')
    setName('New Username')
    setEmailAddress('New Email Address')
}
```

### Delete a user

You can delete a user as follows:

```
def user = Users.getByName('jdoe')
user.delete()
```

### Deactivate and activate a user

You can deactivate or activate a user as follows:

```
def user = Users.getByName('jdoe')
            
user.deactivate()
user.activate()
```

## User permissions and role membership

Extension methods on `com.atlassian.jira.user.ApplicationUser` make it easy to:

1.  Retrieve whether the user has a given permission in a project.
2.  Retrieve whether the user has a given global permission.
3.  Retrieve whether the user has a particular project role membership in a project.

### Retrieving project permissions

You can retrieve project permissions as follows:

```
import com.atlassian.jira.permission.ProjectPermissions

// can this user create issues in project SR
user.canCreateIssues(Projects.getByKey('SR'))

// which is equivalent to
user.hasPermission(ProjectPermissions.BROWSE_PROJECTS, Projects.getByKey('SR'))

// does this user have permission to move issues in project SR
user.hasPermission(ProjectPermissions.MOVE_ISSUES, Projects.getByKey('SR'))

// can this user view issues in SR
user.canView(Projects.getByKey('SR'))

// can this user administer the SR project
user.canAdminister(Projects.getByKey('SR'))
```

### Retrieving issue permissions

You can retrieve issue permissions as follows:

```
import com.atlassian.jira.permission.ProjectPermissions

// does this user have permission to move issue SR-1
user.hasPermission(ProjectPermissions.MOVE_ISSUES, Issues.getByKey('SR-1'))

// can this user view issue SR-1
user.canView(Issues.getByKey('SR-1'))
```

### Working with role memberships

You can work with role memberships as follows:

```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.security.roles.ProjectRoleManager
            
// does this user have membership of the Developers role in the SR project         
user.isMemberOfRole('Developers', Projects.getByKey('SR'))
            
// or using a ProjectRole instance
def projectRoleManager = ComponentAccessor.getComponent(ProjectRoleManager)
def projectRole = projectRoleManager.getProjectRole('Developers')
user.isMemberOfRole(projectRole, Projects.getByKey('SR'))
```

### Working with group membership

You can work with group memberships as follows:

```
// is the user a member of the jira-administrators group
user.isMemberOfGroup('jira-administrators')

// or using a Group instance
def group = Groups.getByName('jira-administrators')
user.isMemberOfGroup(group)

// checking membership from the group works too
group.contains(user)

// as well as with usernames
group.contains('bob')
```

See the [Work with Groups](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-groups) page for more information on working with groups.

## Working with user properties

You can work with user properties as follows:

```
def user = Users.getByName('jdoe') 
             
def propertySet = user.propertySet
            
// set a property
propertySet.setString('my property', 'foo bar')
            
// later
propertySet.getString('my property') // 'foo bar' is returned
```

Check out the [Work with Issue and Entity Properties](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-issue-and-entity-properties) page for more information.

## Retrieving user date information

With HAPI we've made it easy for you to retrieve the date a user was created, and the date a user was last updated.

### Retrieving the date a user was created

You can get the date a user was created as follows:

```
def user = Users.getByName('jdoe')
            
user.getCreatedDate()
```

### Retrieving the date a user was last updated

You can get the date a user was last updated as follows:

```
def user = Users.getByName('jdoe')
            
user.getUpdatedDate()
```

## Related content

-   [Javadocs link](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/8.10.0/hapi/jira/groovydoc/com/adaptavist/hapi/jira/users/Users.html)
-   [Work with Groups](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-groups)
-   [Work with Projects](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-projects)
