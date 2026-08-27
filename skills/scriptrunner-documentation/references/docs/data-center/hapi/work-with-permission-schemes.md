# Work with Permission Schemes

- Platform: data-center
- Space: SR4JS
- Hierarchy: hapi
- Doc ID: doc-sr4js-442888591
- Source: https://docs.adaptavist.com/sr4js/latest/hapi/work-with-permission-schemes

Permission schemes are a collection of [PermissionGrant](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/permission/PermissionGrant.html), which govern whether a user can do a particular action in any given project. 

Within Jira, each project is associated with one permission scheme. However, a permission scheme can be associated with multiple projects. **If you change a permission scheme you will affect all projects that use it****.** Learn more about [permission schemes](https://confluence.atlassian.com/adminjiraserver0813/managing-project-permissions-1027137825.html#Managingprojectpermissions-permission_schemesPermissionschemes) in Atlassian's documentation.

This page is specific to project permission schemes. If you want to modify projects see the [Work with Projects](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-projects) page.

## Retrieving a project's permission scheme

You can get a project's permission scheme as follows:

```
            def project = Projects.getByKey('SR')   
            def permissionScheme = project.permissionScheme
```

## Modifying permission schemes

### Add permissions to a permission scheme

You can add permissions to a permission scheme as follows:

```
            import com.atlassian.jira.permission.JiraPermissionHolderType
            import com.atlassian.jira.permission.ProjectPermissions
            
            // gives any logged-in user Browse permission - note the empty string
            permissionScheme.addPermission(ProjectPermissions.BROWSE_PROJECTS, JiraPermissionHolderType.APPLICATION_ROLE, '')

            // gives the reporter Delete permission
            permissionScheme.addPermission(ProjectPermissions.DELETE_ISSUES, JiraPermissionHolderType.REPORTER)  

            // gives the jira-users group Edit permission 
            permissionScheme.addPermission(ProjectPermissions.EDIT_ISSUES, JiraPermissionHolderType.GROUP, 'jira-users')
```

![Image showing how you add permissions to a project schema](/sr4js/files/latest/442888591/442888600/1/1758746954000/Permissions_add_permission_to_schema.png)

When adding user or group custom fields to the permission scheme remember to use the **custom field ID**, not the custom field name. For example:

```
            import com.atlassian.jira.permission.JiraPermissionHolderType
            import com.atlassian.jira.permission.ProjectPermissions

            permissionScheme.addPermission(ProjectPermissions.MANAGE_WATCHERS, JiraPermissionHolderType.GROUP_CUSTOM_FIELD, 'customfield_12345')
```

#### Completions

If completions are not visible when writing a script, you can trigger them using **Ctrl + space**.

Use completions on `ProjectPermissions` to see the different permissions available, these correspond to the permissions available to you when [managing project permissions](https://confluence.atlassian.com/adminjiraserver0813/managing-project-permissions-1027137825.html) in Jira. 

![Image showing project completions](/sr4js/files/latest/442888591/442888596/1/1758746953000/Permissions_project_permissions_completions.png)

Use completions on `JiraPermissionHolderType` to see different permission holder types. `JiraPermissionHolderType` completions correspond to the radio buttons in the **Grant permission** dialog box in Jira. 

![Image showing jira permission completions](/sr4js/files/latest/442888591/442888595/1/1758746953000/Permissions_jira_permissions_completions.png)

### Remove permissions from a permission scheme

You can remove permissions from a permission scheme in a similar way to how you add permissions.

```
            import com.atlassian.jira.permission.JiraPermissionHolderType
            import com.atlassian.jira.permission.ProjectPermissions
            
            // removes any logged-in user Browse permission - note the empty string
            permissionScheme.removePermission(ProjectPermissions.BROWSE_PROJECTS, JiraPermissionHolderType.APPLICATION_ROLE, '')

            // removes the reporter Delete permission
            permissionScheme.removePermission(ProjectPermissions.DELETE_ISSUES, JiraPermissionHolderType.REPORTER)  

            // removes the jira-users group Edit permission 
            permissionScheme.removePermission(ProjectPermissions.EDIT_ISSUES, JiraPermissionHolderType.GROUP, 'jira-users')
```

![Image showing how you remove permissions from a project schema](/sr4js/files/latest/442888591/442888606/1/1758746954000/Permissions_remove_permission_to_schema.png)

You can remove all permissions of a particular type using `clearPermissions`:

```
            import com.atlassian.jira.security.plugin.ProjectPermissionKey

            permissionScheme.clearPermissions(new ProjectPermissionKey('MANAGE_SPRINTS_PERMISSION'))
```

### Checking permissions

You can check if a permission is already granted as follows:

```
            import com.atlassian.jira.permission.JiraPermissionHolderType
            import com.atlassian.jira.permission.ProjectPermissions

            // does the "reporter" have "Edit Issue" permission            
            permissionScheme.hasPermission(ProjectPermissions.EDIT_ISSUES, JiraPermissionHolderType.REPORTER)

            // does the "jira-users" group have "Browse" permission            
            permissionScheme.hasPermission(ProjectPermissions.BROWSE_PROJECTS, JiraPermissionHolderType.GROUP, 'jira-users')
```

![Image showing how to check permissions using HAPI](/sr4js/files/latest/442888591/442888598/1/1758746953000/Permissions_check_permissions.png)

Alternately, you can get all permission grants for a specific permission type. In the following example we're getting all the permission grants for the **Browse Projects** project permission type.

```
            import com.atlassian.jira.permission.ProjectPermissions
            
            permissionScheme.getPermissions(ProjectPermissions.BROWSE_PROJECTS)
```

You can also get all permissions grants for a specific permission type **AND** specific permission holder type. In the following example we're getting all the permission grants for **Group** permission holders with the **Browse Projects** project permission type.

```
            import com.atlassian.jira.permission.JiraPermissionHolderType
            import com.atlassian.jira.permission.ProjectPermissions
            
            permissionScheme.getPermissions(ProjectPermissions.BROWSE_PROJECTS, JiraPermissionHolderType.GROUP)
```

  

* * *

## Related content

-   [Javadocs link](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/8.10.0/hapi/jira/groovydoc/com/adaptavist/hapi/jira/schemes/PermissionSchemesImplementation.html)
-   [Work with Users](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-users)
-   [Work with Groups](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-groups)
