# Jira On-Premise

Authorized through an application link the user creates in their Jira Data Center, with a key pair the platform generates. Snapshot 2026-09-15 from the web application's setup dialog, cross-checked the same day against https://confluence.atlassian.com/adminjiraserver/link-to-other-applications-938846918.html and https://confluence.atlassian.com/enterprise/using-personal-access-tokens-1026032365.html. One connector type serves several apps in `app list`: Jira On-Premise, Jira Service Management On-Premise, Jira Service Management On-Premise Assets, Tempo Planner On-Premise and Tempo Timesheets On-Premise all report `connectionType.name` "Jira On-Premise", and a connector authorized against the instance serves an API connection of any of them. Confluence On-Premise uses the same dialog and has its own file.

## Before you hand over

`connector create --team <teamId> --app-id <id> --name <name> --api-connection-type-id <id> --listener-type-id <id>`. Pass the app ID of whichever of those apps the API connection will be created for; the type IDs are the shared connector type's and are the same under each of them in `app list`. Only Jira On-Premise and Jira Service Management On-Premise carry a listener type; the Assets and Tempo apps do not, so omit the flag for those. The response is `authorized: false` and `authorizationUrl`. `connector get` reports `baseUrl`, the instance, once authorized.

Everything below needs a Jira administrator, because an application link is an admin setting. Find out early who that is.

## The dialog

One method, titled "Configure Connector", with steps "Add Jira On-Premise Instance URL", "Create Application Link in Jira On-Premise", "Enter Details" and "Authorize". It asks for one value, the instance URL, and shows the rest read-only for copying into Jira: "Consumer Key" and "Consumer Name", plus a public key to download. The key pair is generated when the dialog opens, and re-authorizing later generates a new one.

## Steps

1. Open `authorizationUrl`, sign in. "Enter the Jira On-Premise URL", `https://` required. The dialog tests the URL and warns when it redirects: "The URL you provided, <url>, redirects to <target>. Please ensure you trust the URL before proceeding". A 408 or 502 here means the platform cannot reach the instance; the dialog's own message names the platform's public IP to allow through the firewall, and https://docs.adaptavist.com/src/latest/get-started/connect-to-services-behind-the-firewall is the page for it.
2. "Create Application Link". The dialog says "If you already have an application link to ScriptRunner Connect, skip the steps below and click next", and "To setup an application link you need Jira On-Premise administrator privileges."
3. "Visit the Application links page in Atlassian." The dialog links `<instance>/plugins/servlet/applinks/listApplicationLinks`; the menu path is Administration, Applications, Application links.
4. On a newer Jira: "click on Create link", "select Atlassian product" when asked for a type. On an older one, where an application URL field sits beside "Create new link": enter any URL, "Create new link", and skip to step 7.
5. "Enter https://app.scriptrunnerconnect.com in the Application URL field and then click Continue."
6. "Ignore the No response was received from the URL you entered warning that is displayed and click Continue."
7. "Enter Details". "Enter ScriptRunnerConnect in Application Name. Then select the Create incoming link checkbox." The dialog adds "It does not matter what you enter in the remaining fields, because you only need to set up an incoming link."; "Continue".
8. Jira now asks for the incoming link's details. "Download the public key and paste it in the Public Key field." The dialog offers the key as a `.pem` download. Copy the dialog's "Consumer Key" and "Consumer Name" into Jira's fields of the same name. "Continue" in Jira.
9. Back in the dialog, "Authorize". A consent window opens on the instance; sign in as the account the integration should run as, "Allow".

The dialog notes: "Please remember that the public key will be valid for 5 years. After that time, you will need to re-authorize your connector."

## After the callback

The consent window is closed by the web application after 100 seconds; start "Authorize" again if it does. When Jira answers in time, the dialog closes and the connector reads "Authorized". No site confirmation; there is one instance. Read `connector get` back: `authorized: true` and `baseUrl` naming the instance.

When you drive the browser, step 8 is where it usually goes wrong: the download lands wherever the browser saves files, and the key has to be pasted whole, header and footer lines included. Recommend the user runs steps 3 to 8 themselves with you watching, since they are the administrator anyway.

## Fixed-key alternative through a Generic connector

A personal access token, on Jira Core and Software 8.14 and later and Jira Service Management 4.15 and later: the user's avatar, "Profile", "Personal access tokens", "Create token", a name, optionally "Automatic expiry". Generic connector: base URL the instance, header `Authorization: Bearer <token>`, through `--input` as `generic.md` says. Or basic authentication with a username and password, `--basic-auth-username`, which Atlassian still allows on Data Center but which puts a password in the connector. Build `JiraOnPremApi` from `@managed-api/jira-on-prem-v8-sr-connect` on the Generic connection as `references/scripting.md` shows; the Tempo and Assets packages under the same connector type work the same way. Costs: the token acts as its user with every permission that user has, the instance may enforce an expiry, and the connector reads as Generic. The gain is that no administrator is needed, which on a locked-down instance can be the whole difference.

## Expiry and re-authorization

The public key is valid for 5 years. Re-authorizing at `authorizationUrl` first shows the confirm "Regenerate key pair": "By re-authorizing, a new public-private key pair will be automatically regenerated, which will invalidate your existing connector setup." The application link in Jira then needs the new public key pasted in, so a re-authorization is the administrator's job too, not a click.

## Known differences from the dialog

- The dialog's older-Jira branch ("If an application url field exists next to the Create new link button") describes Jira 8 and earlier. Current Jira Data Center shows "Create link" and asks for the type.
- The dialog does not display the callback URL anywhere. The application link does not need it; the consent window carries it.
- Atlassian's current page describes the wizard as authorizing "the two-way connection"; only the incoming half is needed, which is why the dialog says the remaining fields do not matter.

## Verify before trusting

The Jira version, which decides step 4; that the account authorizing in step 9 is the one the integration should act as; the instance's public-key acceptance (a key pasted with a stray line break fails with an unhelpful error); and `connector get`'s `baseUrl` afterwards.
