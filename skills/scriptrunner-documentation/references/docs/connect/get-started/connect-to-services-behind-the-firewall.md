# Connect to Services Behind the Firewall

- Platform: connect
- Space: SRC
- Hierarchy: get-started
- Doc ID: doc-src-194675108
- Source: https://docs.adaptavist.com/src/latest/get-started/connect-to-services-behind-the-firewall

ScriptRunner Connect is a cloud-based SaaS service that, by default, can only reach services accessible via the public internet. However, if needed, it is possible to connect ScriptRunner Connect to a service behind a firewall.

To be able to connect to a service in a restricted network, you generally have the following two options:

-   Add a firewall ingress bypass rule to your network firewall to allow outgoing ScriptRunner Connect API connections to reach the service behind the firewall. All outgoing ScriptRunner Connect connections use a static IP address: **34.251.34.27** for EU instance, and **35.163.23.171** for US instance.
-   Set up a reverse proxy in a less restricted network (commonly known as a [DMZ network](https://en.wikipedia.org/wiki/DMZ_\(computing\))) to expose the service to the internet. You can also configure an IP allowlist rule in the reverse proxy to only allow connections from ScriptRunner Connect to pass through.

**Connectivity  🛜**

When setting up connections that require user consent (OAuth), you need to be able to reach the same service in a restricted network. In other words, your browser must be able to connect both to the service you're configuring and to ScriptRunner Connect.

## Allow events to reach ScriptRunner Connect

If you have configured event listeners to be triggered from a restricted network and those events are not reaching ScriptRunner Connect, ensure that your network allows egress traffic directly to the internet. ScriptRunner Connect uses AWS API Gateway, which has no static IP address. If acceptable, you can configure your firewall to allow egress traffic to any AWS API Gateway by allowlisting known AWS IP ranges.

You can [view known AWS IP ranges](https://ip-ranges.amazonaws.com/ip-ranges.json) and filter the list by region (eu-west-1) and service (API\_GATEWAY) to find all relevant IP ranges for API Gateway in the region where ScriptRunner Connect is hosted.
