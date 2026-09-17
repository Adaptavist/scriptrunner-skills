# Generic

The one connector whose credentials are values the user already holds: a base URL and a set of HTTP headers, or a username and password the platform encodes into an `Authorization: Basic` header. No consent window. Snapshot 2026-09-15 from the web application's authorization wizard, cross-checked the same day against https://docs.adaptavist.com/src/latest/connectors/generic-connector. It is also the fixed-key alternative every other file in this folder points at, and the only connector the CLI can create authorized.

## Before you hand over

Usually you do not. `connector create --team <teamId> --app-id <id> --name <name> --api-connection-type-id <id> --listener-type-id <id> --base-url <url> [--header <name:value>]... [--basic-auth-username <user>]` with the password in `SR_CONNECT_CLI_BASIC_AUTH_PASSWORD` creates the connector configured and authorized in one request; `connector create --explain` has the whole body and its rules, and `--input <file>` takes the same body from a file, which is how a header value stays out of argv and shell history. Both type IDs from `app list`; the app has one of each. `connector get` then reports `baseUrl`, the derived `authMethod` (`NONE`, `BASIC` or `CUSTOM`) and the header names; header values are never reported back by anything. `connector update` replaces the configuration and takes the same shape, base URL required every time.

Prefer that the user configures it in the web application so no key passes through you; the skill's rule in `references/cli-workflow.md` under Connector setup says so. When they hand you a key anyway: `--input`, never a flag, and delete the file afterwards.

## Methods the wizard offers

Under "Authentication type" ("Choose how you would like to authenticate your connection."):

- "None": a "Base URL" and nothing else. For an API that is open, or one whose credential the script adds per call.
- "Basic authentication": "Username" and "Password"; the platform encodes them. Custom headers can be added beside it.
- "Custom headers": any number of "Name" / "Value" pairs sent with every request. An `Authorization` header goes here for a bearer token, an API key header under its own name.
- "OAuth 2.0": not a method. Selecting it shows "Generic HTTP connector does not support OAuth 2.0." and a template, "Manual OAuth 2.0 for Zendesk", that "demonstrates how to build an OAuth 2.0 authentication manually". The recipe in `references/scripting.md` under "OAuth without a bespoke connector" is the same idea for any app.

The "Authorization method" a read reports is derived from what the connector sends: `CUSTOM` whenever any header other than `Authorization` is present, `BASIC` when basic authentication is all there is, `NONE` otherwise. Basic authentication plus a header of your own therefore reads as `CUSTOM`.

## Steps in the web application

1. Open `authorizationUrl`, sign in. Pick the "Authentication type".
2. "Base URL": "For example: https://api.example.com"; `https://` or `http://` required. The wizard tests the URL on save: an unreachable one fails with "Base URL not reachable.", and one that redirects asks for confirmation naming the target. A host behind a firewall needs the platform's public IP allowed; https://docs.adaptavist.com/src/latest/get-started/connect-to-services-behind-the-firewall.
3. Basic authentication: "Username", "Password", "Apply". If an `Authorization` header already exists the wizard warns "This will replace your existing Authorization header".
4. Custom headers: "Add header", "Name" and "Value" per row, "Apply". The wizard refuses duplicate names ("Duplicate header detected") and an `Authorization` header when basic authentication is set ("Authorization header is covered within the Basic authentication section"). Existing header values display masked and cannot be read back.
5. "Save connector". The connector reads "Authorized" at once.

## After saving

Nothing to wait for. `connector get` reports `authorized: true` and the configuration. A request through the API connection is the only test of the credential itself; the wizard's URL test checks reachability, not authentication.

## Building a Managed API on it

The connector's API connection exposes `fetch` with the base URL and headers applied. For an app that has a Managed API, construct it on the connection ID as `references/scripting.md` shows under "A Managed API on a Generic connector"; each file in this folder names the class and package for its app. Path-joining follows the base URL, so set it to the API root the Managed API expects (`https://<site>.atlassian.net` for Jira Cloud, `https://api.github.com` for GitHub, and so on, per file).

## Expiry and re-authorization

Whatever the credential's own lifetime is; the platform knows nothing about it and a request with an expired key answers whatever the vendor answers, usually 401. Replace the value with `connector update` (base URL required, headers replaced as a set) or in the web application. `connector update --explain` has the rules, including that headers omitted are kept and `[]` clears them.

## Known differences from the wizard

- The wizard tests the base URL before saving; the API does not, so a connector created through the CLI with an unreachable base URL is created and authorized and fails on first use.
- The wizard's "OAuth 2.0" option looks like a fourth method and is a pointer to a template.
- The public documentation says "Custom headers may be added when using the None or Basic authentication method."; the API says the same thing as "basicAuth combines freely with headers".

## Verify before trusting

The base URL against the API root the Managed API expects, trailing slash included; the header name the vendor wants, since the wizard and the API accept any name; and, when the CLI created it, that the value was not typed on the command line.
