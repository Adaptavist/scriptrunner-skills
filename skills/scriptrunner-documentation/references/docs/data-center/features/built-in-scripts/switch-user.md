# Switch User

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Built-in scripts
- Doc ID: doc-sr4js-1c34df5e-368e-4149-b42c-4fb88e9843d4-9132620ecb9e01f6
- Source: https://docs.adaptavist.com/sr4js/latest/features#built-in-scripts--en#switch-user--en

The _Switch User_ function allows administrator users to temporarily assume the identity of another user. You can switch user using the built-in script below, or you can [switch user within Jira](../../get-started/settings/switch-user-function.md). The switch user function is enabled by default. However, you may wish to disable this feature as described on the [Switch User Function](../../get-started/settings/switch-user-function.md) page.

## Using this built-in script

Tip: To switch back to your original user, click the Return to session as \[your name\] link in the _Switch User_ banner, or log out and in again.

1.  Navigate to Built-in Scripts > Switch to a Different User.
2.  Under User, type the name of the target user.
3.  Click Preview to see if the user switch is valid.
    
    Warning: You cannot switch to a user with a higher permission level than your own.
    
4.  If valid, click Run.

## Results

Warning: If you are on Jira 10.x.x without JSM installed, please be aware of the following issue:

When switching to a user with insufficient permissions, you may encounter a Forbidden (403) error. This error prevents you from reverting to the admin session within the same page. To resolve this issue:

1.  Close the current page.
2.  Open a new browser tab or window.
3.  Log in again with your admin credentials.

After you select Run, you are taken to Jira home and see it as that user would.

This is what the audit log entry would look like:

Tip: To prevent the impersonation of system administrator users by other system administrators enable the following dark feature: `scriptrunner.canned.jira.admin.switchuser.denyimpersonatesysadmin` . See [Atlassian documentation](https://confluence.atlassian.com/jirakb/enable-dark-feature-in-jira-959286331.html) for more information on dark features.
