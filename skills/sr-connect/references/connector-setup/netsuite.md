# NetSuite

Authorized through OAuth 2.0 client credentials (machine to machine) with an integration record the user creates in NetSuite and a certificate the platform generates; no consent window. One method. Snapshot 2026-09-15 from the web application's setup dialog, cross-checked the same day against https://docs.oracle.com/en/cloud/saas/netsuite/ns-online-help/section_162730264820.html, which is Oracle's overview of the flow.

## Before you hand over

`connector create --team <teamId> --app-id <id> --name <name> --api-connection-type-id <id> --listener-type-id <id>`, IDs from `app list`; the app has one of each. Then `authorizationUrl`. `connector get` reports no `baseUrl` for this app even once authorized; the web application shows the "Account ID", the API does not, so ask. Everything below needs a NetSuite administrator, or a user with the "OAuth 2.0 Authorized Applications Management" permission for the mapping step.

The credentials are saved through the web application alone; the public API has no field for them, so the CLI cannot finish this connector. The dialog at `authorizationUrl` is the only way.

## The dialog

"Configure Connector", steps "Add NetSuite account ID", "Create Integration Application in NetSuite", "Create Client Credentials mapping", "Authorize". Inputs: the account ID, "Client ID", "Certificate ID". The dialog generates a certificate when it opens and offers it as a download named after the client ID; re-authorizing later generates a new one.

## Steps

1. Open `authorizationUrl`, sign in. "Enter NetSuite Account ID"; the dialog says it "is a part of the instance URL: https://<ACCOUNT ID>.app.netsuite.com". A sandbox account ID carries `_SB1` or similar, and NetSuite's host writes it with a hyphen (`1234567-sb1`); enter it as NetSuite shows it under Setup, Company, Company Information. "Next".
2. "Create Integration Application in NetSuite". The dialog says "If you already have an application, skip the steps below, paste Client ID and click next".
3. "Visit the NetSuite settings page and click New Application." The dialog links `https://<accountId>.app.netsuite.com/app/common/integration/integrapp.nl`; NetSuite's path is Setup, "Integration", "Manage Integrations", "New".
4. "Add a meaningful application name."
5. "Make sure STATE option is set to Enabled."
6. "Under Token-based Authentication section uncheck all the options."
7. "Under OAuth 2.0 section check only CLIENT CREDENTIALS (MACHINE TO MACHINE) GRANT option."
8. "Select RESTLETS and REST WEB SERVICES scopes."
9. "Click Save."
10. "From the bottom section of the page copy the Client ID into the form below." NetSuite shows the client ID and secret once, on the confirmation page; the secret is not needed. "Next".
11. "Create Client Credentials mapping": the dialog links `https://<accountId>.app.netsuite.com/app/oauth2/clientcredentials/setup.nl`; NetSuite's path is Setup, "Integration", "OAuth 2.0 Client Credentials (M2M) Setup", "Create New".
12. "Pick your own account as Entity." (the NetSuite user the integration will run as)
13. "For the Role choose Administrator or Developer depending on availability." The mapped role is what every API call runs as, so prefer a custom role carrying "Log in using OAuth 2.0 Access Tokens", "REST Web Services" and only the record permissions the integration needs; `Administrator` or `Developer` is the fallback when no such role can be created. Setup permissions are a separate question: creating the mapping needs "OAuth 2.0 Authorized Applications Management" or `Administrator`, and creating the integration record in the steps above needs "Integration Application" or `Administrator`. Sources: https://docs.oracle.com/en/cloud/saas/netsuite/ns-online-help/section_157771510070.html and https://docs.oracle.com/en/cloud/saas/netsuite/ns-online-help/section_162686838198.html.
14. "Under Application select your OAuth application from the previous step."
15. "Download public certificate and upload to the mapping." The dialog's download is a `.pem` named `<clientId>-SRC-public-certificate.pem`; NetSuite's field is "Certificate". The dialog notes "Please remember that the certificate will be valid for 2 years. After that time, you will need to re-authorize your connector."
16. "Click Save."
17. "Copy CERTIFICATE ID of newly created mapping from the first column." into the dialog's "Certificate ID". "Next".
18. "Authorize": "To access information in NetSuite you need to authorize ScriptRunner Connect to be able to make requests on your behalf." No window opens; the platform requests a token with the certificate and reports the result. A failure reads "Error while authorizing connector." and usually means the certificate ID, the client ID or the account ID does not match the mapping, or the mapping's role lacks "Log in using OAuth 2.0 Access Tokens".

## After the callback

There is no callback and no consent window. On success the dialog closes and the connector reads "Authorized". Read `connector get` back for `authorized: true`; there is no `baseUrl`, so confirm the account ID with the user.

## Fixed-key alternative through a Generic connector

None fixed. NetSuite's other route, token-based authentication, signs every request with an HMAC over consumer and token secrets, which a header a Generic connector sends once cannot do. The connector's own flow is the answer, or the OAuth recipe in `references/scripting.md` under "OAuth without a bespoke connector" with the client-credentials grant, which needs the same integration record and certificate anyway.

## Expiry and re-authorization

The certificate is valid for 2 years. Re-authorizing at `authorizationUrl` first shows the confirm "Regenerate certificate": "By re-authorizing, your certificate will be automatically regenerated, which will invalidate your existing connector setup." The mapping in NetSuite then needs the new certificate uploaded, which makes a re-authorization the administrator's job. Put the date somewhere the team will see it; NetSuite does not warn before the certificate expires.

## Known differences from the dialog

- The dialog says "Manage Integrations" is reached through "the NetSuite settings page"; the menu path is Setup, "Integration", "Manage Integrations".
- Step 12's "Pick your own account as Entity" reads as if the person setting up must be the entity; any user with a suitable role can be, and a dedicated integration user is the better choice.
- NetSuite spells the setup page "OAuth 2.0 Client Credentials (M2M) Setup"; the dialog calls it "Client Credentials mapping".

## Verify before trusting

The account ID's spelling (sandbox suffix, hyphen against underscore); that the mapping's role carries "Log in using OAuth 2.0 Access Tokens", "REST Web Services" and the record permissions the integration needs; and the certificate's expiry date, two years from the day of setup, noted where someone will find it.
