# Operations on Tabs

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Behaviours > Behaviours Examples
- Doc ID: doc-sr4js-502815da-bd80-4328-8984-61af06b29f2b-016d1760a826c212
- Source: https://docs.adaptavist.com/sr4js/latest/features#behaviours--en#behaviours-examples--en#operations-on-tabs--en

If your screen has multiple tabs you can use our Behaviours feature to hide, disable, or switch to a tab. By leveraging these functions you can create a more intuitive and controlled user experience.

`hideTab()`

This function allows you to completely remove a tab from view. It's particularly useful when you want to prevent certain fields from being edited at specific stages of the workflow or by particular groups or roles.

`disableTab()`

You can choose to disable a tab rather than hide it entirely. This approach keeps the tab visible but inaccessible, indicating to users that the tab exists but is not applicable or forbidden at that moment.

`switchTab()`

This function allows you to programmatically change the active tab. It's especially valuable when used in conjunction with hiding or disabling tabs, as you can direct users to a specific alternative tab. If you don't specify a target tab when hiding or disabling another, the system will default to the left-most tab that remains visible and active. However, we recommend using this function wisely, as frequent automatic tab switching in response to field changes might confuse users.

Note: For more API details see the [API quick reference](https://docs.adaptavist.com/sr4js/latest/features/behaviours/api-quick-reference) page.

## Should I add an initialiser or server-side script?

When setting up a behaviour you may want to determine when your behaviour runs:

-   If you want the behaviour to run when the __Create Issue_, _Edit Issue_, or _Transition issue_ page loads_ , set up an Initialiser. If you are manipulating tabs based on groups, roles, or stages in the workflow, we recommend you add an initialiser script.
-   If you want the behaviour to run every time a user updates the value of a field, we recommend set up a server-side script to react to the user input . The option to add a server-side script appears once you have added a field.

## Examples

Below we provide two examples for hiding tabs. The simple example displays the usage of `hideTab()`, `disableTab()`, and `switchTab()` in one script. The step-by-step example walks you through a practical example that you can easily follow.

### Simple example

In this example, we have three tabs ( Main, Testing, and Customer). When the current user is a member of a group, such as _jira-users_, we want to:

-   Hide the Main tab
-   Disable the Testing tab
-   Switch to the Customer tab

We map our behaviour to the _IssueWithTabs_ issue type and use the following code in the Initialiser script editor:

```
def user = Users.getLoggedInUser()
if
 (user.isMemberOfGroup('jira-users')) {
    hideTab(0)
    disableTab(1)
    switchTab(2)
}
```

Tip: When referencing tabs by their index, the first tab is indexed as `0`, the second as `1`, and so on. Alternatively, you can use the tab names directly instead of their indices: 

```
def user = Users.getLoggedInUser()
if (user.isMemberOfGroup('jira-users')) {
    hideTab('Main')
    disableTab('Testing')
    switchTab('Customer')
}
```

This results in the following whenever a member of the _jira-users_ group creates, transitions, or edits an _IssueWithTabs_ issue:

### Step-by-step example

In this example, we have three tabs (Field Tab, Priority Tab, and Admin Tab). We want to hide the Admin Tab if a user is not an admin.

Tip: If you want to follow this example you must set up an issue screen with at least three tabs, with the third tab being the one you want to hide.

1.  Navigate to ScriptRunner > Behaviours.
2.  Select Create Behaviour.
3.  Enter a name for the behaviour. In this example we enter `Hide admin tab from non admin`.
4.  Enter a description for the behaviour. This field is optional.
5.  Select Create Mapping.
6.  Then select the project and issue type(s) to map this behaviour to.
7.  Select Add Mapping to confirm the mapping.
8.  Select Create to create the behaviour.
    
    You're taken to a screen where you can configure the behaviour further.
    
9.  Optional: Enter a guide workflow.
10.  Under Initialiser select Create Script.
11.  Copy the following code into the inline script editor:
     
     ```
     def user = Users.getLoggedInUser()
     if (!user.isAdmin()) {
         hideTab(2)
     }
     ```
     
12.  Select Save Changes.

You can test to see if this behaviour works by using the [switch user](https://docs.adaptavist.com/sr4js/latest/get-started/settings/switch-user-function#how-to-switch-user--en) function.

## Related content

-   [Behaviours](https://docs.adaptavist.com/sr4js/latest/features/behaviours)
-   [Behaviours Tutorial](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-tutorial)
-   [API Quick Reference](https://docs.adaptavist.com/sr4js/latest/features/behaviours/api-quick-reference)
