# Script Listener behavior change on Forge events

- Platform: cloud
- Space: SR4JC
- Hierarchy: Features > Script Listeners
- Doc ID: doc-sr4jc-f3bfc5b5-b4c6-47cc-96f5-d370ac5952d3-fe79fb64d8180d70
- Source: https://docs.adaptavist.com/sr4jc/latest/features/script-listeners#script-listener-behavior-change-on-forge-events--en

Atlassian is [retiring Connect](https://www.atlassian.com/blog/developer/announcing-connect-end-of-support-timeline-and-next-steps), so ScriptRunner for Jira Cloud is moving to Forge. With that move, the script context variables in your Script Listeners, Perform Actions, and background syncing Scripted Fields such as `issue`, `user`, and `changelog`, are changing too. These variables now get their data from Atlassian's Forge events, which contain much less data than the events from the previous Connect platform.

Your scripts will continue to work without needing a rewrite. The variables keep their names and structure. When your script reads a property that is no longer included, ScriptRunner fetches it from Jira for you.

Note: What's new for your scripts?

A line that only reads a value, such as `issue.fields.priority`, can now trigger an API call to Jira. If Jira rate-limits that call, ScriptRunner waits and retries once. If that second attempt also fails, the script stops with an error. This failure mode did not occur on Connect.

## Script context changes

Script context variables such as `issue`, `user`, and `changelog` now derive their values from Atlassian Forge events instead of Connect. Because Forge events include less data, ScriptRunner may need to fetch missing values from Jira when your script accesses them.

In Atlassian's Forge platform, only a few properties are readily available, such as `issue.key`, `issue.fields.summary`, and a user's `accountId`. Others, such as `issue.fields.priority`, a custom field, or `user.displayName`, arrive when your script first reads them. Some properties are no longer available, and ScriptRunner cannot fetch them. You will need to change any scripts that use those properties; for details, refer to [Atlassian's Transition to Forge Events and Missing Event Properties.](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/atlassians-transition-to-forge-events-and-missing-event-properties/)

## Why ScriptRunner fetches your data

When a property is missing from the Forge event, the only place to retrieve it is the Jira REST API. Previously, Atlassian included this data in the event, and ScriptRunner exposed it directly to your scripts, so you did not need additional API calls.

As we move to Forge, ScriptRunner fills in missing data only when your script first reads it. This on-demand fetching avoids unnecessary REST calls for properties your scripts never use and helps reduce load on Atlassian's systems.

## Details of ScriptRunner fetches

ScriptRunner fetches each missing property at most once per script run, no matter how many times your script reads it. Each listener run is independent, so two listeners on the same event each make their own calls.

<table class="table" id="script-listener-behavior-change-on-forge-events--en__generated-table-id-1"><caption></caption><thead class="thead"><tr class="row"><th class="entry" id="script-listener-behavior-change-on-forge-events--en__generated-table-id-1__entry__1">When your script reads</th><th class="entry" id="script-listener-behavior-change-on-forge-events--en__generated-table-id-1__entry__2">ScriptRunner fetches</th></tr></thead><tbody class="tbody"><tr class="row"><td class="entry" headers="script-listener-behavior-change-on-forge-events--en__generated-table-id-1__entry__1 script-listener-behavior-change-on-forge-events--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">The whole <code class="ph codeph">issue</code> or <code class="ph codeph">user</code> variable, for example when you log it, turn it into JSON, send it in a request, or return it from the script.</td><td class="entry" headers="script-listener-behavior-change-on-forge-events--en__generated-table-id-1__entry__1 script-listener-behavior-change-on-forge-events--en__generated-table-id-1__entry__2 ">All missing properties, including those your script never uses.</td></tr><tr class="row"><td class="entry" headers="script-listener-behavior-change-on-forge-events--en__generated-table-id-1__entry__1 script-listener-behavior-change-on-forge-events--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">A field of <code class="ph codeph">issue</code> that is not included, such as <code class="ph codeph">description</code>, <code class="ph codeph">priority</code>, <code class="ph codeph">labels</code>, or a custom field.</td><td class="entry" headers="script-listener-behavior-change-on-forge-events--en__generated-table-id-1__entry__1 script-listener-behavior-change-on-forge-events--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">The work item.</td></tr><tr class="row"><td class="entry" headers="script-listener-behavior-change-on-forge-events--en__generated-table-id-1__entry__1 script-listener-behavior-change-on-forge-events--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">The parent's summary, status, priority, or work type.</td><td class="entry" headers="script-listener-behavior-change-on-forge-events--en__generated-table-id-1__entry__1 script-listener-behavior-change-on-forge-events--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">The parent work item.</td></tr><tr class="row"><td class="entry" headers="script-listener-behavior-change-on-forge-events--en__generated-table-id-1__entry__1 script-listener-behavior-change-on-forge-events--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">A user's <code class="ph codeph">displayName</code>, <code class="ph codeph">avatarUrls</code>, <code class="ph codeph">timeZone</code>, or <code class="ph codeph">active</code>.</td><td class="entry" headers="script-listener-behavior-change-on-forge-events--en__generated-table-id-1__entry__1 script-listener-behavior-change-on-forge-events--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">The user, once per person, unless the user was already included with a work item that ScriptRunner fetched earlier. When Jira makes the change itself, shown as Anonymous user, there is no user to fetch, and these values remain <code class="ph codeph">null</code>.</td></tr><tr class="row"><td class="entry" headers="script-listener-behavior-change-on-forge-events--en__generated-table-id-1__entry__1 script-listener-behavior-change-on-forge-events--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1"><code class="ph codeph">fromString</code> or <code class="ph codeph">toString</code> on a <code class="ph codeph">changelog</code> item, where it is missing.</td><td class="entry" headers="script-listener-behavior-change-on-forge-events--en__generated-table-id-1__entry__1 script-listener-behavior-change-on-forge-events--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">The changelog entry.</td></tr><tr class="row"><td class="entry" headers="script-listener-behavior-change-on-forge-events--en__generated-table-id-1__entry__1 script-listener-behavior-change-on-forge-events--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">Space, work type, or version details on those events.</td><td class="entry" headers="script-listener-behavior-change-on-forge-events--en__generated-table-id-1__entry__1 script-listener-behavior-change-on-forge-events--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">The space, work type, or version.</td></tr><tr class="row"><td class="entry" headers="script-listener-behavior-change-on-forge-events--en__generated-table-id-1__entry__1 script-listener-behavior-change-on-forge-events--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1"><code class="ph codeph">transitionInput.from_status</code> in a workflow post-function.</td><td class="entry" headers="script-listener-behavior-change-on-forge-events--en__generated-table-id-1__entry__1 script-listener-behavior-change-on-forge-events--en__generated-table-id-1__entry__2 " rowspan="1" colspan="1">The status.</td></tr></tbody></table>

To see what a run fetched, follow these steps:

1.  Open Script Listeners.
2.  Click Run in the listener's _History_ column.
3.  Open the Logs tab.

Each REST call made while your script runs appears in its log, including the calls ScriptRunner makes for you:

```
2026-09-28 12:24:52.445 INFO - Serializing object into 'interface java.util.Map' 2026-09-28 12:24:52.461 INFO - GET /rest/api/2/issue/BACKFILL-2 asObject Request Duration: 1360ms
```

In the example below, you can see the Logs tab of a listener run where the GET line is the fetch ScriptRunner made to fill in `issue.fields.priority`.

A user fetch appears as `GET /rest/api/2/user?accountId=` followed by the account ID. Any request that your script did not make itself is a fetch that ScriptRunner used to fill in the Script Context. Fetches that occur after your script finishes, for example, while ScriptRunner serializes a returned `issue`, do not appear in the log.

The fetched value is the work item as it exists when your script reads it. Previously, `issue` held the work item as it was when the event occurred. If someone changes the work item again in between, your script now sees the newer value.

## What happens when a fetch fails

Atlassian limits how many API calls ScriptRunner can make to your site in a given period. Every call counts toward that limit: your scripts' own calls, these fetches, and ScriptRunner's internal checks, such as listener conditions. Bulk edits and imports fire one event per work item, so calls arrive in bursts, which is when your site is most likely to reach its limit.

When Jira rate-limits a call, ScriptRunner waits as long as Jira asks and tries once more. The log shows a line like this:

```
GET request to /rest/api/2/issue/TEST-1 returned an error code: 429, retrying in 1s...
```

<table class="table" id="script-listener-behavior-change-on-forge-events--en__generated-table-id-2"><caption></caption><colgroup><col><col></colgroup><thead class="thead"><tr class="row"><th class="entry" id="script-listener-behavior-change-on-forge-events--en__generated-table-id-2__entry__1">Jira answers</th><th class="entry" id="script-listener-behavior-change-on-forge-events--en__generated-table-id-2__entry__2">What your script gets</th></tr></thead><tbody class="tbody"><tr class="row"><td class="entry" headers="script-listener-behavior-change-on-forge-events--en__generated-table-id-2__entry__1 script-listener-behavior-change-on-forge-events--en__generated-table-id-2__entry__2 " rowspan="1" colspan="1"> Not found (HTTP 404), or ScriptRunner may not see the data (HTTP 401 or 403) </td><td class="entry" headers="script-listener-behavior-change-on-forge-events--en__generated-table-id-2__entry__1 script-listener-behavior-change-on-forge-events--en__generated-table-id-2__entry__2 " rowspan="1" colspan="1"><code class="ph codeph">null</code>, with two warnings in the log. The run still succeeds. </td></tr><tr class="row"><td class="entry" headers="script-listener-behavior-change-on-forge-events--en__generated-table-id-2__entry__1 script-listener-behavior-change-on-forge-events--en__generated-table-id-2__entry__2 " rowspan="1" colspan="1"> Rate limited (HTTP 429) again after that retry, a server error, or no answer </td><td class="entry" headers="script-listener-behavior-change-on-forge-events--en__generated-table-id-2__entry__1 script-listener-behavior-change-on-forge-events--en__generated-table-id-2__entry__2 " rowspan="1" colspan="1"> The script stops with an error.</td></tr></tbody></table>

For a work item deleted before the script read it, the log showed:

```
2026-09-28 12:32:17.347 WARN - GET request to /rest/api/2/issue/BACKFILL-59 returned an error code: status: 404 - body: {errorMessages=[Issue does not exist or you do not have permission to see it.], errors={}} 2026-09-28 12:32:17.349 WARN - Enrichment of MappedIssueFieldsProperty via GET /rest/api/2/issue/{issueIdOrKey} found nothing (HTTP 404): the entity does not exist or is not visible to the app user, the field stays unset. 2026-09-28 12:32:17.350 INFO - Priority: nul
```

When the script stops, its log shows this error:

```
Could not load the event data missing from the Forge payload (MappedIssueFieldsProperty via GET /rest/api/2/issue/{issueIdOrKey}): the Atlassian API responded with HTTP 429. The script was unable to continue due to an incomplete event
```

A property that is empty because Jira was busy looks the same to your script as a property that is genuinely empty in Jira. If the script continued, it could follow the wrong branch and still report success. For this reason, ScriptRunner does not rerun the script after this error.

## What changed for Workflow Perform Actions

Workflow Perform Actions switched to Forge events on September 29, 2026, on every site simultaneously. They no longer receive the Connect version of the event.

A Perform Actions `issue` variable now behaves like a listener’s. It holds the key and nine fields: summary, work type, status, space, creator, reporter, assignee, created, and updated. ScriptRunner fetches any other field when your script reads it, as described above.

Whose permissions apply. ScriptRunner fetches data as the user the Perform Action runs as. A Perform Action set to run as the Initiating User fetches with that user's permissions. If that user cannot see the data, the script gets `null`, with two warnings in the log.

Status names in `transitionInput`.`transitionInput.from_status` and `transitionInput.to_status` still hold status names. The new status comes with the event. ScriptRunner looks up the previous status when your script first reads it. That lookup does not need Jira administrator rights, so it works for any user the Perform Action runs as. If the lookup fails, the Perform Action stops with an error.

Before this fix, a Perform Action running as a non–Jira administrator could see a status ID, such as `10001`, instead of the name. A condition such as `transitionInput.to_status == 'Done'` then evaluated to false, so the Perform Action skipped its work.

Conditions. A Perform Action's condition can read fields that require a fetch. If that fetch fails, the Perform Action now stops with an error. Previously, the condition evaluated as false and the Perform Action did nothing without reporting an error.

Clone Issue. The built-in Clone Issue Perform Action reads the work item once and copies it as it exists at that moment. The copy includes changes that earlier post-functions on the same transition made. Its additional code sees the same values.

When a Perform Action fails. A Perform Action runs after the transition, so a failed Perform Action does not undo the transition. Only the Perform Action's own work is missing, and ScriptRunner does not run it again.

## Listeners don't run for restricted comments

If a listener uses the `Comment created` or `Comment updated` event, it might not run when the comment is restricted to a group or space role. It still runs as expected for comments that everyone can see.

Why this happens

Jira only sends a comment event to an app if the app can see that comment. ScriptRunner follows the same comment visibility rules as any other Jira user. If it isn't in the group or space role the comment is restricted to, Jira sends no event, and ScriptRunner never knows the comment was added or edited. Nothing appears in Execution History, because the listener was never triggered.

Note: Admin permissions don't override comment visibility in Jira Cloud. Even a site admin can't see a comment restricted to a group or role they don't belong to, and the same applies to ScriptRunner.

Atlassian sometimes tightens how webhooks are sent for restricted content to meet data privacy standards. So a listener that previously ran for restricted comments can stop running even though you haven't changed anything. Also, moving ScriptRunner from Connect to Forge can change the app user's internal ID so role memberships may no longer apply.

How to fix it

1.  Find the group or project role your restricted comments use, such as _Administrators_ or _Developers_.
2.  Go to Project settings > People in each affected space, and add the ScriptRunner app user to that project role.
3.  If the restriction uses a group, add the ScriptRunner app user to that group.
4.  Add a restricted comment to test, and check that the run shows up in the listener's Execution History.

Tip: Tip: Changing Run code as to the Initiating User doesn't fix this. Jira decides whether to send the event before your script runs.

## How to write scripts that handle failed fetches

Fetch the data yourself when the script must decide what happens

Your own REST call gives your script the HTTP status, so the script can skip the run, log a clear message, or take another path. This listener reads the priority and skips the run if Jira does not return it:

```
def response = get("/rest/api/2/issue/${issue.key}") .queryString("fields", "priority") .asObject(Map) if (response.status != 200) { logger.warn("Could not read ${issue.key} (HTTP ${response.status}), skipping this run") return } logger.info("Priority: ${response.body.fields.priority?.name}")
```

Read everything the script needs from that response. If the script also reads a missing property from `issue`, ScriptRunner fetches the work item a second time.

Do not retry by reading the property again

After a failed fetch, ScriptRunner does not fetch the same data again in that run. A script that catches the error and reads the property again gets `null`:

```
def priority try { priority = issue.fields.priority?.name } catch (Exception e) { priority = issue.fields.priority?.name // null: ScriptRunner does not fetch again in this run
```

Check changelog values before you branch on them

If a decision depends on `fromString` or `toString`, fetch the changelog yourself and check the response status.

Keep the number of calls down

-   Use the properties that are readily available when they are enough.
    
-   Read the properties you need, instead of logging or serialising the whole `issue` or `user`.
    
-   Limit each listener to the spaces and events it needs.
    

Check Execution History after bulk changes

After a bulk edit or import, open Execution History from the ScriptRunner menu and check for failed Script Listener and Perform Action runs. The longest interval is 72 hours, so review the history within three days.
