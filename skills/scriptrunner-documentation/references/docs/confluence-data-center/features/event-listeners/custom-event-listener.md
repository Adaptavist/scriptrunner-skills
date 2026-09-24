# Custom Event Listener

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Event Listeners
- Doc ID: doc-sr4c-e26e9558-9d94-4e11-9304-d73748404ffb-5035604515cb6f15
- Source: https://docs.adaptavist.com/sr4c/latest/features#event-listeners--en#custom-event-listener--en

Learn about creating your own Event Listener to suit your needs.

## Add a custom listener

1.  Navigate to General Configuration > ScriptRunner > Event Listeners.
2.  Choose the Custom Event Listener to use your own scripts to respond to events.
3.  Enter an optional Name to identify your script.
4.  Enter a Script, either _Inline_ or from a _File_.
5.  Select Event(s) for the listener to fire on.
6.  Select Add.
    
    You can also Preview to view your results before saving the listener.
    

## Writing code for custom event listeners

### Script binding

The script binding is a set of variables you can use in your custom script. An `event` variable in the script binding corresponds to the event which triggered the listener. For example, if you are listening for `PageCreateEvent` the `event` variable will be a [PageCreateEvent](https://docs.atlassian.com/atlassian-confluence/5.9.6/com/atlassian/confluence/event/events/content/page/PageCreateEvent.html) object.

### Multiple Events

You can choose to have your handler listen for multiple events. If you need to do different things depending on the type of event, you can check that with `instanceof`. Alternatively, you can type the `event` variable to the most specific superclass. In the previous example, that would be [PageEvent](https://docs.atlassian.com/atlassian-confluence/6.2.3/com/atlassian/confluence/event/events/content/page/PageEvent.html) .

In the following example, the `event` is getting page content for both `PageCreateEvent` and `PageUpdateEvent`. Since `PageEvent` is a common superclass for both `PageCreateEvent` and `PageUpdateEvent`, you could cover both events by using the following code:

```
// The event is passed in the binding. This line is only used to give type information when using an IDE, and has no functional impact.
def event = event as PageEvent
def content = event.content.bodyAsString

// do something with the page content
```

## Examples

### Add a comment when a banned word is used

Some organizations have a particular style guide or would like to enforce specific rules. This event listener example looks at the content of new pages for banned words. If the page content contains any on a list of banned words, a comment is automatically added with an alternative suggestion.

Follow these steps to create the listener:

1.  Navigate to General Configuration > ScriptRunner > Event Listeners.
2.  Select Custom Event Listener.
3.  Enter Add a comment when a banned word is used for Name.
4.  Enter the following Script:
    
    ```
    import com.atlassian.confluence.event.events.content.page.PageEvent
    import com.atlassian.confluence.pages.CommentManager
    import com.atlassian.sal.api.component.ComponentLocator
    
    def event = event as PageEvent
    // use event.getPage().getSpace() if you want to restrict only to certain spaces
    
    def commentManager = ComponentLocator.getComponent(CommentManager)
    def body = event.content.bodyAsString
    
    def alternatives = [
        "air hostess": "flight attendant",
        "amuck"      : "amok",
    ]
    
    def commentBody = alternatives.findAll { badWord, goodWord ->
        body.contains(badWord)
    }.collect { badWord, goodWord ->
        "<li><b>${badWord}</b> should be avoided. Consider using: <b>${goodWord}</b>.</li>"
    }.join("")
    
    if (commentBody) {
        commentManager.addCommentToObject(event.content, null, "<p>Please consider the following issues: <ul>$commentBody</ul> </p>")
    }
    ```
    
5.  Leave Events blank because the event is defined in the code.
6.  Select Add.

The following image contains a comment generated in response to a banned word:

Tip: In practice, you would also want to watch page updates and only look at the diff between old and new versions.

### Add an inline comment when a banned word is used

Similar to the previous example, you can configure your listener to add inline comments instead. As you get these comments, you can dismiss them.

Follow these steps to create the listener:

1.  Navigate to General Configuration > ScriptRunner > Event Listeners.
2.  Select Custom Event Listener.
3.  Enter Add an inline comment when a banned word is used for Name.
4.  Enter the following Script:
    
    ```
    import com.atlassian.confluence.core.DefaultSaveContext
    import com.atlassian.confluence.event.events.content.page.PageEvent
    import com.atlassian.confluence.pages.CommentManager
    import com.atlassian.confluence.plugins.highlight.SelectionStorageFormatModifier
    import com.atlassian.confluence.plugins.highlight.model.TextSearch
    import com.atlassian.confluence.plugins.highlight.model.XMLModification
    import com.atlassian.sal.api.component.ComponentLocator
    import com.onresolve.scriptrunner.runner.customisers.PluginModule
    import com.onresolve.scriptrunner.runner.customisers.WithPlugin
    
    import java.time.LocalDateTime
    
    import com.atlassian.confluence.pages.Comment
    
    def commentManager = ComponentLocator.getComponent(CommentManager)
    
    @PluginModule
    @WithPlugin("com.atlassian.confluence.plugins.confluence-highlight-actions")
    SelectionStorageFormatModifier selectionStorageFormatModifier
    
    event = event as PageEvent
    
    def alternatives = [
        "air hostess": "flight attendant",
        "amuck"      : "amok",
    ]
    
    /**
     * find occurrence of word in a String
     */
    Integer keyFinder(String pageBody, String key) {
        def keyToFind = /$key/
        def keyFinder = (pageBody =~ /$keyToFind/)
        keyFinder.count
    }
    
    def inlineCommentMarker = { markerRef ->
        "<ac:inline-comment-marker ac:ref=\"${markerRef}\"></ac:inline-comment-marker>"
    }
    
    def commentTemplate = { String word ->
        "<p>Please use <b>${word}</b> instead</p>"
    }
    
    alternatives.each { badWord, goodWord ->
        def matches = keyFinder(event.content.bodyAsString, badWord)
    
        if (matches == 0) {
            log.warn("Word \"${badWord}\" not found.")
            return
        }
    
        (0..matches - 1).each { matchIndex ->
            def generatedMarkerRef = UUID.randomUUID().toString()
    
            // highlight text in the content
            selectionStorageFormatModifier.markSelection(
                event.page.id,
                event.timestamp,
                new TextSearch(badWord, matches, matchIndex),
                new XMLModification(inlineCommentMarker(generatedMarkerRef))
            )
    
            // add an inline comment related to the highlighted text
            def comment = commentManager.addCommentToObject(event.page, null, commentTemplate(goodWord)).tap {
                setInlineComment(true)
                delegate.getProperties().setStringProperty(Comment.MARKER_REF_PROP, generatedMarkerRef)
                delegate.getProperties().setStringProperty(Comment.ORIGINAL_SELECTION_PROP, badWord)
                setLastModificationDate(LocalDateTime.now().toDate())
            }
            commentManager.saveContentEntity(comment, DefaultSaveContext.DEFAULT)
    
            log.warn("Found word \"${badWord}\". Inline commented with word \"${goodWord}\"")
        }
    }
    ```
    
5.  Leave Events blank because the event is defined in the code.
6.  Select Add.

The following image is an example of an inline comment:

### Create a page in a space when a user is created

This event listener example automatically creates a user profile page in the _Team_ space. You can use this profile page to list their skills and profile.

Follow these steps to create the listener:

1.  Navigate to General Configuration > ScriptRunner > Event Listeners.
2.  Select Custom Event Listener.
3.  Enter Create a page in space when a user is created for Name.
4.  Enter the following Script:
    
    ```
    import com.atlassian.confluence.core.DefaultSaveContext
    import com.atlassian.confluence.event.events.user.UserCreateEvent
    import com.atlassian.confluence.pages.Page
    import com.atlassian.confluence.pages.PageManager
    import com.atlassian.confluence.spaces.SpaceManager
    import com.atlassian.confluence.user.ConfluenceUser
    import com.atlassian.sal.api.component.ComponentLocator
    import groovy.xml.MarkupBuilder
    
    try {
        def event = event as UserCreateEvent
        def user = event.user as ConfluenceUser
        def pageManager = ComponentLocator.getComponent(PageManager)
    
        def spaceManager = ComponentLocator.getComponent(SpaceManager)
        def teamSpace = spaceManager.getSpace("TEAM")
    
        def writer = new StringWriter()
        def builder = new MarkupBuilder(writer)
        builder.table {
            tbody {
                tr {
                    td("About")
                    td {
                        "ac:link" {
                            "ri:user"("ri:userkey": user.key)
                        }
                    }
                }
                tr {
                    td("Profile")
                    td("")
                }
                tr {
                    td("Skillz")
                    td("")
                }
            }
        }
    
        def parentPage = teamSpace.getHomePage()
        assert parentPage
    
        def targetPage = new Page(title: "About ${user.fullName}",
            bodyAsString: writer.toString(),
            space: teamSpace,
            parentPage: parentPage
        )
        pageManager.saveContentEntity(targetPage, DefaultSaveContext.DEFAULT)
        parentPage.addChild(targetPage)
        pageManager.saveContentEntity(parentPage, DefaultSaveContext.MINOR_EDIT)
    }
    catch (anyException) {
        log.warn("Failed to create page for new user", anyException)
    }
    ```
    
5.  Pick UserCreateEvent for Events.
6.  Select Add.

The following image is an example of a profile page created when the _jbloggs_ user is created:

### Collect stats

This event listener example automatically sends statistics to [statsd](https://github.com/etsy/statsd) for page views, space views, and users/pages views.

Follow these steps to create the listener:

1.  Navigate to General Configuration > ScriptRunner > Event Listeners.
2.  Select Custom Event Listener.
3.  Enter Collect stats for Name.
4.  Enter the following Script:
    
    ```
    import com.atlassian.confluence.event.events.content.page.PageEvent
    import com.atlassian.confluence.user.AuthenticatedUserThreadLocal
    import groovy.transform.Field
    
    @Field final def host = "http://192.168.59.103/"
    @Field final def port = 8125
    
    def event = event as PageEvent
    def currentUser = AuthenticatedUserThreadLocal.get()
    
    // keys to create unique nodes for counters
    def spaceKey = event.page.spaceKey
    def pageId = event.page.id as String
    def userKey = currentUser.name
    def nodeId = "confluence.stats.views"
    
    // build the unique metric keys
    def pageViewMetricKey = "${nodeId}.page.${pageId}"
    def spaceViewMetricKey = "${nodeId}.space.${spaceKey}"
    def userViewMetricKey = "${nodeId}.user.${userKey}.${pageId}"
    
    // increase by one the counters for the following metric keys
    increaseByOne(pageViewMetricKey, userViewMetricKey, spaceViewMetricKey)
    
    void increaseByOne(String... keys) {
        def dataToSend = ""
        def value = 1 //increase counter by one
    
        //syntax for counter according to https://github.com/etsy/statsd/blob/master/docs/metric_types.md
        for (key in keys) {
            dataToSend += "${key}:${value}|c
    "
        }
    
        def data = dataToSend.getBytes()
        def address = InetAddress.getByName(host as String)
        def packet = new DatagramPacket(data, data.length, address, port as int)
        def socket = new DatagramSocket()
        try {
            socket.send(packet)
        } finally {
            socket.close()
        }
    }
    ```
    
5.  Pick PageViewEvent for Events.
6.  Select Add.

The following image is an example of the statistics for page views:

Note: In the example, [Grafana](http://grafana.org/) is used to visualize page views metrics.
