# Copy Service Desk Project Queues to Another Project

- Platform: data-center
- Feature: script-console
- Tags: automate, project
- Language: groovy
- Doc ID: example-dataCenter-copy-sd-project-queues-to-another-project-onPrem
- Source: https://examples.scriptrunner.io/scripts/copy-sd-project-queues-to-another-project-onPrem

## Overview

Copy all Service Desk queues from one project to another.
The queue name, JQL filters, order, and columns are all copied to the target project.

## Example

As a product manager, I use queues to keep updated about issues.
As these queues are project defined, I want to have the same queues for all projects I oversee.
Using this script, I can easily copy over my preferred queue configuration, allowing me to access the information I need without needing to configure queues on each project manually.

## Good to Know

* All existing queues in the target project are deleted before the source queues are copied.
* Source project JQL keys are replaced with destination project key.
* Defined JQLs in the source project can include some information specific to that project. Therefore, the destination project should have the same elements defined in the JQL (status, issue types, etc.).

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.servicedesk.api.ServiceDeskManager
import com.atlassian.servicedesk.api.queue.QueueService
import com.onresolve.scriptrunner.runner.customisers.WithPlugin

@WithPlugin("com.atlassian.servicedesk")

// Specify the master SD project to get the queue form
final sourceProjectKey = "SRC"
// Specify the key of the SD project to copy the queue to
final destinationProjectKey = "DST"

// Get current user logged-in
def currentUser = ComponentAccessor.jiraAuthenticationContext.loggedInUser

// Get project objects
def sourceProject = ComponentAccessor.projectManager.getProjectObjByKey(sourceProjectKey)
def destinationProject = ComponentAccessor.projectManager.getProjectObjByKey(destinationProjectKey)

def queueService = ComponentAccessor.getOSGiComponentInstanceOfType(QueueService)
def serviceDeskManager = ComponentAccessor.getOSGiComponentInstanceOfType(ServiceDeskManager)

// Get Service Desk Id related to projects
def sourceProjectServiceDeskId = serviceDeskManager.getServiceDeskForProject(sourceProject).id
def destinationProjectServiceDeskId = serviceDeskManager.getServiceDeskForProject(destinationProject).id

// Delete all destination project queues
def destinationProjectQueues = queueService.newQueueQueryBuilder().serviceDeskId(destinationProjectServiceDeskId).build()
queueService.getQueues(currentUser, destinationProjectQueues).results.each {
    queueService.deleteQueue(currentUser, destinationProjectServiceDeskId, it.id)
}

// Get all source project queues and copy to destination project
def sourceProjectQueues = queueService.newQueueQueryBuilder().serviceDeskId(sourceProjectServiceDeskId).build()
queueService.getQueues(currentUser, sourceProjectQueues).results.eachWithIndex { queue, index ->
    // Default JQL is removed because when a Queue is created 'project = <related key project>' is added by default
    def newJql = (queue.jql - "project = ${sourceProjectKey}" - "AND").trim()
    // Replace source key project with destination key project in JQL
    newJql = newJql.replace(sourceProjectKey, destinationProjectKey)
    def queueCreateParameters = queueService.newQueueCreateParameterBuilder(destinationProjectServiceDeskId, queue.name)
        .jql(newJql)
        .fields(queue.fields)
        .order(index)
        .build()
    queueService.addQueue(currentUser, queueCreateParameters)
}
```

