# Behaviours

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features
- Doc ID: doc-sr4js-6b84c0fa-9055-4152-aa7d-3e45b593e3df-792ac6c9c23ce1d9
- Source: https://docs.adaptavist.com/sr4js/latest/features#behaviours--en

|  |  |
| --- | --- |
|  | Migrating to Jira Cloud? This feature has partial parity in Cloud.<br>[Cloud Feature Parity documentation](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/scriptrunner-migration-to-cloud/feature-parity-and-script-alternatives#behaviours--en) |

## What are Behaviours?

Behaviours give you more control over fields in Jira. A [field configuration](https://confluence.atlassian.com/adminjiraserver/specifying-field-behavior-938847255.html) customizes how fields behave, based on the issue operation screen they appear on. However, a behaviour in ScriptRunner allows you to take that field customization further, defining how fields behave for issues in a given project or issue context.

## How to use Behaviours

Behaviours let you extend the standard field configuration options available in Jira, and give you the power to use contextual information like current field values, workflow step name, or user details as conditional logic.

You can create behaviours to:

-   Make a field mandatory depending on other data entered on the issue screen.
-   Make a field read-only dependent on user role or group.
-   Conduct server-side validation of field data, before the issue screen is submitted.
-   Set a field value depending on other issue screen data.

Behaviours give you more options to customize how fields in Jira behave, so you can show/hide additional fields when a particular option is selected. For example, you give users the option to select a checkbox when they do not know their SEN (Support Entitlement Number). You can set up a behaviour to show additional fields when this checkbox is selected, to collect the information required to identify them.

Alternatively, you might want to use a behaviour to control what information certain users can edit or view. For example, as a project manager, you may want full control over which issues go into a sprint. Using behaviours, you can make the Sprint field read-only for anyone _except_ users in the _Project Managers_ role, ensuring only project managers can add issues to sprints.

## Before you start

|  |  |
| --- | --- |
|  | See our Using Behaviours in ScriptRunner training module to learn about setting up and using behaviours.<br>[Behaviours Training](../training/course-introduction-to-script-runner-for-jira-data-center/1-2-video-using-behaviours-in-script-runner-for-jira-data-center.md) |
|  | Before setting up a behaviour be sure to read through the Behaviour Limitations documentation. This can also help if you're having problems getting your behaviour to work.<br>[Limitations](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviour-limitations) |

## Preserving user responses

When setting up a behaviour that modifies a form, fields with existing values may be overwritten when a project or issue type is changed. ScriptRunner preserves these overwritten values and displays them in a pop-up, allowing users the option of copying and pasting the original values if required.

Note: There is no way to disable this pop-up.
