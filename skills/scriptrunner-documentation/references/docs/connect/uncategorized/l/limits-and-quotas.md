# Limits and Quotas

- Platform: connect
- Space: SRC
- Hierarchy: n/a
- Doc ID: doc-src-194676632
- Source: https://docs.adaptavist.com/src/latest/limits-and-quotas

To ensure ScriptRunner Connect's service reliability, the app applies various limits and quotas to guard against accidents or malicious behavior.

## General limits

**Limit**

**Free Plan**

**Basic Plan**

**Advanced Plan**

**Pro Plan**

AI assistant credits per month

100

1000

1000

1000

[Record Storage](https://docs.adaptavist.com/src/latest/scripting/record-storage) capacity

100 MB

1 GB

5 GB

10 GB

Maximum async (fire and forget) script invocation duration\*

15 minutes

Maximum sync script invocation duration (only applies for Sync HTTP Events)

25 seconds

Maximum event payload size

6MB

Maximum chained invocations (programmatically triggered)

200

Maximum console logs per invocation

1000

Workspaces per account

1000

Connectors per account

1000

API connections per workspace

1000

Event listeners per workspace

1000

Event listener test payloads per workspace

1000

Scheduled triggers per workspace

1000

Environments per workspace

1000

Deployments per workspace

10000

\* To run workloads longer than 15 minutes, you can use a [Trigger Script API](https://docs.adaptavist.com/src/latest/scripting/triggering-scripts) when you are about to reach the timeout limit. This allows you to trigger the same script to continue where the previous invocation left off.

## Rate limits

Rate limits are counted on per second basis.

**Accumulator** is the entity that is used to accumulated rate limits for. In other words, if the accumulator is a `team`  then the limits are shared across all workspaces within that `team`, but if the accumulator is a `user`, then the limits are accumulated solely on the user level.

  

Accumulator

Free Plan

Paid Plans

Script Invocations\*\* 

Team

1

100

External (Fetch) API calls \*\*\*

Team

5

100

[Record Storage](https://docs.adaptavist.com/src/latest/scripting/record-storage) API calls

Team

1

50

[Trigger Script](https://docs.adaptavist.com/src/latest/scripting/triggering-scripts) API calls

Team

1

10

[SR Connect API](https://docs.adaptavist.com/src/latest/rest-api) calls

User

5

10

\*\* Script invocations that go over the limit and are triggered either by asynchronous incoming events, like [event listeners](https://docs.adaptavist.com/src/latest/workspaces/event-listeners) or [scheduled triggers](https://docs.adaptavist.com/src/latest/workspaces/scheduled-triggers), are pushed into the retry queue and return a 429 status code indicating that the event will be processed with a slight delay. The retry queue attempts to retrigger queued invocations later when the burst-limit quota allows it. If the retry queue fails to trigger the queued invocation after 100 attempts, the invocation drops from the queue.

Synchronous incoming events (currently only [Sync HTTP Endpoints](https://docs.adaptavist.com/src/latest/workspaces/event-listeners/generic-http-events)) that need to return the script response quickly (29 seconds) attempt to retrigger the script for up to 20 seconds; after this point, a 429 response is returned. Synchronous events that are rate-limited but successfully retried have less time to run the script as the maximum time to return a response is shortened by retry attempts. You can check the time you have to return a response from the `context` object that is passed into your function as the second parameter.

Manually triggered scripts won't be queued if the rate limit is exceeded; they will be blocked.

\*\*\* External API calls rated limited by ScriptRunner Connect side will return a 429 response, which can also be the same response from the external service if you have breached the rate-limit quota. By default, [Managed APIs](https://docs.adaptavist.com/src/latest/managed-apis) come with a setting that retries rate-limited (429) requests up to a certain extent. If you are using low-level [Fetch API](https://docs.adaptavist.com/src/managed-apis#ManagedAPIs-FetchAPI), you must implement retry logic.
