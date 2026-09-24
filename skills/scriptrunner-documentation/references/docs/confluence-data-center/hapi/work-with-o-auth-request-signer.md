# Work with OAuthRequestSigner

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: HAPI
- Doc ID: doc-sr4c-9a1056c0-7dd8-4103-bd4a-5dcfeb023d9a-665fabbea399c984
- Source: https://docs.adaptavist.com/sr4c/latest/hapi#work-with-oauthrequestsigner--en

Find information about how to create and send GET and POST Requests.

The HAPI API `OAuthRequestSigner` is designed to replace the deprecated `TrustedRequestFactory`, which was removed in Jira 11. This API provides a secure and efficient way to sign both GET and POST requests, ensuring proper authentication when interacting with Jira's REST API endpoints.

## GET request

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

## POST request

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
