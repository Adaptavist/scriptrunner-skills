# HAPI

- Platform: data-center
- Space: SR4JS
- Hierarchy: n/a
- Doc ID: doc-sr4js-442886573
- Source: https://docs.adaptavist.com/sr4js/latest/hapi

![](/sr4js/files/latest/442886573/441364720/1/1750777686000/sr-icon-cloud.png)

**Migrating to Jira Cloud? This feature is available in Cloud. See our** **[HAPI Cloud documentation](https://docs.adaptavist.com/sr4jc/latest/hapi)** **for more details.** 

## What is HAPI?

HAPI is an API (application programming interface) for doing common tasks in Jira, including managing issues, searching for issues, updating fields and much more! HAPI is a simple alternative to Jira's regular API and can be used in your Groovy scripts. 

![Lightning Bolt icon](/sr4js/files/latest/442886573/442886600/1/1758746716000/sr-icon-power.png)

  

[![Graduation hat icon](/sr4js/files/latest/442886573/442886601/1/1758746716000/Copy+of+sr-icon-mortar-board.png)](https://www.youtube.com/watch?v=UEVWmn3RHi4)

Visit ScriptRunner HQ to find out more about HAPI. 

  

Check out our HAPI walkthrough video for a demonstration of how to use HAPI.

[ScriptRunner HQ](https://www.scriptrunnerhq.com/locker/hapi)

  

[Walkthrough Video](https://www.youtube.com/watch?v=UEVWmn3RHi4)

## Who is HAPI for?

**Everyone**. Whether you're a complete beginner or an experienced developer, HAPI is for you and your business. HAPI increases productivity and efficiency by allowing you to create automations and customizations faster than ever.

For example, look how simple the HAPI script is for creating an issue:

```
            Issues.create('ABC', 'Task') {
                setSummary('my first HAPI 😍')
            }
```

## Why?

We want all users to be able to script in ScriptRunner, not just those who are familiar with Jira API. We want the barrier to entry to be next to nothing, and we think HAPI achieves that. 

## What else should you know?

### Completions

When using HAPI you'll notice helpful completions. We've developed completions to make your scripting experience even easier. For example, you don't have to remember or search for project keys; HAPI provides you with a list of project keys. The same goes for many other options you previously had to search for or remember. Give HAPI a go and see how many helpful completions there are! 

Your browser does not support the HTML5 video element

### Keyboard shortcut

You will find the keyboard shortcut **Control + Space** very useful when using HAPI. This shortcut allows you to display completions when they disappear. There are a number of reasons you could want to display completions again. For example:

-   You’ve started typing and selected the wrong value, so you go back and delete some text and completions no longer display.
-   You’ve clicked out of the script console and when you return completions no longer display.
-   You’ve deleted a chosen option in a string and want to see what all of the options were again.

Your browser does not support the HTML5 video element

We also list more keyboard shortcuts within ScriptRunner. You can find these in the script console in the **Documentation and Tips** section.

### Example scripts

Our example scripts also include HAPI code samples, that way you can get started with just a click! We've added the example scripts you will find the most useful. 

Your browser does not support the HTML5 video element

You can also find [HAPI example scripts](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=dataCenter&ScriptRunner%5BrefinementList%5D%5Btag%5D%5B0%5D=hapi) on our ScriptRunner HQ website. 

### Compatibility

HAPI is compatible with Jira Software and Jira Service Management (JSM).

### Javadocs

See our [Javadocs](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/9.18.0/hapi/jira/groovydoc/index.html) for a full list of HAPI classes and API methods.

### Latest updates

See our [Changelog](https://docs.adaptavist.com/sr4js/latest/release-notes/hapi-changelog) page for all of the latest updates to HAPI. 

## What's next?

![Gauge icon](/sr4js/files/latest/442886573/442886609/1/1758746718000/sr-icon-speedometer.png)

Create an issue with HAPI and see how easy it is to use!

[Create an issue](https://docs.adaptavist.com/sr4js/latest/hapi/create-issues)

**If you notice something missing, [let us know](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/21).**
