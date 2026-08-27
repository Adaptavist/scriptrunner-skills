# Create Priority Object

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > rest-endpoints
- Doc ID: doc-sr4js-443374241
- Source: https://docs.adaptavist.com/sr4js/latest/features/rest-endpoints/create-priority-object

This example demonstrates plugging a gap in the official REST API. There is no way to create a new priority object.

This script is compatible with ScriptRunner version 10.x and above.

```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.config.PriorityManager
import com.atlassian.jira.issue.fields.rest.json.beans.JiraBaseUrls
import com.atlassian.jira.issue.fields.rest.json.beans.PriorityJsonBean
import com.atlassian.jira.issue.priority.Priority
import com.fasterxml.jackson.databind.ObjectMapper
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.transform.BaseScript

import jakarta.ws.rs.core.MultivaluedMap
import jakarta.ws.rs.core.Response

@BaseScript CustomEndpointDelegate delegate

def priorityManager = ComponentAccessor.getComponent(PriorityManager)
def baseUrls = ComponentAccessor.getComponent(JiraBaseUrls)

priority(
    httpMethod: "POST", groups: ["jira-administrators"]
) { MultivaluedMap queryParams, String body ->

    def mapper = new ObjectMapper()
    def bean = mapper.readValue(body, PriorityJsonBean)
    assert bean.name: 'must provide priority name'
    assert bean.description: 'must provide priority description'
    assert bean.iconUrl: 'must provide priority icon url'
    assert bean.statusColor: 'must provide priority statusColor'

    Priority priority
    try {
        priority = priorityManager.createPriority(bean.name, bean.description, bean.iconUrl, bean.statusColor)
    } catch (e) {
        return Response.serverError().entity([error: e.message]).build()
    }

    Response.created(new URI("/rest/api/2/priority/${priority.id}")).build()
}
```

This script is compatible with ScriptRunner version 9.x.

```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.config.PriorityManager
import com.atlassian.jira.issue.fields.rest.json.beans.JiraBaseUrls
import com.atlassian.jira.issue.fields.rest.json.beans.PriorityJsonBean
import com.atlassian.jira.issue.priority.Priority
import com.fasterxml.jackson.databind.ObjectMapper
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.transform.BaseScript

import javax.ws.rs.core.MultivaluedMap
import javax.ws.rs.core.Response

@BaseScript CustomEndpointDelegate delegate

def priorityManager = ComponentAccessor.getComponent(PriorityManager)
def baseUrls = ComponentAccessor.getComponent(JiraBaseUrls)

priority(
    httpMethod: "POST", groups: ["jira-administrators"]
) { MultivaluedMap queryParams, String body ->

    def mapper = new ObjectMapper()
    def bean = mapper.readValue(body, PriorityJsonBean)
    assert bean.name: 'must provide priority name'
    assert bean.description: 'must provide priority description'
    assert bean.iconUrl: 'must provide priority icon url'
    assert bean.statusColor: 'must provide priority statusColor'

    Priority priority
    try {
        priority = priorityManager.createPriority(bean.name, bean.description, bean.iconUrl, bean.statusColor)
    } catch (e) {
        return Response.serverError().entity([error: e.message]).build()
    }

    Response.created(new URI("/rest/api/2/priority/${priority.id}")).build()
}
```

 

This script is compatible with ScriptRunner version 8.x.

```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.config.PriorityManager
import com.atlassian.jira.issue.fields.rest.json.beans.JiraBaseUrls
import com.atlassian.jira.issue.fields.rest.json.beans.PriorityJsonBean
import com.atlassian.jira.issue.priority.Priority
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import groovy.transform.BaseScript
import org.codehaus.jackson.map.ObjectMapper

import javax.ws.rs.core.MultivaluedMap
import javax.ws.rs.core.Response

@BaseScript CustomEndpointDelegate delegate

def priorityManager = ComponentAccessor.getComponent(PriorityManager)
def baseUrls = ComponentAccessor.getComponent(JiraBaseUrls)

priority(
    httpMethod: "POST", groups: ["jira-administrators"]
) { MultivaluedMap queryParams, String body ->

    def mapper = new ObjectMapper()
    def bean = mapper.readValue(body, PriorityJsonBean)
    assert bean.name: 'must provide priority name'
    assert bean.description: 'must provide priority description'
    assert bean.iconUrl: 'must provide priority icon url'
    assert bean.statusColor: 'must provide priority statusColor'

    Priority priority
    try {
        priority = priorityManager.createPriority(bean.name, bean.description, bean.iconUrl, bean.statusColor)
    } catch (e) {
        return Response.serverError().entity([error: e.message]).build()
    }

    return Response.created(new URI("/rest/api/2/priority/${priority.id}")).build()
}
```

 

Most of this code is involved with validating the JSON that is passed to it. The validation ensures that all required fields for a priority object are present. The appropriate method on the `response` class sends the right status code. The status code is `500` (server error) if the priority already exists. The status code is `201` (created) if the priority is created.

To test, you could use the following code:

```
curl -X POST -H "Content-type: text/json" -u admin:admin --data "@priority.json" \
    <jira_base_url>/rest/scriptrunner/latest/custom/priority
```

`priority.json` is a text file that contains:

```
{
  "statusColor": "#009900",
  "description": "Major loss of function.",
  "iconUrl": "/images/icons/priorities/lowest.png",
  "name": "Cosmetic"
}
```

You can have multiple methods with the same name in the same file, which is useful to do simple CRUD REST APIs.

An example:

```
POST /priority - creates a priority
PUT /priority - updates a priority
DELETE /priority - deletes a priority
GET /priority - gets a priority
```

Downgrading ScriptRunner can cause REST endpoints to break due to a change in JSON format. Adaptavist does not recommend downgrading.
