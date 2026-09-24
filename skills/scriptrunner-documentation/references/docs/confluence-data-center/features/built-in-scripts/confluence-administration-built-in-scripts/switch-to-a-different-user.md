# Switch to a Different User

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Built-In Scripts > Confluence Administration Built-In Scripts
- Doc ID: doc-sr4c-0b096083-4426-4fd0-8c5c-72c1ae1da306-e74c48598610f287
- Source: https://docs.adaptavist.com/sr4c/latest/features#built-in-scripts--en#confluence-administration-built-in-scripts--en#switch-to-a-different-user--en

The _Switch User_ built-in script allows administrator users to temporarily assume the identity of another user.

_Switch User_ has a variety of uses, such as:

-   Reproducing and troubleshooting problems specific to a user to diagnose permissions issues.
-   Updating content on behalf of another user if they are unavailable.

## Run the script

Tip: To switch back to your original user, click the Return to session as \[your name\] link in the _Switch User_ banner, or log out and in again.

1.  Navigate toBuilt-in Scripts > Switch to a Different User.
2.  Under User, type the name of the target user.
3.  Click Preview to see if the user switch is valid.
    
    Warning: You cannot switch to a user with a higher permission level than your own.
    
4.  If valid, click Run.
    

After you select Run, you are taken to Confluence home and see it as that user would.

This is what the audit log entry would look like:

Tip: You can disable/enable this feature in ScriptRunner Settings. See our [settings](https://docs.adaptavist.com/sr4c/latest/get-started/settings/switch-user-function) documentation for more information.

## Example

### Check permissions

If a user is unable to view content (for example: a space, page, or content on a page like linked Jira issues) an administrator can use this script to switch to the user that is having problems to investigate. Once the admin switches to the user, they can check what they're seeing, make adjustments, then check back to ensure the problem is solved. This way, the admin doesn't need to go through the user each time they've made a potential fix.
