# Write and Run Tests

- Platform: data-center
- Space: SR4JS
- Hierarchy: best-practices
- Doc ID: doc-sr4js-101624703
- Source: https://docs.adaptavist.com/sr4js/latest/best-practices/write-and-run-tests

ScriptRunner makes easy things easier and allows experienced users to perform advanced tasks. You can do anything in a script that you could do in a plugin, usually without the overhead of understanding the host of software development tools and methodologies that a typical plugin developer would have to worry about.

If you’re using ScriptRunner extensively to write a lot of custom code or small amounts of custom code that heavily is relied on, you’re getting into the development platform portion of the product. Even if your formal job title or role is not in software development, that’s okay! You can write and run tests of your code to make sure it’s functioning.

Automated tests help complicated testing tasks, like:

-   Detailed testing plans to make sure custom scripts work after upgrading linked instances of Jira and Confluence with repetitive tasks that need to be completed throughout the upgrade cycle
    
-   Verification to make sure script works as you develop it, without having to click through several steps in the UI every time you make a change.
    

Not every ScriptRunner user needs to write tests, but when you feel that you need them, you should start writing them. For example, this need could be from doing repetitive work to tests scripts or fielding concerns from others about the reliability of custom scripts. Anything that makes you say, "I wish I had a quicker way to test this…​" is a good reason to start writing automated tests for your scripts.

### An Aside for the Initiated Developer

Automated tests are integration tests, so they test your code within the context of a running Atlassian host application. The supported testing framework is Spock.

A unit test only tests your code, which typically means isolating your code by mocking any Atlassian managers and services. You could write a unit test, but it would be expensive to mock everything, and scripts are frequently simple enough that your logic isn’t complex enough to require testing.

The goal of automated testing is to make sure the script still works after you’ve made a change to the script or the environment where it runs.

If you’re building a script plugin with a host of custom classes that have deep business logic of their own, you may have different needs that require a unit test suite.

If you do build unit tests instead of using automated testing, make sure you’ve got enough integration tests in place to be prepared for changes to Atlassian’s API in the next major release.

### Writing and Running Tests

Avoid running tests on a production server. Most tests create data to perform tests on, change bits of the host application’s configuration, and do other things that you wouldn’t want done on a real live system with users milling about.

You can set up a test instance and/or a local development environment to run your tests. You can get a [development license](https://www.atlassian.com/licensing/purchase-licensing#licensing-7) to set up a test server where you can run a cloned instance of your Atlassian application.

ScriptRunner includes a testing library, [Spock](http://spockframework.org/). Like ScriptRunner, it is from the Groovy ecosystem, and it makes automated tests more readable, maintainable, and approachable.

A basic Spock test looks like this:

```
import spock.lang.Specification
 
class MyVeryOwnScriptSpec extends Specification {
 
    def "test that my script does what I say it does"() {
        setup: "create any test data I need (projects, issues, etc.)"
 
        when: "I invoke run my script"
        //write code that makes your script run here
 
        then: "my script makes the changes I expect"
        true //Each line is an assertion
        1 == 1 //Anything that returns true will let the test pass
        "a" == "b" //Anything that returns false will cause the test to fail
    }
}
```

Spock static type checking errors

When writing Spock tests in the Script Editor, you may see static type checking errors within test blocks (`expect:`, `when:`, `then:`, etc.). These are false positives caused by limitations in the type checker's understanding of Spock's DSL. Your tests will run correctly despite these editor warnings. See [Static Type Checking Limitations](https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/static-type-checking#limitations) for more details.

  

Fill in the lines beneath `setup:`, `when:`, and `then:` blocks with code that tests your script. The particulars of doing that will vary a bit based on what you’re testing (an event handler, a REST Endpoint, a Jira workflow function, etc.).

See the child pages of this page for some key particulars.

-   [Test Workflow Functions](https://docs.adaptavist.com/sr4js/latest/best-practices/write-and-run-tests/test-workflow-functions)
    
-   [Test Script Fields](https://docs.adaptavist.com/sr4js/latest/best-practices/write-and-run-tests/test-script-fields)
    

Once you’ve written your test, you can save it to one of your script roots and run it using the [Running Tests](#id-.WriteandRunTestsv8.x-running-tests) task.

### Test-Driven Workflow

When starting on a new feature, Adaptavist often uses a test-driven development workflow. This is the process:

1.  Write a test for a desired outcome.
    
2.  Run the test.
    
3.  The test probably fails.
    
    This indicates that the feature isn’t working yet.
    
4.  Implement the feature until the test passes.
    
5.  Do any required code cleanup.
    
    1.  Refactor.
        
    2.  Make sure the test still passes.
        
6.  Peer review.
    
7.  Make suggested edits.
    
8.  Test to make sure the code is running as expected.
    

### Running Tests

There are two ways that you can run automated tests: through the _Test Runner_ built-in script or via your IDE.

#### Test Runner Built-in Script

You can use the _Test Runner_ built-in script to run Spock tests on the current Jira instance through ScriptRunner. The script creates custom test packages, and selects which tests to run from the checklist, simplifying the testing process.

1.  From ScriptRunner navigate to **Built-in Scripts** \> **Test Runner**.
    
    ![](/sr4js/files/latest/101624703/101628275/1/1600980251000/test-runner+%282%29.png)
2.  Enter the name of the package(s) you want ScriptRunner to scan in **Packages**.
    
    Packages should follow the format `com.yourcompany.scriptrunner.test`, with all tests classes saved in the `com/yourcompany/scriptrunner/test` directory in your script root.
    
    The first time you open _Test Runner_, there is a pre-filled sample package `com.acme.scriptrunner.test`. This package contains sample tests. Run these tests to see an example of successful and failed tests. Running the pre-packaged tests creates a project with the key _SRTESTPRJ_, a workflow, and a workflow scheme.
    
    All these can be deleted, and they are recreated each time the test is run.
    
    Known bug
    
    Due to a known issue, custom test packages may not be automatically discovered in the Test Runner after you create them. If your test package doesn't appear in the **Tests** list, use one of the following workarounds:
    
    **Option 1: Run sample tests and refresh**
    
    1.  Run one of the pre-packaged sample tests from `com.acme.scriptrunner.test`
    2.  Refresh the Test Runner page in your browser.
    3.  Your custom test package should now appear in the **Tests** list.
    
    **Option 2: Manually trigger package rescan**
    
    1.  Navigate to **Script Console.**
    2.  Run the following script, replacing `com.yourcompany.scriptrunner.test` with your actual package name:  
        
        ```
import com.onresolve.scriptrunner.canned.testrunner.TestManager
import com.onresolve.scriptrunner.runner.ScriptRunnerImpl

def testManager = ScriptRunnerImpl.scriptRunner.getBean(TestManager)
testManager.updateScannedPackagesSetting("com.yourcompany.scriptrunner.test")
```
        
    3.  Return to the Test Runner and refresh the page.
    4.  Your custom test package should now be visible.
    
      
    
3.  Select which tests to run from the **Tests** list.  
    This list shows all available tests in the specified package.
    
4.  Optionally, click **Preview** to see details of which tests will be executed.
    
5.  Click **Run** to run the selected tests on the current instance.
    
    Do not run tests in a production instance.
    
6.  The outcome of tests can be viewed under the **Results** tab.
    

To use the included tests as a basis for custom tests, check out the source code for [the sample plugins](https://bitbucket.org/Adaptavist/scriptrunner-samples). Alternatively, unzip the ScriptRunner jar itself and edit the tests. Make sure you are using a source control system, so that you can test on your dev instance, commit your changes, then update your working copy on your production system.

#### Running From an IDE

You can run tests from your IDE. Adaptavist has only tested with Intellij IDEA and recommend it.

ScriptRunner includes a custom JUnit Platform Engine which executes the tests via REST in the running application (Jira, Confluence, Bitbucket etc). That engine will be automatically detected by JUnit Platform when executing tests so there isn't anything you need to do to make it work - simply extend `spock.lang.Specification` like you would do in any other Spock specification.

For example:

```
import spock.lang.Specification

class TestRunnerSampleSpec extends Specification {

    def "test something"() {
        expect:
        true
    }
}
```

  

##### IDEA Configuration

The IDE runs your test locally, which executes a REST call to the app. Therefore the IDE needs to know the address of your running application, so it can tell the app to run the tests. To do this, you can modify the default setting for JUnit tests:

1.  Navigate to **Run** \> **Edit Configurations**.
    
2.  Open the **Templates** drop-down on the left navigation and then select **JUnit**.
    
3.  For **VM Options**, add a property `-Dbaseurl=` pointing to the URL of the running application.
    
    You can omit this if you are running your application locally on port 8080, as in `[http://localhost:8080/jira](http://localhost:8080/jira)`.
    
4.  Under _Before Launch_, delete the _Build_ task using the minus button.
    
    It’s not necessary to rebuild the plugin after editing the tests because ScriptRunner will recompile the test if necessary.
    
5.  Uncheck the **Activate Tool Window** box.
    
    It’s not useful to switch to the tool window because any failures will be shown in the main _Log_ window.
    

Any exceptions are shown in the tool window, but log messages are not redirected to it, so there may not be a need to look at the tool window.

##### ![](/sr4js/files/latest/101624703/101628274/1/1600980251000/debug-test-config+%283%29.png)

##### Use the IDEA Test

-   You can run the code by clicking the annotations in the margin, as shown below:
    
    ![](/sr4js/files/latest/101624703/348418331/1/1668078516000/Screenshot+2022-11-10+at+11.07.07.png)
-   The keyboard shortcut to run the code is to put the cursor in the test `class` name or `method` name, and then press _Ctrl + Shift + F10_ for Windows or _Ctrl + Shift + R_ (on Mac OSX).
