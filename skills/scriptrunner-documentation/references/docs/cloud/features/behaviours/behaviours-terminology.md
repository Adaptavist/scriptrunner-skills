# Behaviours Terminology

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > behaviours
- Doc ID: doc-sr4jc-537427969
- Source: https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-terminology

## Behaviour

A **behaviour** is a configuration that lets you control how fields appear and behave in Jira forms and in Jira Service Management. For example, you can make fields required, hide them, set default values, or change field options based on user input.

## Behaviour mapping

**Behaviour mapping** defines where a behaviour is applied. Mapping connects a behaviour to specific Jira spaces (projects) and work types (issue types).

For example, if a behaviour called _Change Summary Name_ is mapped to the _Docs_ space and the _Task_ work type, the behaviour will only apply when creating or editing Task work items in the Docs space.

### Behaviour mapping wildcard limitation

You can select the wildcard option for either **All spaces** or **All work types** only; due to an Atlassian limitation, both options cannot be chosen simultaneously. 

## Behaviours Bot

The **Behaviours Bot** is an AI-powered script generation assistant built into ScriptRunner for Jira Cloud. It converts natural, everyday language instructions into ready-to-use Behaviour scripts. 

The Behaviours Bot uses a Ministral model by Mistral AI (hosted on AWS Bedrock) to process requests and generate responses.

## Behaviour logs

**Behaviour Logs** record activity related to behaviours, such as execution details, errors, or debugging information. Logs can help troubleshoot why a behaviour is or is not working as expected.

## Condition

A **condition** is a rule that determines when part of a behaviour should run.

For example, a field may only become required when another field is set to **High Priority**.

## Fields

Within the Behaviours feature, you can choose to change or alter one or more fields in your Jira instance. These are essential to initiate a behaviour.

## onLoad

In Behaviours, you can determine when a script should run by selecting the script execution trigger. _onLoad_ defines that a script runs as soon as a screen or form initially loads.

When you select _onLoad_, the script runs immediately when the screen is displayed. For example, it can update a field name or description, pre-populate a field value, set default values, or adjust field visibility.

## onChange

In Behaviours, you can determine when a script should run by selecting the script execution trigger. _onChange_ defines that a script runs when a supported field value changes.

Select _onChange_ when your logic depends on a specific field being updated. When that field changes, the script is triggered and can update other fields accordingly. This trigger is typically used when one field controls or affects the behaviour of another field. 

## Space

A **space** refers to the Jira space (formerly known as a project) where work is managed. Behaviours can be mapped to one or more spaces.

## Supported fields

In the Behaviours feature, modifications can **only** be made to supported fields, depending on your selected view. You can refer to the [Supported fields](https://docs.adaptavist.com/sr4jc/current/features/behaviours/behaviours-supported-fields-and-products#supported-fields) section for details. 

System fields & custom fields

In Behaviours, some Jira-native system fields can be custom field types. An example of this is the **Labels** field, which is a Jira-native system field. Only Jira-native system fields are supported, so your Behaviours may not function correctly if you have created a custom field of _type_ **Labels**.

## Supported products

Both company and team-managed spaces are supported on Cloud for Jira Software. We also support Jira Service Management. You can refer to the [Supported Jira products](https://docs.adaptavist.com/sr4jc/current/features/behaviours/behaviours-supported-fields-and-products#supported-jira-products) section for details.

## Work type

A **work type** refers to the type of item being created or edited in Jira, such as Task, Bug, or Story.

## UUID

A **UUID** (Universally Unique Identifier) is a unique value assigned to each behaviour. It helps identify a specific behaviour among all others in your instance.

You can use the UUID to:

-   Search for a behaviour
-   Reference it in support requests or troubleshooting
-   View it in **Behaviours Logs**

## View types

A **view type** refers to the Jira screen where a behaviour is applied. It determines the context in which the behaviour runs, such as when creating, editing, or transitioning a work item.

Within the Behaviours feature, you can choose to run a script on one or more of the following view types:

-   Create - shown when creating a new work item. Behaviours mapped to this view run during item creation.
-   View/Edit - shown when editing an existing work item. Behaviours mapped to this view run while updating an item.
-   Transition -  shown when moving an existing work item. Behaviours mapped to this view run while moving or transitioning an item.

The term view type in this context refers to the Jira screen that the behaviour is being applied to. For example, when you have a behaviour that runs on a transition, you are not actually applying it to the transition itself; you are applying it to the Jira screen associated with that workflow transition. 

When adding or editing a script, you can select the relevant view type to control where the behaviour should apply, as shown in the example below:

![](/sr4jc/files/latest/537427969/537427971/1/1776178448000/select+view+types.png)

Modifications can **only** be made to the supported fields for your chosen view type, as outlined in the [Behaviours Supported Fields and Products](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-supported-fields-and-products) section.
