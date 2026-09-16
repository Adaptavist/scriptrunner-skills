# Execution Failure Notifier

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Listeners > Built-In Listeners
- Doc ID: doc-sr4js-d1b7a64d-4ab1-4818-b968-b9f55e6b6533-79eed1e4cdf0843d
- Source: https://docs.adaptavist.com/sr4js/latest/features#listeners--en#built-in-listeners--en#execution-failure-notifier--en

You can use this listener to listen for script execution failures in your instance and to notify you of the failure. You can specify which properties are extracted from the failing execution (for example, feature name, URL and stack trace) and have these details automatically sent to you via Slack, email, or another software platform.

Note: Fragments are not tracked by this listener

[Fragments](https://docs.adaptavist.com/sr4js/latest/features/fragments) do not publish an execution failure event and therefore are not tracked by this listener.

## Adding this listener

Note: If you want notifications to be sent via Slack or email, make sure you have set up a [Slack connection](https://docs.adaptavist.com/sr4js/latest/features/resources/slack-connection) or configured a [Mail Server](https://confluence.atlassian.com/adminjiraserver/configuring-an-smtp-mail-server-to-send-notifications-947184044.html).

1.  Navigate to ScriptRunner.
2.  Select Listeners > Create Listener.
3.  Select Execution failure notifier.
4.  Enter a description of the listener in Name.
5.  Enter a script into the script console that defines where you want your execution failure notification to go.
    
    Note: Select Example scripts to find some code examples to get you started in creating your script, or you can use the exact details provided and just edit the required details (for example email or slack room).
    
6.  Select Add to add the listener, or select Preview to validate the listener.
    
    When an execution failure event occurs, you will receive a notification similar to the following:
