# Use IP Addresses

- Platform: cloud
- Space: SR4JC
- Hierarchy: Manage App
- Doc ID: doc-sr4jc-0e357e7c-0b84-4520-9749-5992ba97ee66-9f1ee7eee4aa511d
- Source: https://docs.adaptavist.com/sr4jc/latest/manage-app/use-ip-addresses

You can use ScriptRunner for Jira Cloud's IP addresses to configure your firewall or network security settings, allowing traffic from the app. This is essential for establishing a secure and reliable integration between your system and ScriptRunner for Jira Cloud, particularly when the app needs to communicate with on-premises infrastructure or cloud services protected by a firewall.

## ScriptRunner and network security

We have summarized below some of the most important information regarding ScriptRunner and network security:

-   Certain functionalities of ScriptRunner may be impacted when operating within environments protected by firewalls or within corporate networks that enforce strict security protocols.
-   Your network administrator may need to _allowlist specific IP addresses_ used by ScriptRunner to ensure uninterrupted service and optimal performance.
-   To request the current list of IP addresses, please submit a Support ticket via our [Adaptavist Product Support Portal](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/27). Our Support team will promptly provide you with the necessary information and any additional guidance required.
-   Access to our IP addresses for allowlisting is granted selectively, based on specific customer requirements and use cases. This approach helps us maintain the highest standards of service quality and network security across all customers.
-   We reserve the right to update our hosting infrastructure or modify IP addresses as needed. In such cases, affected customers will be notified well in advance to allow sufficient time for any required adjustments.
-   Once you have requested the IP addresses from Support, you can consult [Atlassian's documentation](https://support.atlassian.com/security-and-access-policies/docs/specify-ip-addresses-for-product-access/) for instructions on how to allowlist IP addresses on Atlassian Cloud products. Note that you may have additional systems that require ScriptRunner's IP addresses to be allowlisted.

## ScriptRunner for Jira Cloud domain allow list

We advise all customers with a Cloud firewall to ensure that access to the `*. [connect.product.adaptavist.com](http://connect.product.adaptavist.com/)` wildcard URL is permitted.

If your firewall policy does not support dns resolution to `*. [connect.product.adaptavist.com](http://connect.product.adaptavist.com/)` , you can add the AWS IP ranges here: [https://ip-ranges.amazonaws.com/ip-ranges.json](https://ip-ranges.amazonaws.com/ip-ranges.json). The range is particularly large, but you can filter the AWS IP ranges down to:

-   'EC2' service, and further down to IPv4 only if you do not need IPv6.
-   the region, us-west-2 or eu-central-1.

To verify your region, you can run the following snippet:

```
System.getenv('AWS_REGION')
```

## How to call external applications from ScriptRunner for Jira Cloud

ScriptRunner for Jira Cloud can execute REST calls to third-party REST APIs. The simplest way to test executing these calls is to use the [Script Console](../features/script-console.md).

To integrate with an external application, follow the steps below:

1.  Contact the support team for the external application and request some examples of how to use their REST API.
2.  Locate the REST API documentation for the external application.
3.  Test interacting with the REST APIs for the external application on the [Script Console](../features/script-console.md), ensuring that [Script Variables](../features/script-variables.md) are used to store any passwords or authorization tokens.

We also recommend using the Post to Slack example Script Listener shown below, which provides an example of how to call an external REST API from ScriptRunner for Jira Cloud and can be used to create the script you require.

Add this listener to the _Issue Created_ event type to post a notification to Slack when a work item is created.

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
Map msg_dets = [text: "A new issue was created with the details below: 
 Issue key = ${issueKey} 
 Issue Sumamry = ${summary} 
 Issue Description = ${description}"]
 
// Post the constructed message to slack
def postToSlack = post('https://slack.com/api/chat.postMessage')
        .header('Content-Type', 'application/json')
        .header('Authorization', "Bearer ${SLACK_API_TOKEN}") // Store the API token as a script variable named SLACK_API_TOKEN
        .body(msg_meta + msg_dets)
        .asObject(Map)
        .body
 
assert postToSlack : "Failed to create Slack message check the logs tab for more details"
```
