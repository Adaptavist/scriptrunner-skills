# Using external APIs in SR

- Platform: data-center
- Feature: script-console
- Tags: automate, extend
- Language: groovy
- Doc ID: example-dataCenter-use-external-api-onPrem
- Source: https://examples.scriptrunner.io/scripts/use-external-api-onPrem

## Overview

This script can be used as a template to make the most common external system calls, such as: get a response, create
data, update data, or delete an element in this external system, using its REST API.

## Example

I am in charge of the company on-boarding Jira project. Every time a new employee is added to our external HR system,
I want to get information about this employee. I can use this script to connect to the external system's REST API and
retrieve the required data.

## Good to Know

* External system can be customised with the requirements needed. In this example, external system specifications are:
  - GET method uses token-based authentication added as a header.
  - POST method use uses a special header to authenticate.
  - PUT method uses Basic Authentication.
  - DELETE method is not authenticated.
  - Query parameters can be added in every method (GET, POST, PUT, DELETE) with corresponding HTTP client methods.
  - Results are handled with custom handlers associated with the client. These handlers managed success and
    failures responses, storing the JSON response if is successful and logging the error if it is a failure.
  - Follow this [link](https://github.com/jgritman/httpbuilder/wiki/RESTClient) for further information about
    `RESTClient`.

## Script

```groovy
import groovy.json.JsonOutput
import groovyx.net.http.ContentType
import groovyx.net.http.HttpResponseDecorator
import groovyx.net.http.RESTClient

final externalUrl = "https://<YOUR API HOST URL>/"

// Turn the data will be sent into JSON, the HTTP requests specify in the header to accept application/JSON
// If the API accepts different types then you can change this and format the data accordingly
def body = JsonOutput.toJson([data: "<YOUR DATA>"])

// The host URL will be the consistent prefix to every request is made. e.g.: https://<YOUR API HOST URL>/
// The endpoint will be the specific API method to hit. e.g.: /GetResults
// The query will be the variable parameter the endpoint will use to get the data. e.g.: /objectId=1
// The body is the JSON version of the data that will be sent to an API, only used for PUT and POST
def getResponse = get(externalUrl, "<YOUR ENDPOINT>", "<QUERY>")
def postResponse = post(externalUrl, "<YOUR ENDPOINT>", "<QUERY>", body)
def putResponse = put(externalUrl, "<YOUR ENDPOINT>", "<QUERY>", body)
def deleteResponse = delete(externalUrl, "<YOUR ENDPOINT>", "<QUERY>")

// If GET response is successful then the response can be cast to a Map which will allow to interact with the data
if (getResponse) {
    def responseGetMap = getResponse as Map
    // A code to manage the resulted data can be inserted here, i.e iterate results with responseMap.each{}
    responseGetMap.each {}

    def responsePostMap = postResponse as Map
    // A code to manage the resulted data can be inserted here, i.e iterate results with responseMap.each{}
    responsePostMap.each {}

    def responsePutMap = putResponse as Map
    // A code to manage the resulted data can be inserted here, i.e iterate results with responseMap.each{}
    responsePutMap.each {}

    def responseStatus = deleteResponse as Integer
    // In this case, status is returned as delete HTTP method responds an empty body
    assert responseStatus == 200
}

def get(def hostUrl, def endpoint, def query) {
    // If authentication mechanism of the API is token-based, it can be specified into this variable
    if (hostUrl.toString().contains('&') || hostUrl.toString().contains('?')) {
        log.error 'The parameters of the endpoint must be included in the query variable'
        return
    }
    def token = '<YOUR TOKEN>'
    def client = new RESTClient(hostUrl)
    client.setHeaders([
            'Accept'       : ContentType.JSON,
            // The 'Authorization' header is added
            'Authorization': "Bearer $token"
    ])
    client.handler.success = { HttpResponseDecorator response, json ->
        json
    }
    client.handler.failure = { HttpResponseDecorator response ->
        // Failure can be handled here
        log.error response.entity.content.text
        [:]
    }
    client.get(
            path: endpoint,
            queryString: query,
            contentType: ContentType.JSON
    )
}

def post(def hostUrl, def endpoint, def query, def bodyJson) {
    def client = new RESTClient(hostUrl)
    client.setHeaders([
            'Accept'   : ContentType.JSON,
            // If authentication mechanism of the API requires a special header, it can be added here
            'x-api-key': '<YOUR KEY>'
    ])
    client.handler.success = { HttpResponseDecorator response, json ->
        json
    }
    client.handler.failure = { HttpResponseDecorator response ->
        // Failure can be handled here
        log.error response.entity.content.text
        [:]
    }
    client.post(
            path: endpoint,
            queryString: query,
            contentType: ContentType.JSON,
            body: bodyJson
    )
}

def put(def hostUrl, def endpoint, def query, def bodyJson) {
    def client = new RESTClient(hostUrl)
    client.setHeaders([
            'Accept'       : ContentType.JSON,
            // If authentication mechanism of the API is Basic Authentication, 'Authorization' header with username and password encoded as Base 64 can be specified here
            'Authorization': "Basic ${'<YOUR USERNAME>:<YOUR PASSWORD>'.bytes.encodeBase64()}"
    ])
    client.handler.success = { HttpResponseDecorator response, json ->
        json
    }
    client.handler.failure = { HttpResponseDecorator response ->
        // Failure can be handled here
        log.error response.entity.content.text
        [:]
    }
    client.put(
            path: endpoint,
            queryString: query,
            contentType: ContentType.JSON,
            body: bodyJson
    )
}

def delete(def hostUrl, def endpoint, def query) {
    def client = new RESTClient(hostUrl)
    client.setHeaders([
            'Accept': ContentType.JSON,
    ])
    client.handler.success = { HttpResponseDecorator response ->
        response.statusLine.statusCode
    }
    client.handler.failure = { HttpResponseDecorator response ->
        // Failure can be handled here
        log.error response.entity.content.text
        [:]
    }
    client.delete(
            path: endpoint,
            queryString: query,
            contentType: ContentType.JSON
    )
}
```

