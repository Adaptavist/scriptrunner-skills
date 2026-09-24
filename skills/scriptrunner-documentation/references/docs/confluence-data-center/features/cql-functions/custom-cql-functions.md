# Custom CQL Functions

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > CQL Functions
- Doc ID: doc-sr4c-78505bea-6a3b-4d69-9a66-d87680ab1ab8-a2193bafbe3cc82d
- Source: https://docs.adaptavist.com/sr4c/latest/features#cql-functions--en#custom-cql-functions--en

Using custom CQL functions in ScriptRunner for Confluence allows you to create and share custom CQL functions (values) with your users to empower their search.

For a large instance, some queries could include multiple CQL statements that could get complicated very fast. Creating this custom function would allow your users to use it and perform a basic CQL query.

Tip: For help with CQL, visit [CQL Guide](https://docs.adaptavist.com/sr4c/latest/get-started/cql-guide).

## Create a custom CQL Function

To create a custom CQL function, follow these steps:

1.  Navigate to General Configuration > ScriptRunner > CQLFunctions.
2.  Select Create CQL Function.
3.  Select Custom CQL Function.
4.  Fill out the following fields:
    
    -   Name: This is a mandatory field used as the CQL function display name. It should respect the [list of reserved words and characters](https://developer.atlassian.com/confdev/confluence-server-rest-api/advanced-searching-using-cql/cql-function-reference#CQLFunctionReference-charactersReservedCharacters) .
    -   Note: This is an optional field, used only for your reference and not used internally. This is where you can describe what the function does.
    -   Number of Parameters: This determines the number of parameters accepted by the CQL Function. For example, enter 1 if you want the user to provide only the space key.
    -   Type: This specifies if the CQL Function returns a single string value or a list of strings.
        -   Single value: This type should return a single String value, which will be the value that the query function will be transformed into. This appears as a single quoted value following the operator in the CQL statement being executed.
            
            Example: `= pagesWithLabel`
            
        -   Multi value: This type should return an Iterable of String values, which will be the values that the query function will be transformed into. This appears within the parentheses following the IN clause in the CQL statement being executed.
            
            Example: = `pagesWithLabel("finance")`
            
    -   Script file: If you have the script in a file, use this to enter the path accessible by the server.
    -   Inline script: This is where we define what the CQL functions return based on the input.
    
    Note: Binding Variables
    
    There are two binding variables available in the CQL Function script:
    
    -   `params` : Parameters passed into the Query Function in the CQL statement being executed
    -   `context` : The class definition of the object that is passed as the context argument to the invoke method of a Query Function
    
5.  Select Add to create the function.

The new custom CQL functions will appear here:

And you can use them when performing CQL searches or using the [CQL Search Macro](https://docs.adaptavist.com/sr4c/latest/features/macros/create-custom-macro/cql-search-macro) macro.

## Custom CQL Function example

Return attachments within a specified space

In this example, you'll create a simple CQL function that will return attachments within a specified space. To start, follow these steps:

1.  Navigate to General Configuration > ScriptRunner > CQL Functions.
2.  Select Create CQL Function.
3.  Select Custom CQL Function.
4.  Enter spaceAttachements for Name.
5.  Enter Returns attachments within a specified space for Note.
6.  Enter 1 for Number of Parameters.
    
    Since we want the user to enter only the space key, the value is _1_.
    
7.  Pick Multi Value for Type.
    
    We're using _Multi Value_ because the function returns a list of attachments.
    
8.  Enter this script for Inline Script.
    
    ```
    import com.atlassian.confluence.pages.Attachment
    import com.atlassian.confluence.pages.AttachmentManager
    import com.atlassian.confluence.pages.Page
    import com.atlassian.confluence.pages.PageManager
    import com.atlassian.confluence.spaces.Space
    import com.atlassian.confluence.spaces.SpaceManager
    import com.atlassian.sal.api.component.ComponentLocator
     
    def attachmentManager = ComponentLocator.getComponent(AttachmentManager)
    def spaceManager = ComponentLocator.getComponent(SpaceManager)
    def pageManager = ComponentLocator.getComponent(PageManager)
    def names = []
     
    String spacekey = params[0]
    Space space = SpaceManager.getSpace(spaceKey)
    for (Page page : pageManager.getPages(space, true)) { 
        for (Attachment attachment : attachmentManager.getLatestVersionsOfAttachments(page)) { 
            names << attachment.getFileName()
        }
    }
     
    return names
    ```
    
9.  Select Add to create the function.

Once the function is created it's possible to retrieve the output using the ScriptRunner macro [CQL Search Macro](https://docs.adaptavist.com/sr4c/latest/features/macros/create-custom-macro/cql-search-macro). Use the query `title in spaceAttachments("ds")` to retrieve the name of all attachments in the DS (Demonstration Space). You can replace "DS" with whatever your space is named.

## Custom CQL Function example with included code

The following examples use code that is included with ScriptRunner for Confluence.

### Search page by label

If you create this custom CQL function, you can return all pages that contain a specified label. To set up this CQL function, follow these steps:

1.  Navigate to General Configuration > ScriptRunner > CQL Functions.
2.  Select Create CQL Function.
3.  Select Custom CQL Function.
4.  Enter pagesWithLabel for Name.
5.  Enter Returns all pages with a certain label for Note.
6.  Enter 1 for Number of Parameters.
7.  Pick Multi Value for Type.
8.  Select Example Scripts, and then choose Pages with a certain label.
    
    Note: Alternatively, here is the code for this custom CQL function:
    
    ```
    import com.atlassian.confluence.labels.Label
    import com.atlassian.confluence.pages.Page
    import com.atlassian.confluence.pages.PageManager
    import com.atlassian.confluence.spaces.Space
    import com.atlassian.confluence.spaces.SpaceManager
    import com.atlassian.sal.api.component.ComponentLocator
    
    def spaceManager = ComponentLocator.getComponent(SpaceManager)
    def pageManager = ComponentLocator.getComponent(PageManager)
    String label = params[0] // <1>
    def ids = []
    
    for (Space space : spaceManager.getAllSpaces()) { // <2>
        for (Page page : pageManager.getPages(space, true)) { // <3>
            for (Label pageLabel : page.getLabels()) { // <4>
                if (pageLabel.getName().equalsIgnoreCase(label)) {
                    ids << String.valueOf(page.getId()) // <5>
                }
            }
        }
    }
    return ids
    ```
    
    Line 10: Getting the label input value
    
    Line 13: Iterating over all spaces
    
    Line 14: Iterating over all pages
    
    Line 15: Iterating over all labels
    
    Line 17: Adding the page ID if a label matches the input
    
    :
    
9.  Select Add to create the function.

Once the function is created, you can use it with the [CQL Search Macro](https://docs.adaptavist.com/sr4c/latest/features/macros/create-custom-macro/cql-search-macro) macro. A CQL query that you could use with the function is `content in pagesWithLabel("finance")` to retrieve all pages with a label in a _Finance_ space, for example. You can replace "Finance" with whatever your space is named.

### Return all pages linked to a specific page

If you create this custom CQL function, you can return all the linked pages associated with the specified page. To set up this CQL function, follow these steps:

1.  Navigate to General Configuration > ScriptRunner > CQL Functions.
2.  Select Create CQL Function.
3.  Select Custom CQL Function.
4.  Enter linkedPages for Name.
5.  Enter Returns all linked pages for Note.
6.  Enter 2 for Number of Parameters.
7.  Pick Multi Value for Type.
8.  Select Example Scripts, and then choose Linked pages for a space and page.
    
    Note: Alternatively, here is the code for this custom CQL function:
    
    ```
    import com.atlassian.confluence.links.OutgoingLink
    import com.atlassian.confluence.pages.Page
    import com.atlassian.confluence.pages.PageManager
    import com.atlassian.confluence.spaces.Space
    import com.atlassian.confluence.spaces.SpaceManager
    import com.atlassian.sal.api.component.ComponentLocator
    
    String spaceKey = params[0]
    String pageTitle = params[1]
    
    SpaceManager spaceManager = ComponentLocator.getComponent(SpaceManager)
    PageManager pageManager = ComponentLocator.getComponent(PageManager)
    def ids = []
    
    Space space = spaceManager.getSpace(spaceKey)
    
    for (Page page : pageManager.getPages(space, true)) {
    
        for (OutgoingLink link : page.getOutgoingLinks()) {
            if (link.getDestinationPageTitle().equals(pageTitle) && link.getDestinationSpaceKey().equals(spaceKey)) { // <4>
                ids << String.valueOf(page.getId())
            }
        }
    }
    
    return ids
    ```
    
    Line 9: Getting the space key and target page title from the inputs
    
    Line 18: Iterating over all pages in the space
    
    Line 20: Iterating over all outgoing links from a page
    
    Line 21: Adding the page ID if the outgoing link matches both the space key and the target page title
    
9.  Select Add to create the function.

Once the function is created, you can use it with the [CQL Search Macro](https://docs.adaptavist.com/sr4c/latest/features/macros/create-custom-macro/cql-search-macro) macro. A CQL query that you could use with the function is `content in linkedPages("ds", "Welcome to Confluence")`. You can replace the space and title with what is in your instance.

### Return all pages using a specific macro

If you create this custom CQL function, you can return all the pages that are using any macro of a specified add-on. To set up this CQL function, follow these steps:

1.  Navigate to General Configuration > ScriptRunner > CQL Functions.
2.  Select Create CQL Function.
3.  Select Custom CQL Function.
4.  Enter addOnPages for Name.
5.  Enter Return all add-on pages for Note.
6.  Enter 1 for Number of Parameters.
7.  Pick Multi Value for Type.
8.  Select Example Scripts and then choose Pages containing macros from a certain add-on.
    
    Note: Alternatively, here is the code for this custom CQL function:
    
    ```
    import com.atlassian.confluence.macro.browser.MacroMetadataSource
    import com.atlassian.confluence.pages.Page
    import com.atlassian.confluence.pages.PageManager
    import com.atlassian.confluence.search.v2.ContentSearch
    import com.atlassian.confluence.search.v2.ISearch
    import com.atlassian.confluence.search.v2.InvalidSearchException
    import com.atlassian.confluence.search.v2.SearchConstants
    import com.atlassian.confluence.search.v2.SearchManager
    import com.atlassian.confluence.search.v2.SearchResult
    import com.atlassian.confluence.search.v2.SearchResults
    import com.atlassian.confluence.search.v2.query.MacroUsageQuery
    import com.atlassian.plugin.ModuleDescriptor
    import com.atlassian.plugin.Plugin
    import com.atlassian.plugin.PluginAccessor
    import com.atlassian.sal.api.component.ComponentLocator
    import com.google.common.base.Function
    import com.google.common.base.Predicate
    import com.google.common.collect.Collections2
    import com.google.common.collect.ImmutableList
    import com.google.common.collect.Lists
    import com.google.common.collect.Ordering
    
    import javax.annotation.Nullable
    
    def pluginManager = ComponentLocator.getComponent(PluginAccessor)
    PageManager pageManager = ComponentLocator.getComponent(PageManager)
    
    String addOnKey = params[0]
    Plugin plugin = pluginManager.getPlugin(addOnKey) // <1>
    assert plugin: "Add-on with key '${addOnKey}' not found"
    
    List<String> pluginMacros = getMacroModuleKeys(plugin) // <2>
    
    List<SearchResult> searchResults = findAbstractPagesContainingMacro(pluginMacros) // <3>
    
    def ids = []
    for (final SearchResult searchResult : searchResults) { // <4>
        Page page = pageManager.getPage(searchResult.getSpaceKey(), searchResult.getDisplayTitle())
        ids << String.valueOf(page.getId())
    }
    
    return ids
    
    private List<String> getMacroModuleKeys(Plugin plugin) {
        if (plugin == null) {
            return Collections.emptyList()
        }
    
        final Collection<ModuleDescriptor<?>> moduleDescriptors = plugin.getModuleDescriptors()
    
        final Collection<ModuleDescriptor<?>> macroModuleDescriptors = Collections2.filter(moduleDescriptors, new Predicate<ModuleDescriptor<?>>() {
            boolean apply(@Nullable ModuleDescriptor<?> moduleDescriptor) {
                return moduleDescriptor instanceof MacroMetadataSource
            }
        })
    
        final Function<ModuleDescriptor<?>, String> getKeyFunction = new Function<ModuleDescriptor<?>, String>() {
            String apply(ModuleDescriptor<?> moduleDescriptor) {
                return moduleDescriptor.getKey()
            }
        }
    
        final Function<ModuleDescriptor<?>, String> getNameFunction = new Function<ModuleDescriptor<?>, String>() {
            String apply(ModuleDescriptor<?> moduleDescriptor) {
                return moduleDescriptor.getName()
            }
        }
    
        final List<ModuleDescriptor<?>> sortedMacroModuleDescriptors = Ordering.natural().onResultOf(getNameFunction).immutableSortedCopy(macroModuleDescriptors)
    
        return Lists.transform(sortedMacroModuleDescriptors, getKeyFunction)
    }
    
    private List<SearchResult> findAbstractPagesContainingMacro(final List<String> pluginMacros) {
    
        final List<SearchResult> allResults = []
        for (String macroName : pluginMacros) {
            doSearch(macroName, 0, SearchConstants.MAX_LIMIT, allResults)
        }
    
        return ImmutableList.copyOf(allResults)
    }
    
    private void doSearch(
        final String macroName, final int startIndex, final int limit, final List<SearchResult> allResults
    ) {
    
        SearchManager searchManager = ComponentLocator.getComponent(SearchManager)
    
        final ISearch search = new ContentSearch(new MacroUsageQuery(macroName), null, null, startIndex, limit)
        try {
            SearchResults searchResults = searchManager.search(search)
            allResults.addAll(searchResults.getAll())
            if (searchResults.getUnfilteredResultsCount() > (startIndex + limit)) {
                doSearch(macroName, (startIndex + limit), limit, allResults)
            }
        } catch (InvalidSearchException e) {
            // We can't recover from this so we wrap the error in a runtime exception
            throw new RuntimeException("Error searching for pages containing the Forms for Confluence macros", e)
        }
    }
    ```
    
    Line 29: Getting the plugin associated with the key specified
    
    Line 32: Retrieving all the macros associated with the plugin
    
    Line 34: Getting all the pages that are using at least one plugin macro
    
    Line 37: Iterating over the pages to return the list of IDs
    
9.  Select Add to create the function.

Once the function is created, you can use it with the [CQL Search Macro](https://docs.adaptavist.com/sr4c/latest/features/macros/create-custom-macro/cql-search-macro) macro. A CQL query that you could use with the function is `content in addOnPages("com.adaptavist.confluence.formMailNG")`.

Note: The function retrieves the add-on macros defined in the plugin descriptor.
