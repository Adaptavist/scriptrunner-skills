# Mail Handler FAQs

- Platform: data-center
- Space: SR4JS
- Hierarchy: get-help > frequently-asked-questions
- Doc ID: doc-sr4js-101626139
- Source: https://docs.adaptavist.com/sr4js/latest/get-help/frequently-asked-questions/mail-handler-faqs

### How can I catch emails sent to Jira and then create or update issues from that email?

ScriptRunner comes with a custom mail handler feature that lets you run a script when you receive an email into your Jira servers inbound mail server. You can use the _Mail Handler_ feature to trigger when an email comes from specified email addresses using the **Catch Email** field or have it run the script for all emails received.

This feature is very powerful as you can use the script to perform many actions, including creating an issue based on data within a received email. Please see the guide example [here](https://docs.adaptavist.com/sr4js/latest/features/mail-handler/mail-handler-examples#id-.MailHandlerExamplesv10.17.0-CreateIssueWithAttachments) for more information, and you can also refer to our [Example Scripts](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bfeature%5D%5B0%5D=email-handler&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=dataCenter) for further examples of Mail Handler scripts.
