# Behaviours

- Platform: cloud
- Space: SR4JC
- Hierarchy: features
- Doc ID: doc-sr4jc-151629763
- Source: https://docs.adaptavist.com/sr4jc/latest/features/behaviours

![](/sr4jc/files/latest/151629763/403866208/1/1751970804000/sr-migrate+%281%29.png)

**Migrating from ScriptRunner for Jira Server/DC to Cloud?** **Learn more in our** **[Feature Parity](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/feature-parity-and-script-alternatives#behaviours)** **overview.**

## Before you start

[![](/sr4jc/files/latest/151629763/339510920/1/1741344478000/sr-icon-power.png)](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=behaviours&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud)

  

[![](/sr4jc/files/latest/151629763/339510919/1/1741344480000/Copy+of+sr-icon-mortar-board.png)](https://docs.adaptavist.com/sr4jc/latest/training/course-scriptrunner-for-jira-cloud-for-beginners/1-2-module-scriptrunner-for-jira-cloud-automation-capabilities)

Visit ScriptRunner HQ to see example scripts. 

  

Before setting up a behaviour, view our demo videos.

[ScriptRunner HQ](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=behaviours&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud)

  

[Watch Behaviours Videos](https://youtube.com/playlist?list=PLnsCytbU4bI6SwVAp1DJlzua9vk1oLQ-G)

## What are Behaviours?

Behaviours give you added control over fields in Jira and Jira Service Management. A [field configuration](https://confluence.atlassian.com/adminjiraserver/specifying-field-behavior-938847255.html?_ga=2.154855672.1347100514.1658738350-964472448.1651132762) customizes how fields behave across an instance. However, a behaviour in ScriptRunner for Jira Cloud allows you to take that field customization further, defining how fields behave for work items in a given space or work item context.

Behaviours provide options enabling you to customize how fields in Jira and Jira Service Management behave. Therefore, you can give your users clear direction when filling in fields on the [Create Behaviour](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/create-and-modify-jira-behaviours) screen. For example, you may want to create a behaviour that hides a field for a specific user group until it's relevant for them to interact with that particular field. 

You can create a behaviour that will:

-   Prefill/preformat a template when a work item is created so users can easily follow it.
    
-   Change the name or description that is displayed for a field.
-   Hide or show a [supported field](https://docs.adaptavist.com/sr4jc/latest/features/behaviours/behaviours-supported-fields-and-products) only to people in a specific role.
    
    Hidden fields
    
    Note that hidden fields can still be submitted if a user edits the HTML form or modifies browser requests. 
    
-   Set a field value based on another supported field.

## How to use Behaviours

Behaviours in ScriptRunner for Jira Cloud can be used to reinforce your business processes. It's beneficial to think of a behaviour as one of your business rules or use cases and understand that it will only affect fields on spaces and work types specified by you.

Within the Behaviours feature, you can choose to change or alter one or more fields. These are essential to initiate a behaviour. As such, they must be defined from the outset and are mandatory. Additionally, it is essential to determine the timing of _when_ the script on the affected field should run: when the create screen first loads or when a change has been made to another supported field.

Difference with ScriptRunner for Jira Server/DC

A fundamental [difference between the ScriptRunner for Jira Server/DC and ScriptRunner for Jira Cloud](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/platform-differences-between-scriptrunner-for-jira-server-dc-and-jira-cloud) behaviours feature is that the field selected is the trigger that causes the behaviour to run in ScriptRunner for Jira Server/DC. However, with ScriptRunner for Cloud, you choose an affected field first and then write a script with logic that will alter that field in your preferred way.
