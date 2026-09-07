# Fires an Event when Condition is True

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > listeners > built-in-listeners
- Doc ID: doc-sr4js-348414108
- Source: https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/fires-an-event-when-condition-is-true

The _Fires an event when condition is true_ listener enables you to trigger a specific [Jira event](https://confluence.atlassian.com/adminjiraserver073/adding-a-custom-event-861253643.html) based on a custom condition. Once fired, the event can be picked up by a [notification scheme](https://confluence.atlassian.com/adminjiraserver0820/creating-a-notification-scheme-1095777110.html), determining who gets alerted.  

Jira events, such as the Issue created or Issue updated event, are predefined occurrences in an issue's lifecycle. This listener allows you to fire these events even if that event wouldn't normally be triggered. This listener only fires the event when your specified condition is met, providing precise control over when notifications are sent.

By combining custom conditions with Jira's existing event types and notification infrastructure, you can create highly targeted alerts. This listener bridges the gap between Jira's standard event system and your unique requirements, allowing for more flexible and responsive issue management and communication.

To make the most of this post function we recommend you familiarise yourself with [Jira events](https://confluence.atlassian.com/adminjiraserver073/adding-a-custom-event-861253643.html) and [notification schemes](https://confluence.atlassian.com/adminjiraserver0820/creating-a-notification-scheme-1095777110.html).
