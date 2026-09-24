# Custom Search Field Examples

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Custom Search Fields
- Doc ID: doc-sr4c-8f74d75e-1c64-44d2-919e-f9f0a5653a2e-2f649e0c0f764777
- Source: https://docs.adaptavist.com/sr4c/latest/features#custom-search-fields--en#custom-search-field-examples--en

Find several examples of Custom Search Fields, which help administrators create custom fields to match specific needs.

Custom search fields are a useful tool for administrators who want to track engagement with their content on a Confluence instance. This feature allows administrators to create custom search fields that match their specific needs and use cases, enabling them to quickly and easily search for and retrieve data that can help them track engagement with their content.

Tip: Custom Search Fields are components to CQL statements. For help with CQL, visit the [CQL Guide](https://docs.adaptavist.com/sr4c/latest/get-started/cql-guide).

Administrators can use this feature to create custom search fields that help them track the popularity, activity, and engagement of their content on a Confluence site, providing them with valuable insights and information about the performance of their content. The examples on this page show ways to do that.

## Number of comments on a page

You can sort pages by number of comments or likes to track the level of engagement and activity on a page. This can be useful if you want to measure the popularity of a page among users, and it can help to identify pages that are performing well or poorly.

1.  Enter a Note, like Number of comments on a page, to identify the custom search field for future use.
2.  Enter a Field Name, like NumberOfComments
3.  Select Number for the Value Type.
4.  Select Page for Assign Field To.
5.  Select Example Scripts once the Field Value field appears.
6.  Select Store the number of comments a page has and paste it into the field.
7.  Select Add.

To sort pages by the number of comments in your instance, follow these steps:

1.  Navigate to search.
2.  Enter `type = page ORDER BY NumberOfComments ASC`.
3.  Search and view the results.

## Number of times a page has been linked or referenced by other pages

You can sort pages based on the number of times they have been linked to or referenced by other pages to track the popularity of a page among users. This can be useful if you want to measure the impact or influence of a page on a Confluence site, and it can help to identify pages that are important or relevant to other users.

1.  Enter a Note, like Number of times a page has been linked or referenced by other pages, to identify the custom search field for future use.
2.  Enter a Field Name, like NumberOfLinksAndReferences.
3.  Select Number for the Value Type.
4.  Select Page for Assign Field To.
5.  Select Example Scripts once the Field Value field appears.
6.  Select Store the number of incoming links a page has and paste it into the field.
7.  Select Add.
    
    To sort pages based on the number of incoming links a page has in your instance, follow these steps:
    
8.  Navigate to search.
9.  Enter `type = page ORDER BY NumberOfLinksAndReferences ASC`.
10.  Search and view the results.
     

## Number of attachments on a page

You can sort pages by the number of attachments they have, which helps you measure engagement with pages. Pages with a high level of engagement could have a large number of attachments because they are popular or frequently accessed by users.

1.  Enter a Note, like Number of attachments on a page, to identify the custom search field for future use.
2.  Enter a Field Name, like NumberOfAttachments.
3.  Select Number for the Value Type.
4.  Select Page for Assign Field To.
5.  Select Example Scripts once the Field Value field appears.
6.  Select Store the number of attachments a page has and paste it into the field.
7.  Select Add.
    
    To sort the pages by the number of attachments they have, follow these steps:
    
8.  Navigate to search.
9.  Enter `type = page ORDER BY NumberOfAttachments ASC`.
10.  Search and view the results.
     

## Number of pages in a space

You can track which spaces have the most user engagement by sorting them by the number of pages.

1.  Enter a Note, like Number of pages in a space, to identify the custom search field for future use.
2.  Enter a Field Name, like NumberOfPages.
3.  Select Number for the Value Type.
4.  Select Space for Assign Field To.
5.  Select Example Scripts once the Field Value field appears.
6.  Select Store the number of pages a space has and paste it into the field.
7.  Select Add.
    
8.  Navigate to Search.
    
    To sort the spaces by the number of pages in each one, follow these steps:
    
9.  Enter `type = space ORDER BY NumberOfPages ASC`.
10.  Search and view the results.
