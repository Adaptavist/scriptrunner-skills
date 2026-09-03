# System Admin-Only Script Edit Permission

- Platform: data-center
- Space: SR4JS
- Hierarchy: get-started > settings
- Doc ID: doc-sr4js-441364245
- Source: https://docs.adaptavist.com/sr4js/latest/get-started/settings/system-admin-only-script-edit-permission

The _Enable System Admin Only Script Edit Permissions_ setting enhances ScriptRunner security by restricting script editing capabilities. Users with Jira System administrators or Jira administrators permissions have script editing permissions by default. This setting allows you to limit script editing to either **Jira System administrators only** or to specific Jira administrators based on group membership. Check out [Atlassian's documentation](https://confluence.atlassian.com/adminjiraserver/managing-global-permissions-938847142.html) for information on managing global permissions and the difference between Jira System administrators and Jira administrators.

**You cannot restrict Jira System administrators from editing scripts**. For more information on Jira permission levels, see this [Permissions Overview](https://confluence.atlassian.com/jirasoftwareserver/permissions-overview-939938996.html).

Please note that Jira administrators can add themselves to any group other than those with Jira System administrator permissions. If this is a concern, you should restrict script edit permissions to Jira System administrators only and not extend permissions to any groups.

For information on how to create groups, see Atlassian's [View, Create or Delete a Group](https://confluence.atlassian.com/adminjiraserver/view-create-or-delete-a-group-938847038.html) documentation.

## Permission recommendations

To mitigate scripting risks, we recommend the following:

-   Restrict script editing access to Jira System administrators only, or to a small, carefully selected group of trusted Jira administrators.
    
-   Never grant scripting access to untrusted users.
    
-   Limit contractor access:
    
    -   Avoid giving contractors privileged access to production instances.
    -   When external access is necessary, confine it to test systems only.

These measures help maintain system integrity and reduce potential security vulnerabilities.

## How to enable this setting

To enable or disable this setting follow the steps below:

To restrict script editing access to specific Jira administrators, first create a new group with Jira administrator permissions. Then, add only those administrators with scripting expertise to this group. 

1.  From ScriptRunner, select **Settings**.  
    ![Image of Settings options](/sr4js/files/latest/441364245/441364247/1/1737461455000/Settings_options.png)
    
2.  Select the **Instance Settings** tab.
    
3.  Toggle _Enable System Admin Only_ _Script Edit Permissions_ on.  
    ![Image showing script editor settings location](/sr4js/files/latest/441364245/441364248/1/1737461456000/Scriptrunner_for_Jira_script_editor_settings.png)
    
4.  Optional: If you wish to extend permissions to certain groups with Jira Administrators permissions, select the group(s) to give script editing permissions to.
    
    Only groups with Jira Administrator permissions appear in the **(Optional) Extend Script Editor Permissions** field. 
    
    If you have a high number of Jira administrators, not all of whom are familiar with creating scripts, consider enabling this setting with no additional groups, limiting permissions to only Jira System administrators only.
    
5.  Optional: To remove script editing permissions, select the **X** next to the group name.
    

  

* * *

## Related content

-   [Permissions](https://docs.adaptavist.com/sr4js/latest/get-started/permissions)
-   [Vulnerabilities and Security](https://docs.adaptavist.com/sr4js/latest/get-started/vulnerabilities-and-security)
-   [Avoid Cross-site Scripting Vulnerabilities](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/avoid-cross-site-scripting-vulnerabilities)
