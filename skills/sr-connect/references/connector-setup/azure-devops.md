# Azure DevOps

Authorized in a browser through OAuth 2.0 against Microsoft Entra ID, with a choice between the platform's own Azure application and one the user registers in their tenant. Snapshot 2026-09-15 from the web application's setup dialog, cross-checked the same day against https://learn.microsoft.com/en-us/entra/identity-platform/quickstart-register-app and https://learn.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate. The dialog is the Microsoft one with the product name swapped and one alert fewer; `microsoft.md` is the full text, and this file lists what differs.

## Before you hand over

`connector create --team <teamId> --app-id <id> --name <name> --api-connection-type-id <id> --listener-type-id <id>`, IDs from `app list`; the app has one of each. Then `authorizationUrl`. `connector get` reports no `baseUrl` for this app even once authorized; the organization is not recorded, so which `dev.azure.com/<org>` a connector reaches is a question for the user.

## Methods the dialog offers

"Choose the instance type that you want to use to connect to Azure DevOps:", one of "Fully managed Azure application by ScriptRunner Connect", the default, and "Self-managed Azure application". Unlike Microsoft's, this dialog carries no scoping warning on the managed radio; the platform's application is registered for Azure DevOps. Default to it; recommend self-managed when the tenant's administrators will not grant consent to a third-party application, or when the user wants the registration under their own control.

## Steps

As Microsoft, with one difference. Under "Configure Permissions", the dialog says "Add a permission then select Azure DevOps" rather than Microsoft Graph, and the delegated permission to tick is `user_impersonation`, which is the only one Azure DevOps offers. The "Admin Consent URL" step, the Azure Portal steps, "Application (client) ID", "Directory (tenant) ID", "Client Secret Value" and the "Redirect URI" shown in the dialog are the same. The dialog's authorize text: "To access information in Azure DevOps you need to authorize our app to be able to make requests on your behalf."

## After the callback

As Microsoft: the consent window closes after 100 seconds, and when Microsoft answers in time the dialog closes and the connector reads "Authorized". No further confirmation; no `baseUrl` to check afterwards.

## Fixed-key alternative through a Generic connector

A personal access token: in the organization, user settings, "Personal access tokens", "+ New Token", a name, the organization, an expiry, and the scopes the integration needs (Azure DevOps has fine-grained ones, "Work Items (Read & write)" and the like). Generic connector: base URL `https://dev.azure.com/<organization>`, and the header Azure DevOps expects, `Authorization: Basic <value>` where the value is the base64 of a colon followed by the token (an empty username). The connector's basic authentication needs a non-empty username, so send the header itself through `--input <file>`, never on argv. Build `AzureDevopsApi` from `@managed-api/azure-devops-v72-sr-connect` on the Generic connection as `references/scripting.md` shows. Costs: Microsoft itself says "Avoid using PATs when a more secure authentication method is available"; the token expires on the date chosen, and one that has not been used in 90 days on an Entra-backed organization goes inactive; the connector reads as Generic. The gain is fine-grained scopes, which neither OAuth path offers beyond `user_impersonation`.

## Expiry and re-authorization

As Microsoft: re-authorize at `authorizationUrl`; a self-managed application's client secret expires on the date chosen when it was created, after which a new secret is pasted into the dialog and every connector on it re-authorized.

## Known differences from the dialog

Those listed in `microsoft.md`.

## Verify before trusting

As Microsoft, plus that the authorizing account is a member of the Azure DevOps organization the integration will work in, since the token names a tenant and not an organization.
