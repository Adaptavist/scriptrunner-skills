# Space Admin Built-in Script Permissions

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Get Started > Settings
- Doc ID: doc-sr4c-079ece0f-214a-412d-9cc7-0e7b4a6ba1b1-4f81addcc5fb893d
- Source: https://docs.adaptavist.com/sr4c/latest/get-started#settings--en#space-admin-built-in-script-permissions--en

By default, all space administrators have access to some [built-in scripts](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/space-administration-built-in-scripts) within ScriptRunner to help administer their space. Admin can restrict or allow access to built-in scripts for users, groups, and/or spaces here.

The toggle defaults to off, which means all space administrators can access the built-in scripts. Toggle on to configure access to the built-in Space Admin scripts.

Warning: We updated this functionality in version 6.45.0 of ScriptRunner for Confluence. Any permissions you had configured in previous versions will be automatically carried over. This functionality is not backwards compatible. If you configure permissions using this functionality and then downgrade to a version prior to 6.45.0, you will lose any changes made using this functionality.

## Turning the feature on

When you toggle on the feature, the configuration table is displayed.

Initially, the _Global_ row displays with all access to all built-in scripts enabled. You can provide or remove access to a particular built-in script to all space administrators by checking the relevant checkbox in the table.

## Modify the configuration table

### Add permission settings

If you want to give or restrict access for a specific space, group, and/or user not displayed in the configuration table, click Add. The _Add Permisions_ screen appears:

From here, you can select the space(s), group(s), and/or user(s) you want to add to the table, then click Add to configure the permissions for each selection. The following screen shows a configuration table with added spaces, groups, and users:

All entries on the configuration table are grouped by type. You can now configure the access as required by checking the relevant checkbox. If a checkbox is checked, the entity has access to that built-in script. If a checkbox is unchecked, access to that built-in script is restricted for that user, group, or space.

#### Order of entries

There is a hierarchy of rules applied to the configuration table. The hierarchy is user > group > space > global . This means that user-level settings overrule group-level settings, which overrule space-level settings, which overrule global settings.

Warning: Group-level permissions are cumulative. If a user is a member of multiple groups with permissions configured, they can access the scripts allowed in any group, even if the scripts are not allowed in some of their groups.

### Remove permission settings

If you want to remove a row from the configuration table, click the x in the _Remove_ column for that row

You can't remove the _Global_ row.

Tip: Due to the number of built-in scripts, you may have to scroll to the right on the configuration table to see all the built-in scripts and the _Remove_ column.

## Examples

We've provided some example scenarios below to show how you can combine permissions for spaces, groups, and users to meet your requirements.

### Scenario 1

I want all space administrators to have access to all built-in scripts except for Copy Space.

Uncheck the Copy Space checkbox in the Global row.

### Scenario 2

I want only users in the power-users group to have access to all built-in scripts.

1.  Uncheck all checkboxes on the _Global_ row.
2.  Add a row for the power-users group and check all checkboxes.

### Scenario 3

I want all space administrators to have access to all built-in scripts except for Copy Space. I do not want the user Bob to access any built-in scripts.

1.  Uncheck the Copy Space checkbox in the Global row.
2.  Add a row for the user Bob and leave all checkboxes unchecked.

### Scenario 4

I want all space administrators to have access to all built-in scripts except for Copy Space. I do not want the Marketing space to access any built-in scripts. Only the user Jane should have access to all built-in scripts, including Copy Space.

1.  Uncheck the Copy Space checkbox in the Global row.
2.  Add a row for the Marketing space and leave all boxes unchecked.
3.  Add a row added for the user Jane and check all checkboxes.
    
    Note: In this scenario, Jane has access to the built-in scripts in the Marketing space as their user permissions take precedence over the Marketing space permissions.
    

### Scenario 5

I want to make only the Copy Space script available to all space administrators. I want members of the power-users group to have access to all built-in scripts in the instance. I don't want any built-in scripts available in the HR space.

1.  Check only the Copy Space checkbox in the Global row.
2.  Add a row for the HR space and leave all boxes unchecked.
3.  Add a row for the power-users group and check all checkboxes.
    
    Note: In this scenario, all members of the power-users group have access to the built-in scripts in the HR space as the group permissions take precedence over the HR space permissions.
    

### Scenario 6

I want to make only the Copy Space script available to all space administrators. I want all space administrators to have access to all built-in scripts in the Proving Ground space. I don't want any built-in scripts available to people in the probation group.

1.  Check only the Copy Space checkbox in the Global row.
2.  Add a row for the Proving Ground space and check all checkboxes.
3.  Add a row for the probation group and leave all checkboxes unchecked.
    
    Note: In this scenario, members of the probation group will not have access to any built-in scripts as the group permissions take precedence over the space and global permissions.
