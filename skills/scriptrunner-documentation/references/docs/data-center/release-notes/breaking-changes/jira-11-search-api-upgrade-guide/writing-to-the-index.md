# Writing to the Index

- Platform: data-center
- Space: SR4JS
- Hierarchy: release-notes > breaking-changes > jira-11-search-api-upgrade-guide
- Doc ID: doc-sr4js-441364878
- Source: https://docs.adaptavist.com/sr4js/latest/release-notes/breaking-changes/jira-11-search-api-upgrade-guide/writing-to-the-index

Atlassian has introduced a [new Search API](https://confluence.atlassian.com/adminjiraserver/search-api-upgrade-guide-1488594607.html) in Jira Data Center version 10.4, transitioning from Lucene to OpenSearch. As part of the Search API upgrade all Lucene indexers will be removed and need to be upgraded to Search API equivalents. Before the new Search API, when writing to the Index, we would rely on the Lucene indexers in this package:

-   `[com.atlassian.jira.issue.index.indexers](https://docs.atlassian.com/software/jira/docs/api/10.6.0/com/atlassian/jira/issue/index/indexers/package-summary.html)`

In Search API, there is a new package with the Search API indexers:

-   `[com.atlassian.jira.search.issue.index.indexers](https://docs.atlassian.com/software/jira/docs/api/10.6.0/com/atlassian/jira/search/issue/index/indexers/package-summary.html)`

This page focuses on explaining how to write to the index with the new Search API.

## Key differences

Below we detail the key differences between the Lucene-based indexing approach and the new Search API implementation.

### Changes to the `index()` method and introduction of `FieldValueCollector` to manipulate documents

Although most of the Lucene classes have equivalent classes in Search API (such as `BooleanQuery` being equivalent to `DefaultBooleanQuery`), the `index()` method has changed. This means that rather than relying on methods such as `indexLocalDateField()` or `Document#add()`, we rely on `FieldValueCollector#add()`. For any indexer, the signature of the index method has changed as follows:

```
index(Document, Issue) -> index(FieldValueCollector, Issue, CustomFieldPrefetchedData)
```

-   `Issue` has stayed the same.
-   `FieldValueCollector` is the new interface that is used to add fields to the document.
-   `CustomFieldPrefetchedData` is a collection of non-null custom fields on the iterated issue. All subclasses extending `FieldIndexer` get access to this variable. The data type of the values varies per custom field.

Examples further down this page demonstrate how to refactor an existing indexer to use `FieldValueCollector`.

See [Atlassian's documentation](https://confluence.atlassian.com/adminjiraserver/migrating-fieldindexers-in-jira-11-1573487045.html#MigratingFieldIndexersinJira11-indexers) for more details. 

### Changes to field configuration and storage part of a field configuration

Previously, if you wanted to specify a given field configuration you would use an appropriate class provided by Lucene. For example, for stored-only fields or fields used for sorting:

```
doc.add(new StoredField(String name, BytesRef value))

or

doc.add(new SortedSetDocValuesField(documentFieldId, new BytesRef(String.valueOf(value.id))))
```

With the new `index()` method, `FieldValueCollector`, and typed fields, you pick a subclass that extends `AbstractField` and then use it's builder to configure the field's specifications. To do so, we call either `.stored(`) and/or `.indexed()` to configure the field to our use case.

Here is an example of an `IntField` that we want to be stored and indexed on a document:

```
def exampleIntField = IntField.builder(STR_FIELD_NAME).stored().indexed().build()
fieldValueCollector.add(exampleIntField, INT_NUMBER)
```

Or you could use `FieldValueCollector#add(String fieldName, Object value)` and provide a valid value to create a field with a default configuration:

```
fieldValueCollector.add("fieldName", someValidValueSuchAsIntStrLongAndSoOn)
```

## Refactoring examples

Below we provide examples of how to refactor your scripts to work with the new Search API. 

### Changing a typed Lucene field to work with Search API

In this example, we're using a `StringField`, which is a primitive typed Lucene field:  

For reference, a typed Lucene field would use one of the primitive types such as `StringField`, `IntField`, `LongField`, etc.

```
@Override
void index(Document doc, Issue issue) {
	def stringValue = "value"
	doc.add(new StringField(getDocumentFieldId(), stringValue, Field.Store.YES))
}
```

Here's how to achieve the same result using the new Search API:

```
@Override
void indexFields(FieldValueCollector collector, Issue issue, CustomFieldPrefetchedData prefetchedData) {
	def stringValue = "value"
	def exampleField = KeywordField.builder("exampleName").stored().indexed().build()
    collector.add(exampleField, value)
}
```

### Refactoring `AbstractCustomFieldIndexer` subclasses

Classes that extend `AbstractCustomFieldIndexer` would likely have two overridden methods:

```
@Override
void addDocumentFieldsSearchable(Document doc, Issue issue) {
	// Logic to handle searchable field
}

@Override
void addDocumentFieldsNotSearchable(Document doc, Issue issue) {
	// Logic to handle unsearchable field
}

OR if on a version <8.10

@Override
void addDocumentFieldsSearchable(Document doc, Issue issue, CustomFieldPrefetchedData prefetchedData) {
	// Logic to handle searchable field
}

void addDocumentFieldsNotSearchable(Document doc, Issue issue, CustomFieldPrefetchedData prefetchedData) {
	// Logic to handle unsearchable field
}
```

To be Search API compliant, we extend `BaseCustomFieldIndexer` and override the streamlined `indexFields()` method which handles both cases automatically:

```
class ExampleFieldIndexer extends BaseCustomFieldIndexer {

    protected ExampleFieldIndexer(
        FieldVisibilityManager fieldVisibilityManager, CustomField customField
    ) {
        super(fieldVisibilityManager, customField,
            KeywordField.builder("${customField.name}")
			    .multiValued()
                .indexed()
                .docValues()
                .stored()
                .build())
    }

    @Override
    void indexFields(FieldValueCollector collector, Issue issue, CustomFieldPrefetchedData prefetchedData) {
        def issueValue = this.getCustomField().getValue(issue)
        issueValue.each { String value ->
            if (value != null) {
                indexField(collector, value, issue)
            }
        }
    }
}
```
