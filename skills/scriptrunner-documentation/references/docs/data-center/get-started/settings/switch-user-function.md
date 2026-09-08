# Switch User Function

- Platform: data-center
- Space: SR4JS
- Hierarchy: get-started > settings
- Doc ID: doc-sr4js-426115405
- Source: https://docs.adaptavist.com/sr4js/latest/get-started/settings/switch-user-function

The _Switch User_ function allows administrator users to temporarily assume the identity of another user. You can switch user as described [below](#id-.SwitchtoaDifferentUserBuiltInScriptv9.x-switchuser), or through the [Switch User](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/switch-user) built-in script. The switch user function is enabled by default. However, you may wish to disable this feature if you have extremely strong compliance requirements.

Users with Script Edit Permissions can still create scripts that perform a user switch via the API.

## How to enable/disable

To enable or disable _Switch User_ follow the steps below:

1.  From ScriptRunner, select **Settings**.  
    ![Image of Settings options](/sr4js/files/latest/426115405/426115399/1/1755677817000/Settings_options.png) 
    
2.  Select the **Instance Settings** tab.
    
3.  Toggle the _Switch to a Different User_ option to _on_ or _off_.  
    ![image of switch user location](/sr4js/files/latest/426115405/426115402/1/1755677817000/Scriptrunner_for_Jira_switch_user.png)
    

## How to switch user

With ScriptRunner an administrator can easily switch user to temporarily assume the identity of another. Use the [Switch User](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/switch-user) built-in script to switch users. 

To switch back to your original user, click the **Return to session as \[your name\]** link in the _Switch User_ banner, or log out and in again.

![An example Switch User banner, with linked text.](/sr4js/files/latest/426115405/426115404/1/1755677817000/switch-user-banner+%283%29.png)
