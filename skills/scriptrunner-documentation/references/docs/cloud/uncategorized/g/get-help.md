# Get Help

- Platform: cloud
- Space: SR4JC
- Hierarchy: n/a
- Doc ID: doc-sr4jc-101629046
- Source: https://docs.adaptavist.com/sr4jc/latest/get-help

You will find several links in this section that provide access to self-service information as well as live support. If you want to learn more, check out many of the informative ScriptRunner [blog posts](https://www.adaptavist.com/blog/category/scriptrunner)!

![](/sr4jc/files/latest/101629046/284330502/1/1725890217000/8c7b1dc6-cb81-4a29-a8c1-b2bfdd6144ce.png)

  

Take our _**ScriptRunner Tour**_ to gain access to helpful videos and demos.

[shortcut ScriptRunner Tour](https://www.scriptrunnerhq.com/atlassian-apps/jira/scriptrunner-for-jira/cloud/get-started)

  

## Support requests

You may require technical advice or come across bugs when writing your own code within ScriptRunner for Jira Cloud. In either case, please feel free to create an issue in our [Adaptavist Product Support Portal](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/27). 

A support request can also be opened if you have a general configuration issue with the app; remember to include the:

-   URL to your instance
-   Output from the 'Diagnostics & Settings' page

Be sure to mention that you are using the Cloud version of ScriptRunner.

If you have any issues logging into the support portal, visit [this page](https://docs.adaptavist.com/log-in-to-the-tag-support-portal) for help.

### ScriptRunner SEN/entitlement ID and version

When contacting [Adaptavist Support](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/27), it is necessary to provide your License SEN or Entitlement ID, so that we can provide you with the best possible level of service. If you have a Server or Data Center product, you need to provide your SEN. If you have a Cloud product, you need to provide your Entitlement ID.

To find your product SEN/Entitlement ID and version:

1.  Navigate to **Manage Apps** from the _Jira Administration Menu_.
    
2.  Click **Manage Apps** under _Atlassian Marketplace_.
    
3.  Locate ScriptRunner and expand the information. The **Installed Version**, **License SEN** and **Entitlement ID** are displayed.
    

### Expired license

If your Cloud license expires, your ScriptRunner instance will stop working, and scripts will no longer run. However, your configuration will be saved for 90 days after you uninstall ScriptRunner from your instance. ScriptRunner will resume if you renew your license within this time period. 

## ScriptRunner website

You can use the [ScriptRunner website](https://www.scriptrunnerhq.com) to explore the many [Example scripts](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud) provided, or read about how ScriptRunner [extends Jira's automation](https://www.scriptrunnerhq.com/locker/jira-automation-compared-with-scriptrunner-for-jira-cloud). You can even [book a demo](https://www.scriptrunnerhq.com/book-a-demo) with our Customer Success team here too. Read 

Remember, there are API differences between Jira Server and Jira Cloud. ScriptRunner for Jira Cloud utilises only the REST API and not the Java API.

## Code help

If you have a how-to question related to migration or writing a groovy script, for instance, how to accomplish something within the API, then your question is equally applicable if you were writing in Java, and you can look for help or raise questions on [http://community.atlassian.com](http://community.atlassian.com/), or [http://www.groovy-lang.org/documentation.html](http://www.groovy-lang.org/documentation.html).

You can also check out our [Scripting in ScriptRunner for Jira Cloud](https://docs.adaptavist.com/sr4jc/latest/get-started/scripting-in-scriptrunner-for-jira-cloud) page to discover the various programming languages used for scripting.

## Common errors

### 5XX errors

-   500 status code errors are automatically retried once.
-   502, 503, and 504 errors are automatically retried three times.

### 429 (Too Many Requests) error

This error indicates that the system was under heavy load and eventually hit [Atlassian's rate limit](https://developer.atlassian.com/cloud/jira/platform/rate-limiting/). Note that rate limiting is enforced by Atlassian (not ScriptRunner) to manage resource sharing in the multi-tenant Cloud environment to prevent performance degradation. For example, a bulk operation that triggers Script Listeners on the `Issue Updated` event and processing too many work items in a short period could overload your instance. 

## Migration help

You can refer to the details provided in [ScriptRunner Migration to Cloud](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud) if you are migrating from ScriptRunner for Jira Server/Data Center.

## System status

You can find our status page here: [http://status.connect.adaptavist.com](http://status.connect.adaptavist.com/)

Any known incidents or maintenance windows are posted on that page. You can also view the status of our services and various systems that we depend on.

## Feedback board

This board provides you with the opportunity to let us know how we can improve ScriptRunner for Jira Cloud. Whilst it may not specifically offer you help on particular issues, you can use it to raise feature requests or enhancements. You can also vote on any existing ideas submitted by other users. All suggestions are reviewed on a regular basis.

To access the board, click the [Vote for Features](https://scriptrunner-for-jira-cloud.nolt.io) option of the Resources section on your Home page.
