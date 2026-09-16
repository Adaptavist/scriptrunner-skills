# Zephyr

- Platform: data-center
- Space: SR4JS
- Hierarchy: Integrations > Other Apps
- Doc ID: doc-sr4js-cbb9346c-129c-4032-a755-2ccbb7484412-03193483c464d0fb
- Source: https://docs.adaptavist.com/sr4js/latest/integrations/other-apps#zephyr--en

[Zephyr](https://marketplace.atlassian.com/apps/1213259/tm4j-test-management-for-jira?tab=overview&hosting=datacenter) (Formerly Test Management for Jira) is a test management solution that integrates with Jira. ScriptRunner integrates with Zephyr, allowing you to automate and customize your tests, making them more accurate and efficient.

Zephyr integration allows you to:

-   Add a workflow condition that prevents an issue transition.
-   Add a workflow post function that creates a test case when an issue performs a particular transition.
-   Create a calculated scripted field that aggregates data for an epic.
-   Create listeners to run an action when a specific Zephyr event fires.

Warning: Zephyr Essential

ScriptRunner does not integrate with [Zephyr Essential](https://marketplace.atlassian.com/apps/1014681/zephyr-essential-test-management-for-jira) due to product limitations.

Note: You must have, at a minimum, ScriptRunner version 5.6.8.1 installed to use the Zephyr events/integration.

## Zephyr Event Listeners

There are currently three Zephyr events available for ScriptRunner:

-   TestExecutionChangedEvent - Fires when a test execution is updated.
-   TestCaseChangedEvent - Fires when a test case is updated.
-   TestCycleChangedEvent - Fires when a test cycle is updated.

Create [listeners](https://docs.adaptavist.com/sr4js/latest/features/listeners) to run scripts when these Zephyr events fire.

Tip: For more information on Zephyr events in ScriptRunner, see the [Zephyr](https://support.smartbear.com/zephyr-scale-server/docs/test-automation/integrations/scriptrunner.html) documentation.

Note: Zephyr version 6.8 is the minimum version required for listener events.

## Workflow Examples

Warning: These examples only work with Zephyr 4.5.3 and above.

### Workflow Condition that Prevents an Issue Transition

The below examples show two ways of preventing an issue transition via a workflow condition using ScriptRunner's scripted condition option. The first example uses a JQL function provided by Zephyr. The second example shows the same functionality, but this time using Zephyr's Java API. Using the Java API means that this example can be extended using additional logic.

Note: In both examples, if an epic has an associated child issue with a non-passing test, the condition also fails to pass.

Tip: See the [Workflow Functions](https://docs.adaptavist.com/sr4js/latest/features/workflows) page for details on how to get access ScriptRunner workflow functions.

#### JQL Query that Fails if the Issue has any Outstanding Non-passing Tests

1.  Navigate to the required transition and add a new ScriptRunner condition.
2.  Select the JQL query matches condition option.
    
    Optionally, add a Note to identify the condition.
    
3.  Use the `hasAllLastTestResults("Pass")` JQL function provided by Zephyr to write a JQL Query for the condition.
4.  Enter a Preview Issue Key to check the JQL function on before saving.
    

For further details on additional JQL functions provided by Zephyr and how to use them, please see the [Advanced Search with JQL Functions](https://support.smartbear.com/zephyr-scale-server/docs/jql-functions.html) documentation.

#### Script that Fails if the Issue has any Outstanding Non-passing Tests

1.  Navigate to the required transition and add a new ScriptRunner condition.
2.  Select the Custom Script Condition option.
    
3.  Optionally, add a Note to identify the condition.
4.  Either select a Script File that contains the code shown below, or paste the following into the Inline Script field:
    
    ```
    package examples.docs.tm4j
    
    import com.atlassian.jira.component.ComponentAccessor
    import com.atlassian.jira.issue.Issue
    import com.kanoah.testmanager.service.publicservice.IssueLinkPublicService
    import com.onresolve.scriptrunner.runner.customisers.WithPlugin
    
    //Must use @WithPlugin annotation to pick up Test Management for JIRA classes
    @WithPlugin("com.kanoah.test-manager")
    
    def issueLinkPublicService = ComponentAccessor.getOSGiComponentInstanceOfType(IssueLinkPublicService)
    
    def checkTestStatus = { Issue targetIssue ->
        issueLinkPublicService.getTestCases(targetIssue.key, "lastTestResultStatus").each {
            if (it.get("lastTestResultStatus") != "Pass") {
                passesCondition = false
            }
        }
    }
    
    if (issue.issueType.name == "Epic") {
        ComponentAccessor.getIssueLinkManager().getOutwardLinks(issue.id).each {
            if (it.issueLinkType.name == "Epic-Story Link") {
                checkTestStatus(it.destinationObject)
            }
        }
    } else {
        checkTestStatus(issue)
    }
    ```
    

Note: The objects returned by the Zephyr Java API are key/value maps representing each object or lists of such maps. You can tailor the key/values returned in the map by specifying the keys as a comma-separated parameter value on the method call. In the above example, we are requesting that the lastTestResultStatus for each test case be returned. For further details on the structure of the returned key/value maps provided by Zephyr, please see the [REST API](https://support.smartbear.com/zephyr-scale-server/api-docs/v1/) documentation.

### Workflow Post Function that Creates a Test Case

The below example shows how to use a scripted post function to create a new test case using details from the issue.

1.  Navigate to the required transition and add a new ScriptRunner post function.
2.  Select the Custom Script Post Function option.
    
3.  Optionally, add a Note to identify the post function.
4.  Either select a Script File that contains the code shown below, or paste the following into the Inline Script field:
    
    ```
    package examples.docs.tm4j
    
    import com.atlassian.jira.component.ComponentAccessor
    import com.kanoah.testmanager.model.activeobjects.TestScriptEntity
    import com.kanoah.testmanager.service.model.StepDTO
    import com.kanoah.testmanager.service.model.TestCaseDTO
    import com.kanoah.testmanager.service.model.TestScriptDTO
    import com.kanoah.testmanager.service.publicservice.TestCasePublicService
    import com.onresolve.scriptrunner.runner.customisers.WithPlugin
    
    //Must use @WithPlugin annotation to pick up Test Management for JIRA classes
    @WithPlugin("com.kanoah.test-manager")
    
    def testCasePublicService = ComponentAccessor.getOSGiComponentInstanceOfType(TestCasePublicService)
    
    def newTestCase = new TestCaseDTO(
        name: issue.summary,
        projectKey: issue.projectObject.key,
        objective: issue.description,
        testScript: new TestScriptDTO(
            type: TestScriptEntity.Type.STEP_BY_STEP.toString(),
            steps: [
                new StepDTO(
                    description: "This is the first test step",
                    testData: "First test step test data",
                    expectedResult: "First test step expected result"
                ),
                new StepDTO(
                    description: "This is the second test step",
                    testData: "Second test step test data",
                    expectedResult: "Second test step expected result"
                )
            ]
        ),
        issueLinks: [issue.key]
    )
    
    testCasePublicService.createTestCase(newTestCase)
    ```
    

Once done, the below code creates a new test case with the issue's details every time the issue is transitioned with the post function's corresponding workflow transition.

## Scripted Fields Examples

Warning: This example only works with Zephyr 4.5.3 and above.

### Scripted Field for Displaying the Percentage of Passing Tests

The below example shows the creation of a scripted field which is used to display the percentage of passing tests. The script either displays the percentage of passing tests for an issue (or 100% in the case of issues with no tests) or, for an epic, displays the percentage of passing tests across all issues within that epic.

1.  Create a new ScriptRunner custom script field.
    
    Tip: For more information on how to create a custom script field, see our [Script Fields](https://docs.adaptavist.com/sr4js/latest/best-practices/binding-variables#script-fields--en) documentation.
    
2.  Enter a Field Name (for example, Tests Passed) and Field Description.
3.  Optionally, add a Note.
4.  Set the Template to Custom. This allows us to control how we want to display the calculated field.
5.  Type $value% into the Custom Template field. `$value` represents the calculated result. While `%` is the unit of measurement, we want to display in this example.
    
6.  Either select a Script File that contains the code shown below or paste the following into the Inline Script field:
    
    ```
    package examples.docs.tm4j
    
    import com.atlassian.jira.component.ComponentAccessor
    import com.atlassian.jira.issue.Issue
    import com.kanoah.testmanager.service.publicservice.IssueLinkPublicService
    import com.onresolve.scriptrunner.runner.customisers.WithPlugin
    
    //Must use @WithPlugin annotation to pick up Test Management for JIRA classes
    @WithPlugin("com.kanoah.test-manager")
    
    def numberOfTests = 0
    def numberOfPassingTests = 0
    
    def issueLinkPublicService = ComponentAccessor.getOSGiComponentInstanceOfType(IssueLinkPublicService)
    
    def countTestsInIssue = { Issue targetIssue ->
        issueLinkPublicService.getTestCases(targetIssue.key, "lastTestResultStatus").each {
            numberOfTests++
            if (it.get("lastTestResultStatus") == "Pass") {
                numberOfPassingTests++
            }
        }
    }
    
    if (issue.issueType.name == "Epic") {
        ComponentAccessor.getIssueLinkManager().getOutwardLinks(issue.id).each {
            if (it.issueLinkType.name == "Epic-Story Link") {
                countTestsInIssue(it.destinationObject)
            }
        }
    } else {
        countTestsInIssue(issue)
    }
    
    if (numberOfTests == 0) {
        return 100
    }
    return (double) (numberOfPassingTests * 100) / numberOfTests
    ```
    

Once you have added the scripted field, you should have the following scripted field configuration:

Notice that the Searcher is listed as being a Free Text Searcher. This is the default. However, in order to make our scripted field more versatile and in order to run issue searches such as Percentage Of Tests Passing < 50 we need to change this to a Number Searcher. Now your config should look like the one below.

## Zephyr Event Listeners Examples

To view example scripts for each Zephyr event listener see the [Creating Listeners in Scriptrunner for Zephyr Events](https://support.smartbear.com/zephyr-scale-server/docs/test-automation/integrations/creating-listeners-in-scriptrunner-for-events.html) documentation.
