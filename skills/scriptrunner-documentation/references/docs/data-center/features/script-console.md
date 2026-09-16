# Script Console

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features
- Doc ID: doc-sr4js-bdc13b53-6a30-4fd6-94d1-512dbb612d22-8038e03065e76a0e
- Source: https://docs.adaptavist.com/sr4js/latest/features#script-console--en

|  |  |
| --- | --- |
|  | Migrating to Jira Cloud? This feature is available in Cloud.<br>[Cloud Script Console documentation](../../cloud/features/script-console.md) |

## What is the Script Console?

The _Script Console_ is the place for running one-off ad hoc scripts, and for learning and experimenting with the [Jira REST API](https://docs.atlassian.com/software/jira/docs/api/REST/latest/) and [HAPI](../uncategorized/h/hapi.md).

You can either enter your script directly in the Script field, or click the _File_ tab, and type the path to a file. The file can be a fully-qualified path name to a .groovy file accessible to the server. If you provide a relative path name the file is resolved relative to your _[script roots](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/script-roots)_.

## How to use the Script Console

You can use the _Script Console_ to:

-   Run a script to display information.
-   Run a one-off clean up task.
-   Bulk update issues, projects, users, versions etc.

For example, as an admin you have been given a list of users who have left the company. For security reasons, you need to remove these users as soon as possible. Usually, you would need to search for each name individually and manually delete each user. However, I can enter the list of user names and bulk delete all of them in one action using a script in the _Script Console_.

Using the Script Console is an easy way to make bulk changes to issues returned by a JQL query. For example, I can look for issues with linked support cases and no watchers so I can then automatically add the linked support cases reporter to the related bug as a watcher.

## Before you start

|  |  |
| --- | --- |
|  | See our Introduction to Scripting in ScriptRunner course to learn about using Groovy to write new scripts, and modify existing scripts in ScriptRunner.<br>[Scripting Training](../training/course-introduction-to-scripting-in-script-runner-for-jira-data-center.md) |
|  | Broaden your horizons by exploring Script Console script examples.<br>[Example Scripts](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=script-console&ScriptRunner%5BrefinementList%5D%5Bproduct%5D%5B0%5D=jira) |

## Executing Script Console scripts remotely

You can also execute arbitrary code in the _Script Console_ remotely. Due to the url encoding this is a bit finicky. Assuming we have the following code in a file called script.groovy

```
script.groovy
 
log.debug ("hello")
log.debug ("sailor")
```

We can execute it using the following curl command:

```
curl -u admin:admin -X POST "http://<jira>/jira/rest/scriptrunner/latest/user/exec/" -H "X-Atlassian-token: no-check" -H "Content-Type: application/x-www-form-urlencoded; charset=UTF-8" -H "Accept: application/json" --data-urlencode "scriptText@script.groovy"
```

To execute a file that already exists under a script root:

```
curl -u admin:admin -X POST "http://<jira>/jira/rest/scriptrunner/latest/user/exec/" -H "X-Atlassian-token: no-check" -H "Content-Type: application/x-www-form-urlencoded; charset=UTF-8" -H "Accept: application/json" --data-urlencode "scriptFile=foo/bar.groovy"
```

## Related content

-   [Dynamic Forms](../best-practices/dynamic-forms.md)
-   [HAPI](../uncategorized/h/hapi.md)
-   [Write Code](../best-practices/write-code.md)
