# HAPI

- Platform: cloud
- Space: SR4JC
- Hierarchy: n/a
- Doc ID: doc-sr4jc-288524072
- Source: https://docs.adaptavist.com/sr4jc/latest/hapi

HAPI is an API used for carrying out common tasks in Jira. These can include managing or searching for work items, updating fields, and more. HAPI is not a _new_ programming language; it's essentially plain Groovy, but it gives you a simpler alternative to Jira's regular API, and you can mix and match HAPI calls with Jira API.

[![](/sr4jc/files/latest/288524072/288524076/1/1722349177000/sr-icon-power.png)](https://www.scriptrunnerhq.com/inspiration/blog/hapi-arrives-on-jira-cloud)

  

[![](/sr4jc/files/latest/288524072/288524074/1/1722349178000/Copy+of+sr-icon-mortar-board.png)](https://youtu.be/vzILSc8W9b8?si=_geBeggUANECSfT-)

Visit ScriptRunner HQ to find out more about HAPI. 

  

Check out our HAPI walkthrough video for a demonstration of how to use HAPI.

[ScriptRunner HQ](https://www.scriptrunnerhq.com/inspiration/blog/hapi-arrives-on-jira-cloud)

  

[Walkthrough Video](https://youtu.be/vzILSc8W9b8?si=_geBeggUANECSfT-)

## Who is HAPI for?

Whether you're a complete beginner or an experienced developer, HAPI is for you and your business. It increases productivity and efficiency by allowing you to create automations and customizations faster than ever, and helping you understand the code better.

For example, look how simple the HAPI script is for creating a work item:

```
WorkItems.create('ABC', 'Task') {
	setSummary('my first HAPI')
}
```

We want all users to be able to script in ScriptRunner, not just those who are familiar with the Jira API, and we think HAPI achieves that. HAPI **does not require** you to [rewrite existing scripts](https://docs.adaptavist.com/sr4jc/latest/hapi/rewrite-scripts-with-hapi). However, should you wish to make your current scripts more manageable, then you might want to update them to use HAPI.

## Permissions

HAPI **respects the permissions** of the current user _by default_. Using HAPI does not change any of the permissions ScriptRunner already has. 

Note that some operations in Jira are restricted for Atlassian Connect apps, and HAPI runs on ScriptRunner, which is a Connect app. For example, read about [group membership management](https://developer.atlassian.com/cloud/jira/platform/rest/v2/api-group-groups/#api-rest-api-2-group-user-post).  

This limitation is not specific to HAPI; it applies to all Connect apps, so even writing the REST request directly will not work when coming from ScriptRunner.

## Autocompletions

When using HAPI in the code editor, you'll notice helpful autocompletions with available methods within the context of your operation. We've developed autocompletions to make your scripting experience even easier. For example, you don't have to remember or search for space keys; HAPI provides you with a list of space keys. The same goes for many other options you previously had to search for or remember. Give HAPI a go and see how many helpful autocompletions there are! 

  

Your browser does not support the HTML5 video element

### Keyboard shortcut

You will find the keyboard shortcut **Control + Space** very useful when using HAPI in the code editor. This shortcut allows you to display autocompletions when they disappear. There are a number of reasons you could want to display autocompletions again. For example:

-   You’ve started typing and selected the wrong value, so you go back and delete some text, and autocompletions no longer display.
-   You’ve clicked out of the script console, and when you return, autocompletions no longer display.
-   You’ve deleted a chosen option in a string and want to see what all of the options were again.

Your browser does not support the HTML5 video element

When viewing an autocomplete suggestion, pressing **Control + Space** again displays any associated [Javadocs](https://docs.adaptavist.com/api/javadoc/cloud/scriptrunner/latest/hapi/jira/groovydoc/index.html) for the selected suggestion.

## Performance

HAPI has been developed with the performance needs of large instances in mind. Under the hood, HAPI optimises the usage of the Jira REST API. However, script execution time is limited, so handling larger datasets may result in time-outs before tasks are completed. HAPI is a powerful API, so it will not complain when you try to perform larger tasks, such as when performing a JQL search over millions of work items. Nevertheless, this may hit the script time-out limits.

## Example scripts

Our example scripts also include HAPI code samples, so you can get started with just a click! We've added the example scripts you will find the most useful. 

Your browser does not support the HTML5 video element

### ScriptRunner HQ

We've updated a number of [Example scripts](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud) to include HAPI methods, now available at our dedicated [ScriptRunner website](https://www.scriptrunnerhq.com). If you have used any of these scripts in the past, you'll notice they're shorter and easier to understand because of HAPI.

## Compatibility

HAPI is compatible with Jira Software and Jira Service Management (JSM).

## Javadocs

See our [Javadocs](https://docs.adaptavist.com/api/javadoc/cloud/scriptrunner/latest/hapi/jira/groovydoc/index.html) for a full list of HAPI classes and API methods.

* * *

## Related content

Check out our training video, [HAPI: A More Intuitive Scripting Experience](https://docs.adaptavist.com/sr4jc/latest/training/video-playlist-scriptrunner-for-jira-cloud-demo/hapi-a-more-intuitive-scripting-experience).
