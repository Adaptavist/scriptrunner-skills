# Post a Message to Slack

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > listeners > built-in-listeners
- Doc ID: doc-sr4js-442888822
- Source: https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/post-a-message-to-slack

This listener allows you to send a personalized custom message to your Slack room. When configuring a listener there are bindings for the issue object and event object.

For example, you want to be notified in a Slack channel when an issue is moved to _Done_ and what the resolution is set to.

```
"Issue $issue resolved with resolution <% out << issue.resolution?.name %>. by <% out << event.getUser() %>"
```

1.  Select the **Post a message to slack** listener.
    
2.  Enter a description of the listener in **Name**. 
3.  Select an event from the drop-down list.
4.  Enter your bearer token to retrieve a list of target rooms (channels) you can post to.
    
    For details on how to create Slack apps and tokens, see [Create Slack App](https://docs.adaptavist.com/scriptrunner-common-files/create-slack-app).
    
5.  Select the target room (channel) you want to post to.
6.  Enter a condition if you want to conditionally send the slack message, or leave this field empty to always send on transition.
7.  Enter a message to send. See below for guidance on creating your message template.

### String templating in groovy

There are two variables available for you to use in your template, "issue" and "event".

Check the [documentation about constructing your string template](http://docs.groovy-lang.org/docs/next/html/documentation/template-engines.html) for the last field of the form:

As a summary, in order to call a property, you can call it with the name

```
"Your issue $issue has been updated."
```

But you can do more complex calls to your object by using the [<% %> notation](http://docs.groovy-lang.org/next/html/documentation/template-engines.html#_streamingtemplateengine):

```
"Your Issue $issue was updated by <% out << event.getUser() %> on <% out << event.getTime() %>."
```
