# A console script for displaying the fields on the Lucene document for an issue

- Platform: data-center
- Feature: script-console
- Tags: administer
- Language: groovy
- Doc ID: example-dataCenter-list-lucene-fields-onPrem
- Source: https://examples.scriptrunner.io/scripts/list-lucene-fields-onPrem

## Overview

Searching in Jira is done using [Lucene](https://lucene.apache.org/).
Each time an issue is edited, or you do a full or project reindex, the Lucene index is updated.
Each issue is represented by a Lucene document.

It is the responsibility of indexers to contribute to the document representing the issue.
When executing a JQL query, various searchers will build a Lucene query to interrogate the index.

This script can be useful to help diagnose any problems with either indexers or searchers.

To use it, enter the key of the issue you wish to see the document for.

## Description

#### Overview

Searching in Jira is done using [Lucene](https://lucene.apache.org/).
Each time an issue is edited, or you do a full or project reindex, the Lucene index is updated.
Each issue is represented by a Lucene document.

It is the responsibility of indexers to contribute to the document representing the issue.
When executing a JQL query, various searchers will build a Lucene query to interrogate the index.

This script can be useful to help diagnose any problems with either indexers or searchers.

To use it, enter the key of the issue you wish to see the document for.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.index.DocumentConstants
import com.atlassian.jira.issue.search.SearchProviderFactory
import com.onresolve.scriptrunner.canned.util.OutputFormatter
import com.onresolve.scriptrunner.parameters.annotation.ShortTextInput
import org.apache.lucene.index.Term
import org.apache.lucene.search.BooleanClause
import org.apache.lucene.search.BooleanQuery
import org.apache.lucene.search.TermQuery

def searchProviderFactory = ComponentAccessor.getComponent(SearchProviderFactory)
def indexSearcher = searchProviderFactory.getSearcher(SearchProviderFactory.ISSUE_INDEX)
def issueManager = ComponentAccessor.issueManager

@ShortTextInput(label = 'Issue Key', description = 'Enter an issue key to view the Lucene document')
String issueKey

assert issueKey: 'Please enter an issue key'

def issue = issueManager.getIssueObject(issueKey)
assert issue: 'Could not find an issue with this key'

def bq = new BooleanQuery.Builder()
    .add(new TermQuery(new Term(DocumentConstants.ISSUE_ID, issue.id.toString())), BooleanClause.Occur.MUST)
    .build()

def docId = indexSearcher.search(bq, 1).scoreDocs.first().doc
def document = indexSearcher.doc(docId)

OutputFormatter.markupBuilder {
    table(class: 'aui') {
        thead {
            tr {
                td('Name')
                td('Value')
            }
        }
        document.fields.sort(false) { it.name() }.each { field ->
            tbody {
                tr {
                    td(field.name())
                    td(field.stringValue())
                }
            }
        }
    }
}
```

