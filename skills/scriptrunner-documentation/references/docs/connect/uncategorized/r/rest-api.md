# REST API

- Platform: connect
- Space: SRC
- Hierarchy: n/a
- Doc ID: doc-src-326370518
- Source: https://docs.adaptavist.com/src/latest/rest-api

ScriptRunner Connect offers a RESTful API to help you accomplish more with the app.

You can create new API keys and access existing ones from the app by clicking your name at the bottom-left corner of the screen and then clicking **API Keys**. 

![](/src/files/latest/326370518/326370519/1/1738876168000/API-Keys.png)

**Base URL  ℹ️**

The base URLs are https://api.scriptrunnerconnect.com for the EU region and https://api.us.scriptrunnerconnect.com for the US region.

**Limited API coverage  🚧**

API coverage is currently limited, but it is expected to grow over time. Feel free to [contact our support](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/20/user/login) to request more capabilities.

## Browse the API

-   [Browse and test the API](https://docs.api.scriptrunnerconnect.com/)
-   [Download the OpenAPI specifications](https://docs.api.scriptrunnerconnect.com/openapi.1.0.yaml)

## Authentication

ScriptRunner Connect API utilizes [basic authentication](https://en.wikipedia.org/wiki/Basic_access_authentication) where the user's email address is the `username` and the API key is the `passwordz`. To generate an API key, click on your name in the bottom left area of the screen, then select **API Keys.** From there, you can generate a new API key.

Once you have the API key, send it along with the `Authorization` header as follows: `Basic base64Encoded(UserName:ApiKey)`. When you generate the API Key, you will also receive the base64 encoded `Authorization` header value, which you can use directly.

**Single key per activity  ☝🏽**

We recommend generating a new key for each activity. This makes it easier to deactivate the activity by deleting the associated API key.

**API keys are not retrievable  💾**

Once the key is generated, make a copy and store it securely. Once you have closed the window that exposed the API key, you won't be able to retrieve it again.

## Call the API from ScriptRunner Connect

Although we currently don't offer a connector or a managed API for our own API, you can call API endpoints from a workspace with the [generic connector](https://docs.adaptavist.com/src/latest/connectors/generic-connector).

## Rate limits

API endpoints are rate-limited; see [Limits and Quotas](https://docs.adaptavist.com/src/latest/limits-and-quotas) to review the exact limits. If throttled, you'll see a `429` HTTP status code; retry the API call at a later time.
