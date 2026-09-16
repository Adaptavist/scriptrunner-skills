# Behaviours

- Platform: cloud
- Space: SR4JC
- Hierarchy: Features
- Doc ID: doc-sr4jc-b5605134-7894-46e9-b724-f64e1dff9829-fd90b959495a21bf
- Source: https://docs.adaptavist.com/sr4jc/latest/features/behaviours

|  |  |
| --- | --- |
|  | Migrating from ScriptRunner for Jira Server/DC to Cloud? Check out our [ScriptRunner Migration to Cloud](../uncategorized/s/script-runner-migration-to-cloud.md) section. |

## Before you start

|  |  |
| --- | --- |
|  | Visit ScriptRunner HQ to see example scripts.<br>[ScriptRunner HQ website](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=behaviours&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud) |
|  | View our demo videos before setting up a behaviour.<br>[Watch Behaviours videos](https://www.youtube.com/playlist?list=PLnsCytbU4bI6SwVAp1DJlzua9vk1oLQ-G) |

## What are Behaviours?

Behaviours give you added control over fields in Jira and Jira Service Management. A [field configuration](https://confluence.atlassian.com/adminjiraserver/specifying-field-behavior-938847255.html?_ga=2.154855672.1347100514.1658738350-964472448.1651132762) customizes how fields behave across an instance. However, a behaviour in ScriptRunner for Jira Cloud allows you to take that field customization further, defining how fields behave for work items in a given space or work item context.

Behaviours provide options enabling you to customize how fields in Jira and Jira Service Management behave. Therefore, you can give your users clear direction when filling in fields on the [Create Behaviour](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/create-and-modify-jira-behaviours) screen. For example, you may want to create a behaviour that hides a field for a specific user group until it's relevant for them to interact with that particular field.

You can create a behaviour that will:

-   Prefill/preformat a template when a work item is created so users can easily follow it.
-   Change the name or description that is displayed for a field.
-   Hide or show a [supported field](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-supported-fields-and-products) only to people in a specific role.
    
    Note: Hidden fields can still be submitted if the HTML form is editied or browser requests are modified.
    
-   Set a field value based on another supported field.

## How to use Behaviours

Behaviours in ScriptRunner for Jira Cloud can be used to reinforce your business processes. It's beneficial to think of a behaviour as one of your business rules or use cases and understand that it will only affect fields on spaces and work types specified by you.

Within the Behaviours feature, you can choose to change or alter one or more fields. These are essential to initiate a behaviour. As such, they must be defined from the outset and are mandatory.

Additionally, it is essential to determine the timing of _when_ the script on the affected field should run: when the create screen first loads or when a change has been made to another supported field.

Note: Difference with ScriptRunner for Jira Server/DC

A fundamental [difference between the ScriptRunner for Jira Server/DC and ScriptRunner for Jira Cloud](../script-runner-migration-to-cloud/platform-differences-between-script-runner-for-jira-server-dc-and-jira-cloud.md) behaviours feature is that the field selected is the trigger that causes the behaviour to run in ScriptRunner for Jira Server/DC. However, with ScriptRunner for Cloud, you choose an affected field first and then write a script with logic that will alter that field in your preferred way.
