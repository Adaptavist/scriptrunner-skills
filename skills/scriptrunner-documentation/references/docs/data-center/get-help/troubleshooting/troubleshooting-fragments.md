# Troubleshooting Fragments

- Platform: data-center
- Space: SR4JS
- Hierarchy: Get Help > Troubleshooting
- Doc ID: doc-sr4js-5f1b2ccc-9f5c-4285-a4d2-9787d9036303-3f1b1bdad809bd13
- Source: https://docs.adaptavist.com/sr4js/latest/get-help#troubleshooting--en#troubleshooting-fragments--en

Note: From ScriptRunner for Jira Data Center 10.19.0 and 9.45.0, the fragment performance changes are included in ScriptRunner and the `scriptrunner.fragments.performance` dark feature has been removed. If you're on one of these versions or later, you don't need to enable it.

## Fragment performance in Jira 10

In some Jira 10 Data Center environments, updating [web fragments](https://docs.adaptavist.com/sr4js/latest/features/fragments) can cause noticeable performance degradation, especially on large clusters. To reduce this impact, we've changed how fragment updates are propagated across the cluster.

In ScriptRunner 9.37.0 and later in the 9.x series, before 9.45.0, the changes are available as a dark feature that you need to enable. This guide explains how to enable the fragment performance feature in those versions and how to check whether it improves performance in your instance.

These changes are included in ScriptRunner for Jira Data Center 10.19.0 and later and 9.45.0 and later, with no setup needed. These changes are not present in ScriptRunner 8.x as this performace issue started in Jira 10.

## Enable the fragment performance feature

1.  Navigate to Administration > System > Dark features.
2.  Under Enable dark feature, add:`scriptrunner.fragments.performance`
3.  Click Add to enable the feature.

To disable the feature again, remove `scriptrunner.fragments.performance` from the list of enabled dark features.

## Validate fragment performance

1.  Navigate to your ScriptRunner Fragments page.
2.  Save an existing fragment, or edit and save a fragment.
3.  Observe whether fragment-related operations complete faster and with less impact on overall Jira responsiveness than before.

If you do not see any performance improvement, or if you notice degraded performance (for example, slow responses, timeouts, or elevated load during fragment updates), please:

-   Capture recent application logs (for example, via a Support Zip), and
-   Share them with [Adaptavist Support](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/21), along with:
    -   Your Jira version and ScriptRunner version
    -   Whether you are running a cluster (and how many nodes)
    -   A brief description of what you were doing when the issue occurred

This information will help us investigate and refine the feature for your environment.
