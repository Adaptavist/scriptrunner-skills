# Example Scripts

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: Scripting Resources
- Doc ID: doc-sr4cc-575dc65b-08c7-4214-aa01-dba02a379c21-9ffb21be145a108b
- Source: https://docs.adaptavist.com/sr4cc/latest/scripting-resources#example-scripts--en

Example Scripts are available from the Code Editor to help with basic examples of useful scripts within ScriptRunner.

The _Example Scripts_ modal is your go-to destination for finding basic examples (formerly the Examples field) and Adaptavist [Library](https://library.adaptavist.com/) scripts without having to leave the ScriptRunner app. To access this modal, you can select the Example Scripts button in any code editor within ScriptRunner.

This modal automatically displays basic examples and Adaptavist Library scripts related to the feature you are working on. When you select a script on the left-hand side, it appears and you can Copy Code.

## Search for scripts

The _Example Scripts_ modal also has a search function that allows you to easily search for an appropriate script. Simply type one or more keywords into the search bar:

## FAQs

### Why can't I see any Library scripts?

When Adaptavist Library examples do not display, and there is no error indicator within the Examples modal, this indicates there are no Library examples for that particular context. We are constantly adding to the library, so there may be examples added for that context in the future.

When Adaptavist Library examples do not display, and you see an error indicator on the page, your internet connection may be down or blocking API calls to the Adaptavist Library API. You should first check your internet connection. If your internet connection is good, ensure that you allow communication to the Adaptavist Library API via the `[examples.scriptrunner.io](http://examples.scriptrunner.io/)` domain to receive Library examples within the ScriptRunner App. If you still have problems after trying this solution, please contact [Adaptavist Support](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/18).

### Can I still use the Adaptavist Library?

Yes, you can still access and use the [Adaptavist Library](https://library.adaptavist.com/).

### Does this new modal slow down my instance?

The _Example scripts_ modal sends API requests from a user's browser to the Adaptavist Library API. These API requests are used to retrieve and search over external script examples. We have optimized our API to speed up responses, so this modal is unlikely to impact performance.
