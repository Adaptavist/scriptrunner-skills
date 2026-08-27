# Behaviours Supported Fields and Products

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > behaviours
- Doc ID: doc-sr4jc-244384040
- Source: https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-supported-fields-and-products

Jira terminology changes

As noted in our [March 2026 release note](https://docs.adaptavist.com/sr4jc/latest/release-notes/release-notes), ScriptRunner for Jira Cloud is aligning with Jira's updated terminology across the app UI and documentation. 

Some Atlassian documentation - particularly the [Jira UI modifications](https://developer.atlassian.com/platform/forge/manifest-reference/modules/jira-ui-modifications/?tabId=3&tab=jira+global+issue+create#view-specific-requirements-and-limitations) guide referenced throughout this page - still uses the previous terminology. As a result, this page currently reflects that older terminology with only minimal updates, and will be revised in due course. 

## Supported Jira products

Jira Product

Supported Capability

Supported on Cloud

_Jira_ 

Company-managed spaces

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

  

Team-managed spaces

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

_Jira Service Management_

  

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

Behaviours are only supported in the Create view for Business company-managed spaces.

### Supported Jira view-specific limitations

View

Space type

Jira global issue create  
(Create view type)

Company-managed

Team-managed

Jira issue view  
(View/Edit view type)

Company-managed

Team-managed

Jira issue transition  
(Transition view type)

Company-managed

Refer to Atlassian's [Jira UI modifications](https://developer.atlassian.com/platform/forge/manifest-reference/modules/jira-ui-modifications/?tabId=3&tab=jira+global+issue+create#view-specific-requirements-and-limitations) documentation for more details.

## Supported fields on JSM

JSM is currently supported in Portal view only. Due to an Atlassian limitation, Agent view is not supported at this time but will be available soon.

Developing Behaviours on Cloud and adding more functionality to this feature remains a high priority for the ScriptRunner team! Behaviours can be applied to **Sub-tasks** and the supported fields outlined below for the **Request Create Portal** on Jira Service Management. We continually strive to support the functionality provided by Atlassian. For more information, please refer to [Atlassian's UI Modifications](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?tabId=1&tab=jira+service+management#supported-fields-per-view) guide.

Modifications can **only** be made to supported fields, depending on your selected view, as outlined in the section below.

System Fields & Custom Fields

In Behaviours, some Jira-native system fields can be custom field types. An example of this is the **Labels** field, which is a Jira-native system field. Only Jira-native system fields are supported, so your Behaviours may not function correctly if you have created a custom field of _type_ **Labels**. System field types are identified in each of the Supported Fields tables below, while custom field types are marked with a ![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg).

### Request create portal (Preview)

Field/methods

System  
Field Type

setName  
getName

setDescription  
getDescription

setVisible  
isVisible

setValue  
getValue

setReadOnly  
isReadOnly

setRequired  
isRequired

setOptionsVisibility  
getOptionsVisibility

[cascading select](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?tabId=1&tab=jira+service+management#cascading-select)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[date picker](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?tabId=1&tab=jira+service+management#date-picker)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[date time picker](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?tabId=1&tab=jira+service+management#date-time-picker)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[description](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?tabId=1&tab=jira+service+management#description)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[due date](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?tabId=1&tab=jira+service+management#due-date)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[labels](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?tabId=1&tab=jira+service+management#labels)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[multi select](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?tabId=1&tab=jira+service+management#multi-select)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

[number](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?tabId=1&tab=jira+service+management#number)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[paragraph](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?tabId=1&tab=jira+service+management#paragraph)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[priority](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?tabId=1&tab=jira+service+management#priority)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

[single select](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?tabId=1&tab=jira+service+management#single-select)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

[summary](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?tabId=1&tab=jira+service+management#summary)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[text field](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?tabId=1&tab=jira+service+management#text-field)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[user picker](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?tabId=1&tab=jira+service+management#user-picker)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

## Supported fields on Jira

Behaviours mapping wildcard limitations

You can select the wildcard option for either **All spaces** or **All work types** only; due to an Atlassian limitation, both options cannot be chosen simultaneously. 

Using the '**All spaces**' field on a behaviour means only 1 context is used for spaces. If it is used with several Work Types, then this 1 context is multiplied by the number of work types selected. If we enable this behaviour for multiple view types, this value is also multiplied by the number of view types. For example:

**Field**

**Selected**

**Contexts**

Space

All Spaces (100 spaces)

1

Work Type/s

Story, Bug, Task

3

Jira Views

Issue Create, Issue View  
(Create, View/Edit view types)

2

  

**Total**

6

Developing Behaviours on Cloud and adding more functionality to this feature remains a high priority for the ScriptRunner team! Behaviours can be applied to **Sub-tasks** and the supported fields outlined below for the **Global Issue Create**, **Issue,** and **Transition** views (Create, View/Edit, Transition view types). We continually strive to support the functionality provided by Atlassian. For more information, please refer to [Atlassian's UI Modifications](https://developer.atlassian.com/platform/forge/custom-ui-jira-bridge/uiModifications/#issue-view--preview-) guide.

Modifications can **only** be made to supported fields, depending on your selected view, as outlined in the [Create](#id-.BehavioursSupportedFieldsandProductsvCurrent-createviewfields), [Issue](#id-.BehavioursSupportedFieldsandProductsvCurrent-issueviewfields), and [Transition](#id-.BehavioursSupportedFieldsandProductsvCurrent-transitionviewfields) view sections below.

System Fields & Custom Fields

In Behaviours, some Jira-native system fields can be custom field types. An example of this is the **Labels** field, which is a Jira-native system field. Only Jira-native system fields are supported, so your Behaviours may not function correctly if you have created a custom field of _type_ **Labels**. System field types are identified in each of the Supported Fields tables below, while custom field types are marked with a ![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg).

### Create view supported fields (Create view type)

Field/methods

System  
Field Type

setName  
getName

setDescription  
getDescription

setVisible  
isVisible

setValue  
getValue

setReadOnly  
isReadOnly

setRequired  
isRequired

setOptionsVisibility  
getOptionsVisibility

[affects version](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#affects-versions)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[assignee](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#assignee)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[cascading select](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#cascading-select)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[components](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#components)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[checkboxes](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#checkboxes)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

[date picker](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#date-picker)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[date time picker](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#date-time-picker)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[description](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#description)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[due date](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#due-date)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[fix versions](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#fix-versions)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[issue type](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#issue-type)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

[labels](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#labels)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[multi select](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#multi-select)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

[multi user picker](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#multi-user-picker)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[number](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#number)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[paragraph](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#paragraph)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[parent](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#parent)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[people](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#people)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[priority](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#priority)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

[project picker](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#project-picker)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[radio buttons](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#radio-buttons)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

[reporter](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#reporter)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[single select](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#single-select)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

[summary](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#summary)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[target start](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#target-start)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[target end](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#target-end)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[text field](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#text-field)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[url](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#url)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[user picker](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#user-picker)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

### Issue view supported fields (View/Edit view type)

Hidden fields

On the Issue view, fields with no value are automatically hidden when they are set to read-only. For example, empty read-only date picker, text (single), select list (single and multiple), checkbox, radio, and number fields are hidden. This is the default behaviour when the user does not have permission to edit the issue.

Field/methods

System  
Field Type

setName  
getName

setDescription  
getDescription

setVisible  
isVisible

setValue  
getValue

setReadOnly  
isReadOnly

setRequired  
isRequired

setOptionsVisibility  
getOptionsVisibility

[affects versions](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#affects-versions)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[assignee](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#assignee)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[cascading select](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#cascading-select)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[components](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#components)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[checkboxes](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#checkboxes)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

[date picker](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#date-picker)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[date time picker](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#date-time-picker)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[description](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#description)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[fix versions](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#fix-versions)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[labels](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#labels)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[multi select](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#multi-select)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

[multi user picker](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#multi-user-picker)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[number](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#number)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[original estimate](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#original-estimate)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[paragraph](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#paragraph)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[parent](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#parent)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[people](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?_ga=2.166433918.1955634371.1731929740-1634595110.1727432790#people)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[priority](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#priority)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

[project picker](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#project-picker)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[radio buttons](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#radio-buttons)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

[reporter](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#reporter)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[single select](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#single-select)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

[status](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#status)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[summary](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#summary)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[text field](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#text-field)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[url](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#url)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[user picker](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#user-picker)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

Story Points field does not perform in the same way as a regular number field

The Story Points field must not be handled as a generic supported `Number` field. In Jira Cloud, Story Points is a Jira-managed special field, and Jira does not reliably enforce read-only behavior for it in the `Issue View`.

#### Supported views for issue view

Behaviours configured to run on the Issue View are triggered when accessed through one of the views outlined below, which are highlighted with example images:

-   full page issue   
    ![](/sr4jc/files/latest/244384040/322830755/1/1737375095000/full+page+issue.png)
-   board issue   
    ![](/sr4jc/files/latest/244384040/322830752/1/1737375269000/board+issue.png)
-   backlog issue  
    ![](/sr4jc/files/latest/244384040/322830751/1/1737375309000/backlog+issue.png)
-   list issue  
    ![](/sr4jc/files/latest/244384040/322830750/1/1737375341000/list+issue+view.png)
-   Issues issue  
    ![](/sr4jc/files/latest/244384040/322830749/1/1737375366000/Issues+issue+view.png)
-   search issue (global search)  
    ![](/sr4jc/files/latest/244384040/322830748/1/1737375456000/search+issues.png)

### Transition view supported fields (Transition view type)

Atlassian's New Transition Dialog

Behaviours on transition view run **only** in the [new Issue transition dialog](https://community.atlassian.com/t5/Jira-articles/Now-GA-try-the-new-issue-transition-experience-in-Jira/ba-p/2734436), as defined by Atlassian’s [UI Modifications API](https://developer.atlassian.com/platform/forge/custom-ui-jira-bridge/uiModifications). If this has not been enabled for your instance, then Behaviours on transition view will not work.

Field/methods

System  
Field Type

setName  
getName

setDescription  
getDescription

setVisible  
isVisible

setValue  
getValue

setReadOnly  
isReadOnly

setRequired  
isRequired

setOptionsVisibility  
getOptionsVisibility

[affects version](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?_ga=2.166433918.1955634371.1731929740-1634595110.1727432790#affects-versions)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

[assignee](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?_ga=2.166433918.1955634371.1731929740-1634595110.1727432790#assignee)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[cascading select](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?_ga=2.166433918.1955634371.1731929740-1634595110.1727432790#cascading-select)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[checkboxes](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?_ga=2.166433918.1955634371.1731929740-1634595110.1727432790#checkboxes)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

[date picker](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?_ga=2.166433918.1955634371.1731929740-1634595110.1727432790#date-picker)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[date time picker](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?_ga=2.166433918.1955634371.1731929740-1634595110.1727432790#date-time-picker)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[description](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?_ga=2.166433918.1955634371.1731929740-1634595110.1727432790#description)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[fix versions](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?_ga=2.166433918.1955634371.1731929740-1634595110.1727432790#fix-versions)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

[issue type](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?_ga=2.166433918.1955634371.1731929740-1634595110.1727432790#issue-type)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

[labels](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?_ga=2.166433918.1955634371.1731929740-1634595110.1727432790#labels)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[multi select](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?_ga=2.166433918.1955634371.1731929740-1634595110.1727432790#multi-select)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

[multi user picker](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?_ga=2.166433918.1955634371.1731929740-1634595110.1727432790#multi-user-picker)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[number](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?_ga=2.166433918.1955634371.1731929740-1634595110.1727432790#number)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[original estimate](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?_ga=2.166433918.1955634371.1731929740-1634595110.1727432790#original-estimate)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[paragraph](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?_ga=2.166433918.1955634371.1731929740-1634595110.1727432790#paragraph)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[parent](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?_ga=2.166433918.1955634371.1731929740-1634595110.1727432790#parent)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

[priority](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?_ga=2.166433918.1955634371.1731929740-1634595110.1727432790#priority)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

[project picker](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#project-picker)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[radio buttons](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?_ga=2.166433918.1955634371.1731929740-1634595110.1727432790#radio-buttons)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

[reporter](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?_ga=2.166433918.1955634371.1731929740-1634595110.1727432790#reporter)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[resolution](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?_ga=2.166433918.1955634371.1731929740-1634595110.1727432790#resolution)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

[single select](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?_ga=2.166433918.1955634371.1731929740-1634595110.1727432790#single-select)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

[summary](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/#summary)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[text field](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?_ga=2.166433918.1955634371.1731929740-1634595110.1727432790#text-field)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[url](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?_ga=2.166433918.1955634371.1731929740-1634595110.1727432790#url)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

[user picker](https://developer.atlassian.com/platform/forge/apis-reference/jira-api-bridge/uiModifications/?_ga=2.166433918.1955634371.1731929740-1634595110.1727432790#user-picker)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)
