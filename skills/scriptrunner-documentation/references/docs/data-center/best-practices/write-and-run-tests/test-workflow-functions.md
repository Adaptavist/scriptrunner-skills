# Test Workflow Functions

- Platform: data-center
- Space: SR4JS
- Hierarchy: best-practices > write-and-run-tests
- Doc ID: doc-sr4js-442889025
- Source: https://docs.adaptavist.com/sr4js/latest/best-practices/write-and-run-tests/test-workflow-functions

## Example Scenario

Let’s say you have business logic that dictates that the component lead(s) must be added as watchers if the priority is _Blocker_.

You ignore the sensible option, just for the purpose of my example, and decide to write a script to add the component leads as watchers on the Start Progress transition.

Your script might look like:

```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.Issue

// this comes to us in the binding... so this line is unnecessary other than to give my IDE "type" information
Issue issue = issue

// get some components we need
def watcherManager = ComponentAccessor.getWatcherManager()
def userUtil = ComponentAccessor.getUserUtil()

// would be better to use componentLead rather than lead, but not available until 6.3
issue.componentObjects*.lead.each {String username ->
    def applicationUser = userUtil.getUserByKey(username)
    watcherManager.startWatching(applicationUser, issue)
}
```

  

We will write some tests for the above script, and throw various combinations at it. The test inherits from AbstractWorkflowSpecification which will take care of setting us up a project, workflow and workflow scheme, ready for us to start editing it.

The entire test class can be found below:

```

import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.Issue
import com.atlassian.jira.issue.IssueInputParametersImpl
import com.atlassian.jira.project.AssigneeTypes
import com.atlassian.jira.project.Project
import com.atlassian.jira.project.type.ProjectTypeKey
import com.atlassian.jira.scheme.Scheme
import com.atlassian.jira.user.ApplicationUser
import com.atlassian.jira.workflow.JiraWorkflow
import com.onresolve.jira.groovy.GroovyFunctionPlugin
import com.onresolve.scriptrunner.canned.jira.workflow.postfunctions.CustomScriptFunction
import com.onresolve.scriptrunner.model.AbstractScriptConfiguration
import com.opensymphony.workflow.loader.ActionDescriptor
import com.opensymphony.workflow.loader.DescriptorFactory
import spock.lang.Shared
import spock.lang.Specification

import static com.atlassian.jira.project.AssigneeTypes.PROJECT_DEFAULT

class TestAddComponentLeadsAsWatchers extends Specification {

    private static final String IN_PROGRESS = "In Progress"
    private static final String JOE_LEAD = "joelead"

    @Shared
    def projectService = ComponentAccessor.getComponent(ProjectService)

    @Shared
    def projectComponentManager = ComponentAccessor.projectComponentManager

    @Shared
    def currentUser = ComponentAccessor.jiraAuthenticationContext.getLoggedInUser()

    @Shared
    def workflowManager = ComponentAccessor.workflowManager

    @Shared
    def workflowSchemeManager = ComponentAccessor.workflowSchemeManager

    @Shared
    def userService = ComponentAccessor.getComponent(UserService)

    @Shared
    def userManager = ComponentAccessor.userManager

    @Shared
    def userUtil = ComponentAccessor.userUtil

    def watcherManager = ComponentAccessor.watcherManager
    def issueService = ComponentAccessor.issueService
    def constantsManager = ComponentAccessor.constantsManager

    @Shared
    Project project

    /**
     * Create the workflow
     * add the post-function at the Start Progress step
     * Add some components, some with leads, some without
     */
    def setupSpec() {
        project = createTestSoftwareProject()

        def draftWorkflow = createDraftWorkflowForProject(project)

        addPostFunctionToDraftWorkflow(draftWorkflow, IN_PROGRESS, [
            "canned-script"                                : CustomScriptFunction.name,
            (AbstractScriptConfiguration.FIELD_SCRIPT_FILE): "com/acme/scriptrunner/scripts/AddComponentLeadsAsWatchers.groovy",
            "class.name"                                   : GroovyFunctionPlugin.name
        ])

        publishDraftWorkflow(draftWorkflow)

        createUser(JOE_LEAD)

        projectComponentManager.create("Comp1", "has an assignee", JOE_LEAD, PROJECT_DEFAULT, project.id)
        projectComponentManager.create("Comp2", "no assignee", null, PROJECT_DEFAULT, project.id)
    }

    def cleanupSpec() {
        removeTestSoftwareProject()
        removeUser(JOE_LEAD)
    }

    def "test script with workflow transitions"() {
        given:
        def issue = createIssueWithComponents(project, componentNames)

        when:
        watcherManager.startWatching(currentUser, issue)
        issue = transitionIssue(issue, IN_PROGRESS)

        then:
        // do a comparison as a Set because we don't care about the order of the watcher names
        watcherManager.getCurrentWatcherUsernames(issue) as Set == expectedWatchers as Set

        // note the current user is always expected to be a watcher, as it's jira's behaviour
        // (provided you haven't turned off autowatch for the user running the test)
        // a useful improvement to this would be to set it

        where:
        componentNames     | expectedWatchers
        []                 | [currentUser.name]
        ["Comp1"]          | [currentUser.name, JOE_LEAD]
        ["Comp1", "Comp2"] | [currentUser.name, JOE_LEAD]
    }

    private Issue createIssueWithComponents(Project project, List<String> componentNames) {
        def inputParameters = new IssueInputParametersImpl().with {
            setProjectId(project.id)
            setSummary("my summary")
            setReporterId(currentUser.name)
            setIssueTypeId(constantsManager.allIssueTypeObjects.find { it.name == "Bug" }.id)
            setComponentIds(componentNames.collect { name -> projectComponentManager.findByComponentName(project.id, name).id } as Long[])
        }

        def createValidationResult = issueService.validateCreate(currentUser, inputParameters)
        assert !createValidationResult.errorCollection.hasAnyErrors()

        issueService.create(currentUser, createValidationResult).issue
    }

    private Issue transitionIssue(Issue issue, String actionName) {
        def workflow = getWorkflowForProject(project)
        def action = getActionInWorkflow(workflow, actionName)

        def transitionValidationResult = issueService.validateTransition(currentUser, issue.id, action.id, new IssueInputParametersImpl())
        issueService.transition(currentUser, transitionValidationResult).issue
    }

    private ApplicationUser createUser(String username) {
        def password = "password"
        def emailAddress = "${username}@example.com"

        def createUserRequest = UserService.CreateUserRequest.withUserDetails(currentUser, username, password, emailAddress, username)
        def validationResult = userService.validateCreateUser(createUserRequest)
        assert !validationResult.errorCollection.hasAnyErrors()

        userService.createUser(validationResult)
    }

    private void removeUser(String username) {
        def userToRemove = userManager.getUserByName(username)

        def validationResult = userService.validateDeleteUser(currentUser, userToRemove)
        assert !validationResult.errorCollection.hasAnyErrors()

        userUtil.removeUser(currentUser, userToRemove)
        assert !userUtil.userExists(userToRemove.name)
    }

    private Project createTestSoftwareProject() {
        def creationData = new ProjectCreationData.Builder().with {
            withName("Test Project")
            withKey("TEST")
            withLead(currentUser)
            withAssigneeType(AssigneeTypes.PROJECT_LEAD)
            withType(new ProjectTypeKey('software'))
            withProjectTemplateKey("com.pyxis.greenhopper.jira:basic-software-development-template")
        }

        def result = projectService.validateCreateProject(currentUser, creationData.build())
        assert !result.errorCollection.hasAnyErrors()

        projectService.createProject(result)
    }

    private void removeTestSoftwareProject() {
        def deleteProjectValidationResult = projectService.validateDeleteProject(currentUser, project.key)
        assert !deleteProjectValidationResult.errorCollection.hasAnyErrors()

        projectService.deleteProject(currentUser, deleteProjectValidationResult)

        def scheme = workflowSchemeManager.getSchemeFor(project)
        removeWorkflowSchemeIfUnused(scheme)
    }

    private void removeWorkflowSchemeIfUnused(Scheme scheme) {
        def projects = workflowSchemeManager.getProjects(scheme)
        if (!projects) {
            def workflows = workflowManager.getWorkflowsFromScheme(scheme).toUnique()
            workflowSchemeManager.deleteScheme(scheme.id)
            workflows.each { workflow ->
                def schemes = workflowSchemeManager.getSchemesForWorkflow(workflow)
                if (!schemes && !workflow.systemWorkflow) {
                    workflowManager.deleteWorkflow(workflow)
                }
            }
        }
    }

    private JiraWorkflow getWorkflowForProject(Project project) {
        def workflowName = getProjectWorkflowName(project)
        workflowManager.getWorkflow(workflowName)
    }

    private JiraWorkflow createDraftWorkflowForProject(Project project) {
        def workflowName = getProjectWorkflowName(project)
        def workflow = workflowManager.createDraftWorkflow(currentUser, workflowName)
        workflow
    }

    private void addPostFunctionToDraftWorkflow(JiraWorkflow draftWorkflow, String actionName, Map<String, String> args) {
        def action = getActionInWorkflow(draftWorkflow, actionName)

        def postFunction = DescriptorFactory.factory.createFunctionDescriptor()
        postFunction.type = 'class'
        postFunction.args << args

        action.unconditionalResult.postFunctions.add(postFunction)
    }

    private void publishDraftWorkflow(JiraWorkflow draftWorkflow) {
        workflowManager.updateWorkflow(currentUser, draftWorkflow)
        workflowManager.overwriteActiveWorkflow(currentUser, draftWorkflow.name)
    }

    private ActionDescriptor getActionInWorkflow(JiraWorkflow workflow, String actionName) {
        workflow.allActions.find { ad -> ad.name == actionName } as ActionDescriptor
    }

    private String getProjectWorkflowName(Project project) {
        def workflowScheme = workflowSchemeManager.getWorkflowSchemeObj(project)
        workflowScheme.actualDefaultWorkflow
    }
}
```

Then we write a single test. I used the Spock [data table](http://spockframework.org/spock/docs/1.0/data_driven_testing.html) idiom. Whilst initially hard to setup, it’s very easy to add new test combinations.

In testing adding a component that doesn’t have a lead, I got an error from my script, and a test failure…​

```
ERROR [scriptrunner.jira.workflow.ScriptWorkflowFunction] Script function failed on issue: SRTESTPRJ-3, actionId: 4, file: examples/docs/AddComponentLeadsAsWatchers.groovy
groovy.lang.GroovyRuntimeException: Ambiguous method overloading for method com.atlassian.jira.issue.watchers.DefaultWatcherManager#startWatching.
Cannot resolve which method to invoke for [null, class com.atlassian.jira.issue.IssueImpl] due to overlapping prototypes between:
    [interface com.atlassian.crowd.embedded.api.User, interface com.atlassian.jira.issue.Issue]
    [interface com.atlassian.jira.user.ApplicationUser, interface com.atlassian.jira.issue.Issue]
    at com.atlassian.jira.issue.watchers.WatcherManager$startWatching$1.call(Unknown Source)
    at examples.docs.AddComponentLeadsAsWatchers$_run_closure1.doCall(AddComponentLeadsAsWatchers.groovy:16)
```

This happened because I was passing null (the component without a lead) to _startWatching_, and so required a small change to the script to handle the case where the component lead is not set, namely:

```
...
if (applicationUser) {
    watcherManager.startWatching(applicationUser, issue)
}
...
```
