# Search by reg exp on select option values

- Platform: data-center
- Feature: jql-functions
- Tags: automate, reporting
- Language: groovy
- Doc ID: example-dataCenter-options-matches-jql-function-onPrem
- Source: https://examples.scriptrunner.io/scripts/options-matches-jql-function-onPrem

## Overview

You may wish to use a regular expression to search for issues based on the select or multi select custom fields. 

Whilst you can do this with `issueFieldMatch` or `issueFieldExactMatch`, these can perform badly for some types of custom field value.

This function runs the reg exp across all valid options for this select/multi select field, and produces a new JQL clause of the form `MyCustomField in (A, B, C)` which should be highly performant.

## Example

I have a `Fruit` multi-select custom field that contains names of fruits like *Blackberry*, *Blueberry*. I can find all issues that have *Blackberry* or *Blueberry* selected by using the following JQL:

```issueFunction in optionMatches("Fruit", ".*berry")```

## Good to Know

See our [Custom JQL Functions documentation](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/custom-jql-functions) for information on how to install this function. 

In short, create a file `com/onresolve/jira/groovy/jql/OptionMatchesFunction.groovy` in your script root, and paste the code below into it. You may need to restart the plugin to make the function available.

## Script

```groovy
package com.onresolve.jira.groovy.jql

import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.CustomFieldManager
import com.atlassian.jira.issue.customfields.manager.OptionsManager
import com.atlassian.jira.jql.builder.JqlQueryBuilder
import com.atlassian.jira.jql.query.LuceneQueryBuilder
import com.atlassian.jira.jql.query.QueryCreationContext
import com.atlassian.jira.jql.validator.NumberOfArgumentsValidator
import com.atlassian.jira.user.ApplicationUser
import com.atlassian.jira.util.MessageSet
import com.atlassian.query.clause.TerminalClause
import com.atlassian.query.operand.FunctionOperand
import org.apache.lucene.search.Query

class OptionMatchesFunction extends AbstractScriptedJqlFunction implements JqlQueryFunction {

    LuceneQueryBuilder luceneQueryBuilder = ComponentAccessor.getComponent(LuceneQueryBuilder)
    OptionsManager optionsManager = ComponentAccessor.getComponent(OptionsManager)
    CustomFieldManager customFieldManager = ComponentAccessor.getCustomFieldManager()

    @Override
    String getDescription() {
        "Matches issues against select option values by regex"
    }

    @Override
    MessageSet validate(ApplicationUser user, FunctionOperand operand, TerminalClause terminalClause) {
        def messageSet = new NumberOfArgumentsValidator(2, 2, getI18n()).validate(operand)

        if (messageSet.hasAnyErrors()) {
            return messageSet
        }

        def customFields = customFieldManager.getCustomFieldObjectsByNameIgnoreCase(operand.args[0])
        if (!customFields) {
            messageSet.addErrorMessage("Could not find custom field ${operand.args[0]}")
        }

        messageSet
    }

    @Override
    List<Map> getArguments() {
        [
            [
                description: "Custom field name",
                optional   : false,
            ],
            [
                description: "Reg exp to match options on",
                optional   : false,
            ],
        ]
    }

    @Override
    String getFunctionName() {
        "optionMatches"
    }

    @Override
    Query getQuery(QueryCreationContext queryCreationContext, FunctionOperand operand, TerminalClause terminalClause) {
        def customField = customFieldManager.getCustomFieldObjectsByName(operand.args[0]).first()
        def fieldConfigSchemes = customField.getConfigurationSchemes()

        def options = fieldConfigSchemes.collect {
            def fieldConfig = it.oneAndOnlyConfig

            optionsManager.getOptions(fieldConfig)*.value.findAll {
                it.matches(operand.args[1])
            }
        }.flatten() as String[]

        def queryBuilder = JqlQueryBuilder.newBuilder()
        def whereClause = queryBuilder
            .where()
            .customField(customField.idAsLong)
            .in(options)
            .endWhere()
            .buildQuery()
            .whereClause

        luceneQueryBuilder.createLuceneQuery(queryCreationContext, whereClause)
    }
}
```

