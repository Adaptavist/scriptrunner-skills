# Custom Scheduled Jobs

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Jobs
- Doc ID: doc-sr4c-5616714e-edb7-4ac0-9bfe-780496d97a1f-9c2e1353c5a9e85b
- Source: https://docs.adaptavist.com/sr4c/latest/features#jobs--en#custom-scheduled-jobs--en

You can use this option to create your own scheduled jobs to run code at regular intervals.

To create a custom scheduled job, follow these steps:

1.  Add a Name for your own reference.
2.  Select a User who the code will run as.
3.  Enter how often you want the job to run on Interval/Cron Expression.
    
    Note: Select Show Examples for example time periods.
    
4.  Add Inline Script to tell your job what to do. You can enter the code on Script or choose existing code on File.
5.  Select Add to schedule your job or Run Now to execute the script now.

## Example: Send Notification for Incomplete Tasks Once a Week

If you'd like to send a weekly email reminder to users to complete tasks assigned to them, you can create a custom scheduled job to send those emails by following these steps:

1.  Enter Send Notification for Incomplete Tasks for Name.
2.  Select Admin for User.
3.  Enter 0 0 0 ? \* FRI \* for Interval/Cron Expression to run at midnight each Friday.
4.  Enter the following code for Inline Script.
    
    ```
    import com.atlassian.confluence.pages.PageManager
    import com.atlassian.mail.MailException
    import com.atlassian.mail.MailFactory
    import com.atlassian.sal.api.component.ComponentLocator
    import com.onresolve.scriptrunner.runner.customisers.PluginModule
    import com.onresolve.scriptrunner.runner.customisers.WithPlugin
    @WithPlugin('com.atlassian.confluence.plugins.confluence-inline-tasks')
    import com.atlassian.confluence.plugins.tasklist.service.InlineTaskService
    import com.atlassian.mail.Email
    import com.atlassian.mail.server.SMTPMailServer
    import com.onresolve.scriptrunner.canned.util.OutputFormatter
    import com.atlassian.mail.server.MailServerManager
    import com.atlassian.confluence.user.UserAccessor
    import com.atlassian.confluence.spaces.SpaceManager
    import com.atlassian.confluence.setup.settings.SettingsManager
    import com.atlassian.confluence.pages.Page
    import com.atlassian.confluence.plugins.tasklist.Task
    import org.jsoup.Jsoup
    
    @PluginModule
    InlineTaskService inlineTaskService
    
    def spaceKey = 'YOUR_SPACE_KEY'
    SMTPMailServer mailServer = ComponentLocator.getComponent(MailServerManager).getDefaultSMTPMailServer()
    def userAccessor = ComponentLocator.getComponent(UserAccessor)
    def spaceManager = ComponentLocator.getComponent(SpaceManager)
    def pageManager = ComponentLocator.getComponent(PageManager)
    def settingsManager = ComponentLocator.getComponent(SettingsManager)
    def space = spaceManager.getSpace(spaceKey)
    
    Map<Page, List<Task>> pageTasks = pageManager.getPages(space, true).collectEntries { it ->
        [
            (it): inlineTaskService.findTaskIdsByContentId(it.getId()).collect { taskId ->
                inlineTaskService.find(it.getId(),taskId)
            }
        ]
    }
    Map<String, List<Task>> assigneeTasks = [:]
    
    pageTasks.each { it ->
        it.value.each { t ->
            if (t.getStatusAsString() == "UNCHECKED" && t.assignee != null) {
                assigneeTasks.put(t.assignee, assigneeTasks.getOrDefault(t.assignee,[]) + t)
            }
        }
    }
    assigneeTasks.each { it ->
        def user = userAccessor.getUserByName(it.key)
        def tasks = it.value
        def baseUrl = settingsManager.getGlobalSettings().getBaseUrl()
        if (!mailServer || MailFactory.getSettings().isSendingDisabled()) {
            log.warn("No mail server or sending disabled.")
        } else {
            try {
                def messageBody = OutputFormatter.markupBuilder {
                    div {
                        p("Hi " + user.fullName + ",")
                        p("The following tasks are assigned to you and require your attention. Please follow the page link where you will see your incomplete task. ")
                        ul {
                            tasks.each { t ->
                                def taskPage = pageManager.getPage(t.contentId)
                                def doc = Jsoup.parse(t.body)
                                li {
                                    a([href: baseUrl + "/pages/viewpage.action?pageId=" + taskPage.getIdAsString()], taskPage.title + " | " + doc.select("span").text())
                                }
                            }
                        }
                        p("Or view the tasks page in your profile (link to user’s task list) for additional task information.")
                        p("If there are any concerns, please contact your Confluence Administrator.")
                    }
                }
                def email = new Email(user.email)
                email.setFrom(mailServer.getDefaultFrom())
                email.setSubject("Confluence incomplete task notification")
                email.setMimeType("text/html")
                email.setBody(messageBody)
                mailServer.send(email)
            } catch (MailException e) {
                log.error("Error sending old content notifier email", e)
            }
        }
    }
    ```
    
5.  Select Add.
