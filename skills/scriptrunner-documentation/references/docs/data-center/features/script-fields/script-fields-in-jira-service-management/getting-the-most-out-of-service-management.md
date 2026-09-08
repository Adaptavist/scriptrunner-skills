# Getting the Most Out of Service Management

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > script-fields > script-fields-in-jira-service-management
- Doc ID: doc-sr4js-442888015
- Source: https://docs.adaptavist.com/sr4js/latest/features/script-fields/script-fields-in-jira-service-management/getting-the-most-out-of-service-management

We’ve been using Service Management for some time, and have found a few irritations and annoyances that get in the way of us firing on all cylinders.

Here we share how we’ve overcome them, to maximize productivity.

## Finding the reporter’s company

We like to see who the reporter works for, sometimes it gives us a good feeling. We also want to identify when multiple different users from the same company are asking for help - perhaps it’s part of a theme.

The way to get this info is to hover over the reporter, then quickly click on the display name before the dialog closes, which is easier said than done. However, I’ve just noticed that this has been improved in the latest version of Service Management where it shows the reporter email address. So this is not as useful as previously, but still worthwhile.

Our solution is to create a text script field, with the following code:

```
issue.reporter?.emailAddress?.replaceAll(/.*@/, "")
```

We can improve this a little by creating a link to a JQL function which will show us all tickets reported by this domain. We want to keep the returned value the same as that’s what we want indexed, but we’ll tweak the displayed value a little by choosing a _Custom_ template, with the following code:

```
<a target="_blank" href="/jira/issues/?jql='Reporter Domain' ~ '$value'">$value</a>
```

We can go a bit further by creating a bunch of links to google them for company info, and take a look at their home page. This is mostly for curiosity’s sake.

```
$value - <a target="_blank"
    href="$applicationProperties.getString("jira.baseurl")/issues/?jql='Reporter Domain' ~ '$value'">
        Find similar
    </a>
|
<a target="_blank" href="http://$value">Company home</a>
|
<a target="_blank" href="http://google.com/#q=$value">Google them</a>
```

On the ticket you should see:

![](/sr4js/files/latest/442888015/442888017/1/1758746898000/view-company.png)

Atlassian is not necessarily a customer, they are just being used as an example

## Canned Comments

We often find ourselves asking people to provide logs, or version information and screenshots etc. After doing this five or six times in a day you can find yourself getting a little terse.

In order to preserve the illusion of courtesy, we can pick from a template comment. These are processed on the server using groovy templates, so you can include substitutions like the user and agent’s first name.

This has been expanded into the [template comments plugin](https://bitbucket.org/Adaptavist/jsd-canned-comments), which should be used in preference to setting this up yourself. The code examples are now outdated, but could be useful to see the process you might follow.

## SEN Integration

If you are a marketplace vendor you may be interested in validating the user’s _Support Entitlement Number_ (SEN). Even if not, perhaps users of your product have some sort of token that they need to provide to show they are entitled to support. You might want to look this up in your CRM database and verify that the customer is within their maintenance agreement.

The following post-function, which we put on the _Create_ action, validates the SEN and gets information from the marketplace API, which is used to populate the fields.

```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.config.properties.JiraProperties
import com.atlassian.jira.issue.CustomFieldManager
import com.atlassian.jira.issue.MutableIssue
import com.onresolve.scriptrunner.runner.customisers.ContextBaseScript
import groovy.sql.Sql
import groovy.transform.BaseScript
import groovyx.net.http.ContentType
import groovyx.net.http.HTTPBuilder
import groovyx.net.http.Method
import org.apache.http.HttpRequest
import org.apache.http.HttpRequestInterceptor
import org.apache.http.protocol.HttpContext

import java.sql.Driver
import java.sql.Timestamp
import java.text.SimpleDateFormat

def http = new HTTPBuilder("https://marketplace.atlassian.com")

def jiraProperties = ComponentAccessor.getComponent(JiraProperties)

/**
 * system properties defined like -Dplugin.marketplace.basic.auth.credential=user@example.com:password
 */
def cred = jiraProperties.getProperty("plugin.marketplace.basic.auth.credential")
def dbPassword = jiraProperties.getProperty("plugin.marketplace.database.password")

if (!cred) {
    log.warn("Set plugin.marketplace.database.password as system prop")
}

http.client.addRequestInterceptor(new HttpRequestInterceptor() {
    void process(HttpRequest httpRequest, HttpContext httpContext) {
        httpRequest.addHeader("Authorization", "Basic " + cred.bytes.encodeBase64().toString())
    }
})

@BaseScript ContextBaseScript baseScript

def issue = getIssueOrDefault("SD-12") as MutableIssue

def customFieldManager = ComponentAccessor.getComponent(CustomFieldManager)
def senCf = customFieldManager.getCustomFieldObjectByName("SEN")
def sen = issue.getCustomFieldValue(senCf) as String

// note: all the following fields shown here are required - see comment for type // <1>
def licenceTypeCf = customFieldManager.getCustomFieldObjectByName("Licence Type")               // short text
def licenceSizeCf = customFieldManager.getCustomFieldObjectByName("Licence Size")               // short text
def licensedProductCf = customFieldManager.getCustomFieldObjectByName("Licensed Product")       // short text
def licensee = customFieldManager.getCustomFieldObjectByName("Licensee")                        // short text
def mainStartDateCf = customFieldManager.getCustomFieldObjectByName("Maintenance Start Date")   // date
def mainEndDateCf = customFieldManager.getCustomFieldObjectByName("Maintenance End Date")       // date

try {
    if (!sen.startsWith("SEN-L")) {
        def response = http.request(Method.GET, ContentType.JSON) {
            uri.path = "/rest/1.0/vendors/81/sales"
            uri.query = [limit: 1, "sort-by": "date", order: "desc", q: sen]
        }

        def dateFormat = new SimpleDateFormat("yyyy-MM-dd")

        def licence = response.sales.find { it.licenseId == sen } as Map
        if (licence) {
            issue.setCustomFieldValue(licenceTypeCf, licence.licenseType)
            issue.setCustomFieldValue(licenceSizeCf, licence.licenseSize)
            issue.setCustomFieldValue(licensee, licence.organisationName)
            issue.setCustomFieldValue(licensedProductCf, licence.pluginKey)
            issue.setCustomFieldValue(mainStartDateCf, new Timestamp(dateFormat.parse(licence.maintenanceStartDate as String).time))
            issue.setCustomFieldValue(mainEndDateCf, new Timestamp(dateFormat.parse(licence.maintenanceEndDate as String).time))
        } else {
            // couldn't find licence
        }
    }
```

```
}
catch (any) {
    log.warn("Failed to get SEN details", any)
}
```

**Line 47:** All of these fields must exist with the type as shown

Evaluation licenses are not available via the marketplace API, as far as we can see. We have a database that we can query for these…​ the code for this is not shown.

## Updating Tickets when bugs are Fixed

When a user reports a bug, either already known or not yet known, we link to the public bug (creating it if necessary). Then we close the support ticket as a _Known Issue_, asking the user to _watch_ the linked bug report. Sometimes they do, sometimes they don’t.

To ensure they are aware when the bug is fixed and released, we add a [post-function](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions) on the _Release_ transition for the bug workflow which adds a comment to all support tickets that link to it:

The following comment is in the example below:

```
The issue <% out << issue.key %> which causes the problem in this support request has now been released

bq. <% out << issue.summary %>
```

![](/sr4js/files/latest/442888015/442888022/1/1758746898000/Add_comment_to_blocked_issue.png)

When the bug is _released_, the service desk tickets are updated with the following comment (and a mail is sent, etc):

![](/sr4js/files/latest/442888015/442888019/1/1758746898000/update-blocking-comment.png)

## Adding organizations when a Service Management issue gets created

**What are organizations in Jira?**

In a Jira Service Desk project you can configure organizations to group your customers together (see the Atlassian documentation for [Adding customers to organizations](https://confluence.atlassian.com/servicemanagementserver/adding-customers-939926467.html#Addingcustomers-Addcustomerstoanorganization)). When you add an organization to a project, it's members can raise requests in the project and share them with the organization. The organizations are added to an issue through the custom field named **Organizations**.

**Use case**

You want to automatically add certain organizations to new issues created in your service desk project. Using the script below, you can configure a custom _Listener_ to listen for the _Issue Created_ event and automatically add the organizations you specify in the script.

You can further customize this script by specifying conditions for when certain organizations are added to the issue, such as checking the email address of the user creating the request.

```
import com.atlassian.jira.project.type.ProjectTypeKeys

// get the issue that triggered the event
def issue = event.issue

// exit early if the issue is not in a Service Desk project
if (issue.projectObject.projectTypeKey.key != ProjectTypeKeys.SERVICE_DESK.key) {
    log.warn('Cannot add organizations to a non-service desk issue')
    return
}

// update the issues organizations
issue.update {
    setOrganizations {
        add('fooOrg', 'barOrg')
    }
}
```

## Automatically Clone an Issue

This tutorial will take you through the steps needed to create a new issue in another project and transfer the information needed, once your original request is resolved.

### Use Cases:

1.  When a user raises a bug report, if it is verified, you want to automatically add it to your backlog in your development project.
    
2.  When a request for an item is approved by your manager, you want it to be placed in another project so that the appropriate team can can acquire it.
    
3.  When a person has been successfully hired, you want to auto raise a ticket to IT so that their login and basic IT is provided for them.
    
4.  When an incident has been fixed and you need to file a Root Cause Analysis(RCA) ticket in another project.
    

### Steps:

We need to setup a [_Clones an issue, and links_ post function](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/clones-an-issue-and-links) in the transition that closes your ticket.

#### 1\. Set up the condition:

a): the request type is the one pertinent to us. In this case "Bug Report"

b): the transition to closed with a resolution that implies that you are going to do something with that ticket. In this case "Bug Reproduced".

```

import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.servicedesk.api.requesttype.RequestTypeService
import com.onresolve.scriptrunner.runner.customisers.WithPlugin

@WithPlugin("com.atlassian.servicedesk")
def requestTypeService = ComponentAccessor.getOSGiComponentInstanceOfType(RequestTypeService)

if (issue.issueType.name == "Incident") {

    def sourceIssueRequestTypeQuery = requestTypeService
        .newQueryBuilder()
        .issue(issue.id)
        .requestOverrideSecurity(true)
        .build()
    def requestTypeEither = requestTypeService.getRequestTypes(currentUser, sourceIssueRequestTypeQuery)

    if (requestTypeEither.isLeft()) {
        log.warn "${requestTypeEither.left().get()}"
        return false
    }

    def requestType = requestTypeEither.right.results[0]

    if (requestType.name == "Bug Report" && issue.resolution.name == "Bug Reproduced") {
        return true
    }
}

return false
```

#### 2\. Setup the other fields.

Setup the target project, target issue type and fields to copy.

![](/sr4js/files/latest/442888015/442888025/1/1758746898000/Cones_an_issue_example.png)

This is example, you could choose to copy the whole issue if you wish.

## Create RCA Confluence Page

This tutorial will show you a complex example on how to move data from Jira Service Management to Confluence.

### Use Cases:

RCA analysis usually needs a sharing of information and document collaboration that is very hard to achieve in Jira. That’s why a Confluence integration is a better idea for this particular example.

### Steps:

We need to setup a "Custom Scripted Function". Also, in order for this to work, you must have a reciprocal appLink between your Confluence and Jira.

#### 1\. Set up the condition:

a): the request type is the one pertinent to us. In this case "Incident"

b): the transition to closed with a resolution that implies that you are going to do something with that ticket. In this case "Bug Reproduced"

### 2\. Use this script to copy the information to Confluence.

```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.config.properties.APKeys
import com.atlassian.sal.api.net.Request
import com.atlassian.sal.api.net.Response
import com.atlassian.sal.api.net.ResponseException
import com.atlassian.sal.api.net.ResponseHandler
import com.atlassian.servicedesk.api.organization.OrganizationService
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import com.opensymphony.workflow.WorkflowContext
import groovy.json.JsonBuilder
import groovy.xml.MarkupBuilder

@WithPlugin("com.atlassian.servicedesk")

/*Fetch and check for the confluence link*/
def applicationLinkService = ComponentAccessor.getComponent(ApplicationLinkService)
def confluenceLink = applicationLinkService.getPrimaryApplicationLink(ConfluenceApplicationType)

/*If your issue isn't an incident, you don't want to create a RCA ticket*/
if (issue.issueType.name != "Incident") {
    return
}

/*Check that the confluence link exists*/
if (!confluenceLink) {
    log.error "There is no confluence link setup"
    return
}

def authenticatedRequestFactory = confluenceLink.createAuthenticatedRequestFactory()

/*Start getting information about the issue from Service desk*/
def issueLinkManager = ComponentAccessor.getIssueLinkManager()
def commentManager = ComponentAccessor.getCommentManager()
def customFieldManager = ComponentAccessor.getCustomFieldManager()
def organizationService = ComponentAccessor.getOSGiComponentInstanceOfType(OrganizationService)

/*SLA related fields*/
def timeFirstResponse = issue.getCustomFieldValue(customFieldManager.getCustomFieldObjectByName("Time to first response"))
def timeResolution = issue.getCustomFieldValue(customFieldManager.getCustomFieldObjectByName("Time to resolution"))
def organizations = issue.getCustomFieldValue(customFieldManager.getCustomFieldObjectByName("Organizations"))

def currentUserId = ((WorkflowContext) transientVars.get("context")).getCaller()
def currentUser = ComponentAccessor.getUserManager().getUserByKey(currentUserId)

def writer = new StringWriter()
def xml = new MarkupBuilder(writer)

xml.h2("This is the RCA analysis thread for the issue above.")

xml.p("${issue.summary}")

xml.p("This issue was raised by ${issue.reporter.name} on ${issue.getCreated()} " +
    "and resolved by ${currentUser.name} with resolution ${issue.getResolution().name}")

xml.h3("Time to first response:")
xml.p("Start date: ${timeFirstResponse.completeSLAData?.startTime[0].toDate().toString()}")
xml.p("Stop  date: ${timeFirstResponse.completeSLAData?.stopTime[0].toDate().toString()}")

xml.h3("Times to resolution:")
xml.p("Start date(s): ${timeResolution.completeSLAData?.startTime[0].toDate().toString()}")
xml.p("Stop  date(s): ${timeResolution.completeSLAData?.stopTime[0].toDate().toString()}")

xml.h3("Description:")
xml.p("${issue.description}</p>")

//You might want to log information about your users and organizations.
xml.h3("Organizations")
organizations?.each {
    xml.p("<b>${it.name}</b>")
    def usersEither = organizationService.getUsersInOrganization(currentUser, organizationService.newUsersInOrganizationQuery().customerOrganization(it).build())
    if (usersEither.isLeft()) {
        log.warn usersEither.left().get()
        return
    }
    usersEither.right().get().results.collect { "${it.displayName}" }.each {
        xml.p(it)
    }
}

//You want to collect the outward links of your issue.
def outwardLinks = issueLinkManager.getOutwardLinks(issue.id)
xml.h3("Outward Issue Links")
if (outwardLinks instanceof List) {
    outwardLinks?.collect { buildIssueURL(it.destinationObject.key) }?.join(" ").each {
        xml.p(it)
    }
} else {
    xml.p(buildIssueURL(outwardLinks.destinationObject.key))
}

//You want to collect the inward links of your issue.
def inwardLinks = issueLinkManager.getInwardLinks(issue.id)
xml.h3("Inward Issue Links")
if (inwardLinks instanceof List) {
    inwardLinks?.collect { buildIssueURL(it.destinationObject.key) }?.join(" ").each {
        xml.p(it)
    }
} else {
    xml.p(buildIssueURL(inwardLinks.destinationObject.key))
}

//You might also want to collect the comments on the issue:
xml.h3("Comments")
commentManager.getComments(issue)?.collect { "${it.getAuthorFullName()} : $it.body" }.each {
    xml.p(it)
}

//Here you parse the whole of the information collected into the RCA ticket.
def params = [
    type : "page",
    title: "RCA analysis: ${issue.key}",
    space: [
        key: "TEST" //This should be the name of your space, you should set it accordingly
    ],
    body : [
        storage: [
            value         : writer.toString(),
            representation: "storage"
        ]
    ]
]
//This is used to send a REST request to the Confluence link.
authenticatedRequestFactory
    .createRequest(Request.MethodType.POST, "rest/api/content")
    .addHeader("Content-Type", "application/json")
    .setRequestBody(new JsonBuilder(params).toString())
    .execute(new ResponseHandler<Response>() {
        @Override
        void handle(Response response) throws ResponseException {
            if (response.statusCode != HttpURLConnection.HTTP_OK) {
                throw new Exception(response.getResponseBodyAsString())
            }
        }
    })

//This is an aux function to build the URL for the issue.
String buildIssueURL(String issueKey) {
    def baseUrl = ComponentAccessor.getApplicationProperties().getString(APKeys.JIRA_BASEURL)
    """
    <a href="$baseUrl/browse/$issueKey">$issueKey</a>
    """
}
```

## Email Linked Issue Watchers, Request Participants & Organizations

### Email Reporter, Watchers, Request Participants and Organizations of Linked Issues When Transitioning

This Post-Function script will allow you to trigger notifications users/customers (reporter, watchers, request participants and organizations) for a linked issue. This was written assuming this would be most helpful to notify users when the linked issues were being resolved, but could fit anywhere in the workflow.

#### Use Cases:

1.  Your helpdesk team is receiving issues related to a software bug. Your customers' organizations can be added to the helpdesk issue and then receive an email when the software team has closed their linked issue.
    
2.  Business users may have an IT issue linked as a blocker, but might have no interest in watching an IT team’s issues for updates due to the volume of comments/edit. If they would like to receive a notification only when it is finished, this script can shield them from all the rest of the Jira notifications.
    

#### Steps

##### 1\. Identify the appropriate Workflow

This post-function should live in the Jira workflow that needs to relay the emails out to other projects. See the use cases above for more detail.

##### 2\. Edit the Workflow

You will want to edit the workflow and navigate to the specific transition where you want these emails to trigger. Keep in mind, you may have to update the verbiage of the email to account for different transitions or meanings. See below for more on that.

##### 3\. Add the script

Add the script to a custom script post-function.

```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.Issue
import com.atlassian.jira.mail.Email
import com.atlassian.jira.user.ApplicationUser
import com.atlassian.servicedesk.api.organization.CustomerOrganization
import com.atlassian.servicedesk.api.organization.OrganizationService
import com.atlassian.servicedesk.api.util.paging.SimplePagedRequest
import com.onresolve.scriptrunner.runner.customisers.WithPlugin

@WithPlugin("com.atlassian.servicedesk")

final def LINK_NAME = "causes"
def issueLinks = ComponentAccessor.getIssueLinkManager().getOutwardLinks(issue.getId())
def causedByIssues = ComponentAccessor.getIssueLinkManager().getOutwardLinks(issue.getId())?.findAll {
    it.issueLinkType.outward == LINK_NAME
}
if (!causedByIssues) {
    log.debug "Does not cause any issues"
    return
}

causedByIssues.each {
    def destinationIssue = it.destinationObject
    def watcherManager = ComponentAccessor.watcherManager

    // this should be an admin you wish to use inside the script OR currentUser
    def adminUser = ComponentAccessor.userManager.getUserByKey("admin")

    def strSubject = "An issue linked to ${destinationIssue.getKey()} has been resolved"
    def baseURL = ComponentAccessor.getApplicationProperties().getString("jira.baseurl")
    def strIssueURL = "<a href='${baseURL}/browse/${issue.getKey()}'>${issue.getKey()}</a>"
    def strDestinationURL = "<a href='${baseURL}/browse/${destinationIssue.getKey()}'>${destinationIssue.getKey()}</a>"
    def strBody = """${strIssueURL} has been resolved.
 This issue has a &quot;${LINK_NAME}&quot; issue link which points to ${strDestinationURL}.
 You received this notification because you are watching ${strDestinationURL}."""
    def emailAddressTo = destinationIssue.reporterUser ? destinationIssue.reporterUser.emailAddress : adminUser.emailAddress
    def emailAddressesCC = []

    emailAddressesCC = watcherManager.getWatchers(destinationIssue, Locale.ENGLISH)?.collect { it.emailAddress }
    emailAddressesCC.addAll(getOrganizationMembersEmailsInIssue(destinationIssue, adminUser))
    emailAddressesCC.addAll(getParticipantsEmailsInIssue(destinationIssue))
    emailAddressesCC = emailAddressesCC.unique()
    emailAddressesCC = emailAddressesCC.join(",")

    sendEmail(emailAddressTo, emailAddressesCC, strSubject, strBody)
}

void sendEmail(String to, String cc, String subject, String body) {

    log.debug "Attempting to send email..."
    def mailServer = ComponentAccessor.getMailServerManager().getDefaultSMTPMailServer()
    if (mailServer) {
        Email email = new Email(to)
        email.setCc(cc)
        email.setSubject(subject)
        email.setBody(body)
        email.setMimeType("text/html")
        mailServer.send(email)
        log.debug("Mail sent to (${to}) and cc'd (${cc})")
    } else {
        log.warn("Please make sure that a valid mailServer is configured")
    }
}

List<String> getOrganizationMembersEmailsInIssue(Issue issue, ApplicationUser adminUser) {
    def organisationService = ComponentAccessor.getOSGiComponentInstanceOfType(OrganizationService)
    def cf = ComponentAccessor.customFieldManager.getCustomFieldObjectByName("Organizations")
    def emailAddresses = []
    (issue.getCustomFieldValue(cf) as List<CustomerOrganization>)?.each {
        def pageRequest = new SimplePagedRequest(0, 50)
        def usersInOrganizationQuery = organisationService.newUsersInOrganizationQuery().pagedRequest(pageRequest).customerOrganization(it).build()
        // this is a paged response, it will return only the first 50 results, if you have more users in an organization
        // then you will need to iterate though all the page responses
        def pagedResponse = organisationService.getUsersInOrganization(adminUser, usersInOrganizationQuery)
        if (pagedResponse.isLeft()) {
            log.warn pagedResponse.left().get()
        } else {
            emailAddresses.addAll(pagedResponse.right().get().results.collect { it.emailAddress })
        }
    }

    emailAddresses
}

List<String> getParticipantsEmailsInIssue(Issue issue) {
    def cf = ComponentAccessor.customFieldManager.getCustomFieldObjectByName("Request participants")
    def cfVal = issue.getCustomFieldValue(cf)?.collect { it.emailAddress }

    cfVal
}
```

You will need to edit this script.

Variables to look to edit are…​

a) LINK\_NAME - this determines which issue link relation you are looking for as the trigger for the emails. It currently holds a value of "causes." This means that the post-function looks to check if the current transitioning issue "causes" any other issues, then checks those other issues for watchers and notifies them.

b) adminUser - This should be a user that will persist with the ability to query Organizations and to receive the email if no reporter exists.

c) strSubject - This is a short summary of the email and may need to be adjusted if you use this post-function to continue into another unresolved status.

d) strBody - This is an in-depth description of what issues were affected and why the user is receiving the notification. It also references resolving an issue so definitely change this if you are not using a transition landing in a resolved state.

Also, keep in mind…​

a) This script only notifies for one issue link type. If you want it to notify on multiple, you would need to add a string array or another mechanism to this script or duplicate the script.

b) The more watchers/Request participants/Organization customers are on the linked issue, the longer the post-function will take to execute.

c) The script assumes that both issues are on the same instance of Jira, meaning they will have the same URL.

d) The script CCs everyone at once to avoid the time consuming activity of sending out tons of email.
