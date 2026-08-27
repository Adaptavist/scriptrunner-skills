# Event Queues

- Platform: connect
- Space: SRC
- Hierarchy: workspaces
- Doc ID: doc-src-490145529
- Source: https://docs.adaptavist.com/src/latest/workspaces/event-queues

This feature is available only for paid users on non-legacy plans.  
If you would like to try this feature, you can [request a free trial](https://docs.adaptavist.com/src/latest/release-notes#id-.ReleaseNotesvDraft-ProPlanFreeTrial) from within the app that will grant you access to all restricted features.

Event queues are designed to let you queue incoming (external) events that must be processed sequentially, rather than concurrently, which is the default behavior. You may want to consider using event queues when your integrated applications tend to emit events at close intervals, and the scripts that process those events tend to take longer than the arrival time of the next event, potentially causing race conditions. Event queues work on the [FIFO](https://en.wikipedia.org/wiki/FIFO_\(computing_and_electronics\)) (first-in, first-out) principle.

Opt in feature

This feature is opt-in; all existing workspaces and new workspaces will continue to process events in near real-time, unless explicitly configured to use a queuing mechanism on the event listener level.

## Configuration ⚙️

To get started, first configure the Event Queue for your workspace:

1.   Assign it a _N__ame._
2.   Optionally: configure the _E__viction policy_, which is _enabled_ by default.

### Eviction policy

Eviction policy lets you control how long events are allowed to stay in the queue. This is useful when, in certain circumstances, the queue might become stalled (although this should never happen; this feature guards against this unlikely event). And when you're receiving events faster than you can process them. Eviction policy has 2 configuration items:

-   Eviction time - How long the event is allowed to stay in queue, measured in minutes.
-   Action for stuck events - What will happen with the event that has exceeded the allowed time, whether to process the event out of order (immediately) or drop the event. In case the event gets dropped, you will be notified (by email) about it, so you may manually replay the event if you have deemed it safe to do so.

Environment specific configuration items

Queue state (which determines whether the queue is enabled or disabled) is an environment-specific configuration item, meaning you can change the queue state configuration independently in each environment. When the queue is disabled, all inbound events will be processed immediately, as if no queue were configured for them. For example, you don't have to enable the queue in dev or staging environments if you want to test what happens when events are processed concurrently.

Evictions policies are recommended ✅

We strongly recommend using the eviction policy in a queue to prevent an infinite buildup of a queue in unforeseen circumstances.

### Associate a queue with an event listener

Grouping is recommended ✅

We strongly recommend using grouping to increase the throughput of your queues.  
Without grouping, all events pushed into the queue without grouping are processed sequentially. 

Once you have configured the queue, you can associate a queue with each event listener you need. You may not need to configure the queue for each event listener, only for the event listeners that process events affecting the same entity type and are likely to be processed in close intervals, thus are susceptible to causing race conditions. When associating a queue with an event listener, you can also optionally specify the grouping logic for each event listener.

Grouping allows you to specify which events should be grouped together and thus will be processed in sequence.  
Events that don't share a group, but are still pushed to the same _queue_, will be processed concurrently (effectively only sharing the eviction policy). Grouping logic uses the incoming event payload field values to determine which events should be grouped. You can specify up to 10 field paths to make up the composite ID for the group. Usually, a single field is sufficient, but we do allow composition for more complex use cases.

Grouping configuration uses dot-notation to specify field paths and only works with event payloads that arrive in JSON format.

To help you in configuring the field paths, we display all known field paths for known event types, but you can always specify your own field paths if you know those fields exist in incoming event payloads. Certain products only support generic events, for which we cannot display the known field paths, given that they are dynamic in nature; thus, you have to configure the field paths manually, based on what you know to exist in the event payloads. Misconfiguring the field path will cause the value to default to undefined, thereby treating it as if it has no group. In the case of composite grouping, field paths that don't yield a value will be treated as having the same values (all undefined), and essentially have no effect.

#### Example

Let's say you're processing Issue Creation, Issue Updated, and Comment Added events for Jira Cloud and want to queue them to prevent race conditions. In this case, you can group these events by the issue key, as it is safe to process events that don't share the same issue key concurrently, assuming that concurrent updates across issues are considered secure (dependent on your business logic). To do so, you can configure the following field path for the grouping: _issue.key_.

## Access queue info at runtime ℹ️

To determine if the event you're processing was queued, at runtime, you can access the queue property from the context object. If the event wasn't queued, this property will remain undefined. However, if the event was queued, it will contain an object with the following properties:

-   `id` - Queue ID.
-   `name` - Queue Name.
-   `groupId` - Group ID if the grouping was used, otherwise `undefined`, containing the actual value(s) extracted from the event payload based on the configured field paths at the Event Listener level. If multiple field paths were used (composite ID), each value will be delimited by `#`.

Additionally, `queuedAt`, which contains the timestamp when the event was queued initially (in milliseconds), is also present in the `context` object. To determine how long the event stayed in the queue, you can subtract `queuedAt` from the `startTime` property, which is also present in the `context` object and represents the time when the script was triggered. Similarly to the `queue` object, `queuedAt` is not present if the event that triggered the script wasn't queued (default behavior).

## Observability 

To help you track retroactively which script invocations were queued and when, we introduced the following new fields to the Script Invocations Log Report:

-   Queue Name
-   Queued At.

## Considerations

A few things to consider when using event queuing:

-   Since the queued event can stay in the queue for a considerable amount of time, the event payload may have already become outdated once it gets processed. In this case, you can fetch the information explicitly at runtime that you would otherwise have extracted from the event payload, and then determine if it is still safe to proceed.
-   Using the eviction policy is strongly recommended to prevent infinite queue buildup.
-   Using grouping is strongly recommended to increase the throughput of your queue, thus reducing the chances of queue buildup that may cause events to be evicted by triggering the eviction policy.
