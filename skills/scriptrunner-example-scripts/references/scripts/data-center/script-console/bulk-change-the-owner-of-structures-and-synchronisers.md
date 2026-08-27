# Bulk Change the Owner of Structures and Synchronisers

- Platform: data-center
- Feature: script-console
- Tags: administer, issue, user
- Language: groovy
- Doc ID: example-dataCenter-structure-bulk-change-owners-onPrem
- Source: https://examples.scriptrunner.io/scripts/structure-bulk-change-owners-onPrem

## Overview

*Structure for Jira* allows you to create structures to organise issues and projects.
This script changes the owner of all structures and synchronisers which belonged to a particular user to a different one.

## Example

As a Jira administrator, I want to remove a particular user from the Jira instance.
Using this script, I can transfer all the structures owned by the disabled user to a different owner.

## Good to Know

* This script requires the [Structure for Jira plugin](https://marketplace.atlassian.com/apps/34717/structure-project-management-at-scale).

## Script

```groovy
import com.almworks.jira.structure.api.StructureComponents
import com.almworks.jira.structure.api.auth.StructureAuth
import com.almworks.jira.structure.api.sync.StructureSyncManager
import com.almworks.jira.structure.api.structure.Structure
import com.almworks.jira.structure.api.sync.SyncInstance
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.user.ApplicationUser
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.onresolve.scriptrunner.runner.customisers.WithPlugin

@WithPlugin("com.almworks.jira.structure")
@PluginModule
StructureComponents structureComponents

def userManager = ComponentAccessor.userManager
def structureManager = structureComponents.structureManager
def syncManager = structureComponents.syncManager

final oldOwnerKey = 'old_owner_key'
final newOwnerKey = 'new_owner_key'

def oldOwner = userManager.getUserByKey(oldOwnerKey)
assert oldOwner : "Could not find user with key ${oldOwnerKey}"
def newOwner = userManager.getUserByKey(newOwnerKey)
assert newOwner : "Could not find user with key ${newOwnerKey}"

def changedStructures = [] as List<Structure>
def changedSynchronizers = [] as List<SyncInstance>
def processException
try {
    StructureAuth.sudo {
        def structuresOfOldOwner = structureManager.getAllStructures(null, true).findAll { it.ownerUserKey == oldOwnerKey }
        structuresOfOldOwner.each { structure ->
            def changedElements = changeStructureOwner(oldOwner, newOwner, structure, syncManager)

            changedStructures.addAll(changedElements.changedStructures as List<Structure>)
            changedSynchronizers.addAll(changedElements.changedSynchronizers as List<SyncInstance>)
        }
    }
} catch (Exception e) {
    log.error("Failed to change owner from '${oldOwnerKey}' to '${newOwnerKey}'", e)
    processException = e
}

/**
 * Changes the owner of an structure and its synchronizers from the old owner to the new owner
 * @param oldOwner The old owner of the structure (to be removed)
 * @param newOwner The new owner of the structure (to be added)
 * @param structure The structure to change the owner
 * @param syncManager The SyncManager instance
 * @return a map containing the effectively changed structures and synchronizers
 */
Map changeStructureOwner(ApplicationUser oldOwner, ApplicationUser newOwner, Structure structure, StructureSyncManager syncManager) {
    // Collect the changed structures and synchronizers in a Map
    def result = [changedStructures: [], changedSynchronizers: []]

    // Change owner of the structure
    structure.owner = newOwner
    structure.saveChanges()
    result.changedStructures << structure

    // Change owner of synchronizers installed for this structure
    def synchronizersForStructure = syncManager.getInstalledSynchronizersForStructure(structure.id)
    synchronizersForStructure.each { sync ->
        // Do not update the owner if the synchronizer doesn't belong to the old owner
        if (sync.userKey != oldOwner.key) {
            return
        }

        def isAutoSyncEnabled = syncManager.isAutosyncEnabled(sync.id)
        if (isAutoSyncEnabled) {
            syncManager.setAutosyncEnabled(sync.id, false)
            syncManager.updateSynchronizer(sync.id, sync.parameters, newOwner)
            // Do full resync after update
            final resync = true
            if (resync) {
                syncManager.resync(sync.id, true, null)
            } else {
                syncManager.setAutosyncEnabled(sync.id, true)
            }
        } else {
            syncManager.updateSynchronizer(sync.id, sync.parameters, newOwner)
        }
        result.changedSynchronizers << sync
    }

    result
}

// Output message about changed structures and synchronizers to the console output
def message = """Script to change owner from '${oldOwnerKey}' for '${newOwnerKey}'.
Status:
${processException ? "Failed (${processException && processException.message})" : 'Success'}

Changed structures:
${changedStructures.collect { "#${it.id} ${it.name}" }.join("\n")}

Changed synchronizers:
${changedSynchronizers.collect { "#${it.id} (for structure #${it.structureId})" }.join("\n")}
"""
message.replaceAll("\n", "<br>")
```

