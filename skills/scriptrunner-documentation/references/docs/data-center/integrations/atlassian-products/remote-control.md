# Remote Control

- Platform: data-center
- Space: SR4JS
- Hierarchy: integrations > atlassian-products
- Doc ID: doc-sr4js-101624736
- Source: https://docs.adaptavist.com/sr4js/latest/integrations/atlassian-products/remote-control

_Remote Control_ allows you to easily execute code on other Atlassian applications with ScriptRunner installed.

You could do the same by writing and deploying remote APIs, eg REST endpoints. However, this method allows you to run arbitrary code on any instance, without deploying it first. You can execute code locally, pass a value to a remote instance, manipulate it, and return some new value to your local instance.

If you have many instances of an application you can easily run code across all the instances - possible examples might be:

-   Check if any projects are anonymously accessible
    
-   Find the version of a common plugin
    
-   Anything you could do with remote events, e.g. mark a Jira version as released when a tag is created in Bitbucket
    

## Example

This script gets the number of issues in both the local instance, and the "applinked" instance, and returns a message to the console.

```
import com.atlassian.jira.component.ComponentAccessor
import com.onresolve.scriptrunner.remote.RemoteControl

def issuesInRemote = RemoteControl.forPrimaryJiraAppLink().exec {
    ComponentAccessor.issueManager.issueCount
}

def issuesInLocal = ComponentAccessor.issueManager.issueCount

"There are ${issuesInRemote} issues in the remote instance, ${issuesInLocal} in the local instance"
```

As you can see it’s as easy to write a script to operate on a remote instance as it is on a local instance.

## Security

Executing code on the remote application requires administrator privileges on the target application, in the same way as executing custom code or a built-in script requires administrator permissions. If you are running code as the current user, you may need to switch user before executing the remote closure code.

If you cannot or do not want to switch to an admin user, you can call a REST endpoint rather than using _remote control_, where you can set the security as you choose.

## Under the Hood

Under the covers, we serialize the _closure_ you pass to the exec method, and any variables it uses. This is sent to the remote machine in binary form, then executed. Any results are sent back to the calling instance.

When you use code like `.each { …​ }` the part in the brackets is a _closure_.

This means, that any variables passed in or back from the closure must be _serializable_. In practice, if you stick to passing simple types like strings, numbers, dates, or _Collections_ (Lists, Maps etc) of these types it will work fine.

If you don’t read any further, just pass around strings, numbers, dates, etc or _Collections_ thereof.

If you attempt to pass something not simple, e.g. a [Jira project object](https://docs.atlassian.com/jira/server/com/atlassian/jira/project/Project.html) you will get an exception:

```
import com.atlassian.jira.component.ComponentAccessor
import com.onresolve.scriptrunner.remote.RemoteControl

def project = ComponentAccessor.projectManager.getProjectObjByKey("JRA")

RemoteControl.forPrimaryJiraAppLink().exec {
    log.debug project.versions
}
```

results in an exception: **`Caused by: [java.io](http://java.io).NotSerializableException: com.atlassian.jira.project.ProjectImpl`**.

This applies equally to returning objects from the closure. So, rather than returning a Collection of [`Version`](https://docs.atlassian.com/jira/server/com/atlassian/jira/project/version/Version.html) objects we return just their names:

```
import com.atlassian.jira.component.ComponentAccessor
import com.onresolve.scriptrunner.remote.RemoteControl

def projectKey = "JRA"

def remoteVersions = RemoteControl.forPrimaryJiraAppLink().exec {
    def project = ComponentAccessor.projectManager.getProjectObjByKey(projectKey)
    project.versions.collect { it.name }
}

"Versions for project: $projectKey on the remote are: ${remoteVersions}"
```

Similarly, objects like ProjectManager etc. cannot be serialized and passed to the remote (or back), so you need to retrieve it from the `ComponentAccessor` (or `ComponentLocator` on Bitbucket and Confluence) inside the closure.

### Optional Returns

You may recall that the `return` keyword is optional in groovy…​ if omitted the result of the last statement executed in a closure or method will be returned.

This can cause inadvertent problems with _remote control_ \- for example, imagine a case where you are creating an issue on a remote instance:

```
RemoteControl.forPrimaryJiraAppLink().exec {
    def issueManager = ComponentAccessor.getComponent(IssueManager)
    issueManager.createIssueObject("admin", [
        summary: "a new issue",
        // etc
    ])
}
```

Because `createIssueObject` returns an `Issue`, and this statement is the last in the closure, the system attempts to return the `Issue` object from the remote application. This will fail because `Issue` is not serializable: `**io.remotecontrol.client.UnserializableReturnException: The return value of the command was not serializable, its string representation was 'JRA-13'**`

  

Solutions might be just returning the issue key, or, if you don’t care about the return value, return nothing:

```
RemoteControl.forPrimaryJiraAppLink().exec {
    def issueManager = ComponentAccessor.getComponent(IssueManager)
    issueManager.createIssueObject("admin", [
        summary: "a new issue",
        // etc
    ])
    null
}
```

## Running Code on Multiple Instances

By iterating through the application links of a particular application type, you can execute code on multiple instances sequentially:

```
import com.atlassian.applinks.api.ApplicationLinkService
import com.atlassian.applinks.api.application.jira.JiraApplicationType
import com.atlassian.jira.component.ComponentAccessor
import com.onresolve.scriptrunner.remote.RemoteControl

def applicationLinkService = ComponentAccessor.getComponent(ApplicationLinkService)
def jiraAppLinks = applicationLinkService.getApplicationLinks(JiraApplicationType) // <1>

def issueTotals = jiraAppLinks.collect { appLink -> // <2>
    RemoteControl.forAppLink(appLink).exec {
        ComponentAccessor.issueManager.issueCount
    }
}

"Issue totals are: ${issueTotals.join(", ")}, total: ${issueTotals.sum()}."
```

**Line 7:** Get all Jira-type application links

**Line 9:** `collect` the results into a list

## Running Code on Unlinked Instances

You can also execute code on instances without an application link, so long as you can authenticate as an administrator. Example:

```
import com.atlassian.jira.component.ComponentAccessor
import com.onresolve.scriptrunner.remote.RemoteControl

def currentUser = RemoteControl.forUrlWithBasicAuth("https://jira.acme.com", "admin", "secret").exec {
    ComponentAccessor.jiraAuthenticationContext.getLoggedInUser()?.name
}

"Logged in to the remote as ${currentUser}"
```

## Running Code on Different Products

So far all the examples have focused on running code an another Jira instance, or instances, from an existing Jira. This is relatively easy, and the same approach works for all supported products.

What if you needed to run a script on Bitbucket from a Jira instance? For example, you may wish to find all projects that don’t have a matching Bitbucket project (by key), or check that no users are permissioned in a Bitbucket repository except the developers role for the corresponding project.

In this case you need to use an API for an application that is not native - the problem is the Bitbucket API is not available from Jira. Whilst you could do it all with reflection this is quite tricky.

What we do here is use [_Grape_](http://docs.groovy-lang.org/latest/html/documentation/grape.html) to grab the relevant API dependency. This will take a few seconds to download the relevant jar file, but that delay is only the first time the script is run.

Using the Bitbucket API from Jira:

```
import com.atlassian.bitbucket.project.ProjectService
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.sal.api.component.ComponentLocator
import com.onresolve.scriptrunner.remote.RemoteControl

@Grapes([ // <1>
    @Grab("com.atlassian.bitbucket.server:bitbucket-api:5.1.0"),
    @GrabExclude("com.atlassian.annotations:atlassian-annotations")
])
def dummy = 1 // <2>

def jraProjectKeys = ComponentAccessor.projectManager.projectObjects*.key

def bbsProjKeys = RemoteControl.forPrimaryBitbucketAppLink().exec {
    def projectService = ComponentLocator.getComponent(ProjectService)
    projectService.findAllKeys()
}

(jraProjectKeys - bbsProjKeys).each {
    log.warn("No Bitbucket project for JIRA project: $it")
    // create it...
}

(bbsProjKeys - jraProjectKeys).each {
    log.warn("No JIRA project for Bitbucket project: $it")
    // create it...
}
```

**Line 6:** _Grab_ the Bitbucket API dependency.

**Line 10:** A dummy variable, as annotations need to annotate "something."

If you have problems or you find this too difficult, use could use remote events, or write a REST endpoint in Bitbucket and call it from Jira.

## Synchronizing Worklogs Example

Internally, we use several Jira instances. We do our support and development on one instance, but have to log our time on another instance. We don’t want to duplicate issues across as this causes confusion, just on the time-tracking instance we just have several bucket tickets for the combination of products and whether it’s development, maintenance or support.

The problem with this is that the development leads cannot drill down to issues where the time spent. Our solution uses an event listener or worklog created/updated/deleted, and _remote control_ to create or update the worklog on the target ticket.

The event listener looks like:

![](/files/101638529/209688584/1/1701272687000/Remote_control_screen.png)

As in the example above, the `.exec()` method can take multiple closures, not just one. If used like this the returned value(s) of each closure are passed to the next one. This is a good way of reusing code, as with _remote control_ you cannot call a method defined in the script, outside of the closure.
