# Test a Mail Handler

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > mail-handler
- Doc ID: doc-sr4js-442887764
- Source: https://docs.adaptavist.com/sr4js/latest/features/mail-handler/test-a-mail-handler

The following should be conducted in a test environment.

1.  Configure a ScriptRunner _Mail Handler_ for _Local Files_ (see [Add an Incoming Mail Handler](https://docs.adaptavist.com/sr4js/latest/features/mail-handler#add-mail-handler)).
    
2.  Copy or write an email message in the _<jira-home>/import/mail_ folder.
    
    See [How to locate Jira Home Directory](https://confluence.atlassian.com/jirakb/how-to-locate-jira-home-directory-313466063.html) for details on how to locate your Jira home location. For more about file system messages, check the _File System Messages_ section in [Configuring Issues and Comments from Email](https://confluence.atlassian.com/adminjiraserver073/creating-issues-and-comments-from-email-861253784.html).
    
3.  Start with a simple script such as:  
    
    ```
import com.atlassian.mail.MailUtils

def subject = message.getSubject()
def body = MailUtils.getBody(message)

log.debug "${subject}"
log.debug "${body}"
```
    
4.  Click the **Run Now**.
    
    A _Script executed successfully_ notification appears if the mail handler ran as expected. If there is an error, an error notification appears. In the case of an unsuccessful execution, select **More details** link to get more information.
    
     ![](/sr4js/files/latest/442887764/442887767/1/1758746879000/Test_mail_handler.png)
5.  Once tested, add the configuration to your Jira instance.
