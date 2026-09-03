# Custom Picker

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > script-fields > built-in-script-fields
- Doc ID: doc-sr4js-288523298
- Source: https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/custom-picker

Use a _Custom Picker_ field to set up a field that allows users to pick values from a list. It is similar to the _Database, LDAP_, and _Issue Picker_ script fields, but it is not specialized for any particular case.

For example, you can set up a custom picker to pick a Jira object such as a **Version**, **User**, or **Component** when you want custom selection criteria that are not available when using the native field types. Or you may want to utilize it when picking from a list that can be searched using a REST API.

At a minimum, you need to provide code for handling the following:

1.  Returning a list of objects when the user opens the drop-down, and when they type text for searching.
2.  Converting from the "object" to an option in the drop-down. This is where you select the object's unique ID that is stored in the Jira database.
3.  Given the ID that is stored, convert back to the "object".
4.  Rendering the "object".

The "object" in the above example differs depending on what type of structure this field represents. In the case of a version picker, it will be a [com.atlassian.jira.project.version.Version](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/project/version/Version.html). For a user, it should be a [com.atlassian.jira.user.ApplicationUser](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/user/ApplicationUser.html) etc. When picking from a rest resource, it will generally be a Map.

## Custom picker example

### Country Picker

In this example, users can select a country from a REST resource that provides geographical data.

We use [https://restcountries.com/](https://restcountries.com/) as our example resource for this scenario.

Before starting the implementation of a REST resource picker, the following needs to be established:

1.  That we can search by name. For example, [https://restcountries.com/v2/name/united](https://restcountries.com/v2/name/united).
2.  That we can get the first number of records for when the user opens the drop-down and does not type anything. In this case, we can use [https://restcountries.com/v2/all](https://restcountries.com/v2/all). 
3.  That each object has a unique identifier, and that we can look up the object by this unique identifier. For example, countries have a unique 3-character ID, e.g. GBR, and we can get this country from the ID. For example, [https://restcountries.com/v2/alpha/GBR](https://restcountries.com/v2/alpha/GBR) to retrieve the United Kingdom. 

Once we have tested all the above in the browser, we can start coding. 

The following example can be accessed from the **Snippets** menu under the configuration script.

We recommend you start with one of the working examples and adjust it before implementing your own.

```
import com.onresolve.scriptrunner.canned.jira.fields.model.PickerOption
import groovyx.net.http.ContentType
import groovyx.net.http.HTTPBuilder
import groovyx.net.http.Method

// Create an HTTPBuilder instance - all URLs below are relative to this base URL
HTTPBuilder getHttpBuilder() {
    new HTTPBuilder("https://restcountries.com/")
}

/*
    Search is called when the user opens the drop-down, and when they start typing.

    `inputValue` will contain what they type to search through the list. It may be an empty string.

    This should return a Collection of "objects", e.g. Version, ApplicationUser - in this case we will return a Map.
 */
search = { String inputValue ->
    httpBuilder.request(Method.GET, ContentType.JSON) {

        // If inputValue is not empty then use the search URL, otherwise get `/all`
        uri.path = inputValue ?
            "v2/name/${inputValue}" :
            'v2/all'

        // This resource allows us to choose to return only the fields that we are interested in.
        // For the drop-down we only need the name and the unique ID
        uri.query = [fields: 'name,alpha3Code']

        response.failure = { null }
    }
}

/*
    `toOption` will be called for each item returned by `search`.

    The first parameter will have the type of whatever object we are representing, in this case Map.
    You are also passed a Closure that can be used to highlight search matches in the display value.

    You must return a com.onresolve.scriptrunner.canned.jira.fields.model.PickerOption, with at least `value` and `label` keys.

    The `value` should be a String, and is the unique identifier that is stored in the database.
    We will call `getItemFromId` with this ID to convert back to the "object".

    The `label` value is used for sorting and uniqueness, and will be displayed if the `html` key is not used.

    The `html` value should be used if you want to highlight the matching search term(s) within the result, or include other HTML in the option.

    Optionally, you can include an `icon` key which should be the URL to an icon representing this option.
 */
toOption = { Map<String, String> map, Closure<String> highlight ->
    new PickerOption(
        value: map.alpha3Code,
        label: map.name,

        // The second argument `false` means to highlight the search term even in the middle of the result.
        // Without this, or if this is `true`, only matches at the beginning of words are highlighted.
        html: highlight(map.name, false),
    )
}

/*
    `getItemFromId` is called to convert from the ID back to the object you are representing, in this case a Map.

    If the object no longer exists then you should return null.
 */
getItemFromId = { String id ->
    httpBuilder.request(Method.GET, ContentType.JSON) {
        uri.path = "v2/alpha/$id"
        uri.query = [fields: 'name,region,alpha3Code']

        // In the event that a country is "deleted", this will return 404 and throw an exception - in our case we
        // want to handle that and just return `null`
        response.failure = { null }
    }
}

/*
    `renderItemViewHtml` is called to get the view HTML when viewing an issue.

    In our case we are showing the country name and, in parentheses its region
    (note that we also requested to retrieve the `region` field in `getItemFromId`),
    for example: "Algeria (Africa)".
    You can use HTML in the value to be displayed, and include other information from the object.
 */
renderItemViewHtml = { Map country ->
    "${country.name} (${country.region})"
}

/*
    `renderTextOnlyValue` is called when doing a CSV export or View -> Printable.
    You should not include HTML in output from this closure.
 */
renderItemTextOnlyValue = { Map country ->
    country.name
}
```

![](/sr4js/files/latest/288523298/288523295/1/1726761820000/image2021-8-2_9-19-16.png)

  

[https://restcountries.com](https://restcountries.com) is not related to Adaptavist and we cannot guarantee its uptime. This example is just for instructive and testing purposes. In practice, it does not make sense to use this as a country picker, as ~200 countries could be handled by a Select List. Choosing from a REST resource is most useful when the number of selections is too large for a select list, or subject to change, or have multiple attributes that you might want to display.

### Caching

Retrieving information from REST resources can be expensive. Each time the issue is viewed, the code making the REST request is called in order to get the item; hence it is advisable to cache responses.

As always, with caching, there is a balance between the cache size (limiting the memory consumed by the cached objects), the staleness of objects in the cache, and the cost of reloading new ones.

Because of all these variables, caching is left to the script author. In general, we recommend using either [com.google.common.cache.CacheBuilder](https://guava.dev/releases/26.0-jre/api/docs/com/google/common/cache/CacheBuilder.html) (Google Guava), or [com.atlassian.cache.CacheManager](https://developer.atlassian.com/server/confluence/atlassian-cache-2-overview/), which is a wrapper over the Guava cache.

In the case of the country picker example above, we could set the size to around 250, as there are only ~200 countries in the world. Although it happens, it's not common for countries to be deleted or for them to change names, so we don't need to worry about expiring countries from the cache. 

#### Cache Loader Method

The example below is similar to the previous [country picker example](#id-.CustomPickerv9.x-country-picker-example), except that fetching from the REST resource has been moved from `getItemFromId` into the cache loader method.

The other notable change is that, because Guava cache does not allow null keys or values, the actual value is wrapped in an Optional. This avoids failures if a country has been deleted. Using the web UI, it is not possible for a user to enter a country code that does not exist; however, they could do it using Jira's REST API.

In this case, it would make sense to cache all the countries and search in memory; however, in most cases, it's not practical to load all possible options.

```
import com.google.common.cache.Cache
import com.google.common.cache.CacheBuilder
import com.google.common.cache.CacheLoader
import com.onresolve.scriptrunner.canned.jira.fields.model.PickerOption
import groovyx.net.http.ContentType
import groovyx.net.http.HTTPBuilder
import groovyx.net.http.Method

def httpBuilder = new HTTPBuilder("https://restcountries.com/")

/*
If we wished to expire entries from the cache we could add `.expireAfterWrite(14, TimeUnit.DAYS)` after .newBuilder below
 */
Cache<String, Optional<Map>> cache = CacheBuilder.newBuilder().maximumSize(250).build(new CacheLoader<String, Optional<Map>>() {
    @Override
    Optional<Map> load(String id) throws Exception {
        def country = httpBuilder.request(Method.GET, ContentType.JSON) {
            uri.path = "v2/alpha/$id"
            uri.query = [fields: 'name,region,alpha3Code']

            response.failure = { null }
        } as Map

        Optional.ofNullable(country)
    }
})

search = { String inputValue ->
    def queryParameters = [fields: 'name,region,alpha3Code']

    httpBuilder.request(Method.GET, ContentType.JSON) {
        uri.path = inputValue ?
            "v2/name/${inputValue}" :
            'v2/all'

        uri.query = queryParameters
    }
}

toOption = { Map<String, String> map, Closure highlight ->
    new PickerOption(
        value: map.alpha3Code,
        label: map.name,
        html: "${highlight(map.name, false)} <i>${map.region}</i>",
    )
}

getItemFromId = { String id ->
    // Use the cache here rather than fetch the item every time
    cache.get(id).orElse(null)
}

renderItemViewHtml = { Map country ->
    "${country.name} <i>${country.region}</i>"
}

renderItemTextOnlyValue = { Map country ->
    country.name
}
```

### Disabled vs. Non-Existent

Some thought must be given to what constitutes a valid selection in a custom picker.

In this user picker example, we only want to allow users who are members of either of the _jira-administrators_ or  _jira-system-administrators_ groups.

If an administrator is selected in the picker, and then at a later date removed from the administrator group, that option is disabled in the picker list. This should make that option "disabled." In this case, the issue can be edited with this disabled value without errors, but new issues cannot be created with this disabled value.

In the case of a selected user being "deleted," `getItemFromId` should return `null`. 

The following example introduces a final closure `validate`. This checks the "object" matches the required selection criteria.

Note that `search` should only return items that are valid. In this case, we use [UserSearchService](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/bc/user/search/UserSearchService.html) to filter on only users in those groups. 

```
import com.atlassian.jira.avatar.Avatar
import com.atlassian.jira.bc.user.search.UserSearchParams
import com.atlassian.jira.bc.user.search.UserSearchService
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.user.ApplicationUser
import com.atlassian.jira.user.UserFilter
import com.onresolve.scriptrunner.canned.jira.fields.model.PickerOption

def userSearchService = ComponentAccessor.getComponent(UserSearchService)
def userManager = ComponentAccessor.userManager
def avatarService = ComponentAccessor.avatarService
def authenticationContext = ComponentAccessor.jiraAuthenticationContext
def groupManager = ComponentAccessor.groupManager

def maxResults = 30
def userFilter = new UserFilter(true, null, ['jira-administrators', 'jira-system-administrators'])
def userSearchParams = new UserSearchParams.Builder(maxResults).allowEmptyQuery(true).filter(userFilter).build()

search = { String inputValue ->
    userSearchService.findUsers(inputValue, userSearchParams)
}

/*
 * Retrieve the user from internal storage (we store the key). Return them if they still exist, regardless of
 * their group membership.
 */
getItemFromId = { String id ->
    userManager.getUserByKey(id)
}

/*
 * The user is still "valid" if they are a member of either of the below-mentioned groups, otherwise they become "disabled".
 */
validate = { ApplicationUser user ->
    groupManager.getGroupNamesForUser(user).intersect(['jira-administrators', 'jira-system-administrators'])
}

renderItemViewHtml = { ApplicationUser user ->
    user.displayName
}

renderItemTextOnlyValue = renderItemViewHtml

toOption = { ApplicationUser user, Closure<String> highlight ->
    def remoteUser = authenticationContext.getLoggedInUser()

    new PickerOption(
        value: user.key,
        label: user.displayName,
        html: highlight(user.displayName, false),
        icon: avatarService.getAvatarURL(remoteUser, user, Avatar.Size.SMALL)?.toString()
    )
}
```

## Further Examples

The following additional examples are available in the **Snippets** drop-down under the _Configuration Script_ section.

### Version Picker

This example allows users to pick a non-archived Jira version across projects. This a further example of using `validate` to ensure only the selection of a non-archived **Version**.

Additionally, we customize the display using a lozenge to show the **Version Status**:

![](/sr4js/files/latest/288523298/288523296/1/1726761820000/image2021-8-2_9-52-6.png)

### GitHub Repository Picker

This uses the GitHub REST API to allow the selection of a repository in the _Adaptavist_ organization. This is not a practical example due to the _Rate Limiting_ on the GitHub API. Even when authenticated, you are only allowed a minimal number of calls to the _search_ resource.

## Customizing the Displayed Value

As with the [Issue Picker](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/issue-picker/issue-picker-customizations), HTML can be provided for each selected item in a multi-picker. 

As well as `renderItemViewHtml,` `renderItemColumnViewHtml` can be used to display an abbreviated value when used in the _Issue Navigator,_ along with `renderItemTextOnlyValue` for the plain text value which is used in _History Tab_, email notifications and CSV exports.

For rendering multiple values in a table, use `renderViewHtml`, `renderColumnHtml`, or `renderTextOnlyValue`, in which case a Collection of all selected items will be passed to the closure. `renderItemViewHtml` does not need to be implemented if using this approach.

For example, rendering multiple **Versions** in a table:

```
                import com.onresolve.scriptrunner.canned.util.OutputFormatter

                renderViewHtml = { List<Version> versions ->
                    OutputFormatter.markupBuilder {
                        table(class: 'aui') {
                            thead {
                                tr {
                                    th('Name')
                                    th('Project')
                                    th('Release Date')
                                }                                
                            }
                            tbody {
                                versions.each { version ->
                                    tr {
                                        td(version.name)
                                        td(version.project.name)
                                        td(version.releaseDate)
                                    }
                                }
                            }
                        }
                    }
                }
```

## Definitions

Important information regarding picker configuration closures when writing dynamic logic

We cache the configuration closures you write within the scripts for your pickers to enhance performance; [check out our FAQ](https://docs.adaptavist.com/sr4js/latest/get-help/frequently-asked-questions/script-fields-faq#closure-configuration) for more details.

The following script contains all closures with all possible parameters that you can use and other variables you can set.

Note that when an `Issue` is provided, this is a "live" issue - it reflects changes made in the form during editing. This allows you to change possible selection values based on issue attributes, or indeed the current user roles and groups etc.

```
import com.atlassian.jira.issue.Issue

search = { String inputValue, Issue issue -> }

getItemFromId = { String id -> }

toOption = { Map<String, String> map, Closure<String> highlight, Issue issue ->
    // return a com.onresolve.scriptrunner.canned.jira.fields.model.PickerOption
}

/*
    The following are used for rendering the view in different scenarios.
    For multiple pickers, they will called for each selected item.

    In scripts, you can replace Object with whatever type you return from getItemFromId
*/
renderItemViewHtml = { Object object -> }
renderItemColumnViewHtml = { Object object -> }
renderItemTextOnlyValue = { Object object -> }

/*
 * The following closures can be called to render all selected items, which is useful if you want to present a table for instance.
 *
 * In scripts, you can replace List<Object> with whatever type you return from getItemFromId, for example List<Version>
 *
 * If you implement the closures below, the ones above will not be called. Eg. if you implement `renderViewHtml`,
 * you do not need to implement `renderItemViewHtml`
 */
renderViewHtml = { List<Object> objects -> }
renderColumnHtml = { List<Object> objects -> }
renderTextOnlyValue = { List<Object> objects -> }

// set the maximum number of records to be shown in the drop-down
maxRecordsForSearch = 30

// String used to join multiple values for multiple pickers.
// Not used if you choose to render all items together.
multiValueDelimiter = ', '
```
