# Send Custom Email

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Event Listeners > Built-In Listeners
- Doc ID: doc-sr4c-59b8abfe-c211-4e7d-9f26-35a20984f93a-d31d26cdb0142f0a
- Source: https://docs.adaptavist.com/sr4c/latest/features#event-listeners--en#built-in-listeners--en#send-custom-email--en

Using the _Send Custom Email_ listener, you can send a customized email in response to an event.

In order to send an email for an event, the event has to be configured as an [event listener](https://docs.adaptavist.com/sr4c/latest/features/event-listeners).

Follow these steps to configure a custom email triggered by an event:

1.  You can add an identifier in Name.
2.  Select the events you want to trigger the email in Event drop-down field.
3.  Optional: Enter Conditions from a script or file if you would like to add additional stipulations for the email trigger.
    
    You can select Example Scripts for conditions you can use.
    
4.  Select a file or enter a script in Mail Configuration to organize your email.
    
    Tip: This field takes precedence over Subject Template, Body Template, To Addresses, To Groups, CC Groups, and Reply-To Email Address.
    
    The input has a `config map` and a `mail object` in the binding. The `config map` feeds into the email's subject and body templates so you can feed data from your Confluence instance. The `mail object` gives you dynamic control over the recipients of the email.
    
    You can select Example Scripts for conditions you can use.
    
5.  Enter a script in Subject Template to configure the subject of the email.
    
    Tip: The input should be able to feed information from the same binding object as the Body Template field.
    
    You can select Example Scripts for conditions you can use.
    
6.  Enter a script in Body Template to configure the body of the email.
    
    Tip: The input should have the event and the keys of the `config map` used as a variable.
    
    You can select Example Scripts for conditions you can use.
    
7.  Select if you would like the email to be Plan Text or HTML.
8.  One of the following fields is required:
    
    -   To Addresses
    -   To Groups
    
    You can override them via the Mail Configuration code block.
    
    Enter the email addresses of people who should receive the email in To Addresses.
    
9.  Enter groups of people who should receive the email in To Groups.
10.  Enter groups of people who should be carbon-copied on the email in CC Groups.
11.  Enter the email address where you would send replies to the email in Reply-To Email Address.
     
     Note: If you leave this field blank, the default FROM address associated with the configured mail server is used.
     
12.  Select Run.
     
     You can select Preview instead of Run to view changes before implementing them. Once you select Run, the _Results_ of the script appear.
     

## Example: Email a Group When Permissions Changes in a Monitored Space

For a complex example, you could set up a _Send Custom Email_ listener to monitor a sensitive space for permission changes and email a group of users whenever permissions in that space change.

Follow these steps to set up the listener:

1.  For the Event, use the [SpacePermissionChangeEvent](https://docs.atlassian.com/ConfluenceServer/javadoc/7.0.1/com/atlassian/confluence/event/events/permission/SpacePermissionChangeEvent.html), which covers permissions being added, removed, and altered for a given space.
2.  For the Condition, the following code limits the listener so that it only fires for permission changes to the space with key `"DS"`.
    
    ```
    package com.onresolve.examples.events.mail
    
    import com.atlassian.confluence.event.events.permission.SpacePermissionChangeEvent
    import com.atlassian.confluence.event.events.permission.SpacePermissionRemoveEvent
    
    def targetSpaceKey = "DS"
    SpacePermissionChangeEvent event = event
    
    // SpacePermissionRemoveEvent objects have the affected space on the event
    if (event instanceof SpacePermissionRemoveEvent) {
        return event.space.key == targetSpaceKey
    } else {
        return event.permissions.any { perm ->
            perm.space?.key?.toUpperCase() == targetSpaceKey
        }
    }
    ```
    
3.  For the Mail Configuration, use the following code to grab the name of the space for our email.
    
    ```
    package com.onresolve.examples.events.mail
    
    import com.atlassian.confluence.event.events.permission.SpacePermissionChangeEvent
    import com.atlassian.confluence.event.events.permission.SpacePermissionRemoveEvent
    
    SpacePermissionChangeEvent event = event
    if (event instanceof SpacePermissionRemoveEvent) {
        config["spaceName"] = event.space.name
    } else {
        config["spaceName"] = event.permissions.first().space.name
    }
    ```
    
4.  For the Subject Template and Body Template, a simple template naming the affected space will suffice for this example, but you could add more information to meet your needs.
    
    ```
    Permissions updated for space: ${config['spaceName']}
    ```
    
5.  Leave Email Format as the default of Plain Text because we didn't use any HTML.
6.  Enter devops-admin for To Groups to send the mail to that group of people.
