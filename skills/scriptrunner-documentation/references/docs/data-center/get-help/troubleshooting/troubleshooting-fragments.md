# Troubleshooting Fragments

- Platform: data-center
- Space: SR4JS
- Hierarchy: get-help > troubleshooting
- Doc ID: doc-sr4js-566298163
- Source: https://docs.adaptavist.com/sr4js/latest/get-help/troubleshooting/troubleshooting-fragments

## Fragment performance in Jira 10

In some Jira 10 Data Center environments, updating [web fragments](https://docs.adaptavist.com/sr4js/latest/features/fragments) can cause noticeable performance degradation, especially on large clusters. From ScriptRunner for Jira Data Center **9.37.0 and later in the 9.x series**, we’ve introduced changes to how fragment updates are propagated across the cluster to reduce this impact. **These changes are not yet present in ScriptRunner 8.x or 10.x.**

This guide explains how to enable the fragment performance feature in ScriptRunner and how to check whether it improves performance in your instance. 

### Enable the fragment performance feature

1.  Navigate to **Administration > System > Dark features**.
2.  Under **Enable dark feature**, add:  
    `scriptrunner.fragments.performance`
3.  Click **Add** to enable the feature.

To disable the feature again, remove `scriptrunner.fragments.performance` from the list of enabled dark features.

### Validate fragment performance

1.  Navigate to your ScriptRunner **Fragments** page.
2.  **Save** an existing fragment, or **edit and save** a fragment.
3.  Observe whether fragment-related operations complete faster and with less impact on overall Jira responsiveness than before. 

If you do not see any performance improvement, or if you notice degraded performance (for example, slow responses, timeouts, or elevated load during fragment updates), please:

-   Capture recent application logs (for example, via a **Support Zip**), and
-   Share them with [Adaptavist Support](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/21), along with:
    -   Your Jira version and ScriptRunner version
    -   Whether you are running a cluster (and how many nodes)
    -   A brief description of what you were doing when the issue occurred 

This information will help us investigate and refine the feature for your environment.
