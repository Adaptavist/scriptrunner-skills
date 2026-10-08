# Google Sheets

What a script meets at run time when it calls Google Sheets. Snapshot 2026-10-08, read from `@managed-api/google-sheets-v4-sr-connect` 2.2.0 and `@managed-api/google-drive-v3-core` 1.4.0 and from an agent's notes. Load this file only when a script calls Google Sheets' API. Authorizing the connector is `references/connector-setup/google-sheets.md`.

## The vendor API

Nothing beyond Google's own documentation is known. A spreadsheet is copied with Drive's `files.copy` or rebuilt tab by tab; Sheets itself has no file copy.

## The Managed API

The whole method list, so nothing else is worth looking for:

- `Spreadsheet.createSpreadsheet`, `Spreadsheet.getSpreadsheet`
- `Spreadsheet.Sheet.copySheet`, which copies one tab into another spreadsheet (`sheets.copyTo`)
- `Spreadsheet.Value.appendValuesInRange`, `clearValuesInRange`, `getValuesInRange`, `setValuesInRange`

There is no `batchUpdate`, so no formatting, renaming, adding or deleting tabs, and no whole-file copy. Anything else goes through the connection's managed `fetch`, which supplies the base URL and auth: `GoogleSheets.fetch('/v4/spreadsheets/<id>:batchUpdate', { method: 'POST', body: JSON.stringify({ requests }) })`. The path shape is the one the package's own methods send, `/v4/spreadsheets/<id>/...`.

Copying a spreadsheet, the way that worked: `createSpreadsheet`, then `copySheet` for each tab of the template, then one `batchUpdate` through managed `fetch` to rename the copied tabs and delete the empty default one. Drive's Managed API has `File.copyFile`, but the Google Drive connector reaches only files the platform created, so it cannot copy a template a person made; see `references/connector-setup/google-drive.md`.

## Event types

No listener type. Google Apps Script bound to the sheet posts to a Generic listener; see the bridge in `references/event-listener-setup/generic.md`.

## Verify before trusting

The method list: `grep -n "Alternative usage" node_modules/@managed-api/google-sheets-v4-core/index.d.ts`. A newer package version may add `batchUpdate`; check `package list-npm-versions @managed-api/google-sheets-v4-sr-connect` before building around its absence.
