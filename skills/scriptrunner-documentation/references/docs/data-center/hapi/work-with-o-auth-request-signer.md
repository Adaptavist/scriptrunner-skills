# Work with OAuthRequestSigner

- Platform: data-center
- Space: SR4JS
- Hierarchy: hapi
- Doc ID: doc-sr4js-443373574
- Source: https://docs.adaptavist.com/sr4js/latest/hapi/work-with-oauthrequestsigner

The HAPI API `OAuthRequestSigner` is designed to replace the deprecated `TrustedRequestFactory`, which was removed in Jira 11. This API provides a secure and efficient way to sign both GET and POST requests, ensuring proper authentication when interacting with Jira's REST API endpoints.

## Get request

The example below demonstrates how to create and send a GET request using `OAuthRequestSigner`:

```
def url = applicationProperties.getBaseUrl(UrlMode.CANONICAL) + '/rest/api/2/myself'

def request = HttpRequest.newBuilder()
    .uri(OAuthRequestSigner.createOAuthUri(url))
    .header("Content-Type", "application/json")
    .header("Authorization", OAuthRequestSigner.createAuthorizationHeader(url, Request.HttpMethod.GET))
    .GET()
    .build()

def response = HttpClient.newHttpClient()
    .send(request, HttpResponse.BodyHandlers.ofString())
```

## Post request

The example below demonstrates how to construct and send a POST request using `OAuthRequestSigner`:

```
def project = projectManager.getProjectByCurrentKey('JRA')
def issueType = issueTypeManager.issueTypes.find { it.name == 'Bug' }

def url = applicationProperties.getBaseUrl(UrlMode.CANONICAL) + '/rest/api/2/issue'

def requestBody = JsonOutput.toJson([
    fields: [
        project: [
            id: project.id
        ],
        issuetype: [
            id: issueType.id
        ],
        summary: 'build me a rocket',
    ]
])

def request = HttpRequest.newBuilder()
    .uri(OAuthRequestSigner.createOAuthUri(url))
    .header("Content-Type", "application/json")
    .header("Authorization", OAuthRequestSigner.createAuthorizationHeader(url, Request.HttpMethod.POST))
    .POST(HttpRequest.BodyPublishers.ofString(requestBody, StandardCharsets.UTF_8))
    .build()

def response = HttpClient.newHttpClient()
    .send(request, HttpResponse.BodyHandlers.ofString())
```
