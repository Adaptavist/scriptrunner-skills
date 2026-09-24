# HAPI

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: n/a
- Doc ID: doc-sr4c-58b0bb85-2789-4876-aad3-04cdf687a91c-63eba05dc097273d
- Source: https://docs.adaptavist.com/sr4c/latest/hapi

Learn about HAPI, our API in Confluence.

Visit ScriptRunner HQ to find out more about HAPI.

## What is HAPI?

HAPI is an API (application programming interface) for doing common tasks in Confluence, including adding labels, creating pages, deactivating users, and much more! HAPI is a programming language but it is not a new programming language, it is plain Groovy. It's a simpler alternative to Confluence's regular API.

|  |  |
| --- | --- |
|  | Visit ScriptRunner HQ to find out more about HAPI.<br>[ScriptRunner HQ](https://www.scriptrunnerhq.com/hapi) |

 

|  |  |
| --- | --- |
|  | Check out our HAPI walkthrough video for a demonstration of how to use HAPI.<br>[Walkthrough Video](https://www.youtube.com/watch?v=NPR3EfJn8ig) |

## Who is HAPI for?

Everyone.

Whether you're a complete beginner or an experienced developer, HAPI is for you and your business. HAPI increases productivity and efficiency by allowing you to create automations and customizations faster than ever.

For example, look how simple the HAPI script is for deactivating a user:

```
Users.getByName('USERNAME').deactivate()
```

## Why?

We want all users to be able to script in ScriptRunner, not just those familiar with the Confluence API. We want the barrier to entry to be next to nothing, and we think HAPI achieves that.

## What else should you know?

## Completions

When using HAPI, you'll notice helpful completions. We've developed completions to make your scripting experience even easier. For example, you don't have to remember or search for project keys; HAPI provides a list of them. The same goes for many other options you previously had to search for or remember. Give HAPI a go and see how many helpful completions there are!

## Keyboard shortcut

You will find the keyboard shortcut Control + Space very useful when using HAPI. This shortcut displays completions when they disappear. There are several reasons you might want to display completions. For example:

-   You've started typing and selected the wrong value, so you go back and delete some text, and completions no longer display.
-   You've clicked out of the script console, and when you return, completions no longer display.
-   You've deleted a chosen option in a string and want to see what all of the options were again.

Note: We also list more keyboard shortcuts within ScriptRunner. You can find these in the script console in the Documentation and Tips section.

## Compatibility

HAPI is compatible with all Confluence versions listed on the marketplace for ScriptRunner for Confluence and can be used in any existing scripts.

## Javadocs

See our [Javadocs](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/9.18.0/hapi/confluence/groovydoc/overview-summary.html) for a full list of HAPI classes and API methods.

## Latest updates

See our [Changelog](../../release-notes/hapi-changelog.md) page for all of the latest updates to HAPI.

## Support

If you notice something missing, [let us know](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/13).

## Have any feedback?

Take our [short survey](https://www.surveymonkey.com/r/YXN8SNW) and let us know what you think about HAPI!

## What's next?

[Create a page](https://docs.adaptavist.com/sr4c/latest/migration/migrating-to-or-from-cloud/rewrite-scripts-for-cloud/adapt-scripts-for-confluence-cloud#create-a-page--en) with HAPI and see how easy it is to use.
