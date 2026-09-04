# Behaviours

- Platform: data-center
- Space: SR4JS
- Hierarchy: features
- Doc ID: doc-sr4js-442886995
- Source: https://docs.adaptavist.com/sr4js/latest/features/behaviours

![](/sr4js/files/latest/442886995/441364756/1/1750863681000/sr-icon-cloud.png)

**Migrating to Jira Cloud? This feature has partial parity in Cloud. Check out our [Cloud Feature Parity documentation](https://docs.adaptavist.com/display/_PK/SR4JC/feature-parity#behaviours) for more details.**

## What are Behaviours?

Behaviours give you more control over fields in Jira. A [field configuration](https://confluence.atlassian.com/adminjiraserver/specifying-field-behavior-938847255.html) customizes how fields behave, based on the issue operation screen they appear on. However, a behaviour in ScriptRunner allows you to take that field customization further, defining how fields behave for issues in a given project or issue context.

## How to use Behaviours

Behaviours let you extend the standard field configuration options available in Jira, and give you the power to use contextual information like current field values, workflow step name, or user details as conditional logic.

You can create behaviours to:

-   Make a field mandatory depending on other data entered on the issue screen.
    
-   Make a field read-only dependent on user role or group.
    
-   Conduct server-side validation of field data, before the issue screen is submitted.
    
-   Set a field value depending on other issue screen data.
    

Behaviours give you more options to customize how fields in Jira behave, so you can show/hide additional fields when a particular option is selected. For example, you give users the option to select a checkbox when they do not know their SEN (Support Entitlement Number). You can set up a behaviour to show additional fields when this checkbox is selected, to collect the information required to identify them.

Alternatively, you might want to use a behaviour to control what information certain users can edit or view. For example, as a project manager, you may want full control over which issues go into a sprint. Using behaviours, you can make the **Sprint** field read-only for anyone _except_ users in the _Project Managers_ role, ensuring only project managers can add issues to sprints.

## Before you start

![](/sr4js/files/latest/442886995/442887001/1/1758746767000/Copy+of+sr-icon-mortar-board.png)

See our Using Behaviours in ScriptRunner training module to learn about setting up and using behaviours.

  

![](/sr4js/files/latest/442886995/442887002/1/1758746767000/sr-icon-process-chart.png)

Before setting up a behaviour be sure to read through the Behaviour Limitations documentation. This can also help if you’re having problems getting your behaviour to work.

[Behaviours Training](https://docs.adaptavist.com/sr4js/latest/training/course-introduction-to-scriptrunner-for-jira-data-center-server/1-2-video-using-behaviours-in-scriptrunner-for-jira-data-center-server)

  

[Limitations](https://docs.adaptavist.com/sr4js/latest/features/behaviours/behaviour-limitations)

## Preserving user responses

When setting up a behaviour that modifies a form, fields with existing values may be overwritten when a project or issue type is changed. ScriptRunner preserves these overwritten values and displays them in a pop-up, allowing users the option of copying and pasting the original values if required. ![](/sr4js/files/latest/442886995/442886997/1/1758746766000/Screenshot+2021-11-23+at+11.28.57.png)

There is no way to disable this pop-up.
