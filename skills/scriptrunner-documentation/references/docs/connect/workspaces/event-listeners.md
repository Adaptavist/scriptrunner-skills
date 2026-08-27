# Event Listeners

- Platform: connect
- Space: SRC
- Hierarchy: workspaces
- Doc ID: doc-src-194675282
- Source: https://docs.adaptavist.com/src/latest/workspaces/event-listeners

The event-listener feature allows you to listen and react to events originating from external services/apps.

To create a new event listener, you can click on the **+** next to the _Event Listeners_ category in the resource tree. When you do, you'll be asked to select the app (service) you want to start listening for events from. After confirming which app you would like to work with, you're taken to a screen and asked for the following information:

-   **Event Type**  
    You must select which event type you want to listen to. Event types are specific to the app you have chosen.
-   **Linked Script**  
    You'll have the option to either create a new script event listener setup by specifying a name for the new script or link an existing one. **We recommend creating a new script** because it will be generated with the appropriate TypeScript event type you selected. If you link an existing script, then it's up to you to ensure that the TypeScript's event type is correct. If the type is incorrect, the editor will display incorrect suggestions.
-   **Connector**  
    (Global) connector to link with the event listener. Most of the time, this is not mandatory. Still, we recommend doing it anyway because it logically relates the incoming event listener to a (global) connector, which can help increase the visibility of how connectors are being used. Most of the time, we'll provide more detailed setup instructions if the connector is linked.

After you save the event listener for the first time, you will receive final setup instructions, which basically ask you to register a webhook in the external service/app.

You don't have to set up the event listener right away, but you can always return to it and click **View setup instructions** to finish the setup.

You can technically configure more than one event listener to trigger the same script, but in this case, please be mindful that the script logic and the event type must account for potentially processing more than a single event type.

## Environments

When you create a new [environment](https://docs.adaptavist.com/src/latest/workspaces/deployments-and-environments), you'll be asked to relink the connector and re-run the setup instructions (if required) to register the event listener within the context of your new environment.

You cannot create a new deployment and have it deployed to the (new) environment until that environment has all the event listeners gone through a setup.

## Test event payloads

Testing your script by triggering event listeners externally (from the external service/app) can be time-consuming. To increase productivity, you can register a dummy event to trigger your event listeners internally without ever leaving the ScriptRunner Connect app.

You must save the event listener at least once to be able to configure the test event payload.

You can configure the dummy event by opening the event listener and then going to the _Test Event Payloads_ tab. You'll receive a dummy template that has already been created for you. You can modify it to suit your needs, and when you're ready, click the **P****lay** button in the event listener node in the resource tree to trigger your event listener with the dummy event. You can create as many dummy events as you like.

-   The event payload that remains selected in the _Test Event Payloads_ tab will be the default event payload that will get triggered. To change the default selection, return to the _Test Event Payloads_ tab, select a new event payload, and confirm the selection.
-   If the default event payload that we provide is not accurate enough to start from, you can always trigger the event listener externally and have the event logged out into the console by your script, which you can then copy-paste into the payload window and use it as the dummy event.

## Available Event Listeners

ScriptRunner Connect is equipped with connectors for the following apps and services with available event listeners:

Connector

App

Auth Type

[Azure DevOps](https://www.npmjs.com/package/@managed-api/azure-devops-v72-sr-connect)

OAuth 2.0

[Bitbucket Cloud](https://www.npmjs.com/package/@managed-api/bitbucket-cloud-v2-sr-connect)

OAuth 2.0

[Bitbucket On-Premise](https://www.npmjs.com/package/@managed-api/bitbucket-on-premise-v1-sr-connect)

OAuth

[Confluence On-Premise](https://www.npmjs.com/package/@managed-api/confluence-on-prem-v7-sr-connect)

OAuth

[GitHub](https://www.npmjs.com/package/@managed-api/github-sr-connect)

OAuth 2.0

[GitLab](https://www.npmjs.com/package/@managed-api/gitlab-v4-sr-connect)

OAuth 2.0

[Jira Cloud](https://www.npmjs.com/package/@managed-api/jira-cloud-v3-sr-connect)

OAuth 2.0

Jira On-Premise

[Jira On-Premise](https://www.npmjs.com/package/@managed-api/jira-on-prem-v8-sr-connect)

OAuth

[Jira Service Management On-Premise](https://www.npmjs.com/package/@managed-api/jira-service-management-on-premise-v4-sr-connect)

[Jira Service Management Cloud](https://www.npmjs.com/package/@managed-api/jira-service-management-cloud-assets-sr-connect)

OAuth 2.0

[Microsoft](https://www.npmjs.com/package/@managed-api/microsoft-graph-v1-sr-connect)

[Teams](https://www.npmjs.com/package/@managed-api/microsoft-graph-v1-sr-connect)

OAuth 2.0

[monday.com](https://www.npmjs.com/package/@managed-api/monday-sr-connect)

OAuth 2.0

[NetSuite](https://www.npmjs.com/package/@managed-api/netsuite-v1-sr-connect)

OAuth 2.0

[Opsgenie](https://www.npmjs.com/package/@managed-api/opsgenie-sr-connect)

Basic (API Token)

[Salesforce](https://www.npmjs.com/package/@managed-api/salesforce-v57-sr-connect)

OAuth 2.0

[ServiceNow](https://www.npmjs.com/package/@managed-api/service-now-sr-connect)

OAuth 2.0

[Slack](https://www.npmjs.com/package/@managed-api/slack-sr-connect)

App credentials

[Statuspage](https://www.npmjs.com/package/@managed-api/statuspage-v1-sr-connect)

Basic (API Token)

[Zendesk](https://www.npmjs.com/package/@managed-api/zendesk-v2-sr-connect)

OAuth 2.0

[Zoom](https://www.npmjs.com/package/@managed-api/zoom-v2-sr-connect)

App credentials
