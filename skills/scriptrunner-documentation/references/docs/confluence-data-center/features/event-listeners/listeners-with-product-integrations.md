# Listeners with Product Integrations

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Event Listeners
- Doc ID: doc-sr4c-43f9fead-67e5-4f20-9e93-871ea80bf38c-b220596f5d5e7de5
- Source: https://docs.adaptavist.com/sr4c/latest/features#event-listeners--en#listeners-with-product-integrations--en

Some of our listeners are compatible with Forms for Confluence, Jira, and Comala Document Management. Find out more here.

## Forms for Confluence

This section requires [Forms for Confluence](https://marketplace.atlassian.com/apps/261/forms-for-confluence) to be installed.

### Creating a page when a form is submitted

Using a custom event listener and Forms for Confluence, you can automatically create a new page when a form is submitted. For example, you could want a page created when a user submits an internal feature request or events proposal using Forms for Confluence.

Follow these steps to create the form and event listener:

1.  Verify that Forms for Confluence is installed.
2.  In your Confluence instance, create a new form that includes input fields to collect the following named input fields:
    
    -   _pageTitle_
    -   _spaceKey_
    -   _pageContent_
    
    Tip: You can also include additional fields, like an attachment.
    
3.  Navigate to General Configuration > ScriptRunner > Event Listeners.
4.  Select Custom Event Listener.
5.  Enter Create a page when a form is submitted for the Name.
6.  Enter FormsSubmitEvent for Events.
    
7.  Enter this code into Script:
    
    ```
    import com.atlassian.confluence.core.DefaultSaveContext
    import com.atlassian.confluence.pages.Page
    import com.atlassian.confluence.pages.PageManager
    import com.atlassian.confluence.spaces.SpaceManager
    import com.atlassian.sal.api.component.ComponentLocator
    import com.atlassian.xwork.FileUploadUtils
    import groovy.json.JsonSlurper
    
    def spaceManager = ComponentLocator.getComponent(SpaceManager)
    def pageManager = ComponentLocator.getComponent(PageManager)
    
    def eventFormSubmission = binding.variables.get("event")
    
    String eventData = eventFormSubmission.structuredValue
    
    //  any uploaded files. ie - uploaded using the "Forms - Attachment" macro
    List<FileUploadUtils.UploadedFile> uploadedFiles = eventFormSubmission.uploadedFiles
    
    // Space key, page title, page content, in a map.
    Map<String, String[]> inputtedValues = new JsonSlurper().parseText(eventData) as Map<String, String[]>
    
    def parentPageTitle = getValue(inputtedValues, "parentPageTitle")
    def pageTitle = getValue(inputtedValues, "pageTitle")
    def spaceKey = getValue(inputtedValues, "spaceKey")
    def pageContent = getValue(inputtedValues, "pageContent")
    
    // construct a new page
    Page targetPage = constructNewPage(spaceManager, spaceKey, pageTitle, pageContent)
    
    validateSpace(spaceKey, spaceManager)
    validateParentPage(spaceKey, parentPageTitle, pageManager)
    
    setPageAncestryAndSave(parentPageTitle, targetPage, spaceKey, pageManager)
    
    private static String getValue(Map<String, String[]> data, String key) {
        if (!data.get(key) || data.get(key)[0].isEmpty()) {
            throw new IllegalArgumentException("A \"" + key + "\" was not provided.")
        } else if (hasMultipleUniqueEntries(data.get(key) as List<String>)) {
            throw new IllegalArgumentException("multiple \" " + key + "\"'s were provided, please enter a single \"" + key + "\"")
        }
        data.get(key)[0]
    }
    
    private static boolean hasMultipleUniqueEntries(List<String> entries) {
        Set uniqueEntries = [] as Set
        uniqueEntries.addAll(entries)
        uniqueEntries.size() != 1
    }
    
    private static Page constructNewPage(SpaceManager spaceManager, String spaceKey, String pageTitle, String pageContent) {
        def targetPage = new Page(
            space: spaceManager.getSpace(spaceKey),
            title: pageTitle,
            bodyAsString: pageContent,
        )
        targetPage
    }
    
    private static void validateSpace(String spaceKey, SpaceManager spaceManager) {
        def space = spaceManager.getSpace(spaceKey)
        if (space == null) {
            throw new IllegalArgumentException("invalid space key")
        }
    }
    
    private static void validateParentPage(String spaceKey, String parentPageTitle, PageManager pageManager) {
        def parentPage = pageManager.getPage(spaceKey, parentPageTitle)
        if (parentPage == null) {
            throw new IllegalArgumentException("invalid parentPageTitle. " + parentPageTitle + " is not found in " + spaceKey)
        }
    }
    
    private static void setPageAncestryAndSave(
        String parentPageTitle, Page targetPage, String spaceKey, PageManager pageManager
    ) {
        Page parentPage = pageManager.getPage(spaceKey, parentPageTitle)
        parentPage.addChild(targetPage)
        targetPage.setParentPage(parentPage)
    
        pageManager.saveContentEntity(parentPage, DefaultSaveContext.DEFAULT)
        pageManager.saveContentEntity(targetPage, DefaultSaveContext.DEFAULT)
    }
    ```
    
    Note: This code determines that the _spaceKey_, _pageTitle_, and _pageContent_ correspond to the name parameter defined for the macros in your form.
    
    This event listener is not directly tied to the Forms configuration. The results of the Forms configuration can be recorded and/or sent to a different destination that you choose.
    

When the form is submitted, a new page is created with the values entered by the user.

This is the form:

The following image is the resulting page that is created when the form is submitted:

## Jira

This section requires [Jira](https://www.atlassian.com/software/jira) to be installed.

Tip: Jira and Confluence need to be properly linked for this to work. If you haven't done so, you can find instructions [here](https://docs.adaptavist.com/sr4c/latest/integrations/atlassian/connect-to-atlassian-via-app-links).

### Creating a Jira project when a Confluence space is created

This event listener example automatically creates a Jira project every time a space is created.

Follow these steps to create the listener:

1.  Navigate to General Configuration > ScriptRunner > Event Listners.
2.  Select Custom Event Listener.
3.  Enter Create a Jira project when a Confluence space is created for Name.
4.  Enter the following Script:
    
    ```
    import com.atlassian.applinks.api.ApplicationLinkService
    import com.atlassian.applinks.api.application.jira.JiraApplicationType
    import com.atlassian.confluence.event.events.space.SpaceCreateEvent
    import com.atlassian.sal.api.component.ComponentLocator
    import com.atlassian.sal.api.net.Response
    import com.atlassian.sal.api.net.ResponseException
    import com.atlassian.sal.api.net.ResponseHandler
    import groovy.json.JsonBuilder
    
    import static com.atlassian.sal.api.net.Request.MethodType.POST
    
    def appLinkService = ComponentLocator.getComponent(ApplicationLinkService)
    def appLink = appLinkService.getPrimaryApplicationLink(JiraApplicationType)
    def applicationLinkRequestFactory = appLink.createAuthenticatedRequestFactory()
    
    def event = event as SpaceCreateEvent
    def space = event.space
    
    def input = new JsonBuilder([
        projectTypeKey    : "business",
        projectTemplateKey: "com.atlassian.jira-core-project-templates:jira-core-task-management",
        name              : space.name,
        key               : space.key,
        lead              : event.space.creator.name,
    ]).toString()
    
    def request = applicationLinkRequestFactory.createRequest(POST, "/rest/api/2/project")
        .addHeader("Content-Type", "application/json")
        .setEntity(input)
    
    request.execute(new ResponseHandler<Response>() {
        @Override
        void handle(Response response) throws ResponseException {
            if (response.statusCode != 201) {
                log.error("Creating jira project failed: ${response.responseBodyAsString}")
            }
        }
    })
    ```
    
5.  Pick SpaceCreateEvent for Events.
6.  Select Add.

A Jira project is created every time a space is added.

## Comala Document Management

This section requires [Comala Document Management](https://marketplace.atlassian.com/apps/142/comala-document-management?hosting=cloud&tab=overview&utm_source=google&utm_medium=cpc&utm_campaign=comala_search_mp&gclid=CjwKCAiA3pugBhAwEiwAWFzwdWJSVHJlJN7P6Lwr92ts2pHIKZ3DCR3VHhnJpBnZauAsUCu6l95VOBoCRMUQAvD_BwE) to be installed.

Tip: Jira and Confluence need to be properly linked for this to work. If you haven't done so, you can find instructions [here](https://docs.adaptavist.com/sr4c/latest/integrations/atlassian/connect-to-atlassian-via-app-links).

### Create a Jira issue when a page or blog post is approved

Using a custom event listener, you can track every time a page or blog post is approved in your Confluence instance by creating a Jira issue.

Tip: Have a look at [Comala Document Management's JavaDoc](https://comalatech.bitbucket.io/comala-workflows/6.1.0/apidocs/com/comalatech/workflow/event/package-summary.html) for more information/more events.

Follow these steps to create the listener:

1.  Navigate to General Configuration > ScriptRunner > Event Listeners.
2.  Select Custom Event Listener.
3.  Enter Create a Jira issue when a page or blog post is approved for Name.
4.  Enter the following Script:
    
    ```
    import com.atlassian.applinks.api.ApplicationLinkService
    import com.atlassian.applinks.api.application.jira.JiraApplicationType
    import com.atlassian.sal.api.component.ComponentLocator
    import com.atlassian.sal.api.net.Response
    import com.atlassian.sal.api.net.ResponseException
    import com.atlassian.sal.api.net.ResponseHandler
    import com.comalatech.workflow.event.approval.ApprovalApprovedEvent
    import com.onresolve.scriptrunner.runner.customisers.WithPlugin
    import groovy.json.JsonBuilder
    
    import static com.atlassian.sal.api.net.Request.MethodType.POST
    
    @WithPlugin("com.comalatech.workflow")
    
    def event = event as ApprovalApprovedEvent
    
    if (!event.isPartial()) {
        def appLinkService = ComponentLocator.getComponent(ApplicationLinkService)
        // Retrieves the primary Jira application link
        def appLink = appLinkService.getPrimaryApplicationLink(JiraApplicationType)
        def applicationLinkRequestFactory = appLink.createAuthenticatedRequestFactory()
    
        def approvalComment = event.approval.comment
        // Specify values for the issue's fields here. Further examples of this can be found at https://docs.atlassian.com/software/jira/docs/api/REST/latest/#api/2/issue
        def body = new JsonBuilder([
            fields: [
                project    : [key: "PROJECT_KEY"],
                summary    : "Confluence Page Created",
                description: "A page has been created and approved by administrators with comment: \"${approvalComment}\"",
                issuetype  : [name: "Story"]
            ]
        ]).toString()
    
        def request = applicationLinkRequestFactory.createRequest(POST, "/rest/api/2/issue")
            .addHeader("Content-Type", "application/json")
            .setEntity(body)
    
        // Executes the request
        request.execute(new ResponseHandler<Response>() {
            @Override
            void handle(Response response) throws ResponseException {
                if (response.statusCode != 201) {
                    log.error("Creating Jira issue failed: ${response.responseBodyAsString}")
                }
            }
        })
    }
    ```
    
5.  Pick ApprovalApprovedEvent for Events.
6.  Select Add.

Now when a page or blog post is fully approved, a new Jira issue is created on behalf of the current user in the linked Jira issue.
