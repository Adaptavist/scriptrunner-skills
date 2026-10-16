# Atlassian Marketplace

What a script meets at run time when it calls the Atlassian Marketplace reporting API, the vendor-side API for licenses, transactions and sales of a Marketplace partner's apps. Snapshot 2026-10-16, from agents' notes on a partner account. It has no connector or listener of its own: reach it through a Generic connector holding the partner's credentials. Load this file only when a script calls that API.

## The vendor API

- Per-record lookups hit 429 quickly. Calls such as `licenses?text=<cloudId>` and `sales/transactions?text=<entitlement>`, one per license at a concurrency of 10, were throttled constantly. Do not fan out over licenses.
- Use the asynchronous exports instead. The license and transaction exports are ready within seconds to about a minute; poll the export's status at a modest interval, then download the result. One agent's run of 44 transaction exports and one license export took about 8 minutes to download and index in all.
- A large export can be too big for one response. See the Fetch section of `references/scripting.md`: split it by date range.
- Some Data Center licenses have no `licenseId` (SEN). Passing that undefined value as `sales/transactions?text=` drops the filter, and the call returns the first page of the whole developer space's transactions, which looks like a real answer. Their transactions are filed under `appEntitlementNumber`; search by that, and never build a `text=` filter from a value you have not checked is present.

## The Managed API

None. Use the Generic connector's managed `fetch`.

## Event types

None. The reporting API sends no webhooks; a scheduled trigger polls it.

## Verify before trusting

- The throttling: one probe at low concurrency before a bulk run, and log the headers of a 429 to see what the API asks for.
- An empty filter: log the exact query string a lookup sent before trusting a result count.
