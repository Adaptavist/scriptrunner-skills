# Send an Email with a Script

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: scripting-resources
- Doc ID: doc-sr4cc-269812113
- Source: https://docs.adaptavist.com/sr4cc/latest/scripting-resources/send-an-email-with-a-script

You can write a custom script to send emails.

An SMTP server setup is required to send emails through scripts.

Here is an example of code to send an email. You can include a script like this in any ScriptRunner [Code Editor](https://docs.adaptavist.com/sr4cc/latest/scripting-resources/code-editor) field, like the [Script Listeners](https://docs.adaptavist.com/sr4cc/latest/features/script-listeners) or [Script Jobs](https://docs.adaptavist.com/sr4cc/latest/features/script-jobs). They can include code like the example in their script jobs or CQL jobs to send out an email notification of job completion.

```
import javax.mail.internet.*
import javax.mail.*

Properties prop = new Properties()
//Enter the details of your SMTP server
prop.put("mail.smtp.auth", true)
prop.put("mail.smtp.host", "smtp.gmail.com")
prop.put("mail.smtp.port", "450")
prop.put("mail.smtp.starttls.enable", "true")

String emailId = "<email id>"
String password = "<password>"

Session session = Session.getInstance(prop, new Authenticator() {
    @Override
    protected PasswordAuthentication getPasswordAuthentication() {
        new PasswordAuthentication(emailId, password)
    }
})

MimeMessage msg = new MimeMessage(session)
msg.setFrom(new InternetAddress(emailId, "NoReply-JD"))
msg.setSubject("<Test email>", "UTF-8")
msg.setText("<Test body>", "UTF-8")
msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(emailId, false))

Transport.send(msg)
logger.info("Email Sent Successfully!!")
```
