# Listeners

- Platform: data-center
- Space: SR4JS
- Hierarchy: features
- Doc ID: doc-sr4js-442886980
- Source: https://docs.adaptavist.com/sr4js/latest/features/listeners

![](/sr4js/files/latest/442886980/441364752/1/1750863710000/sr-icon-cloud.png)

**Migrating to Jira Cloud? This feature has partial parity in Cloud. Check out our [Cloud Feature Parity documentation](https://docs.adaptavist.com/display/_PK/SR4JC/feature-parity#listeners) for more details.**

## What are Listeners?

A listener is an automated procedure or function in ScriptRunner that waits (or listens) for a specific event to occur in Jira and then carries out an action if the event occurs. Listeners sit on your instance and wait for an event to happen before executing the listener script. ScriptRunner for Jira includes several built-in listener options, as well as the ability to create your own completely custom listeners using Groovy. 

## How to use Listeners

You may want to use a listener to:

-   Send an email or notification to a list of emails or all the users defined in a user picker field when the issue is commented on.
-   Transition an issue to another status when it is assigned to a user who is a member of the _Developers_ role using the _Issue Assigned_ event.
-   Automatically update fields for an existing issue when a user edits a specific value for a related field using the _Issue Updated_ event.

On paper, ScriptRunner listeners and [post functions](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions) seem similar; however, listeners allow you more control over automated actions than you would get with a post function. For example, whenever there is a _Critical_ level priority issue in a certain project, you want a message to be sent to a Slack channel. If you use a post function to do this, an event would fire only after a transition, not if the issue is edited. Therefore, if the priority of the issue was edited to _Critical_ the post function would not catch it until after the issue had been transitioned. To achieve this use case, you would use a listener to catch a change in priority when it happened. 

Before you Start

![](/sr4js/files/latest/442886980/442886992/1/1758746765000/Copy+of+sr-icon-mortar-board.png)

See our Using Listeners in ScriptRunner training module to learn about setting up and using listeners.

  

![](/sr4js/files/latest/442886980/442886993/1/1758746765000/sr-icon-book.png)

Broaden your horizons by exploring the Example Scripts for custom listener examples.

[Listener Training](https://docs.adaptavist.com/sr4js/latest/training/course-introduction-to-scriptrunner-for-jira-data-center-server/1-3-video-using-listeners-in-scriptrunner-for-jira-data-center-server)

  

[shortcut Example Scripts](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=listeners&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=dataCenter)
