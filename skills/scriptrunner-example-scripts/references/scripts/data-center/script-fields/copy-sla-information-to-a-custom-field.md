# Copy SLA information to a Custom Field

- Platform: data-center
- Feature: script-fields
- Tags: automate, issue
- Language: groovy
- Doc ID: example-dataCenter-copy-sla-information-to-custom-field-onPrem
- Source: https://examples.scriptrunner.io/scripts/copy-sla-information-to-custom-field-onPrem

## Overview

This script helps you to copy a SLA field to another custom field.

## Example

As a project manager, I want to export SLA field to an Excel file. The default SLA field does not export correctly, so
a custom field with a copy of the SLA information can be created for later export.

## Good to Know

* Use *Text Field (multi-line)* as template for the custom field.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.servicedesk.api.sla.info.SlaInformation
import com.atlassian.servicedesk.api.sla.info.SlaInformationService
import com.atlassian.servicedesk.api.util.paging.PagedResponse
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.onresolve.scriptrunner.runner.customisers.WithPlugin

@WithPlugin("com.atlassian.servicedesk")
@PluginModule SlaInformationService slaInformationService

// SLA field name
final slaName = '<SLA name>'

// Gets the SLA information querying SLA service for the current issue
def query = slaInformationService.newInfoQueryBuilder()
    .issue(issue.id)
    .build()
def user = ComponentAccessor.jiraAuthenticationContext.loggedInUser
def slaFormatter = slaInformationService.durationFormatter
def slaPagedResponse = slaInformationService.getInfo(user, query).right().get() as PagedResponse
def sla = slaPagedResponse.results.find { (it as SlaInformation).name == slaName } as SlaInformation

if (sla?.ongoingCycle?.present) {
    // If there is an ongoing SLA. it takes the current ongoing SLA remaining time and format it as duration of "X hours Y minutes"
    log.error("SLA remaining time: ${sla.ongoingCycle.get().remainingTime}")
    slaFormatter.format(user, sla.ongoingCycle.get().remainingTime)
} else {
    // If there is no ongoing SLA, it takes last completed cycle remaining type and format it as duration of "X hours Y minutes"
    log.error("SLA remaining time: ${sla?.completedCycles?.last()?.remainingTime}")
    slaFormatter.format(user, sla?.completedCycles?.last()?.remainingTime)
}
```

