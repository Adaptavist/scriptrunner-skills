# Using external APIs in SR

- Platform: cloud
- Feature: script-console
- Tags: automate, extend
- Language: groovy
- Doc ID: example-cloud-use-external-api-cloud
- Source: https://examples.scriptrunner.io/scripts/use-external-api-cloud

## Overview

This script can be used as a template to make the most common external system calls, such as: get a response, create
data, update data, or delete an element in this external system, using its REST API.

## Example

I am in charge of the company on-boarding Jira space. Every time a new employee is added to our external HR system,
I want to get information about this employee. I can use this script to connect to the external system's REST API and
retrieve the required data.

## Good to Know

* External system can be customised with the requirements needed. In this example, external system specifications are:
  - GET method uses token-based authentication added as a header.
  - POST method use uses a special header to authenticate.
  - PUT method uses Basic Authentication.
  - DELETE method is not authenticated.
  - Query parameters can be added in every method (GET, POST, PUT, DELETE) with corresponding HTTP client methods..
  - Results obtained are stored in a Map (except DELETE method that has not response body), but can be stored
    in a List, if the endpoint returns a list of objects, or the object needed, with the use of `asObject` method.
  - Follow this [link](http://kong.github.io/unirest-java/) for further information about
    `Unirest-Java`, the HTTP client used by Jira Cloud.

## Script

```groovy
import groovy.json.JsonOutput

final externalUrl = "https://<YOUR API HOST URL>/"

// Turn the data will be sent into JSON, the HTTP requests specify in the header to accept application/JSON
// If the API accepts different types then you can change this and format the data accordingly
def body = JsonOutput.toJson([data: "<YOUR DATA>"])

// The host URL will be the consistent prefix to every request is made. i.e: https://<YOUR API HOST URL>/
// The endpoint will be the specific API method to hit. i.e: /GetResults
// The query will be the variable parameter the endpoint will use to get the data. i.e: /objectId=1
// The body is the JSON version of the data that will be sent to an API, only used for PUT and POST
def getResponse = get(externalUrl, "<YOUR ENDPOINT AND QUERY>")
def postResponse = post(externalUrl, "<YOUR ENDPOINT AND QUERY>", body)
def putResponse = put(externalUrl, "<YOUR ENDPOINT AND QUERY>", body)
def deleteResponse = delete(externalUrl, "<YOUR ENDPOINT AND QUERY>")

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

def get(def hostUrl, def endpointAndQuery) {
    // If the API is token-based authenticated, token can be specified into this variable
    def token = "<YOUR TOKEN>"
    get("$hostUrl$endpointAndQuery")
        .header('Accept', 'application/JSON')
    // The 'Authorization' header is added
        .header('Authorization', "Bearer $token")
        .asObject(Map)
        .body
}

def post(def hostUrl, def endpointAndQuery, def bodyJson) {
    post("$hostUrl$endpointAndQuery")
        .header('Accept', 'application/JSON')
    // If authentication mechanism of the API requires a special header, it can be added here
        .header('x-api-key', '<YOUR KEY>')
        .body(bodyJson)
        .asObject(Map)
        .body
}

def put(def hostUrl, def endpointAndQuery, def bodyJson) {
    put("$hostUrl$endpointAndQuery")
        .header('Accept', 'application/JSON')
    // If authentication mechanism of the API is Basic Authentication, 'Authorization' header with username and password encoded as Base 64 can be specified here
        .header('Authorization',  "Basic ${'<YOUR USERNAME>:<YOUR PASSWORD>'.bytes.encodeBase64()}")
        .body(bodyJson)
        .asObject(Map)
        .body
}

def delete(def hostUrl, def endpointAndQuery) {
    delete("$hostUrl$endpointAndQuery")
        .header('Accept', 'application/JSON')
    // If DELETE HTTP method does not response with body, status can be returned
        .asString()
        .status
}
```

