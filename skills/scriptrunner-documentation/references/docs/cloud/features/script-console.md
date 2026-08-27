# Script Console

- Platform: cloud
- Space: SR4JC
- Hierarchy: features
- Doc ID: doc-sr4jc-101629019
- Source: https://docs.adaptavist.com/sr4jc/latest/features/script-console

![](/sr4jc/files/latest/101629019/403866192/1/1751558637000/sr-migrate+%281%29.png)

**Migrating from ScriptRunner for Jira Server/DC to Cloud?** **Learn more in our** **[Feature Parity](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/feature-parity-and-script-alternatives#script-console)** **overview.**

## Before you start 

[![](/sr4jc/files/latest/101629019/339510908/1/1741345336000/sr-icon-power.png)](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=script-console&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud)

  

[![](/sr4jc/files/latest/101629019/339510909/1/1741345336000/Copy+of+sr-icon-mortar-board.png)](https://docs.adaptavist.com/sr4jc/latest/training/course-scriptrunner-for-jira-cloud-for-intermediate-users/2-4-module-modifying-existing-scripts)

Visit ScriptRunner HQ to see example scripts. 

  

Learn how to modify existing scripts in the Script Console.

[ScriptRunner HQ](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=script-console&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud)

  

[Training Videos](https://docs.adaptavist.com/sr4jc/latest/training/course-scriptrunner-for-jira-cloud-for-intermediate-users/2-4-module-modifying-existing-scripts)

  

## What is the Script Console?

The Script Console is a place to run scripts. Using the Script Console, you can copy and paste or write a script to run in Jira Cloud. The _Script Console_ enables you to run one-off ad hoc scripts and helps you learn and experiment with the Jira REST API from ScriptRunner. 

You find a script editor, similar to the Script Console, anywhere you choose to use a custom script option (for example, when adding a [Script Listener](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners) or [Scheduled Job](https://docs.adaptavist.com/sr4jc/latest/features/scheduled-jobs)).

The Script Console is useful for testing scripts or performing operations that you only want to do once. So if you want a list of all the spaces on your instance and some details about them, you can run a script for that. Or if you want to delete all spaces that were created by a certain person, you can do that. You can also run maintenance scripts that modify something on your instance.

Like all coding fields in ScriptRunner for Jira Cloud, the Script Console uses an intelligent code editor. Learn more in the [Code Editor](https://docs.adaptavist.com/sr4jc/latest/get-started/scripting-in-scriptrunner-for-jira-cloud#id-.ScriptinginScriptRunnerforJiraCloudvCurrent-codeeditor) documentation. The editor has autocomplete for the following code: 

-   Groovy
-   Atlassian REST API
-   Automatically available variables

The image below illustrates how autocomplete appears in the Script Console: 

![](/sr4jc/files/latest/101629019/448005586/1/1760524549000/script+console+autocomplete.png)

You can read more about [Completions](https://docs.adaptavist.com/sr4jc/latest/hapi#autocompletions) if you are using HAPI in the code editor.

### AutoCompletions for Atlassian's REST API

Similar to [HAPI's automatic completions](https://docs.adaptavist.com/sr4jc/latest/hapi#autocompletions), ScriptRunner for Jira Cloud also provides completions for calls to Atlassian's REST API, helping to make script writing easier and ensuring accuracy. You can follow the example provided below to see how this works.

#### Example: Retrieve a list of users who commented on a work item

For example, suppose you want your script to retrieve a list of everyone who commented on a work item. Since you're _getting_ information, you start with the `get` method and check which APIs relate to comments. You type `get("comment")`and see the following options

![](/sr4jc/files/latest/101629019/416383830/1/1754643284000/jonny+ex+1.png)

For this script, you know the issue key, so select `/rest/api/3/issue/{issueIdOrKey}/comment`. Enter the issue key manually for now; you can replace it with a variable later. Append `asObject(Map).body` to the `get` method call to retrieve the list of comments from the Atlassian REST API. To see available properties, you could go to the [Atlassian Cloud REST API documentation](https://developer.atlassian.com/cloud/jira/platform/rest/v3/intro/#about), however, instead you can rely on the autocompletions. Add a period after `body` to show available completions, the first of which is `comments`, which returns a list of comments.

![](/sr4jc/files/latest/101629019/416383829/1/1754643745000/jonny+ex+2.png)

Using your knowledge of Groovy, apply [the spread operator (\*.)](https://groovy-lang.org/operators.html#_spread_operator) to collect information from each element in the list. Autocomplete shows that `author` is available on the target.

![](/sr4jc/files/latest/101629019/416383828/1/1754643930000/jonny+ex+3.png)

A single user may comment multiple times, so you only need unique authors. Start typing `uni` to see the `unique` method in the completions list.

![](/sr4jc/files/latest/101629019/416383827/1/1754644066000/jonny+ex+4.png)

Using completions reduces the need to switch back and forth between the documentation, helping you code without breaking your flow. While HAPI offers the gold standard for ScriptRunner code editor completions, if you need to fall back to the Atlassian API for more complex cases, we still provide guidance where possible.

## How to use the Script Console

You can either enter the script you want to run directly in the **Script** field or click the **Example scripts** button to select an example script. 

![](/sr4jc/files/latest/101629019/448005585/1/1760524806000/script+console+initial+screen.png)

You also have the option to click **Load** and reuse a script you previously saved in Script Manager. Details on how to do this can be found in [Reuse scripts in the UI](https://docs.adaptavist.com/sr4jc/latest/features/script-manager#id-.ScriptManagervCurrent-ReusescriptsintheUI).

If you choose to reuse one of the many examples provided, rather than writing your own script, you will see the following screen:  
![](/sr4jc/files/latest/101629019/294139625/1/1729263639000/example+scripts+script+console.png)  

1.  Choose an example script from the list provided and the code automatically appears. You also have the option to search for a particular script.
2.  Click **Copy Code** and then **Close**.
3.  Paste the copied code in the code editor.
4.  ****(Optional)**** Click **Script context** to view an information modal highlighting parameters/code variables. For further information on referencing Script Context values, refer to Example Script Variables.  

You can use the Script Console to:

-   Run a script to display information.
-   Run a one-off clean up task.
-   Make one-off or bulk updates to work items, spaces, users, versions etc.

For example, as an admin, you have been given a list of users who have left the company. For security reasons, you need to remove these users as soon as possible. Usually, you would need to search for each name individually and manually delete each user. However, I can enter the list of user names and bulk delete all of them in one action using a script in the _Script Console_.

Using the Script Console is an easy way to make bulk changes to work items returned by a [JQL query](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-queries). For example, I can look for work items with linked support cases and no watchers so I can then automatically add the linked support cases reporter to the related bug as a watcher.

### Run code as user

Code that is run from the Script Console can make requests back to Jira using either the **ScriptRunner Add-on user** or the **Current User**. See the [Run As User section of Workflow Rules](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions/fields) for more information.

* * *

## Related content

-   Take our [ScriptRunner Tour](https://www.scriptrunnerhq.com/atlassian-apps/jira/scriptrunner-for-jira/cloud/get-started).
-   [S](https://docs.adaptavist.com/api/javadoc/cloud/scriptrunner/latest/hapi/jira/groovydoc/com/adaptavist/hapi/cloud/jira/projects/Projects.html#method_summary)ee our [Example Scripts](https://www.scriptrunnerhq.com/help/example-scripts) for Script Console.
