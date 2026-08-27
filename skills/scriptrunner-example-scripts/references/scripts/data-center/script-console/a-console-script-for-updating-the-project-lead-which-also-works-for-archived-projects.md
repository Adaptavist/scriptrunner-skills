# A console script for updating the project lead which also works for archived projects

- Platform: data-center
- Feature: script-console
- Tags: administer, automate, project
- Language: groovy
- Doc ID: example-dataCenter-change-project-lead-onPrem
- Source: https://examples.scriptrunner.io/scripts/change-project-lead-onPrem

## Overview

This script allows you to easily update the project lead for a given project. 

This works even if the project is archived.

## Example

I want to update a project (or several projects), currently owned by a leaver to a new project lead, so I can keep my configuration up to date.

## Description

#### Overview

This script allows you to easily update the project lead for a given project. 

This works even if the project is archived.

#### Example

I want to update a project (or several projects), currently owned by a leaver to a new project lead, so I can keep my configuration up to date.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.project.Project
import com.atlassian.jira.project.UpdateProjectParameters
import com.atlassian.jira.user.ApplicationUser
import com.onresolve.scriptrunner.canned.util.OutputFormatter
import com.onresolve.scriptrunner.parameters.annotation.ProjectPicker
import com.onresolve.scriptrunner.parameters.annotation.UserPicker

@ProjectPicker(label = 'Project Key', description = 'Select project(s) to update', multiple = true, includeArchived = true)
List<Project> projects

@UserPicker(label = 'New project lead', description = 'Enter a project lead to set for this project')
ApplicationUser newProjectLead

def projectManager = ComponentAccessor.projectManager

assert projects: 'Please select at least one project'
assert newProjectLead: 'Please select a project lead to set'

projects.each {
    def params = UpdateProjectParameters.forProject(it.id).leadUserKey(newProjectLead.key)
    projectManager.updateProject(params)
}

OutputFormatter.markupBuilder {
    projects.each { project ->
        p {
            mkp.yield("Updated ${project.key} project lead to ${newProjectLead.name}")
        }
    }
}
```

