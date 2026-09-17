# Slack

Listener type APP, 89 event types in three families: Slack events (`Message Channels`, `Reaction Added`, `Team Join` and the like), interactive components (`Block Actions`, `Message Action`, `Shortcut`, `View Submission`, `View Closed`) and `Slash Command`. Snapshot 2026-09-14 from the web application's setup dialog, cross-checked the same day against https://docs.slack.dev/apis/events-api/ and https://docs.slack.dev/authentication/verifying-requests-from-slack.

## Before you hand over

`event-listener get -e <env> <listenerId>` for `webhookUrl`, `setupUrl` and `connectorId`. `connectionRequired` is true: a Slack listener without a connector receives nothing, and the connector must be authorized, because Slack's request verification runs against the signing secret stored with it. `connector get <connectorId>` reports `baseUrl` as the app's configuration page, `https://api.slack.com/apps/<APP_ID>`; that is the page every step below starts from, and it says nothing about which workspace is production.

## Deep links

Off `baseUrl`:

- Slack events: `<baseUrl>/event-subscriptions`
- Interactive components and shortcuts: `<baseUrl>/interactive-messages`
- Slash commands: `<baseUrl>/slash-commands`

Without a base URL, `https://api.slack.com/apps`, then the app.

## Steps

Slack event:

1. Open "Event Subscriptions" and switch events on.
2. Paste the webhook URL into "Request URL". Slack posts a `url_verification` challenge to it at once and the platform answers; the field shows "Verified". If it fails, "Retry"; if it fails again the connector is probably unauthorized.
3. Under "Subscribe to bot events", "Add Bot User Event", and add the event the listener was created for. Slack spells it in lower case with a dot for a subtype, `message.channels`, `reaction_added`, `team_join`. The SRC event type name is the same words in title case, `Message Channels`. Add the value from Slack's own list, never the form the SRC setup dialog prints — it lower-cases the SRC name and joins it with underscores, and `message_channels` is not a Slack event; see Known differences.
4. "Save Changes". Slack may ask to reinstall the app so the new bot scopes take effect; do it.

Interactive component:

1. Open "Interactivity & Shortcuts" and switch "Interactivity" on.
2. Paste the webhook URL into "Request URL". "Save Changes".
3. For a `Shortcut` event, "Create New Shortcut" under "Shortcuts", fill in the name, description and callback ID, "Create", "Save Changes".

Slash command:

1. Open "Slash Commands", "Create New Command", or edit an existing one.
2. "Command", beginning with `/`. Paste the webhook URL into "Request URL". "Short Description", optionally "Usage Hint". "Save".

Every Slack request expects an answer within three seconds. The platform acknowledges before the script runs, but it does not always make it inside Slack's window; when it does not, the user who typed the slash command or clicked the button sees Slack's generic "request timed out" message. The script still runs, and whatever it sends back through the Slack API connection still lands in the channel, so the user sees a misleading error followed by the real result. Say so in the handoff so nobody debugs a working integration. A script that must reply in-channel always does so through the Slack Managed API, not through the response.

## Filter on the app side

Only the event subscription itself. Slack sends every event of that type the bot can see, in every channel the app is in; there is no channel or team filter on the app configuration. In the script, check `event.channel`, `team_id` and, for `message.*` events, `event.subtype` and `event.bot_id`, so the bot does not react to its own messages. Read the channel ID from a parameter. Interactive components carry `callback_id`, `action_id` or `block_id`; a slash command carries `command` and `text`.

## Secure it

Slack signs every request with the app's "Signing Secret" from the "Basic Information" page: `X-Slack-Signature` is `v0=` and the HMAC-SHA256 of `v0:<X-Slack-Request-Timestamp>:<body>`. The platform checks this against the signing secret the connector holds, before the script runs; no further action is needed beyond keeping the connector authorized, and nothing goes in the code. A request that fails verification never reaches the script. Slack publishes no address list.

## Known differences from the setup dialog

- The dialog's labels "Enable Events", "Add Bot User Event" and "Save Changes" are the app configuration page's, not the documentation's; the docs say "toggle the feature on" and name the lists "Workspace Events" and "Bot Events". Follow the page.
- The dialog spells the bot event as `message_channels`, the SRC name lower-cased with underscores. Slack's subtyped events use a dot, `message.channels`; the underscore form does not exist and the search box will not find it. Undotted events (`reaction_added`) are spelled as the dialog says.
- The dialog names no security step. None is needed, because the connector's signing secret covers it; say so rather than leaving the line blank.

## Verify before trusting

The event's exact spelling in Slack's list, the three page paths, and whether the app has been reinstalled after the scopes changed. A "Request URL" that will not verify means the connector, not the URL.
