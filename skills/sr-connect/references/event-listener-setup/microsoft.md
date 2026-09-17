# Microsoft

Microsoft Teams. Listener type WEBHOOK, 1 event type: "Teams Command Event via an Outgoing Webhook". Snapshot 2026-09-14 from the web application's setup dialog, cross-checked the same day against https://learn.microsoft.com/en-us/microsoftteams/platform/webhooks-and-connectors/how-to/add-outgoing-webhook.

## Before you hand over

`event-listener get -e <env> <listenerId>` for `webhookUrl` and `setupUrl`. A Microsoft connector records no host, so `connector get` reports no `baseUrl`, and the registration happens in the Teams client rather than on a web page. `connectionRequired` is false.

The security token Teams shows at creation is required, and it can only be entered in the web application's setup dialog at `setupUrl`. Until it is saved there, every message Teams sends is refused. The CLI cannot store it.

## Deep links

None. The Teams client: the team, "•••", "Manage team", "Apps" tab, then "Create an outgoing webhook" under "Upload an app" at the bottom right.

## Steps

1. In Teams open the team the webhook belongs to, "•••" next to its name, "Manage team".
2. Open the "Apps" tab. Under "Upload an app", "Create an outgoing webhook".
3. "Name": this is the word users will @mention to trigger the script, so pick something short. "Description" for the team. "Profile picture" optional.
4. Paste the webhook URL into "Callback URL". "Create".
5. Teams shows the security token once. Copy it, open the setup dialog at `setupUrl`, paste it into "Security Token", "Save changes". Store nothing else anywhere; the platform keeps it.
6. In a public channel of the team, type `@<Name> <text>`. The script receives the message.

## Filter on the app side

None. The webhook fires only when a user @mentions it, only in the team's standard channels, never in private channels or chats. The message text after the mention is the payload's `text`; the script parses it, and checks `channelData.channel.id` against a parameter when only one channel should be honoured. Teams waits five seconds for a reply to render in the channel; the platform acknowledges at once and the script's reply, if any, goes back through the Managed API.

## Secure it

Teams signs every message: the `Authorization` header is `HMAC <base64>`, the HMAC-SHA256 of the UTF-8 body keyed with the base64-decoded security token. The platform verifies it against the token saved in the setup dialog, and answers 401 when no token is stored or the signature does not match, so nothing is needed in code. The token never expires; deleting and recreating the outgoing webhook issues a new one, which must be saved again.

## Known differences from the setup dialog

- The dialog says "Click on Upload an app and select Create an outgoing webhook"; the current UI shows the button under an "Upload an app" heading rather than behind a click. Same place.
- The dialog does not say the token is verified or that a missing token means a refused message; the platform does both.
- Microsoft's Q&A forum reports webhook creation refused when the callback URL does not answer quickly during creation; the webhook URL is live as soon as the listener exists, so this should not affect an SRC listener, but if "Error submitting webhook!" appears, retry after a minute.

## Verify before trusting

Whether the new Teams client still has the "Apps" tab under "Manage team", and the five-second reply window. Microsoft revises the Teams client more often than the docs.
