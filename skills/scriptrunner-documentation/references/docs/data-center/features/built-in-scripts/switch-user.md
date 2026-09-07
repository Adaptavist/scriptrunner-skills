# Switch User

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > built-in-scripts
- Doc ID: doc-sr4js-442889324
- Source: https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/switch-user

The _Switch User_ function allows administrator users to temporarily assume the identity of another user. You can switch user using the built-in script below, or you can [switch user within Jira](https://docs.adaptavist.com/sr4js/latest/?contentKey=settings-switch-user#switchuser). The switch user function is enabled by default. However, you may wish to disable this feature as described on the [Switch User Function](https://docs.adaptavist.com/sr4js/latest/?contentKey=settings-switch-user) page.

## Using this built-in script

To switch back to your original user, click the **Return to session as \[your name\]** link in the _Switch User_ banner, or log out and in again.

![Image example of the return to session dialog](/files/101638520/179605224/1/1687956289000/switch_user_banner.png)

1.  Navigate to **Built-in Scripts > Switch to a Different User**.
    
2.  Under **User**, type the name of the target user.
    
3.  Click **Preview** to see if the user switch is valid.
    
    You cannot switch to a user with a higher permission level than your own.
    
4.  If valid, click **Run**.
    

## Results

If you are on Jira 10.x.x without JSM installed, please be aware of the following issue:

When switching to a user with insufficient permissions, you may encounter a Forbidden (403) error. This error prevents you from reverting to the admin session within the same page. To resolve this issue:

1.  Close the current page.
2.  Open a new browser tab or window.
3.  Log in again with your admin credentials.

After you select **Run**, you are taken to Jira home and see it as that user would.

![Example of how switch user built in script works](/sr4js/files/latest/442889324/442889329/1/1758747017000/Switch_user_example.png)

This is what the audit log entry would look like: 

![Image of switch user audit log](/sr4js/files/latest/442889324/442889330/1/1758747017000/Switch_user_audit_log.png)

To prevent the impersonation of system administrator users by other system administrators enable the following dark feature:

`scriptrunner.canned.jira.admin.switchuser.denyimpersonatesysadmin`

See [Atlassian documentation](https://confluence.atlassian.com/jirakb/enable-dark-feature-in-jira-959286331.html) for more information on dark features.
