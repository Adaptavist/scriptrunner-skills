# System Admin-Only Script Edit Permission

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Get Started > Settings
- Doc ID: doc-sr4c-9434a179-19dc-4306-8e00-b001454ce3a6-5de293e014e690d3
- Source: https://docs.adaptavist.com/sr4c/latest/get-started#settings--en#system-admin-only-script-edit-permission--en

By default, all Confluence Administrators can edit and execute scripts. However, _Script Edit_ permissions can optionally be restricted to a smaller set of users.

When this setting is disabled, all members of the _System Administrators_ group, and any group with the _Confluence Administrators_ global permission, can edit scripts (this is the default state after you install the plugin).

Enabling this setting allows you to control which groups can edit ScriptRunner scripts. Note that only groups with the Confluence Administrators global permission can be authorised to edit scripts. This means that you can restrict "edit script" access only to some of the _Confluence Administrators_ groups, for instance, those with _System Administrator_ permissions only. Please also note that when you add new groups, only groups that already have _Confluence Administrators_ global permission assigned will be suggested.

Warning: Members of _System Administrators_ group have access to full functionality of ScriptRunner regardless of status of _Script Edit Permission_ setting.
