# Send a custom email (non-issue events)

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > listeners > built-in-listeners
- Doc ID: doc-sr4js-272763532
- Source: https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/send-a-custom-email-non-issue-events

Use this listener to send an email based on a Jira non-issue event and custom condition. Non-issue events include:

-   Create a project
    
-   Add a new user
    
-   Update a component
    
-   Third-party plugin events
    

This listener is similar to the [Send a Custom Email](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/send-a-custom-email) listener and [Send a Custom Email](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/send-a-custom-email) post function.

This listener has multiple elements to it:

-   **Applied to:** Choose if you want to apply this listener to specific or all projects in your instance. 
-   **Events:** Choose the non-issue event/s this listener will fire on. 
-   **Condition and configuration**: Set a condition to control when this listener fires. You can also pass additional variables to the body and subject templates using the `config` map, and dynamically control recipients using the `mail` variable. See [Send a custom email](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/send-a-custom-email) for more information on configuring custom emails.
-   **Email template**: Write an email template using plain text or the [GStringTemplateEngine](http://docs.groovy-lang.org/docs/next/html/documentation/template-engines.html).
-   **Subject template**: Write the subject template using plain text or the [GStringTemplateEngine](http://docs.groovy-lang.org/docs/next/html/documentation/template-engines.html).
-   **Email format**: Choose whether to send the email as plain text or HTML.
-   **To addresses/To Groups**: Choose who to send the email to. 
-   **CC addresses/CC Groups**: Choose who should be CC'd on the email. 
    
-   **Reply-to email address**: Set the email address for replies.

Prerequisite

You must [configure an SMTP mail server](https://confluence.atlassian.com/adminjiraserver/configuring-an-smtp-mail-server-to-send-notifications-947184044.html) to send mail.

## Condition and configuration example

In the _Condition and configuration_ code editor you can enter a condition to ensure certain conditions are met before the email is sent. You can also use this code editor to pass additional variables to the _Email template_ and _Subject template_ using the `config` map, and dynamically control recipients using the `mail` variable. For example, we want to send an email after a version is released. In this example, the selected event will be `VersionReleaseEvent` and the script in the **Condition and Configuration** field will be:

```
import com.atlassian.jira.event.project.VersionReleaseEvent

def versionReleaseEvent = event as VersionReleaseEvent
def version = versionReleaseEvent.version

// Store in the config map, the version and the project name so we can use them later in our templates
config.'versionName' = version.name
config.'projectName' = version.project.name
true
```

We can use the above variables in our _Email_ and _Subject_ and templates, for example the **Email template** would be:

```
Version $config.versionName for project $projectName just released.

Congratulations!
```

## Use this listener

1.  Navigate to ScriptRunner. 
2.  Select **Listeners > Create Listener**. 
3.  Select **Send custom email (non-issue events)**.
4.  Enter a name that describes the listener (this name is for your reference when viewing all listeners).
5.  Enter the project(s) this listener will be applied to. 
6.  Enter the event(s) this listener will fire on. 
7.  Optional: Enter a condition and any configuration you require. If no condition is specified, then this listener will always run on the chosen event/s.  
    
    You can pass additional variables to the body and subject template using the `config` map, and dynamically control recipients using the `mail` variable.
    
    ![image example of configuration](/sr4js/files/latest/272763532/273483837/1/1722873021000/Send_non_issue_event_email.png)
    
8.  Write an email template. This can be written in plain text or you can use the [GStringTemplateEngine](http://docs.groovy-lang.org/docs/next/html/documentation/template-engines.html).
9.  Write the subject template. This can be written in plain text or you can use the [GStringTemplateEngine](http://docs.groovy-lang.org/docs/next/html/documentation/template-engines.html).
10.  Select the email format you want to send the email as. 
11.  Enter whom you want to send the email to in **To addresses** and/or **To groups**.
12.  Enter whom you want to CC the email to in **CC addresses** and/or **CC groups**. 
13.  Enter a reply-to email address. 
14.  Select **Preview** to see an overview of the configuration.  
     ![image example of configuration](/sr4js/files/latest/272763532/273483838/1/1722873161000/Send_non_issue_event_email_2.png)
     
     If you are facing issues with characters appearing as question marks (???) then, in most cases, problems are due to a misconfiguration in the encoding, see [Jira Application internationalization and encoding troubleshooting](https://confluence.atlassian.com/jirakb/jira-application-internationalisation-and-encoding-troubleshooting-203394762.html).
     
15.  Select **Add**.
     

  

* * *

## Related content

-   [Listeners](https://docs.adaptavist.com/sr4js/latest/features/listeners)
-   [Send a Custom Email Post Function](https://docs.adaptavist.com/sr4js/latest/features/workflows/post-functions/send-a-custom-email)
-   [Send a Custom Email](https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/send-a-custom-email)
