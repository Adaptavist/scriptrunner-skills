# Test Script Fields

- Platform: data-center
- Space: SR4JS
- Hierarchy: best-practices > write-and-run-tests
- Doc ID: doc-sr4js-101624676
- Source: https://docs.adaptavist.com/sr4js/latest/best-practices/write-and-run-tests/test-script-fields

Testing [scripted fields](https://docs.adaptavist.com/sr4js/latest/features/script-fields) is fairly simple, it just involves creating the custom field, creating issues and verifying the correct data.

For this sample, I have created a script field that displays the earliest release date for any "fix versions" for that issue. A naive implementation might simply be:

```
issue.fixVersions.first().releaseDate
```

  

This is going to break (NullPointerException) if there are no fixVersions. If there are multiple fix versions you probably want to show the closest release date. Sometimes Versions don’t have a releaseDate set. All these cases should be tested for.

A slightly better implementation looks like:

```
package com.acme.scriptrunner.scripts
import com.atlassian.jira.issue.Issue

/**
 * Custom field script that displayes the earliest release date for any "fix versions"
 * Just an example but might be useful for JQL queries etc... eg to help find issues that really need to be done
 */

Issue issue = issue
def fixVersions = issue.fixVersions
if (fixVersions) {
    def releaseDates = fixVersions.findResults { it.releaseDate }.sort()
    if (releaseDates) {
        return releaseDates.first()
    }
}
```

  

For the template, perhaps you want to display it in red if the release date is within 7 days.

The test script can be found here: [https://gist.github.com/anonymous/a68dae64d00db6f5ac73](https://gist.github.com/anonymous/a68dae64d00db6f5ac73)

By extending `com.onresolve.scriptrunner.test.AbstractScriptFieldSpecification` we get for free a new project that is recreated every invocation of the test. The `setupSpec` method runs once for all the tests in the class, so that is the place where we create our test data - in this case some project versions, some having release dates, some not. There is also a simple method of create a script field, which includes the custom field itself, and sets script field specific properties.

The test method just creates issues with various combination of fixVersions, and verifies the script field shows the correct data.
