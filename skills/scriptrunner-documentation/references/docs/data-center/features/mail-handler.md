# Mail Handler

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features
- Doc ID: doc-sr4js-61c52ab5-b7f3-4bb1-87df-5020d5f210d2-4bbf73abee92a3a0
- Source: https://docs.adaptavist.com/sr4js/latest/features#mail-handler--en

## What is the Mail Handler?

_Mail Handler_ for ScriptRunner allows users to run Groovy scripts when a message is received, expanding on Jira's built-in mail-handling capabilities. The _Mail Handler_ processes incoming mail, automates tasks, creates users from the recipient list, or triggers workflow actions.

## How to use a Mail Handler

You may want to configure a mail handler to:

-   Create a new issue from the mail subject.
-   Create users from the recipient list.
-   Transition an issue based on the email content.

## Before you start

|  |  |
| --- | --- |
|  | See our Introduction to Scripting in ScriptRunner training module to learn about scripting.<br>[Scripting Training](../training/course-introduction-to-script-runner-for-jira-data-center.md) |

|  |  |
| --- | --- |
|  | Broaden your horizons by exploring Mail Handler script examples.<br>[Example Scripts](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=email-handler&ScriptRunner%5BrefinementList%5D%5Bproduct%5D%5B0%5D=jira) |

## Add an Incoming Mail Handler

1.  Navigate to System > Incoming Mail > Add Incoming Mail Handler from the Administration menu.
2.  Specify a Name for the handler.
3.  In Server, select either a POP3/IMAP mail server or the Local Files option (for an external service that writes messages to the file system).
4.  Specify the Delay (in minutes); this is the frequency at which the mail handler runs.
5.  In Handler, select ScriptRunner Mail Handler.
6.  Select Next to add or write a custom groovy script.
    

### Configuring a Mail Handler

1.  Specify a Catch Email.
    
    Mail Handler only processes email messages whose To:, Cc:, or Bcc: lines contain the recipient specified in this field.
    
2.  Provide a Forward Email address.
    
    An email is sent to the given address if an error occurred during Mail Handler execution.
    
    Note: This functionality is available for IMAP/POP3 configuration only.
    
3.  Check the Strip Quotes option to remove quoted text from the message body, and populate the context variable `nonQuotedMessageBody` (use this is exclude content from previous email replies).
4.  Check Create Users to create new Jira users based on the From email address, if the message comes from an unrecognized address.
5.  In Bulk, select the action that occurs for emails with the precedence `Bulk`, or emails with the `Auto-Submitted` header.
6.  To enter a script manually, type the script in the Script Console.
    
    Alternatively, click the File tab on the Script Console to upload a script file. Start typing the name of the file into the Script File field.
    
    Warning: The file must be accessible on the server.
    

The ScriptRunner Mail Handler provides the following binding variables:

-   `message` - The email message the handler is going to handle. `message` is an instance of [javax.mail.Message](https://docs.oracle.com/javaee/7/api/javax/mail/Message.html).
-   `messageHandlerContext` - Jira [utility class](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/service/util/handler/DefaultMessageHandlerContext.html) which helps to create issues, comments, and attachments etc.
-   `nonQuotedMessageBody` - A non-quoted message body contains lines that do not start with a '>' or '|'.

Tip: For help writing mail handler scripts, and details of utility methods, such as retrieving senders, body, and attachments from messages, see [Atlassian MailUtils](https://docs.atlassian.com/atlassian-mail/1.9/apidocs/com/atlassian/mail/MailUtils.html).
