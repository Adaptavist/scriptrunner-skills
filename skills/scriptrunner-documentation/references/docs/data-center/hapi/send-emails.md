# Send Emails

- Platform: data-center
- Space: SR4JS
- Hierarchy: hapi
- Doc ID: doc-sr4js-442888505
- Source: https://docs.adaptavist.com/sr4js/latest/hapi/send-emails

A common requirement when writing automations is the ability to mail people. HAPI provides you with a very simple method of sending mail.

Prerequisite

You must [configure an SMTP mail server](https://confluence.atlassian.com/adminjiraserver/configuring-an-smtp-mail-server-to-send-notifications-947184044.html) to send mail.

## Sending mail

When sending mail, you need to specify at least one recipient (a To, Cc and/or Bcc), the subject and body text. The following is an example of the minimum requirements for sending mail:

```
        Mail.send {
            setTo('foo@example.com', 'bar@example.com')
            setSubject('this is the subject')
            setBody('this is the body')
        }
```

When mail is sent, it's added to the Jira mail queue first, and then sent within one minute.

### Setting who the mail is from

To set the "from" address, you can use `setFrom()`. Additionally, you can use `setFromName()` to set the name the mail client will display. For example:

```
        Mail.send {
            setTo('foo@example.com', 'bar@example.com')
            setFrom('from@example.com')
            setFromName('Your Boss')
            setSubject('this is the subject')
            setBody('this is the body')
        }
```

## Sending HTML mail

To send HTML mail, you can use `setHtml()`. For example:  

```
        Mail.send {
            setTo('foo@example.com')
            setSubject('my subject')
            setHtml()
            setBody('This is <b>html</b>.')
        }
```

## Sending attachments

You can add attachments to mail using HAPI. You can call `addAttachment` multiple times as required. For example:

```
        Mail.send {
            setTo('foo@example.com')
            setSubject('this is the subject')
            setBody('this is the body')
            addAttachment('my-file.xls')
        }
```

## Including inline images

To include inline images in an HTML mail, you must specify the _content ID_ of the attachment as the image source. The `addAttachment()` method will return the content ID, for example:

```
        Mail.send {
            setTo('foo@example.com')
            setSubject('this is the subject')
            setHtml()
            setBody('embedded image <img src="cid:${addAttachment("my-image.png")}/>"')
        }
```

  

* * *

## Related content

-   [Javadocs link](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/8.10.0/hapi/jira/groovydoc/com/adaptavist/hapi/jira/mail/Mail.html)
-   [Update Issues](https://docs.adaptavist.com/sr4js/latest/hapi/update-issues)
-   [Transition Issues](https://docs.adaptavist.com/sr4js/latest/hapi/transition-issues)
