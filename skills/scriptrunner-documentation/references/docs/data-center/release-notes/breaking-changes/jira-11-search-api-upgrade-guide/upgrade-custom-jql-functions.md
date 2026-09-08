# Upgrade Custom JQL Functions

- Platform: data-center
- Space: SR4JS
- Hierarchy: release-notes > breaking-changes > jira-11-search-api-upgrade-guide
- Doc ID: doc-sr4js-441364875
- Source: https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes/jira-11-search-api-upgrade-guide/upgrade-custom-jql-functions

Atlassian has introduced a [new Search API](https://confluence.atlassian.com/adminjiraserver/search-api-upgrade-guide-1488594607.html) in Jira Data Center version 10.4, transitioning from Lucene to OpenSearch. Some of the existing search methods used in custom JQL functions have been deprecated and will be removed in Jira 11. If you currently use any of the deprecated methods, you will need to rewrite your scripts before upgrading to Jira 11.

The following Lucene methods and classes, typically used in custom JQL functions, have been [deprecated](https://confluence.atlassian.com/adminjiraserver/search-api-deprecations-and-upgrade-guide-for-jira-11-1573486929.html#SearchAPIdeprecationsandupgradeguideforJira11-migrating):

-   Query subclasses (for example `BooleanQuery`)
-   `SearchProvider`/`ManagedIndexSearcher`
-   `LuceneQueryBuilder`

On this page, we provide examples of how to update your custom JQL function scripts.

## Upgrading query subclasses and clauses

### Query subclasses

Query subclasses, such as `BooleanQuery`, `TermQuery` and so on, have been deprecated in Jira 10.4. Most of these subclasses have an equivalent in the new Search API called a Default, and therefore can be directly replaced. For example, `BooleanQuery` can be directly replaced with `DefaultBooleanQuery`:

```
Lucene
....
		def exampleBooleanQuery = new BooleanQuery.Builder().add(
			new BooleanClause(exampleSimpleQuery, BooleanClause.Occur.SHOULD)
		)

Search API
....
		def exampleBooleanQuery = new DefaultBooleanQuery.Builder().add(
            BooleanQuery.Occur.clause(exampleSimpleQuery, BooleanQuery.Occur.SHOULD)
        )
```

`TermQuery` is a notable exception which cannot be directly replaced with `DefaultTermQuery`. It needs to be wrapped within a `DefaultBooleanQuery` to function the same way as before:

```
Lucene
....
            return new TermQuery(new Term(EXAMPLE_FIELD, EXAMPLE_VALUE))


Search API
....
			return new DefaultBooleanQuery.Builder().add(
                new DefaultTermQuery(EXAMPLE_FIELD, EXAMPLE_VALUE),
                BooleanQuery.Occur.MUST
            ).build()
```

### Clauses

It is important to note that `clauses` are now accessible via `BooleanQuery.Occur` instead of `BooleanClause.Occur`.

## Upgrading `SearchProvider`/`ManagedIndexSearcher`

`SearchProvider`, `SearchProviderFactory` and therefore `ManagedIndexSearcher` have been deprecated in Jira 10.4. While the overall design has remained the same, there are differences that need to be accounted for when upgrading your script. We will use the example below to help explain the differences:

```
Lucene
....
		def booleanQuery = new BooleanQuery.Builder()
    		.add(new TermQuery(new Term(CUSTOM_BOOLEAN_FIELD_FOR_CUSTOM_JQL_FUNCTION, TRUE.toString())), MUST)
    		.build()

		def idCollector = new IssueIdCollector()
		def searchProviderFactory = ComponentAccessor.getComponent(SearchProviderFactory)
		def commentSearcher = searchProviderFactory.getSearcher(SearchProviderFactory.ISSUE_INDEX)
		commentSearcher.search(booleanQuery, idCollector)

		def collectedIssueIds = idCollector.issueIds

....
```

This is a rudimentary example of a `SearchProvider` being used with a collector to get the IDs from matching Lucene documents. There are a few things that need to be upgraded for this to be compatible with the new Search API:

-   `BooleanQuery` needs to be upgraded to use the new Search API `Default` classes (`DefaultBooleanQuery`, `DefaultTermQuery`)
-   A new `Collector` needs to be created that mimics the functionality of gathering issue IDs like the old Lucene collector. We go over an [example collector](#id-.UpgradeCustomJQLFunctionsv9.x-collector) under Search API below.
-   Before, we would use `SearchProviderFactory` to get us an instance of a `ManagedIndexSearcher` to do our search. In the new Search API, we instead use the `IndexAccessorRegistry` to get us an `IndexSearcher` for the same purpose.
-   Now that we are using an IndexSearcher, we can no longer provide the Query directly. Instead, we add wrap the Query into a SearchRequest and provide that SearchRequest to the IndexSearcher.

The upgraded version looks as follows:

```
SearchAPI
....
		def booleanQuery = DefaultBooleanQuery.builder()
			.add(new DefaultTermQuery(CUSTOM_BOOLEAN_FIELD_FOR_CUSTOM_JQL_FUNCTION, TRUE.toString()), BooleanQuery.Occur.MUST)
			.build() 
		// The Lucene Query has been replaced with SearchAPI defaults	

		def collector = new IssueIdHitFunction() 
		// A new Collector has been defined. This IssueIdHitFunction is defined in the Collectors section below this example.

		def req = new SearchRequest.Builder(booleanQuery).documentType(DocumentTypes.ISSUE)
			.build() 
		// The DefaultBooleanQuery has been wrapped within a SearchRequest

		IndexAccessorRegistry indexAccessorRegistry = ComponentAccessor.getComponent(IndexAccessorRegistry)
		def indexSearcher = indexAccessorRegistry.getIssuesIndexAccessor().getSearcher() 
		// We got the IndexSearcher instead of a SearchProviderFactory

		indexSearcher.scan(req, collector) 
		def issueIdsQuery = new DefaultTermsSetQuery(DocumentConstants.ISSUE_ID, collector.issueIds*.toString()) 
		// We can use the collector.issueIds elsewhere

....
```

## Collectors

Search API does not currently come with `Collector` defaults in the same way that there are `Query` defaults (such as `DefaultBooleanQuery`). This means that new equivalent classes will need to be written to facilitate various use cases in your code.  The example in the previous section used a custom class called `IssueIdFunction()` to mimic the functionality of the Lucene `IssueIdCollector`. We will use this example to explain the new collector structure that needs to be used in the Search API for defining new collectors:

```
import com.atlassian.jira.issue.index.DocumentConstants
import com.atlassian.jira.search.Document

import java.util.function.Function

class IssueIdHitFunction implements Function<Document, Boolean> {

    private Set<Long> issueIds = []

    @Override
    Boolean apply(Document document) {
        def issueIdStr = document.getString(DocumentConstants.ISSUE_ID)
        if (issueIdStr.isPresent()) {
            def issueId = Long.parseLong(issueIdStr.get())
            this.collect(issueId)
        }
        true
    }

    Set<Long> getIssueIds() {
        this.issueIds
    }

    protected void collect(Long issueId) {
        this.issueIds.add(issueId)
    }
}
```

This is a simple collector that goes into a document and gets the issue ID. Any collector in the Search API needs to follow this structure:

-   The collector needs to implement `Function<Document, Boolean>` so that the `IndexSearcher` accepts it as an argument
-   The collector needs to implement an overridden Boolean `apply()` that returns true. This is the method that the `IndexSearcher` will call on each matching Lucene document returned as part of the query. We return true in the method so that the iteration does not stop prematurely. You may wish to implement logic that returns false as part of the `apply()` if a limited number of iterations fits your business needs.

## `LuceneQueryBuilder`

Although `LuceneQueryBuilder` has been deprecated, it has a replacement in the form of `DefaultQueryFactory`. The one difference between the two classes is that the resulting query is stored and accessed differently. Whereas `LuceneQueryBuilder` returned the query immediately, `DefaultQueryFactory` stores it inside of a `QueryFactoryResult` as an instance variable. Below is an example refactor to help demonstrate this:

```
Lucene
...
LuceneQueryBuilder luceneQueryBuilder = ComponentAccessor.getComponent(LuceneQueryBuilder)

return luceneQueryBuilder.createLuceneQuery(queryCreationContext, notEmptyQuery.whereClause)
...

Search API
...
DefaultQueryFactory defaultQueryFactory = ComponentAccessor.getComponent(DefaultQueryFactory)

return defaultQueryFactory.create(notEmptyQuery.whereClause, queryCreationContext).query
...
```
