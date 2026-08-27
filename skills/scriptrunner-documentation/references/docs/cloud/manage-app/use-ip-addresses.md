# Use IP Addresses

- Platform: cloud
- Space: SR4JC
- Hierarchy: manage-app
- Doc ID: doc-sr4jc-355468162
- Source: https://docs.adaptavist.com/sr4jc/latest/manage-app/use-ip-addresses

You can use ScriptRunner for Jira Cloud's IP addresses to configure your firewall or network security settings, allowing traffic from the app. This is essential for establishing a secure and reliable integration between your system and ScriptRunner for Jira Cloud, particularly when the app needs to communicate with on-premises infrastructure or cloud services protected by a firewall.

## ScriptRunner and network security 

We have summarized below some of the most **important information** regarding ScriptRunner and network security:

-   Certain functionalities of ScriptRunner may be impacted when operating within environments protected by firewalls or within corporate networks that enforce strict security protocols.
-   Your network administrator may need to _allowlist specific IP addresses_ used by ScriptRunner to ensure uninterrupted service and optimal performance.
-   To request the current list of IP addresses, please submit a Support ticket via our [Adaptavist Product Support Portal](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/27). Our Support team will promptly provide you with the necessary information and any additional guidance required.
-   Access to our IP addresses for allowlisting is granted selectively, based on specific customer requirements and use cases. This approach helps us maintain the highest standards of service quality and network security across all customers.
-   We reserve the right to update our hosting infrastructure or modify IP addresses as needed. In such cases, affected customers will be notified well in advance to allow sufficient time for any required adjustments.

If you have already allowlisted ScriptRunner IP addresses, please note that these IP addresses will change after 14th August 2026. We have notified you via email of the new list of IP addresses. If you believe you have not received this email, please get in touch with our Support team. Please ensure that your allowlists are updated in advance of 14th August 2026 to ensure ScriptRunner's continued functionality. If you requested the IP addresses on or after 1st April 2026, then you can disregard this message, as you should already have received the new IP addresses.

## ScriptRunner for Jira Cloud domain allow list 

We advise all customers with a Cloud firewall to ensure that access to the `*.[connect.product.adaptavist.com](http://connect.product.adaptavist.com)` wildcard URL is permitted.

If your firewall policy **does not support** dns resolution to `*.[connect.product.adaptavist.com](http://connect.product.adaptavist.com)`, you can add the AWS IP ranges here: [https://ip-ranges.amazonaws.com/ip-ranges.json](https://ip-ranges.amazonaws.com/ip-ranges.json "https://ip-ranges.amazonaws.com/ip-ranges.json"). The range is particularly large, but you can filter the AWS IP ranges down to:

-   ‘EC2’ service, and further down to IPv4 only if you do not need IPv6.
    
-   the region, us-west-2 or eu-central-1.
    

To verify your region, you can run the following snippet:

```
System.getenv('AWS_REGION')
```

## How to call external applications from ScriptRunner for Jira Cloud

ScriptRunner for Jira Cloud can execute REST calls to third-party REST APIs. The simplest way to test executing these calls is to use the [Script Console](https://docs.adaptavist.com/sr4jc/latest/features/script-console).

To integrate with an external application, follow the steps below:

1.  Contact the support team for the external application and request some examples of how to use their REST API.
2.  Locate the REST API documentation for the external application.
3.  Test interacting with the REST APIs for the external application on the [Script Console](https://docs.adaptavist.com/sr4jc/latest/features/script-console), ensuring that [Script Variables](https://docs.adaptavist.com/sr4jc/latest/features/script-variables) are used to store any passwords or authorization tokens.

We also recommend using the Post to Slack example Script Listener shown below, which provides an example of how to call an external REST API from ScriptRunner for Jira Cloud and can be used to create the script you require.

Add this listener to the _Issue Created_ event type to post a notification to Slack when a work item is created.

```
// Specify the key of the issue to get the fields from
def issueKey = issue.key

// Get the issue summary
def summary = issue.fields.summary

// Get the issue description
def description = issue.fields.description

// Specify the name of the slack room to post to
def channelName = '<ChannelNameHere>'

// Specify the name of the user who will make the post
def username = '<UsernameHere>'

// Specify the message metadata
Map msg_meta = [ channel: channelName, username: username ,icon_emoji: ':rocket:']

// Specify the message body which is a simple string
Map msg_dets = [text: "A new issue was created with the details below: \n Issue key = ${issueKey} \n Issue Sumamry = ${summary} \n Issue Description = ${description}"]

// Post the constructed message to slack
def postToSlack = post('https://slack.com/api/chat.postMessage')
        .header('Content-Type', 'application/json')
        .header('Authorization', "Bearer ${SLACK_API_TOKEN}") // Store the API token as a script variable named SLACK_API_TOKEN
        .body(msg_meta + msg_dets)
        .asObject(Map)
        .body

assert postToSlack : "Failed to create Slack message check the logs tab for more details"
```

## Behaviours and IP allow lists

### Behaviours installation

If you experience any issues whilst [installing](https://docs.adaptavist.com/sr4jc/latest/get-started/installation) the Behaviours App, please check if your Jira instance uses IP allowlists. 

Before installing the ScriptRunner Behaviours app, you must include IP address ranges for outbound connections for Forge apps. The current IPs can be found in Atlassian’s [documentation](https://support.atlassian.com/organization-administration/docs/ip-addresses-and-domains-for-atlassian-cloud-products/#Outgoing-Connections). Whilst IP whitelisting is not required for [2LO apps](https://support.atlassian.com/security-and-access-policies/docs/specify-ip-addresses-for-product-access/#IP-allowlist-exceptions) such as ScriptRunner Behaviours, adding the outbound connection IPs to the allowlist is required due to ongoing Atlassian bugs, [ACCESS-1442](https://jira.atlassian.com/browse/ACCESS-1442) and [FRGE-634](https://ecosystem.atlassian.net/browse/FRGE-634).

If the issue persists, or you do not have IP allowlists, please contact the [Adaptavist Support](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/27) team.

### Using Behaviours

When using the [Behaviours](https://docs.adaptavist.com/sr4jc/latest/features/behaviours) feature, note that if your Jira instance is using IP allowlists, you need to expand that to include:

-   the [Atlassian Forge IP address range](https://ip-ranges.atlassian.com/), refer to Atlassian's [IP addresses and domains for Atlassian cloud products](https://support.atlassian.com/organization-administration/docs/ip-addresses-and-domains-for-atlassian-cloud-products/).
-   all [AWS IP Ranges](https://ip-ranges.amazonaws.com/ip-ranges.json) for the region in which you are located.

Behaviours is a Forge app, and Atlassian now supports the [IP allowlisting feature](https://support.atlassian.com/security-and-access-policies/docs/specify-ip-addresses-for-product-access/) available with Premium plans for Jira, JSM, and Confluence. Forge apps installed on sites with IP allowlisting enabled can make [Jira](https://developer.atlassian.com/platform/forge/apis-reference/fetch-api-product.requestjira/) and [Confluence](https://developer.atlassian.com/platform/forge/apis-reference/fetch-api-product.requestconfluence/) API requests by default. Therefore, there is no longer a need to manually add [IP addresses or domains for Atlassian Cloud apps](https://support.atlassian.com/organization-administration/docs/ip-addresses-and-domains-for-atlassian-cloud-products/#Outgoing-Connections) or [Atlassian Support](https://support.atlassian.com/organization-administration/docs/ip-addresses-and-domains-for-atlassian-cloud-products/#Outgoing-Connections) to the allowlist.
