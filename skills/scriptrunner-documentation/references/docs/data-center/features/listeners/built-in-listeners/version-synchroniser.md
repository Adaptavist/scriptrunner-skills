# Version Synchroniser

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > listeners > built-in-listeners
- Doc ID: doc-sr4js-442888832
- Source: https://docs.adaptavist.com/sr4js/latest/features/listeners/built-in-listeners/version-synchroniser

This listener allows create, update, delete, move, merge etc. operations on _Jira versions_ across multiple projects. The listener is useful if you have multiple projects that should all have the same versions list.

It should be used carefully as will **modify** and **delete** versions in all configured target projects, if that operation is done to the _source_ version.

The following image shows an example version synchronizer:

![Example of version synchroniser screen](/sr4js/files/latest/442888832/442888834/1/1758746973000/Version_synchroniser.png)

1.  The listener will listen for version-related events in the selected _source project_. For this listener, the event list is pre-populated and you cannot update it.
    
2.  You can select multiple target projects. The listener won’t allow you to select target projects that contain the source project, as that is not meaningful.
    

**Please understand the functionality of the listener before implementing it in your production environment**. The listener propagates the following:

1.  _version creates_ to all target projects, when a version is created in the source project
    
2.  _version updates_, if the version is already available in the target project
    
3.  _version deletes_. It does not delete the target version if it is referenced in issues **and** the **swap** option is not defined for affected issues
    
4.  _version deletes with swaps_. If any of the versions to be swapped to is not contained in the destination project, be it "Fix Versions" or "Affects Versions", the version will be created in the destination project.
    
5.  _version merges_, if the same versions are available in the target project. It does not trigger a merge operation if the **merge-to version** is unavailable in the target project. It will trigger a **Version Deleted event instead**, deleting the version in the destination project without swapping.
    
6.  _move and reorder operations_. The order of versions in target projects may not be the same as the source project, if the version names in the target project differ greatly
    
7.  _release_, and _archive_ operations
    

At the current time, the release operation does not move unresolved issues in target projects, because the release event does not contain details of the version to move unresolved issues to.

At the current time, if a version deletion is initiated in a project that has no issues associated with the version to be deleted, you will not be prompted for a version swap. This is Jira functionality, as of now there is no way of prompting this swap or merge. Also, if a version merge is initiated, and the original version has no issues associated with, the merge will not happen in the destination project. This happens because in that case, Jira raises a Version Deleted Event, instead of a Version Merge event. There is one workaround, to add an issue to hold all of your versions to merge or delete with swap in the source project. A listener can be added on VersionCreate that adds all the versions created in that project to that issue as "Fix Versions" and "Affect Versions". This would solve the problem.

Before doing a release, it is advisable to run a query across the project group that the listener is configured for (i.e. source and target projects) to check for unresolved versions:

```
project in (P1, P2, P3) and fixVersion = 1.0 and resolution is empty
```

You can then do a bulk update before _releasing_ the version in the source project.
