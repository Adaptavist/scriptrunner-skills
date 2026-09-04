# Behaviour Limitations

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > behaviours
- Doc ID: doc-sr4js-442889222
- Source: https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviour-limitations

## JavaScript-based

Behaviours rely on client-side JavaScript. In most environments, users can disable JavaScript in their browser. If the security of a field is critical, behaviours are not enough to protect the field from malicious data entry.

However, the typical use cases are to prompt the user that they should be entering another field depending on some condition, or to hide a field for clarity’s sake. In these cases, the user is better off with behaviours, and no worse off than they were without them.

If a behaviour makes a field read-only, the issue history can also reveal if that rule has been subverted.

One of the intentions of this feature is to provide a more structured, maintainable way to customize fields rather than entering javascript in a field description.

Another side effect is that behaviours can't override other server-side validation rules, such as field configurations and workflow validators. For example, if you have a field configuration that specifies a field is required, a behaviour can't override that requirement. You can however, take a non-required field and make it required.

## Bulk edit

There is currently no support for bulk edits.

## Latency

The field behaviours are retrieved from the server after the form has loaded in the browser. This may cause a delay in the styling being applied.

## Remote API

Due to the JavaScript limitation, the behaviours are not enforced when using the remote API.

## Multiple behaviours on the same field

It is possible to apply multiple behaviours in overlapping contexts. For example, you may have a behaviour that is mapped to one project and all issue types, then another behaviour that is mapped to all projects and one particular issue type.

Normally, this is fine as all applicable behaviours are applied in any given context. However, if both behaviours try to manipulate the same field, it’s possible for them to contradict each other. For example, if one behaviour tries to set the field to be read-only, but the other sets the field to be writeable, only one can win. If both behaviours set the field’s value to something specific, only one is applied.

If a behaviour appears to be working inconsistently, this is a likely cause.

It may be helpful in these circumstances to use one server-side behaviour for that field. You can map it to every applicable context, then provide some detailed logic specifying in one place what ought to happen in which circumstances. See [Scripted Conditions](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviours-examples/scripted-conditions) for some sample code that you can re-purpose inside a behaviour.

## Screens

Behaviours only function on the following screens:

-   Create Issue
-   Update/Edit Issue
-   Assign Issue
-   Workflow Transition

Behaviors are not supported on other screens (for example, Advanced Roadmaps/Plans screens).

On the _View Issue_ screen, trying to edit a field with a behaviour launches the _Edit Issue screen_, instead of the normal inline editor.

Behaviours do not work on the _Move Issue_ screen. They also do not work for any bulk issue operations, or any issue edits that bypass the UI such as the REST API and other ScriptRunner scripts.

## Permissions

If you use a behaviour to link to other projects, the user interacting with the behaviour needs the appropriate permissions in those projects to do whatever it is you are having them do. For example, if you create a behaviour that allows a user to link to issues, that user must have the _Link Issues_ permission in the other projects.

## Required fields limitations in Jira Service Desk customer portal

There is a known limitation with the Behaviours feature in the Jira Service Desk (JSD) customer portal. Currently, Behaviours cannot override required fields in this specific interface. If a field is set as required in Project settings, using a Behaviour to make it optional will not take effect when creating issues through the JSD portal. The field will still appear as required.

This limitation only applies to the customer portal.
