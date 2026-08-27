# Notify Approvers of Pending Approvals via Email

- Platform: data-center
- Feature: escalation-services
- Tags: workflow
- Language: groovy
- Doc ID: example-dataCenter-notify-approvers-of-pending-appprovals-via-email-onPrem
- Source: https://examples.scriptrunner.io/scripts/notify-approvers-of-pending-appprovals-via-email-onPrem

## Overview

This escalation service is used to trigger an email that notifies approvers of pending issues, once their email has been retrieved using the [REST Endpoint](https://library.adaptavist.com/entity/get-email-address-of-approvers).

## Example

In this example, a reminder email is triggered, after the email addresses of an issue’s outstanding approvers were obtained via a REST Endpoint.

## Good to Know

* For Jira versions prior to 8.10.0, the additional Thread parameters are not required to send the email as shown in the example below:  
  `def email = new Email(emailAddress)`  
  `email.setSubject(subject)`  
  `email.setBody(body)`  
  `email.setMimeType('text/html')`  
  `mailServer.send(email)`

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.mail.Email
import groovy.json.JsonSlurper
import groovy.xml.MarkupBuilder

def key = issue.key

def applicationProperties = ComponentAccessor.applicationProperties
def mailServerManager = ComponentAccessor.mailServerManager
def mailServer = mailServerManager.defaultSMTPMailServer

final def host = applicationProperties.getString('jira.baseurl')
final def restEndpointName = 'getApprovers'

def baseUrl = "${host}/rest/scriptrunner/latest/custom/${restEndpointName}?issueKey=${key}"
def response = baseUrl.toURL().text

def json = new JsonSlurper().parseText(response)
def artifacts = json.collect()

def emailBody = new StringWriter()
def html = new MarkupBuilder(emailBody)
def mkp = html.mkp
html.html {
    body {
        p {
            mkp.yield 'Awaiting your Approval for this Issue'
            a(href: "${host}/browse/${key}", key.toString())
        }
    }
}

artifacts.findAll {
    def emailAddress = it.toString()
    def subject = 'Approval Reminder'
    def body = emailBody.toString()
    def email = new Email(emailAddress)
    email.setSubject(subject)
    email.setBody(body)
    email.setMimeType('text/html')
    def threadClassLoader = Thread.currentThread().contextClassLoader
    Thread.currentThread().contextClassLoader = mailServer.class.classLoader
    mailServer.send(email)
    Thread.currentThread().contextClassLoader = threadClassLoader
}
```

