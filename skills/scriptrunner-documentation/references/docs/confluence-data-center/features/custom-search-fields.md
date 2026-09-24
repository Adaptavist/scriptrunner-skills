# Custom Search Fields

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features
- Doc ID: doc-sr4c-a467afca-0c88-48d6-b3ff-0a74ba653590-5067a7c500e63440
- Source: https://docs.adaptavist.com/sr4c/latest/features#custom-search-fields--en

Use custom search fields to add useful indexes to Confluence's search, enabling you to find content that meets specific criteria.

Warning: SEARCH EXTRACTORS

Beginning in ScriptRunner for Confluence 8.0.0, Custom Search Extractors no longer function. We moved to the [Extractor2 implementation](https://confluence.atlassian.com/doc/preparing-for-confluence-8-0-1095775426.html#PreparingforConfluence8.0-LuceneandBonnieAPIisolation) to maintain cross-compatibility with Confluence 7 and Confluence 8. Existing Search Extractors cannot be automatically migrated; however, we have achieved feature parity with the new Extractor2 implementation.

To migrate your existing search extractors, you can retrieve your configurations by running this script in the Script Console:

```
import groovy.json.JsonOutput
import com.onresolve.scriptrunner.runner.util.AOPropertyPersister
 
def AO_PROPERTY_KEY = "confluence_extractors"
def oldExtractors = AOPropertyPersister.loadList(AO_PROPERTY_KEY) as List<Map>
JsonOutput.prettyPrint(JsonOutput.toJson(oldExtractors))
```

You'll need to create new custom search fields manually using your old configurations as a reference. Your scripts can be vastly simplified in the new implementation.

Custom search fields expand the capabilities of your CQL search. You can extend your CQL search capabilities outside of Confluence's [standard CQL fields](https://developer.atlassian.com/server/confluence/cql-field-reference/) by creating custom search fields. You can search for specific criteria in spaces, attachments, comments, and pages.

Tip: For help with CQL, visit the [CQL Guide](https://docs.adaptavist.com/sr4c/latest/get-started/cql-guide).

For example, you can use custom search fields to:

-   Search for pages that were last modified by a specific user.
-   Search for comments on pages that were added before a certain date.
-   Search for spaces that have fewer than a certain number of pages.
-   Search for pages that have an attachment larger than a specified file size.

## Create a Custom Search Field

To create a custom search field, follow these steps:

1.  Navigate to Administration > Custom Search Fields > Create Custom Search Field.
2.  Select Custom Search Fields.
    
    Note: Once you have some created, you can select them here if they need to be modified.
    
3.  Optional: Enter a Note for your reference. This note can be anything that helps you identify or use the custom search field.
4.  Enter a Field Name for your custom search field. This field is required. If you choose to use capital letters, please keep in mind that the fields are case-sensitive, and you will need to use capitals to search with the fields. Spaces and special characters are not accepted.
5.  Select a Value Type. You can select _Text_ or _Number_ here. This determines what kind of value the field stores. For example, a field storing a username would use Text.
6.  Choose an option for Assign Field To.Your choices are _Space_, _Attachment_, _Comment_, or _Pages_.This determines the type of content that the field will be associated with. For example, select _Pages_ if you want to search for pages edited by a specific user_._
7.  Enter a script for Field Value. This is how the field collects the value to store.
8.  Select Add to save the new custom search field.

## Use Custom Search Fields

Once you've created custom search fields, you can use them anywhere that you can search in Confluence, including [Enhanced Search](https://docs.adaptavist.com/sr4c/latest/features/enhanced-search).

Note: If you want the search result to return all the pages that exist in Confluence, including those created before the custom search field was introduced, then the Confluence search index must be rebuilt. For more information on rebuilding the index, read [Content Index Administration](https://confluence.atlassian.com/doc/content-index-administration-148844.html).

Warning: Rebuilding the search index is a time-consuming and resource-intensive operation, and it should not be triggered during busy hours.

1.  Determine which custom search field you need and note the name.
    
    Note: You can see all of your custom search fields on Administration > Custom Search Fields.
    
2.  Navigate to where you want to search.
3.  Type the name of your custom search field and the value you want to search for, and then perform the search.
    
    Tip: The search doesn't accept empty values. The custom search field has to be part of a CQL statement.
    
    -   Enhanced Search results:
    -   Confluence search results

## Examples

For more information about using custom search fields, check out the following page:

-   [Custom Search Field Examples](https://docs.adaptavist.com/sr4c/latest/features/custom-search-fields/custom-search-field-examples)
