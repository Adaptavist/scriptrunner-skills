# Script Console

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features
- Doc ID: doc-sr4c-bbe29917-b68b-401a-8fa2-1cdeec5277c1-5f1cbf71fb61552d
- Source: https://docs.adaptavist.com/sr4c/latest/features#script-console--en

Use the _Script Console_ to run one-off ad hoc scripts and to learn and experiment with the Confluence API.

You can type your script directly into the browser or click the File tab, where you type the path to a file. The file can be a fully qualified pathname to a .groovy file that is accessible to the server. If you provide a relative pathname, the file is resolved relative to your script roots. By default, there is one script root automatically created, `<confluence_home>/scripts/`.

Read more about [script roots](https://docs.adaptavist.com/sr4c/latest/best-practices-and-app-management/script-roots).

## Examples

You can use one of these examples in your instance or modify it to fit a new situation.

### Enumerate All Public Spaces

Use the following code to return all names of all global spaces:

```
import com.atlassian.confluence.spaces.SpaceManager
import com.atlassian.sal.api.component.ComponentLocator

def spaceManager = ComponentLocator.getComponent(SpaceManager)
spaceManager.allSpaces.findAll {
    it.isGlobal()
}.collect {
    it.name
}
```

### List Pages and Authors Across Spaces

Use the following code to find all spaces, pages, and authors for all spaces in the Confluence instance.

This example is limited to three spaces and ten pages because it's not practical to hold all this information in a string for large instances.

The code returns a `Map`, where the keys are the `Space` objects and the values are a list of `Page` objects.

1.  Use the following code to find all spaces, pages, and authors for all spaces in the Confluence instance.
    
    ```
    import com.atlassian.confluence.pages.Page
    import com.atlassian.confluence.pages.PageManager
    import com.atlassian.confluence.spaces.Space
    import com.atlassian.confluence.spaces.SpaceManager
    import com.atlassian.sal.api.component.ComponentLocator
    import groovy.xml.MarkupBuilder
    
    def spaceManager = ComponentLocator.getComponent(SpaceManager)
    def pageManager = ComponentLocator.getComponent(PageManager)
    
    def spaces = spaceManager.allSpaces.findAll { it.isGlobal() }.take(3) // <1>
    
    Map<Space, List<Page>> pagesInfo = spaces.collectEntries { space ->
    
        [
            (space): pageManager.getPages(space, true).findAll {
                it instanceof Page
            }.take(10) //<2>
        ]
    }
    ```
    
    Line 12: Gets the first three spaces in this Confluence instance
    
    Line 18: Gets page information for up to ten pages for each space
    
    CAUTION: This example is limited to three spaces and ten pages because it's not practical to hold all this information in a string for large instances.
    
2.  To view this data in a more organized way, format the data into a table by appending this code to the example code above:
    
    ```
    def writer = new StringWriter()
    def builder = new MarkupBuilder(writer)
    
    builder.table(class: "aui") {
        thead {
            tr {
                th("Space")
                th("Page")
                th("Author")
            }
        }
    
        tbody {
            pagesInfo.each { space, pages ->
    
                if (pages.size() > 0) {
    
                    pages.each { page ->
                        tr {
                            th {
                                b(space.name)
                            }
                            td(page.title)
                            td(page.creator?.name ?: "N/A")
                        }
                    }
                }
            }
        }
    }
    
    writer.toString()
    ```
    
    When you click Run, your screen should appear like this:
    

### Disable Inactive Users

Warning: Test all potentially wide-ranging operations like this in a staging environment first.

Use the following code to disable all the users who are inactive for the last three months.

```
import com.atlassian.confluence.security.PermissionManager
import com.atlassian.confluence.security.login.LoginManager
import com.atlassian.confluence.user.UserAccessor
import com.atlassian.sal.api.component.ComponentLocator
import com.atlassian.user.UserManager
import groovy.time.TimeCategory

def userManager = ComponentLocator.getComponent(UserManager)
def userAccessor = ComponentLocator.getComponent(UserAccessor)
def loginManager = ComponentLocator.getComponent(LoginManager)
def permissionManager = ComponentLocator.getComponent(PermissionManager)

def threeMonthsBack
use(TimeCategory) {
    threeMonthsBack = 3.months.ago // <1>
}
def users = userManager.users // <2>

def page = users.currentPage

while (true) {

    page.each { user ->

        if (userAccessor.isDeactivated(user)) {
            return
        }

        log.debug(user)
        def userLoginInfo = loginManager.getLoginInfo(user) // <3>
        def lastSuccessfulLoginDate = userLoginInfo?.lastSuccessfulLoginDate

        def toDeactivate = !lastSuccessfulLoginDate || lastSuccessfulLoginDate < threeMonthsBack // <4>
        if (toDeactivate) {
            log.warn "Found user: ${user.name} with last login date ${lastSuccessfulLoginDate}, will deactivate"
            return // <5>

            if (!permissionManager.isSystemAdministrator(user)) { // <6>
                log.info "Deactivating user.."
                userAccessor.deactivateUser(user)
            }
        }
    }

    if (users.onLastPage()) {
        return
    } else {
        users.nextPage()
    }
}
```

Line 15: Selects a date three months prior to today.

Line 17: Gets all the users.

Line 30: Gets login information for a specific user to get the last successful login date.

Line 33: Compares the two dates to see whether the user is inactive for the last three months, or if they have never logged in.

Line 36: Prints the message. You can remove this `return` statement to actually disable the messages.

Line 38: Disables the user if the user is required and not a system administrator.

Warning: The script takes a while to execute if you have a large user base.

### Add/Remove User from Group

The following example shows how to add or remove users from Confluence groups. In this example, a group called `deactivated users` is created. You could combine this code with the example code above to move all deactivated users to a group for easy identification.

Use the following code to add or remove users from Confluence groups.

```
import com.atlassian.confluence.user.UserAccessor
import com.atlassian.sal.api.component.ComponentLocator
import com.atlassian.user.GroupManager

def groupManager = ComponentLocator.getComponent(GroupManager)
def userAccessor = ComponentLocator.getComponent(UserAccessor)

def inactiveGroup = groupManager.getGroup("Deactivated users") ?: groupManager.createGroup("Deactivated users") // <1>

def usersToMove = ["anuser", "u100"] // <2>

usersToMove.each { username ->

    def user = userAccessor.getUserByName(username)

    if (user) {
        log.info "Removing user ${user.name} from confluence-users"
        def confUsersGroup = groupManager.getGroup("confluence-users")
        groupManager.removeMembership(confUsersGroup, user) // <3>

        log.info "Add user ${user.name} to the group: 'Deactivated Users'"
        groupManager.addMembership(inactiveGroup, user) // <4>
    }
}
```

Line 8: Creates a new user group, _Deactivated Users,_ if it does not exist

Line 10: Defines the hard-coded list of users to modify

Line 19: Removes group membership for the user

Line 22: Adds the user to the group created in step one
