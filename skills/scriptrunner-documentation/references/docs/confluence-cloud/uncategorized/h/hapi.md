# HAPI

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: n/a
- Doc ID: doc-sr4cc-416678049
- Source: https://docs.adaptavist.com/sr4cc/latest/hapi

HAPI is an API used for carrying out common tasks in Confluence. These can include creating spaces, pages, labels, and more. HAPI is not a new programming language. It's essentially plain Groovy, but it gives you a simpler alternative to Confluence's regular API. You can even mix and match HAPI calls with the Confluence API.

![](https://docs.adaptavist.com/sr4jc/files/current/288524072/288524076/1/1722349177000/sr-icon-power.png)

Visit ScriptRunner HQ to find out more about HAPI. 

[ScriptRunner HQ - update](https://www.scriptrunnerhq.com/atlassian-apps/confluence/scriptrunner-for-confluence-cloud)

## Who is HAPI for?

Whether you're a complete beginner or an experienced developer, HAPI is for you and your business. It increases productivity and efficiency by allowing you to create automations and customizations faster than ever and helping you understand the code better.

For example, look how simple the HAPI script is for [creating a space](https://docs.adaptavist.com/sr4cc/latest/hapi/work-with-spaces):

```
def space = Spaces.create("Analytics and Data", "AD") {}
```

We want all users to be able to script in ScriptRunner, not just those who are familiar with the Confluence API and we think HAPI achieves that. HAPI does not require you to rewrite existing scripts. However, should you wish to make your current scripts more manageable then you might want to update them to use HAPI.

## Permissions

HAPI respects the permissions of the current user _by default_. Using HAPI does not change any of the permissions ScriptRunner already has. 

Note that some operations in Confluence are restricted for Atlassian Connect apps, and HAPI runs on ScriptRunner which is a Connect app. For example, read about [group membership management](https://developer.atlassian.com/cloud/jira/platform/rest/v2/api-group-groups/#api-rest-api-2-group-user-post). This limitation is not specific to HAPI; it applies to all Connect apps, so even writing the REST request directly will not work when coming from ScriptRunner.

## Completions

When using HAPI in the code editor you'll notice helpful completions with available methods within the context of your operation.

Shortcut

If you need to display completions after they have disappeared, press the keyboard shortcut **Control + Space.**

Performance

HAPI has been developed with the performance needs of large instances in mind. Under the hood, HAPI optimises the usage of the Confluence REST API. However, script execution time is limited, so handling larger datasets may result in time-outs before tasks are completed. HAPI is a powerful API so it will not complain when you try to perform larger tasks, such as when performing a CQL search over millions of issues. Nevertheless, this may hit the script time-out limits.

## Keyboard shortcut

You will find the keyboard shortcut **Control + Space** very useful when using HAPI in the code editor. This shortcut allows you to display completions when they disappear. There are a number of reasons you could want to display completions again. For example:

-   You’ve started typing and selected the wrong value, so you go back and delete some text and completions no longer display.
-   You’ve clicked out of the script console and when you return completions no longer display.
-   You’ve deleted a chosen option in a string and want to see what all of the options were again.

When viewing an autocomplete suggestion, pressing **Control + Space** again displays any associated [Javadocs](https://docs.adaptavist.com/api/javadoc/cloud/scriptrunner/latest/hapi/confluence/groovydoc/index.html) for the selected suggestion.

## Compatibility

HAPI is compatible with Confluence Software.

## Javadocs

See our [Javadocs](https://docs.adaptavist.com/api/javadoc/cloud/scriptrunner/latest/hapi/confluence/groovydoc/index.html) for a full list of HAPI classes and API methods.
