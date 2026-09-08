# Guardrails

- Platform: data-center
- Space: SR4JS
- Hierarchy: best-practices
- Doc ID: doc-sr4js-348417816
- Source: https://docs.adaptavist.com/sr4js/latest/best-practices/guardrails

Atlassian recommends a number of [guardrails](https://confluence.atlassian.com/adminjiraserver/jira-software-guardrails-1141488685.html) that are designed to prevent or fix performance issues with your Jira instance. 

It's not easy to check for guardrails that exceed the recommended guidelines using just Jira alone. **This is where ScriptRunner comes in!**

With ScriptRunner you can run a number of [built-in scripts](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/guardrails-built-in-scripts) to check guardrails associated with projects, comments, attachments, issue links and change logs. ScriptRunner also allows you to run more complex JQL queries to check the [epics guardrail](#id-.Guardrailsv8.x-Epicsguardrail). 

## Guardrails strategy

We recommend that you develop a policy or strategy to regularly check guardrails. Doing so should reduce the occurrence of performance issues with your Jira instance. The strategy you choose is up to you and your company. For example, you can check each guardrail once a month, or, you can choose to only check guardrails of concern. 

## Built-in scripts

We have developed multiple [built-in scripts](https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/guardrails-built-in-scripts) so you can check if certain guardrails exceed the recommended guidelines, and to bring any that do within the correct limits. We haven't developed a built-in script for epics, however you can search for epics with the aid of ScriptRunner, as described below.

## Epics guardrail

In the suggested JQL queries below, we recommend you add a time clause to avoid archiving a recently created epic. For example, to find epics that have not been updated for over a year use: `and updated < -52``w`. 

Atlassian recommends a [guardrail limit of 100,000 epics](https://confluence.atlassian.com/adminjiraserver/jira-software-guardrails-1141488685.html#JiraSoftwareguardrails-Epics). The epic link menu loads slowly in instances with epics over this value. To avoid this issue, Atlassian suggests you archive epics that are not needed. 

A built-in script isn't required for this guardrail as finding the total number of epics is simple. You can use the following JQL query and look at the total count:

```
issuetype = Epic
```

With ScriptRunner you can also run more specific queries, such as those listed below. 

**Finding epics that don't have stories:**

1.  Run the following JQL query:
    
    ```
type = Epic and issueFunction not in epicsOf('')
```
    
2.  Review the results, then bulk archive those that are not needed.

**Finding epics where all the stories are closed:**

1.  Run the following JQL query:  
    
    ```
issueFunction in epicsOf('resolution is not empty') and not issueFunction in epicsOf('resolution is empty')
```
    
2.  Review the results, then bulk archive those that are not needed.

**Deleting epics**

If you don't want to archive an epic, you can delete it. You are only able to delete an epic if you have permission to do so.
