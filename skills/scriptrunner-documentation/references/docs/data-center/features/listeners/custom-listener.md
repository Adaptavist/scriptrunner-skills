# Custom Listener

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > listeners
- Doc ID: doc-sr4js-442887781
- Source: https://docs.adaptavist.com/sr4js/latest/features/listeners/custom-listener

Using groovy scripts as workflow functions instead of full-blown java plugins is much faster, more maintainable and flexible, and has all the same capabilities as java plugins. Explicit compilation is much over-rated.

As well as listening for issue events, you can also handle project, version and user-related events. Examples of this might be:

-   mail a new user when they are created in Jira
    
-   notify downstream systems when a _version_ is released
    
-   create link git repositories or Confluence spaces when a project is created
    

There are a couple of ways to structure your listener code.

The easiest, and recommended way, is to just write a script. You can use an inline script, or point to a file in your script roots, as usual.

The `event` object will be passed to the script in the binding. For issue related events, this will be an [`IssueEvent`](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/event/issue/IssueEvent.html). So the simplest listener might look like:

![](/sr4js/files/latest/442887781/442887794/1/1758746881000/Custom_listener_1.png)

For other types of listeners, the event type will be whatever you selected to listen to; for example, selecting ProjectUpdatedEvent in the Events field means the event object will provide access to properties/methods on the [`ProjectUpdatedEvent`](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/event/ProjectUpdatedEvent.html) type.

![](/sr4js/files/latest/442887781/442887799/1/1758746881000/Custom_listener_2.png)

If you are listening to multiple events because the code is mostly common, you can distinguish between them using `instanceof`:

![](/sr4js/files/latest/442887781/442887800/1/1758746881000/Custom_listener_3.png)

## Issue Event Bundles

[SRJIRA-1929](https://productsupport.adaptavist.com/browse/SRJIRA-1929) has been fixed, which means your specified event handler will be correctly called for the relevant events.

Jira 6.3.10 and above broadcasts "bundles" of events, containing all relevant events. ScriptRunner will unbundle the events, and call all relevant script listeners for each event.

Previous to this fix, if you had a handler listening for the _Issue Assigned_ event, it would only have been invoked if the issue assignment was the **only** action made. If someone had updated or commented an issue at the same time as assigning it, the _Issue Updated_ or _Issue Commented_ event would have been published, and your _issue assigned_ handler would not run.

After this fix, it will run, but the consequence is it will be called more often than before, and perhaps when you do not expect it to. For instance, if you create an issue and set the assignee at the same time, this will invoke any _Issue Assigned_ listeners (where previously it would not).

We advise you to write your listeners in such a way that this makes sense…​ for instance, if you want to do something when the assignee changes, then either consider the initial assignee to be a change, or to check the previous value of that field.

Or, you can choose to ignore events that were raised alongside a more "significant" event. To do this, you can make use of the [`IssueEventBundle`](https://docs.atlassian.com/jira/latest/com/atlassian/jira/event/issue/IssueEventBundle.html), which is available in the script binding as `bundle`.

Example:

**An error occured**

There is a problem with the file path provided or a failure to connect with Bitbucket. Check the File Path provided, Application Link for Bitbucket Data Center or the permissions of the app password for Bitbucket Cloud. [Contact your system administrator.](https://docs.adaptavist.com/contactadministrators.action)

**An error occured**

There is a problem with the file path provided or a failure to connect with Bitbucket. Check the File Path provided, Application Link for Bitbucket Data Center or the permissions of the app password for Bitbucket Cloud. [Contact your system administrator.](https://docs.adaptavist.com/contactadministrators.action)

## Custom Listener Example

The following example will post a message to a cloud instant messaging provider when a version is released. The listener is configured for the [`VersionReleaseEvent`](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/event/project/VersionReleaseEvent.html).

```
import com.atlassian.jira.event.project.VersionReleaseEvent
import groovy.json.JsonBuilder
import groovyx.net.http.ContentType
import groovyx.net.http.HTTPBuilder
import groovyx.net.http.Method

VersionReleaseEvent event = event

def http = new HTTPBuilder("https://hooks.slack.com")
http.request(Method.POST, ContentType.TEXT) {
    uri.path = "/services/XXXX/YYYYY/ZZZZZ" // <1>
    body = new JsonBuilder([
        channel   : "#dev",
        username  : "webhookbot",
        text      : "Woop!: Version: *${event.version.name}* " +
            "has been released in project *${event.version.project.name}*. We're off to the pub!!", // <2>
        icon_emoji: ":ghost:",
        mrkdwn    : true,
    ]).toString()
}
```

## Send a custom email (non-issue events)

Use the _Send a Custom Email_ listener functionality to send custom emails in reaction to non-issue events such as:

-   Create a project
    
-   Add a new user
    
-   Update a component
    
-   Third party plugin events
    

See [Send a custom email](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts) for more information on configuring custom emails for issue events.

Declare the event variable in **Condition and Configuration** to enable [Code Insights](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/code-editor).

For example, we want to send an email after a version is released. In that case, the selected event will be `VersionReleaseEvent` and the script in the **Condition and Configuration** field will be:

```
import com.atlassian.jira.event.project.VersionReleaseEvent

def event = event as VersionReleaseEvent
def version = event.version

// Store in then config map, the version and the project name so we can use them later in our templates
config.'versionName' = version.name
config.'projectName' = version.project.name
true
```

Now we can use the above variables in our **Templates**, for example the **Email template** will be:

```
Version $versionName for project $projectName just released.

Congratulations y'all !
```

## Jira Software Events

This section gives you an idea of how to use Jira Software events. The Jira Software events will be available automatically if Jira Software is installed and enabled. A Script can listen to various Jira Software events (such as `SprintStartedEvent`, `SprintClosedEvent`) and take action based on your requirements. For an example send an email with sprint data when a sprint starts or send an email with list of incomplete issues when a sprint finishes.

![](/sr4js/files/latest/442887781/442887803/1/1758746881000/Custom_listener_4.png)

To get the list of incomplete issues a custom listener can be configured to listen to `SprintClosedEvent` with the following code fragment:  

```
import com.atlassian.greenhopper.service.rapid.view.RapidViewService
import com.atlassian.greenhopper.service.sprint.Sprint
import com.atlassian.greenhopper.web.rapid.chart.HistoricSprintDataFactory
import com.atlassian.jira.component.ComponentAccessor
import com.onresolve.scriptrunner.runner.customisers.ast.PluginModuleTransformer
import com.onresolve.scriptrunner.runner.customisers.WithPlugin

@WithPlugin("com.pyxis.greenhopper.jira")

def historicSprintDataFactory = PluginModuleTransformer.getGreenHopperBean(HistoricSprintDataFactory)
def rapidViewService = PluginModuleTransformer.getGreenHopperBean(RapidViewService)
def user = ComponentAccessor.jiraAuthenticationContext.getLoggedInUser()

def sprint = event.sprint as Sprint

if (sprint.state == Sprint.State.CLOSED) {
    def view = rapidViewService.getRapidView(user, sprint.rapidViewId).value
    def sprintContents = historicSprintDataFactory.getSprintOriginalContents(user, view, sprint)
    def sprintData = sprintContents.value
    if (sprintData) {
        def incompleteIssues = sprintData.contents.issuesNotCompletedInCurrentSprint*.issueId
        log.warn "incompelte issues id : ${incompleteIssues}"
    }
}
```

## Service Management Events

Jira Service Management events will be available automatically if Service Management is installed and enabled. ScriptRunner supports large number of events which users can intercept according to the requirements.

![](/sr4js/files/latest/442887781/442887804/1/1758746881000/Custom_listener_5.png)

The following example shows how to get information from `SlaThresholdsExceededEvent`. The event is triggered when configured SLA’s `goal` time exceeds. The event contains information of the issue and at what time the resolution has been violated.

```
import com.atlassian.servicedesk.workinprogressapi.sla.threshold.SlaThresholdsExceededEvent
import com.onresolve.scriptrunner.runner.customisers.WithPlugin

@WithPlugin("com.atlassian.servicedesk")

def event = event as SlaThresholdsExceededEvent
def issue = event.issue
def time = event.time
log.warn "Time to resolution violated for issue : ${issue.summary} at ${time}"
```

## "Heritage" Custom Listeners

This is the old method of using custom listeners. It still works, but you are not advised to use it for new code:

1.  Write your listener as groovy - but as a groovy class, not a groovy script. You could just extend AbstractIssueEventListener, but your class merely needs to respond to **workflowEvent(IssueEvent)**.
    
2.  Copy the .groovy file to the correct place under the _script roots_ directory (depending on its package).
    
3.  Go to Script Listeners, and enter the name of the package and class, e.g. _com.onresolve.jira.groovy.listeners.ExampleListener_. This is in the distribution so you could try this actual class, it just logs the events it catches.
    

If you update the groovy class it will be reloaded automatically.

The simplest possible listener class looks like this:

```
class ExampleListener extends AbstractIssueEventListener {
    Category log = Category.getInstance(ExampleListener.class)

    @Override
    void workflowEvent(IssueEvent event) {
        log.debug "Event: ${event.getEventTypeId()} 
            fired for ${event.issue} and caught by ExampleListener"
    }
}
```
