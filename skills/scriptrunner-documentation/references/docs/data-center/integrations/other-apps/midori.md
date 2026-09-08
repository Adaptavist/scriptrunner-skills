# Midori

- Platform: data-center
- Space: SR4JS
- Hierarchy: integrations > other-apps
- Doc ID: doc-sr4js-442889185
- Source: https://docs.adaptavist.com/sr4js/latest/integrations/other-apps/midori

## Better PDF Exporter for Jira

[Better PDF Exporter for Jira](https://marketplace.atlassian.com/apps/5167/better-pdf-exporter-for-jira-pdf-view?hosting=server&tab=overview&utm_medium=sr-docs&utm_source=adaptavist&utm_campaign=partnering) is a highly configurable PDF exporter, that is easily scriptable through its API. Used together with ScriptRunner, it can generate, distribute, or locally save your periodic Jira issue reports or other PDF documents. For more technical information about the PDF API, the interface exposed by Better PDF Exporter for Jira, see the [documentation](https://www.midori-global.com/products/better-pdf-exporter-for-jira/server/documentation/api?utm_medium=sr-docs&utm_source=adaptavist&utm_campaign=partnering).

The examples below are relatively simple, but the possible use cases are limitless. ScriptRunner is the perfect tool to take advantage of the flexibility of Better PDF Exporter for Jira. Effortlessly create complex documents to support your custom business needs and internal processes.

### Emailing a PDF Document from an Issue During a Transition

This is a simple workflow post function example to generate a custom PDF document from the transitioned issue and send that attached to a custom email.

```
import javax.activation.DataHandler
import javax.mail.internet.MimeBodyPart
import javax.mail.internet.MimeMultipart
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.mail.util.ByteArrayDataSource
import com.atlassian.mail.Email
import com.atlassian.mail.queue.SingleMailQueueItem

// PDF configuration
def templateName = "issue-fo.vm"
def title = "My sample PDF document"

// email configuration
def to = "adam@acme.com, bob@acme.com, cecil@acme.com" // can contain multiple addresses in a comma-separated list
def subject = "Post-function executed on ${issue.key}"
def body = "See the PDF document generated from \"${issue.summary}\" in the attachment!"

// render the PDF
def user = ComponentAccessor.jiraAuthenticationContext?.user
def pdfApiClass = this.getClass().forName('com.midori.jira.plugin.pdfview.api.PdfApi', true, ComponentAccessor.pluginAccessor.classLoader)
def pdfApi = ComponentAccessor.getOSGiComponentInstanceOfType(pdfApiClass)
ComponentAccessor.jiraAuthenticationContext.setLoggedInUser(user)
def pdfResult = pdfApi.getPdf(templateName, title.toString(), [issue], [:])

// send email
to.tokenize(",").each {
    def dataSource = new ByteArrayDataSource(new ByteArrayInputStream(pdfResult.bytes), "application/pdf")
    def attachmentPart = new MimeBodyPart(dataHandler: new DataHandler(dataSource), fileName: pdfResult.fileName)
    def multipart = new MimeMultipart("mixed")
    multipart.addBodyPart(attachmentPart)

    def email = new Email(it.trim())
    email.subject = subject
    email.body = body
    email.multipart = multipart
    ComponentAccessor.mailQueue.addItem(new SingleMailQueueItem(email))
}
```

### Periodically Run JQL and Export Results to a PDF

This example can be installed as a Groovy service to run a JQL query, generate a PDF document from the results and save it to the filesystem.

```
import com.atlassian.jira.bc.issue.search.SearchService
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.jql.parser.JqlQueryParser
import com.atlassian.jira.web.bean.PagerFilter
import org.springframework.util.FileCopyUtils

// PDF configuration
def userName = "admin" // this user runs the search and generates the PDF
def jql = "updated > -24h"
def templateName = "issue-fo.vm"
def title = "Issues updated in the last 24 hours"

// run the search
def jqlQueryParser = ComponentAccessor.getComponent(JqlQueryParser)
def query = jqlQueryParser.parseQuery(jql)
def searchProvider = ComponentAccessor.getComponent(SearchService)
def user = ComponentAccessor.userManager.getUserByName(userName)
def search = searchProvider.search(user, query, PagerFilter.getUnlimitedFilter())

// render the PDF
def issues = search.results
if (issues) {
    def pdfApiClass = this.getClass().forName('com.midori.jira.plugin.pdfview.api.PdfApi', true, ComponentAccessor.pluginAccessor.classLoader)
    def pdfApi = ComponentAccessor.getOSGiComponentInstanceOfType(pdfApiClass)
    ComponentAccessor.jiraAuthenticationContext.setLoggedInUser(user)
    def pdfResult = pdfApi.getPdf(templateName, title.toString(), issues, [:])

// do whatever you want to do with the PDF
// (in this example, we just write it to a file with a timestamped filename like "example-20170526-1304.pdf")
    FileCopyUtils.copy(pdfResult.bytes, new File("c:\\tmp\\example-${new Date().format('yyyyMMdd-HHmm')}.pdf"))
}
```

## Better Excel Exporter for Jira

ScriptRunner can be used with [Better Excel Exporter for Jira](https://marketplace.atlassian.com/apps/1212652/better-excel-exporter-for-jira-xlsx?hosting=server&tab=overview&utm_medium=sr-docs&utm_source=adaptavist&utm_campaign=partnering) to create, email or locally save your Jira issue exports or reports in native Excel format. Better Excel Exporter for Jira is deeply customizable and allows you to use the native Excel reporting features (pivot reports, pivot charts, functions, formulas) on your Jira data. For more technical information about Better Excel Exporter for Jira and it’s API, see the [documentation](https://www.midori-global.com/products/better-excel-exporter-for-jira/server/documentation/api?utm_medium=sr-docs&utm_source=adaptavist&utm_campaign=partnering).

Below are two simple examples of emailing and saving a Jira Excel export. Generate even the most complex business intelligence reports using scripts thanks to the flexibility of ScriptRunner and Better Excel Plugin.

### Emailing an Excel File After a Transition

This is a simple workflow post function example to export a transitioned issue to an Excel file, and send the exported file to a custom email.

```
import javax.activation.DataHandler
import javax.mail.internet.MimeBodyPart
import javax.mail.internet.MimeMultipart
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.mail.util.ByteArrayDataSource
import com.atlassian.mail.Email
import com.atlassian.mail.queue.SingleMailQueueItem

// XLSX configuration
def templateName = "issue-navigator.xlsx"
def title = "My sample Excel document"
// email configuration
def to = "adam@acme.com, bob@acme.com, cecil@acme.com" // can contain multiple addresses in a comma-separated list
def subject = "Post-function executed on ${issue.key}"
def body = "See the Excel document generated from \"${issue.summary}\" in the attachment!"
// render the XLSX
def user = ComponentAccessor.jiraAuthenticationContext?.user
def xlsApiClass = this.getClass().forName('com.midori.jira.plugin.betterexcel.api.XlsApi', true, ComponentAccessor.pluginAccessor.classLoader)
def xlsApi = ComponentAccessor.getOSGiComponentInstanceOfType(xlsApiClass)
ComponentAccessor.jiraAuthenticationContext.setLoggedInUser(user)
def xlsResult = xlsApi.getXls(templateName, title.toString(), [issue], [:])
// send email
to.tokenize(",").each {
    def dataSource = new ByteArrayDataSource(new ByteArrayInputStream(xlsResult.bytes), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
    def attachmentPart = new MimeBodyPart(dataHandler: new DataHandler(dataSource), fileName: xlsResult.fileName)
    def multipart = new MimeMultipart("mixed")
    multipart.addBodyPart(attachmentPart)
    def email = new Email(it.trim())
    email.subject = subject
    email.body = body
    email.multipart = multipart
    ComponentAccessor.mailQueue.addItem(new SingleMailQueueItem(email))
}
```

### Running a JQL Search and Export the Result to an Excel File

This example can be installed as a Groovy service to run a JQL query, generate an Excel spreadsheet from the results and save it to the filesystem.

```
import com.atlassian.jira.bc.issue.search.SearchService
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.jql.parser.JqlQueryParser
import com.atlassian.jira.web.bean.PagerFilter
import org.springframework.util.FileCopyUtils

// XLSX configuration
def userName = "admin" // this user runs the search and generates the XLSX
def jql = "updated > -24h"
def templateName = "issue-navigator.xlsx"
def title = "Issues updated in the last 24 hours"
// run the search
def jqlQueryParser = ComponentAccessor.getComponent(JqlQueryParser)
def query = jqlQueryParser.parseQuery(jql)
def searchService = ComponentAccessor.getComponent(SearchService)
def user = ComponentAccessor.userManager.getUserByName(userName)
def search = searchService.search(user, query, PagerFilter.getUnlimitedFilter())
// render the XLSX
def issues = search.results
if (issues) {
    def xlsApiClass = this.getClass().forName('com.midori.jira.plugin.betterexcel.api.XlsApi', true, ComponentAccessor.pluginAccessor.classLoader)
    def xlsApi = ComponentAccessor.getOSGiComponentInstanceOfType(xlsApiClass)
    ComponentAccessor.jiraAuthenticationContext.setLoggedInUser(user)
    def xlsResult = xlsApi.getXls(templateName, title.toString(), issues, [:])
// do whatever you want to do with the XLSX
// (in this example, we just write it to a file with a timestamped filename like "example-20170526-1304.xlsx")
    FileCopyUtils.copy(xlsResult.bytes, new File("c:\\tmp\\example-${new Date().format('yyyyMMdd-HHmm')}.xlsx"))
}
```

## Script Fields Integration

_Script Fields_ are calculated custom fields configured using ScriptRunner. These fields use Groovy to display data on an issue.

### Exporting ScriptRunner Script Fields to Excel

[Better Excel Exporter 4.4.0](https://www.midori-global.com/products/better-excel-exporter-for-jira/server/version-history?utm_source=adaptavist&utm_medium=sr-docs&utm_campaign=partnering#support-for-scriptrunner-script-custom-fields) introduced integration with _Script Fields_. Better Excel Exporter is compatible with the _Script Fields_ feature and the custom field values are correctly exported to Excel. Find more information on ScriptRunner exports to Excel in Better Excel Exporter’s [documentation](https://www.midori-global.com/products/better-excel-exporter-for-jira/server/documentation/integrations?utm_source=adaptavist&utm_medium=sr-docs&utm_campaign=partnering#scriptrunner).

![](/sr4js/files/latest/442889185/442889186/1/1758747003000/midori-jira-scriptrunner-export-excel.png)

### Exporting ScriptRunner Script Fields to PDF

[Better PDF Exporter 7.4.0](https://www.midori-global.com/products/better-pdf-exporter-for-jira/server/version-history?utm_source=adaptavist&utm_medium=sr-docs&utm_campaign=partnering#support-for-scriptrunner-script-custom-fields) introduced integration with _Script Fields_. Better PDF Exporter is compatible with _Script Fields_ and the custom field values are correctly exported to PDF. Find more information on ScriptRunner exports to PDF in Better PDF Exporter’s [documentation](https://www.midori-global.com/products/better-pdf-exporter-for-jira/server/template-gallery?utm_source=adaptavist&utm_medium=sr-docs&utm_campaign=partnering#scriptrunner-exports).

![](/sr4js/files/latest/442889185/442889187/1/1758747003000/midori-jira-scriptrunner-export-pdf.png)
