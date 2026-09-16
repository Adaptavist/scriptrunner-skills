# Script Console

- Platform: cloud
- Space: SR4JC
- Hierarchy: Features
- Doc ID: doc-sr4jc-c8b0a945-b128-4886-967f-ff47eccc7df1-f75b5d70332fed0d
- Source: https://docs.adaptavist.com/sr4jc/latest/features/script-console

|  |  |
| --- | --- |
|  | Migrating from ScriptRunner for Jira Server/DC to Cloud? Check out our [ScriptRunner Migration to Cloud](../uncategorized/s/script-runner-migration-to-cloud.md) section. |

## Before you start

|  |  |
| --- | --- |
|  | Visit ScriptRunner HQ to see example scripts.<br>[ScriptRunner HQ website](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=script-console&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud) |
|  | Learn how to modify existing scripts in the Script Console.<br>[Training videos](../training/course-script-runner-for-jira-cloud-for-intermediate-users/2-4-module-modifying-existing-scripts.md) |

## What is the Script Console?

The Script Console is a place to run scripts. Using the Script Console, you can copy and paste or write a script to run in Jira Cloud. The _Script Console_ enables you to run one-off ad hoc scripts and helps you learn and experiment with the Jira REST API from ScriptRunner.

You find a script editor, similar to the Script Console, anywhere you choose to use a custom script option (for example, when adding a [Script Listener](script-listeners.md) or [Scheduled Job](scheduled-jobs.md)).

The Script Console is useful for testing scripts or performing operations that you only want to do once. So if you want a list of all the spaces on your instance and some details about them, you can run a script for that. Or if you want to delete all spaces that were created by a certain person, you can do that. You can also run maintenance scripts that modify something on your instance.

Like all coding fields in ScriptRunner for Jira Cloud, the Script Console uses an intelligent code editor. Learn more in the [Code Editor](https://docs.adaptavist.com/sr4jc/latest/get-started/scripting-in-scriptrunner-for-jira-cloud#code-editor--en) documentation. The editor has autocomplete for the following code:

-   Groovy
-   Atlassian REST API
-   Automatically available variables

The image below illustrates how autocomplete appears in the Script Console:

You can read more about [Completions](https://docs.adaptavist.com/sr4jc/latest/hapi#autocompletions--en) if you are using HAPI in the code editor.

### AutoCompletions for Atlassian's REST API

Similar to [HAPI's automatic completions](https://docs.adaptavist.com/sr4jc/latest/hapi#autocompletions--en), ScriptRunner for Jira Cloud also provides completions for calls to Atlassian's REST API, helping to make script writing easier and ensuring accuracy. You can follow the example provided below to see how this works.

#### Example: Retrieve list of users who commented on a work item

For example, suppose you want your script to retrieve a list of everyone who commented on a work item. Since you're _getting_ information, you start with the `get` method and check which APIs relate to comments. You type `get("comment")` and see the following options

For this script, you know the issue key, so select `/rest/api/3/issue/{issueIdOrKey}/comment`. Enter the issue key manually for now; you can replace it with a variable later. Append `asObject(Map).body` to the `get` method call to retrieve the list of comments from the Atlassian REST API. To see available properties, you could go to the [Atlassian Cloud REST API documentation](https://developer.atlassian.com/cloud/jira/platform/rest/v3/intro/#about), however, instead you can rely on the autocompletions. Add a period after `body` to show available completions, the first of which is `comments`, which returns a list of comments.

Using your knowledge of Groovy, apply [the spread operator (\*. )](https://groovy-lang.org/operators.html#_spread_operator) to collect information from each element in the list. Autocomplete shows that `author` is available on the target.

A single user may comment multiple times, so you only need unique authors. Start typing `uni` to see the `unique` method in the completions list.

Using completions reduces the need to switch back and forth between the documentation, helping you code without breaking your flow. While HAPI offers the gold standard for ScriptRunner code editor completions, if you need to fall back to the Atlassian API for more complex cases, we still provide guidance where possible.

## How to use the Script Console

You can either enter the script you want to run directly in the Script field or click the Example scripts button to select an example script.

Tip: You also have the option to click Load and reuse a script you previously saved in [Script Manager](script-manager.md). Details on how to do this can be found in [Reuse scripts in the UI](https://docs.adaptavist.com/sr4jc/latest/features/script-manager#reuse-scripts-in-the-ui--en).

If you choose to reuse one of the many examples provided, rather than writing your own script, you will see the following screen:

1.  Choose an example script from the list provided and the code automatically appears.
    
    You also have the option to search for a particular script.
    
2.  Click Copy Code and then Close.
3.  Paste the copied code in the code editor.
4.  (Optional): Click Script context to view an information modal highlighting parameters/code variables. For further information on referenceing Script Context values, refer to [Example Script Variables](https://docs.adaptavist.com/sr4jc/latest/features/script-variables/example-script-variables).

You can use the Script Console to:

-   Run a script to display information.
-   Run a one-off clean up task.
-   Make one-off or bulk updates to work items, spaces, users, versions etc.

For example, as an admin, you have been given a list of users who have left the company. For security reasons, you need to remove these users as soon as possible. Usually, you would need to search for each name individually and manually delete each user. However, I can enter the list of user names and bulk delete all of them in one action using a script in the _Script Console_.

Using the Script Console is an easy way to make bulk changes to work items returned by a [JQL query](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-queries). For example, I can look for work items with linked support cases and no watchers so I can then automatically add the linked support cases reporter to the related bug as a watcher.

### Run code as user

Code that is run from the Script Console can make requests back to Jira using either the ScriptRunner Add-on user or the Current User. See the [Run As User section of Workflow Rules](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions/fields#run-as-user--en) for more information.

### Related content

-   Take our [ScriptRunner Tour](https://www.scriptrunnerhq.com/atlassian-apps/jira/scriptrunner-for-jira/cloud/get-started).
-   See our [Example Scripts](https://www.scriptrunnerhq.com/help/example-scripts) for Script Console.
