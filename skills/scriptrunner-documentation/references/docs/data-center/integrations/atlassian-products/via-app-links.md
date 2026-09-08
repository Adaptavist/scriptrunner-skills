# Via App Links

- Platform: data-center
- Space: SR4JS
- Hierarchy: integrations > atlassian-products
- Doc ID: doc-sr4js-101624691
- Source: https://docs.adaptavist.com/sr4js/latest/integrations/atlassian-products/via-app-links

[Application Links](https://confluence.atlassian.com/display/APPLINKS/Application+Links+Documentation) exist to handle authentication when making calls between applications.

## App Link Configuration

App links can be configured in one of three ways

-   OAuth
    
-   Trusted applications
    
-   Basic authentication
    

However only the first of these is currently recommended by Atlassian, and is the kind we will focus on.

Note that all of the examples provided below also work with _Trusted applications_.

OAuth comes in two flavors: _OAuth authentication_ and _OAuth with impersonation_. Impersonation should only be used where the sets of users on both apps are the same.

If you _can_ enable _OAuth with impersonation_ you should do so, as it allows you to make requests from code on behalf of the user that invoked the function (eg event, workflow function etc), **without any interaction on their behalf**.

The following image shows the outbound configuration the source app, and the inbound configuration for the target app, when two-legged oauth with impersonation is enabled.  
Configuration with 2 legged-oauth

![An example configuration screen for a source app.](/files/101638474/101638789/1/1599763591000/app-links+%281%29.png)

If you create a new reciprocal app link, and check the box confirming that the set of users are the same on both apps, you will get the configuration above.

### Making Requests as the Current User

If you wish to make a remote REST request on behalf of the current user, you can do so using [`com.atlassian.applinks.api.ApplicationLink.createAuthenticatedRequestFactory()`](https://developer.atlassian.com/static/javadoc/applinks/latest/reference/com/atlassian/applinks/api/ApplicationLink.html#createAuthenticatedRequestFactory\(\)). The following example calls a Jira endpoint that returns details of the user making the request, so is useful for experimenting.

This example should work calling Jira from Bitbucket Server, Confluence, and Bamboo. To call another app you should change the endpoint, as this one exists only in Jira. Note also that in Jira you will get the `ApplicationLinkService` using `ComponentAccessor` rather than `ComponentLocator`.  

```
import com.atlassian.applinks.api.ApplicationLinkResponseHandler
import com.atlassian.applinks.api.ApplicationLinkService
import com.atlassian.applinks.api.application.jira.JiraApplicationType
import com.atlassian.sal.api.component.ComponentLocator
import com.atlassian.sal.api.net.Response
import com.atlassian.sal.api.net.ResponseException
import groovy.json.JsonSlurper

import static com.atlassian.sal.api.net.Request.MethodType.GET

def appLinkService = ComponentLocator.getComponent(ApplicationLinkService)
def appLink = appLinkService.getPrimaryApplicationLink(JiraApplicationType) // <1>

def applicationLinkRequestFactory = appLink.createAuthenticatedRequestFactory() // <2>

def request = applicationLinkRequestFactory.createRequest(GET, "/rest/auth/1/session")

def handler = new ApplicationLinkResponseHandler<Map>() {
    @Override
    Map credentialsRequired(Response response) throws ResponseException {
        null
    }

    @Override
    Map handle(Response response) throws ResponseException {
        assert response.statusCode == 200
        new JsonSlurper().parseText(response.getResponseBodyAsString()) as Map // <3>
    }
}

def sessionDetails = request.execute(handler) // <4>
log.debug("Making the request as: " + sessionDetails["name"])
```

**Line 13:** Get the primary Jira application link - if you have multiple, see [Two-legged OAuth Without Impersonation](#id-.ViaAppLinksv8.x-Two-leggedOAuthWithoutImpersonation).

**Line 15:** Get the OAuth provider.

**Line 28:** The response is JSON, so convert it to a `Map.`

**Line 32:** Execute the request.

You should see a log message like:

```
2016-05-05 10:15:34 [http-bio-8080-exec-10] DEBUG c.o.s.runner.ScriptRunnerImpl - Making the request as: admin
```

## Making Requests as Another User

That’s great, but let’s say you want you want to create a new _page_ in Confluence on a Jira transition. If the user executing the Jira transition does not have permission to create a page, this will fail. You may well want this to happen, indeed it’s probably the safest course. But let’s say you want to create a Confluence space on a transition, perhaps as part of a provisioning process. If this is the case you will need to temporarily impersonate a user on the target system that has the _create page_ or _create space_ permission etc.

How you do that is unfortunately not standardized across applications, so what follows are examples for each application supported by ScriptRunner:

It’s advisable to create a user called for example: `deployment`, which has admin rights. You can create a password which can’t be used, so you will know whenever you see this user in the _audit log_, that these changes are the results of your integrations.

**From Bitbucket Server**  

```
import com.atlassian.bitbucket.user.SecurityService
import com.atlassian.bitbucket.user.UserService
import com.atlassian.bitbucket.util.Operation
import com.atlassian.sal.api.component.ComponentLocator
import com.atlassian.sal.api.user.UserManager

def userManager = ComponentLocator.getComponent(UserManager)

def securityService = ComponentLocator.getComponent(SecurityService)

def adminUser = ComponentLocator.getComponent(UserService).getUserByName("deployer")
assert adminUser: 'make sure an admin user called "deployer" exists in all instances'
def securityContext = securityService.impersonating(adminUser, "Creating a space on behalf of ${userManager.getRemoteUser().fullName}")

securityContext.call(new Operation<Void, RuntimeException>() {
    @Override
    Void perform() throws Throwable {
        assert userManager.getRemoteUser().username == "deployer"

        // make REST requests here

        null
    }
})
```

**From Confluence**

```
import com.atlassian.confluence.user.AuthenticatedUserImpersonator
import com.atlassian.confluence.user.AuthenticatedUserThreadLocal
import com.atlassian.confluence.user.UserAccessor
import com.atlassian.sal.api.component.ComponentLocator

def userAccessor = ComponentLocator.getComponent(UserAccessor)

def adminUser = userAccessor.getUserByName("deployer")
assert adminUser: 'make sure an admin user called "deployer" exists in all instances'

AuthenticatedUserImpersonator.REQUEST_AGNOSTIC.asUser({
    assert AuthenticatedUserThreadLocal.get().name == "deployer"

    // make REST requests here

}, adminUser)
```

**From Jira**

```
import com.atlassian.jira.component.ComponentAccessor

def jiraAuthenticationContext = ComponentAccessor.getJiraAuthenticationContext()
def originalUser = jiraAuthenticationContext.getLoggedInUser()

def userManager = ComponentAccessor.getUserManager()
def adminUser = userManager.getUserByName("deployer")
assert adminUser: 'make sure an admin user called "deployer" exists in all instances'

try {
    jiraAuthenticationContext.setLoggedInUser(adminUser)

    // make REST requests here
}
finally {
    jiraAuthenticationContext.setLoggedInUser(originalUser)
}
```

## Two-legged OAuth Without Impersonation

If you have different sets of users between your apps, you cannot use two-legged authentication with impersonation. The problem here is that user _jbloggs_ on Jira may actually refer to a different _jbloggs_ on Confluence. Atlassian expresses this in their documentation as _"users must have the same password"_, but I believe they mean that the user for any given ID should be the same person.

If you just have some a subset of users in one app that all exist in another app you should be OK using 2-legged with impersonation.

If not, your alternatives are:

-   specify a user on the target app that all remote requests via this link will execute as. However, as you can’t specify a user with admin rights this may not be useful
    
-   prompt the end-user to do the _login dance_, which will allow them to grant the source app to make requests to the target on their behalf.
    

This code sample focuses on doing the _dance_.

```
import com.atlassian.applinks.api.ApplicationLinkRequest
import com.atlassian.applinks.api.ApplicationLinkService
import com.atlassian.applinks.api.CredentialsRequiredException
import com.atlassian.applinks.api.application.jira.JiraApplicationType
import com.atlassian.sal.api.component.ComponentLocator

import static com.atlassian.sal.api.net.Request.MethodType.GET

def appLinkService = ComponentLocator.getComponent(ApplicationLinkService)
def appLink = appLinkService.getPrimaryApplicationLink(JiraApplicationType)

def applicationLinkRequestFactory = appLink.createAuthenticatedRequestFactory()

ApplicationLinkRequest request
try {
    request = applicationLinkRequestFactory.createRequest(GET, "/rest/auth/1/session")
}
catch (CredentialsRequiredException e) {
    log.warn("Your permission is required to make this request, go to: ${e.authorisationURI}")
    return
}

// we have the permission, use the request object...
```

Once the user has clicked the link which takes them to the page below, the code will proceed beyond the `catch` block.

![An example authentication screen.](/files/101638474/101638787/1/1599763591000/dance+%282%29.png)

The problem you may encounter is that there may not be any easy way to present this URL to the user in the web UI. In this case, you could just fail the transition or whatever, or in Jira, add a message into the UI:

```
import com.onresolve.scriptrunner.runner.util.UserMessageUtil

// get requestUrl as above
UserMessageUtil.warning("Please authenticate to Confluence " +
    "via ${requestUrl} before executing this transition.")
```
