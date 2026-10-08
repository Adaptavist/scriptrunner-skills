# ServiceNow

What a script meets at run time when it calls ServiceNow or handles its events. Snapshot 2026-10-08, read from `@managed-api/service-now-sr-connect` 2.1.0 and `@sr-connect/servicenow`. Load this file only when a script calls ServiceNow's API or handles its events. Authorizing the connector is `references/connector-setup/servicenow.md`; setting up the outbound REST message is `references/event-listener-setup/servicenow.md`.

## The vendor API

The multipart attachment upload, `POST /api/now/v1/attachment/upload`, takes the file in a form field named `uploadFile`. A stored body sent with `x-stitch-stored-body-id` goes out under the field name `file` unless told otherwise, so add `x-stitch-stored-body-form-data-file-identifier: uploadFile`. The header table is under Fetch in `references/scripting.md`.

## The Managed API

`@managed-api/service-now-sr-connect`, types in `@managed-api/service-now-core`. The events library is spelled `@sr-connect/servicenow`, without the hyphen; both names are right. `Attachment.uploadMultipartFile` builds the `uploadFile` field itself, and `Attachment.uploadBinaryFile` is the raw-body variant; both hold the file in memory, so a large attachment goes through the stored-body route above.

## Event types

`@sr-connect/servicenow/events` exports one type, `ServiceNowGenericEvent`, which is `any`. The sender defines the payload: a business rule's REST message posts whatever its script builds, and there is no seeded sample. Log one real event and type the body from it.

## Verify before trusting

ServiceNow's Attachment API documentation for the field name, and `node_modules/@managed-api/service-now-core/index.js` for what the Managed API sends.
