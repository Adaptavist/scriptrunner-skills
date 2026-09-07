# Custom JQL Functions

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > jql-functions
- Doc ID: doc-sr4js-443373704
- Source: https://docs.adaptavist.com/sr4js/latest/features/jql-functions/custom-jql-functions

Custom [JQL functions](https://developer.atlassian.com/server/jira/platform/jql-function/) let you extend Jira's search language with your own query logic, for example, finding issues linked to a specific object, matching a complex business rule, or querying across related entities that standard JQL can't reach.

Unlike a standard Jira JQL plugin, which can only return a list of issue key literals, ScriptRunner lets your custom function return a **native search query object** directly. This is evaluated natively against the search index and is significantly faster, especially at scale.

Jira version note

The underlying search API changed in Jira DC 10.4, transitioning from Lucene to OpenSearch. Lucene-specific classes were deprecated in 10.4 and removed entirely in Jira 11. If you are on Jira 11 or later, see the [Jira 11 Search API Upgrade Guide](https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes/jira-11-search-api-upgrade-guide) to ensure your scripts use the new Search API.

ScriptRunner supports two kinds of custom functions:

-   **Issue queries:** return a search query object, evaluated directly against the index for maximum performance.
-   **Non-issue queries:** return a collection of identifiers for other entity types such as users, projects, or components.

There is an [example](#id-.CustomJQLFunctionsv10.17.0-examples) below of each type.

**Before you start:** custom JQL functions are among the more technically demanding ScriptRunner customisations. You will be working directly with Jira's internal search APIs, we recommend you use a properly configured IDE with code completions.

## Quick start

Use one of the [examples](#id-.CustomJQLFunctionsv10.17.0-examples) below, and modify it to suit.

-   Modify the class name to something of your choice
    
-   Specify arguments if required
    
-   Implement argument validation
    
-   Click the _scan_ link at ScriptRunner → JQL Functions.
    
    The _scan_ function is only required when you first add a JQL function to a running Jira instance. From this point on it will automatically be loaded when Jira starts, so you should never need to click the _scan_ link more than once per function you add. See [Scanning for JQL functions](#id-.CustomJQLFunctionsv10.17.0-scanning) for more information on scanning. 
    
    ![](/sr4js/files/latest/443373704/443373702/1/1758888167000/JQL_function_scan.png)
    
-   When you are happy, test in the issue navigator. Make sure you test your error handling by entering incorrect parameters, the wrong number of parameters, and as different users.
    

You can modify the code, when you re-run the query via the issue navigator (or REST etc), your new code will be automatically recompiled. As always, tail the log while you are working, so you can see compilation errors etc.

### Scanning for JQL functions

For the scanning process to recognize your class as a JQL function you must either:

-   implement `com.onresolve.jira.groovy.jql.JqlQueryFunction` for functions that utilize issueFunction (and have a `getQuery()` method)
    
-   OR implement `com.onresolve.jira.groovy.jql.JqlValuesFunction` for functions that return a list of QueryLiterals from the getValues() method.
    

To make life easy you should extend `com.onresolve.jira.groovy.jql.AbstractScriptedJqlFunction`.

You need to implement `getFunctionName()`, `getDescription()`, and `getArguments()`, which simply provide information to the drop-down list, but otherwise have no functional effect.

Your function must reside under the `com.onresolve.jira.groovy.jql` package for it to be found. You can create these directories under one of your script roots as follows:

1.  Navigate to **ScriptRunner → Script Editor**.
2.  Select the _Add Folder_ icon. 
3.  Enter **com/onresolve/jira/groovy/jql**.
4.  Select **Add**.  
    This creates the nested folder structure needed.
5.  Add the JQL function script under the **jql** folder calling it the same name as the class name in the script. 

## Examples

### JQL alias example

Sometimes you need a complex query for tasks like generating release notes, but expecting users to type it correctly every time is unreliable. This function lets you define a complex query once and expose it as a simple, parameterized alias.

In this example, running `issueFunction in releaseNotes("1.1")` executes `project = JRA AND fixVersion = 1.1 AND affectedVersion = 1.1`. In practice, the underlying query would typically be far more complex.

The validator also checks the aliased query itself, so invalid input, such as a nonexistent version, is caught and reported to the user.

This script is compatible with ScriptRunner version 10.x and above.

```
package com.onresolve.jira.groovy.jql

import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.jql.parser.JqlQueryParser
import com.atlassian.jira.jql.query.QueryCreationContext
import com.atlassian.jira.jql.validator.NumberOfArgumentsValidator
import com.atlassian.jira.search.Query
import com.atlassian.jira.search.jql.DefaultQueryFactory
import com.atlassian.jira.user.ApplicationUser
import com.atlassian.jira.util.MessageSet
import com.atlassian.query.clause.TerminalClause
import com.atlassian.query.operand.FunctionOperand

import java.text.MessageFormat

class JqlAliasFunction extends AbstractScriptedJqlFunction implements JqlQueryFunction {

    /**
     * Modify this query as appropriate.
     *
     * See {@link java.text.MessageFormat} for details
     */
    public static final String TEMPLATE_QUERY =
        "project = JRA and fixVersion = {0} and affectedVersion = {0}"

    JqlQueryParser queryParser = ComponentAccessor.getComponent(JqlQueryParser)
    DefaultQueryFactory queryFactory = ComponentAccessor.getComponent(DefaultQueryFactory)

    @Override
    String getDescription() {
        "Create release notes"
    }

    @Override
    MessageSet validate(ApplicationUser user, FunctionOperand operand, TerminalClause terminalClause) {
        def messageSet = new NumberOfArgumentsValidator(1, 1, getI18n()).validate(operand)

        if (messageSet.hasAnyErrors()) {
            return messageSet
        }

        def query = mergeQuery(operand)
        messageSet = searchService.validateQuery(user, query)
        messageSet
    }

    @Override
    List<Map> getArguments() {
        [
            [
                description: "Version to generate release notes for",
                optional   : false,
            ]
        ]
    }

    @Override
    String getFunctionName() {
        "releaseNotes"
    }

    @Override
    Query getQuery(QueryCreationContext queryCreationContext, FunctionOperand operand, TerminalClause terminalClause) {
        def query = mergeQuery(operand)
        queryFactory.create(query.whereClause, queryCreationContext)
    }

    private com.atlassian.query.Query mergeQuery(FunctionOperand operand) {
        def queryStr = MessageFormat.format(TEMPLATE_QUERY, operand.args.first())
        queryParser.parseQuery(queryStr)
    }
}
```

This script is compatible with ScriptRunner versions 8.x to 9.x.

```
package com.onresolve.jira.groovy.jql

import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.jql.parser.JqlQueryParser
import com.atlassian.jira.jql.query.LuceneQueryBuilder
import com.atlassian.jira.jql.query.QueryCreationContext
import com.atlassian.jira.jql.validator.NumberOfArgumentsValidator
import com.atlassian.jira.user.ApplicationUser
import com.atlassian.jira.util.MessageSet
import com.atlassian.query.clause.TerminalClause
import com.atlassian.query.operand.FunctionOperand
import org.apache.lucene.search.Query

import java.text.MessageFormat

class JqlAliasFunction extends AbstractScriptedJqlFunction implements JqlQueryFunction {

    /**
     * Modify this query as appropriate.
     *
     * See {@link java.text.MessageFormat} for details
     */
    public static final String TEMPLATE_QUERY =
        "project = JRA and fixVersion = {0} and affectedVersion = {0}"

    JqlQueryParser queryParser = ComponentAccessor.getComponent(JqlQueryParser)
    LuceneQueryBuilder luceneQueryBuilder = ComponentAccessor.getComponent(LuceneQueryBuilder)

    @Override
    String getDescription() {
        "Create release notes"
    }

    @Override
    MessageSet validate(ApplicationUser user, FunctionOperand operand, TerminalClause terminalClause) {
        def messageSet = new NumberOfArgumentsValidator(1, 1, getI18n()).validate(operand)

        if (messageSet.hasAnyErrors()) {
            return messageSet
        }

        def query = mergeQuery(operand)
        messageSet = searchService.validateQuery(user, query)
        messageSet
    }

    @Override
    List<Map> getArguments() {
        [
            [
                description: "Version to generate release notes for",
                optional   : false,
            ]
        ]
    }

    @Override
    String getFunctionName() {
        "releaseNotes"
    }

    @Override
    Query getQuery(QueryCreationContext queryCreationContext, FunctionOperand operand, TerminalClause terminalClause) {
        def query = mergeQuery(operand)
        luceneQueryBuilder.createLuceneQuery(queryCreationContext, query.whereClause)
    }

    private com.atlassian.query.Query mergeQuery(FunctionOperand operand) {
        def queryStr = MessageFormat.format(TEMPLATE_QUERY, operand.args.first())
        queryParser.parseQuery(queryStr)
    }
}
```

  

### Project versions example

This JQL function returns issues that have a fix or affects version where the version is not released, but the _start date_, if present, is in the past.

We suppose this might let you infer what will be released soon. It would be used as in: `fixVersion in versionsStarted()`. It is not really intended to be useful, just a guide.

Because this function is applicable to Version fields (ie fix and affects versions, single and multi version custom fields), we implement `JqlFunction` rather than `JqlQueryFunction`, and need to return a list of [`QueryLiteral`](https://docs.atlassian.com/software/jira/docs/api/8.13.0/com/atlassian/jira/jql/operand/QueryLiteral.html). See the notes below the code.

```
package com.onresolve.jira.groovy.jql

import com.atlassian.jira.JiraDataType
import com.atlassian.jira.JiraDataTypes
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.jql.operand.QueryLiteral
import com.atlassian.jira.jql.query.QueryCreationContext
import com.atlassian.jira.permission.ProjectPermissions
import com.atlassian.jira.project.version.VersionManager
import com.atlassian.jira.security.PermissionManager
import com.atlassian.query.clause.TerminalClause
import com.atlassian.query.operand.FunctionOperand

class VersionIsStarted extends AbstractScriptedJqlFunction implements JqlFunction {

    VersionManager versionManager = ComponentAccessor.getComponent(VersionManager)
    PermissionManager permissionManager = ComponentAccessor.getPermissionManager()

    @Override
    String getDescription() {
        "Issues with fixVersion started but not released"
    }

    @Override
    List<Map> getArguments() {
        Collections.EMPTY_LIST // <1>
    }

    @Override
    String getFunctionName() {
        "versionsStarted"
    }

    @Override
    JiraDataType getDataType() {
        JiraDataTypes.VERSION // <2>
    }

    @Override
    List<QueryLiteral> getValues(
        QueryCreationContext queryCreationContext, FunctionOperand operand, TerminalClause terminalClause
    ) {

        def now = new Date()
        versionManager.allVersions.findAll {
            def startDate = it.startDate

            !it.released && startDate && startDate < now // <3>
        }.findAll {
            queryCreationContext.securityOverriden || permissionManager.hasPermission(ProjectPermissions.BROWSE_PROJECTS, it.project, queryCreationContext.applicationUser) // <4>
        }.collect {
            new QueryLiteral(operand, it.id) // <5>
        }
    }
}
```

1.  No arguments for this function
2.  We must specify the type that we are returning
3.  Versions not released, having a start date, and the start date is before today
4.  Filter just those current user has permission to see the project of
5.  Create the `QueryLiteral` from the version identifier

  

* * *

## Related content

-   [JQL Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions)
-   [JQL Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial)
-   [Included JQL Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions)
