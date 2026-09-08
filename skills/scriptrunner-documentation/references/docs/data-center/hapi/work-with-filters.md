# Work with Filters

- Platform: data-center
- Space: SR4JS
- Hierarchy: hapi
- Doc ID: doc-sr4js-442887539
- Source: https://docs.adaptavist.com/sr4js/latest/hapi/work-with-filters

With HAPI we've made it easy for you to work with filters.

## Finding filters

With HAPI, you can retrieve all filters with a given **name** or return a specific filter using a **name** and **owner** combination or the filter **id**. Once you have the filter, you can use it with our [issue search methods](https://docs.adaptavist.com/sr4js/latest/hapi/work-with-filters#search), as demonstrated below.

### Find a filter you own by name

You can find a filter that you own as follows:

```
        def myFilter = Filters.getMyFilterByName('My Filter')
```

### Find a filter by name and owner

You can find a filter shared with you from another user as follows:

```
        def user = Users.getByName('johndoe')
        def johnsSharedFilter = Filters.getByName("John's Filter", user)
```

### Find all filters with a given name

You can find a list of filters with the same name and then further filter that list to return only the filters you want. For example, find all the filters shared with all logged-in users:

```
        // Get all filters with a given name and find only those shared with any logged-in user
        def sharedWithAnyLoggedInUsers = Filters.getByName('A Shared Filter').findAll { filter ->
            filter.permissions.authenticated
        }
```

### Find all filters

You can retrieve all the filters accessible to you as follows:

```
        def allFilters = Filters.getAll()
```

You can then filter the result to return only the filters you care about. For example, you could get all filters shared with a specific group:

```
        import com.atlassian.jira.sharing.type.ShareType
        
        def allFilters = Filters.getAll()
        
        // Find filters shared with a specific group
        allFilters.findAll { filter ->
            filter.getPermissions().any { permission ->
                permission.getType() == ShareType.Name.GROUP 
                    && permission.getParam1() == Groups.getByName('abc-group').name
            }
        }
```

### Finding a filter by ID

You can find a filter by ID as follows:

To get the filter ID, go to **Issues > Manage filters**, open the filter you want, and the filter ID is in the URL (for example /jira/browse/SSPA-1?filter=**10000**)

```
        def myFeaturesFilter = Filters.getById(10001)
```

## Searching with a filter

You can search for issues using a filter. For example, you have already created a JQL query and saved it as a filter. You now want to run the filter and use the `[issue.update](https://docs.adaptavist.com/sr4js/latest/hapi/update-issues)` method to set a comment on all returned issues.

In this example we're returning all issues of a saved filter. 

Where the example says "do something with each issue", you can, for example, update all returned issues using the `[issue.update](https://docs.adaptavist.com/sr4js/latest/hapi/update-issues)` method.

```
            def filter = Filters.getMyFilterByName('My Private Filter')
            
            Issues.search(filter).each { issue ->
                // do something with each issue
            }
```

![Image showing how to search with a filter](/sr4js/files/latest/442887539/442887557/1/1758746822000/Searching_with_filter.png)

## Counting issues with a filter

You can count the number of issues returned by a filter. For example:

```
            def user = Users.getByName('johndoe')
            def filter = Filters.getByName("John's Shared Bugs Filter", user)
             
            def issueCount = Issues.count(filter)
```

![Image showing how to count issues with a filter](/sr4js/files/latest/442887539/442887566/1/1758746823000/Count_issues_filter.png)

## Checking if an issue matches a filter

You can check if an issue matches your filter. The script returns true if the issue is included in the issues returned by your filter. For example:

```
            def user = Users.getByName('janedoe')
            def filter = Filters.getByName("Jane's Shared Filter", user)

            def issue = Issues.getByKey('ABC-1')
            issue.matches(filter)
```

  

* * *

## Related content

-   [Javadocs link](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/8.10.0/hapi/jira/groovydoc/com/adaptavist/hapi/jira/jql/Filters.html)
-   [Update Fields](https://docs.adaptavist.com/sr4js/latest/hapi/update-fields)
-   [Search for Issues](https://docs.adaptavist.com/sr4js/latest/hapi/search-for-issues)
