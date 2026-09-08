# Script Console

- Platform: data-center
- Space: SR4JS
- Hierarchy: features
- Doc ID: doc-sr4js-442886856
- Source: https://docs.adaptavist.com/sr4js/latest/features/script-console

![](/sr4js/files/latest/442886856/441364746/1/1750863748000/sr-icon-cloud.png)

**Migrating to Jira Cloud? This feature is available in Cloud. Check out our** **[Cloud Script Console documentation](https://docs.adaptavist.com/sr4jc/latest/features/script-console)** **for more details.** 

## What is the Script Console?

The _Script Console_ is the place for running one-off ad hoc scripts, and for learning and experimenting with the [Jira REST API](https://docs.atlassian.com/software/jira/docs/api/REST/latest/) and [HAPI](https://docs.adaptavist.com/sr4js/latest/hapi).

You can either enter your script directly in the **Script** field, or click the _File_ tab, and type the path to a file. The file can be a fully-qualified path name to a .groovy file accessible to the server. If you provide a relative path name the file is resolved relative to your _[script roots](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/script-roots)_.

## How to use the Script Console

You can use the _Script Console_ to:

-   Run a script to display information.
-   Run a one-off clean up task.
-   Bulk update issues, projects, users, versions etc. 

For example, as an admin you have been given a list of users who have left the company. For security reasons, you need to remove these users as soon as possible. Usually, you would need to search for each name individually and manually delete each user. However, I can enter the list of user names and bulk delete all of them in one action using a script in the _Script Console_.

Using the Script Console is an easy way to make bulk changes to issues returned by a JQL query. For example, I can look for issues with linked support cases and no watchers so I can then automatically add the linked support cases reporter to the related bug as a watcher.

## Before you start

![Hat icon](/sr4js/files/latest/442886856/442886866/1/1758746745000/Copy+of+sr-icon-mortar-board.png)

See our Introduction to Scripting in ScriptRunner course to learn about using Groovy to write new scripts, and modify existing scripts in ScriptRunner.

  

![Book icon](/sr4js/files/latest/442886856/442886867/1/1758746745000/sr-icon-book.png)

Broaden your horizons by exploring Script Console script examples.

[Scripting Training](https://docs.adaptavist.com/sr4js/latest/training/course-introduction-to-scripting-in-scriptrunner-for-jira-data-center-server)

  

[shortcut Example Scripts](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=script-console&ScriptRunner%5BrefinementList%5D%5Bproduct%5D%5B0%5D=jira)

## Executing Script Console scripts remotely

You can also execute arbitrary code in the _Script Console_ remotely. Due to the url encoding this is a bit finicky. Assuming we have the following code in a file called **script.groovy**

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

-   [Dynamic Forms](https://docs.adaptavist.com/sr4js/latest/best-practices/dynamic-forms)
-   [HAPI](https://docs.adaptavist.com/sr4js/latest/hapi)
-   [Write Code](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code)
