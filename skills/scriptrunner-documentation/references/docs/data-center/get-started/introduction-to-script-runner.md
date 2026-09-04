# Introduction to ScriptRunner

- Platform: data-center
- Space: SR4JS
- Hierarchy: get-started
- Doc ID: doc-sr4js-442887451
- Source: https://docs.adaptavist.com/sr4js/latest/get-started/introduction-to-scriptrunner

For a video introduction to ScriptRunner, see the [Introduction to ScriptRunner](https://docs.adaptavist.com/sr4js/latest/training/course-introduction-to-scriptrunner-for-jira-data-center-server/1-1-video-introduction-to-scriptrunner-for-jira-data-center-server) video. 

ScriptRunner for Jira is an app available on the Atlassian Marketplace that allows you to extend Jira functionality using built-in and custom Groovy scripts. 

ScriptRunner allows you to extend basic Jira functionality, such as JQL, and use scripted [JQL functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions). It also allows you to automate using [escalation services](https://docs.adaptavist.com/sr4js/latest/features/jobs/built-in-jobs/escalation-services) and [workflow functions](https://docs.adaptavist.com/sr4js/latest/features/workflows). You can build scripted fields to show calculated data or use [Behaviours](https://docs.adaptavist.com/sr4js/latest/features/behaviours) to customize how you create and update issues.

Out-of-the-box, you can find several [built-in scripts](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts) ready to go, or you may want to create custom scripts using Groovy and [HAPI](https://docs.adaptavist.com/sr4js/latest/hapi) (our very own API).

![Image of scriptrunner script console page](/sr4js/files/latest/442887451/442887456/1/1758746807000/Script_console_screen.png)

To reach the _Script_ _Console_ in the above screenshot, you need Jira administration permissions. You can reach this screen through the _Administration_ menu.

## Who has access?

ScriptRunner is managed by a Jira administrator, however many users can use its functions. You may not even know you are using a ScriptRunner function, or working through a script condition in a workflow, because of how seamlessly it integrates.

We recommend creating a generic user to carry out some of the automated functions—a user that won't get confused with actual users in your Jira instance.

### Example

At Great Adventure, they have created a user named Tobor. Tobor is a Jira administrator, so he can handle all of the back-end functions that ScriptRunner carries out.

Tobor does consume a license for any of the applications he needs access to; however, by using this generic account, Great Adventure gets clarification on what actions are automated vs. what actions are completed by an actual user in Jira.

![An example Users screen.](/sr4js/files/latest/442887451/442887453/1/1758746806000/Tobor.png)

## ScriptRunner for Jira or just plain old Jira?

While Jira includes many tools that can help automate, report, and move your issues through from start to finish, ScriptRunner does just a bit more! Let’s compare a few items to see what you can do in Jira and then in ScriptRunner. Of course, this list is not everything ScriptRunner can do.

Feature

Jira capability

ScriptRunner for Jira capability

**JQL**

In Jira, you can use JQL to search for issues and create filters. You also use JQL in Service Management queues and SLAs, as well as to power Software boards.

With ScriptRunner, you can use scripted JQL functions to extend what you can do with basic JQL, including the ability to calculate data through the scripted JQL.

**Workflow functions**

In Jira, you can use workflow functions to control who does what with issues in a workflow, or automate some actions after a transition has completed.

With ScriptRunner, you can use workflow functions to further extend these control and automation capabilities, allowing you to manage issues at a more detailed level.

**Custom fields**

In Jira, you can create custom fields to capture more information on your issues.

With ScriptRunner, you can create scripted custom fields that allow you to include calculations in a field. For example you can use a custom field to display the date and time the issue had its status changed.

So, as you see, ScriptRunner adds some great features to Jira that can help you work more efficiently and with better information.

Continue to the [Feature Overview](https://docs.adaptavist.com/sr4js/latest/get-started/feature-overview) page to see a full list of ScriptRunner features and where to find them.

  

* * *

## Related content

-   [Training](https://docs.adaptavist.com/sr4js/latest/training)
-   [Installation](https://docs.adaptavist.com/sr4js/latest/get-started/installation)
-   [Navigation](https://docs.adaptavist.com/sr4js/latest/get-started/navigation)
-   [Update ScriptRunner](https://docs.adaptavist.com/sr4js/latest/get-started/update-scriptrunner)
