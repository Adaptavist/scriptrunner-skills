# Built-In Listeners

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > listeners
- Doc ID: doc-sr4js-442887816
- Source: https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners

We have a number of built-in listeners that let you have better control over your business processes. Many of the listeners available are also available as [Post Functions](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions); however, listeners allow you more control over automated actions than you would get with a post function.

With built-in listeners, you can specify which events the listener is fired on and which projects are applicable. You can also add [Conditions](#id-.BuiltInListenersv9.x-conditions) to your built-in listeners, as described below. 

Check out the [Listeners](https://docs.adaptavist.com/sr4js/latest/features/listeners) page for an overview of listeners and how to use them.

### Accessing built-in listeners

Listeners can be accessed if you go to **ScriptRunner** **\>** **Listeners**.

### Conditions

With conditions you can set the parameters for which the built-in script will fire on. For example, if you need to filter on issue type you could enter the following script:

```
issue.issueTypeObject.name == "Bug" // && any other conditions
```

More example conditions can be found if you select the **Example scripts** button in script editor.

![](/sr4js/files/latest/442887816/442887821/1/1758746882000/Built_in_listeners.png)

You can add multiple configurations for the same type of listener if they have different parameters.

### Available built-in listeners

The following built-in listeners are available with ScriptRunner:

-   [Adds the Current User as a Watcher](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/adds-the-current-user-as-a-watcher)
-   [Clones an Issue and Links](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/clones-an-issue-and-links)
-   [Create a Sub-task](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/create-a-sub-task)
-   [Execution Failure Notifier](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/execution-failure-notifier)
-   [Fast-track Transition an Issue](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/fast-track-transition-an-issue)
-   [Fires an Event when Condition is True](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/fires-an-event-when-condition-is-true)
-   [Post a Message to Slack](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/post-a-message-to-slack)
-   [Send a Custom Email](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/send-a-custom-email)
-   [Send a custom email (non-issue events)](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/send-a-custom-email-non-issue-events)
-   [Version Synchroniser](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/version-synchroniser)
