# Vendors API

- Platform: data-center
- Space: SR4JS
- Hierarchy: integrations
- Doc ID: doc-sr4js-442888201
- Source: https://docs.adaptavist.com/sr4js/latest/integrations/vendors-api

We have developed a new API for Atlassian Marketplace Vendors to use with their custom Jira fields to make them compatible with our DC [Behaviours](https://docs.adaptavist.com/sr4js/latest/features/behaviours) feature. When a Vendor integrates this API, all custom fields created with their application will work seamlessly with our Behaviours feature. 

## For Vendors

As Atlassian Marketplace Vendors, you can use this API to make your custom fields read-only, provide values, and accept values. Reading these fields depends on how a Jira Admin creates their Behaviours. This API also provides a way to inform our Behaviours feature that a field value has been changed by a user.

Once you have integrated this API, your users use will be able to do the following with your custom Jira fields when they use our Behaviours feature:

-   Set the field value
-   Get the field value
-   Make the field read-only 
-   Make the field writable
-   Monitor the field for a value change event
-   Automatically update set list values when new options are added

Users can already do all this with custom fields provided by Jira. 

## Why have we developed this API?

Behaviours are one of our most popular features for ScriptRunner for Jira DC and we want everyone to be able to use this feature with ease.

## Accessing this API

You can access this API on [npm](https://www.npmjs.com/package/@scriptrunnerhq/vendors-api) and [GitHub](https://github.com/scriptrunnerhq/vendors-api). 

## Integrating our API into your application

You can integrate this API using the _Readme_ file found on [npm](https://www.npmjs.com/package/@scriptrunnerhq/vendors-api) and [GitHub](https://github.com/scriptrunnerhq/vendors-api). 

## Example Plugin

We've developed an example plugin for you to use so you can test this API. Check out the [Vendors API Example Plugin](https://docs.adaptavist.com/sr4js/latest/integrations/vendors-api/vendors-api-example-plugin) page for details on compiling, configuring, and testing the example plugin.
