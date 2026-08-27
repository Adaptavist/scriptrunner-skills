# Deploying From Build Pipelines

- Platform: connect
- Space: SRC
- Hierarchy: external-coding
- Doc ID: doc-src-504038088
- Source: https://docs.adaptavist.com/src/latest/external-coding/deploying-from-build-pipelines

When using Git or another version control system (VCS) in your workflows, you may want to automatically deploy your [remote workspace](https://docs.adaptavist.com/src/latest/external-coding) changes after they are merged into the `main` branch. 

This can be done using your existing secure file transfer protocol (SFTP) credentials, which were used to develop the change in the remote workspace. However, this creates a safety issue when you or any of your teammates continue working on the `HEAD` version, since the build pipeline deploys directly to it. Doing this will overwrite any new work that may have been done since. Someone actively working while automated deployment is underway is also unsafe because it can lead to a corrupted release being created and deployed (working copy scripts mixed with the deployed version).

To circumvent the need to deploy back to `HEAD` versions from build pipelines, you can programmatically request temporary SFTP credentials to be created that act as a safe space to deploy into from build pipelines without risking overwriting newer work in the `HEAD` version or creating a corrupted release.

Disclaimer

Although this approach is safer, at this time, you must not change the structure of the workspace in the HEAD version before the version(s) from the build pipeline(s) have been deployed. Doing so can result in an incorrect release state being created. This is because, during deployment, while using the temporary space, these scripts will be matched with the scripts in the `HEAD` version to look up metadata that does not exist in the remote workspace file system, while the rest of the workspace structure is used to create the release snapshot. Changing, editing, adding new or deleting: scripts, API connections, event listeners, scheduled triggers, or packages can lead to an incorrect snapshot state being created. In other words, the workspace HEAD version structure must remain intact to match the state of the version that is being deployed back. However, you are allowed to continue changing the content of the scripts.

Error scenarios:

-   Cause: A new script was created, or the script name was changed. Effect: an error will be thrown when trying to create a release via temp space.
-   Cause: a script was deleted. Effect: the deleted scripts' content will continue to be used if the deleted script was a dependent script of another, but the deleted script(s) won't be displayed in the workspace resources of the release.

We plan to address this shortcoming in the future, so the build pipeline deployments will become 100% safe. Until then, we strongly recommend checking your VCS build pipelines against the workspace repository you intend to work on to find out if there are any pending or active deployments. If there are, proceed with caution; limit workspace changes in the `HEAD` version to changing safe content in the scripts. Any other structural change should be postponed until the build pipeline deployment has successfully completed.

## How it works

Let's say you want a PR created in Git, that's merged to the main branch, and a build pipeline is kicked off that deploys this change back to your workspace, creates a release from it, and deploys that release to one of your environments. To achieve this, build the following logic in your build pipeline:

1.  Create new, temporary SFTP credentials by calling [POST /v1/workspace/{workspaceId}/sftp/temp](https://docs.api.scriptrunnerconnect.com/#/Remote%20Workspace/RemoteWorkspaceTemporaryCredentials_createRemoteWorkspaceTemporaryCredentials) API endpoint using the [REST API](https://docs.adaptavist.com/src/latest/rest-api). Doing so, you'll get the ID for the temporary SFTP access and credentials to use.
2.  Using the SFTP credentials obtained above, use an SFTP client of your own choosing to deploy the contents of your remote workspace file system into a temporary SFTP space.
3.  Once files are uploaded, call [DELETE /v1/workspace/:workspaceId/sftp/temp/{tempSftpAccessId}](https://docs.api.scriptrunnerconnect.com/#/Remote%20Workspace/RemoteWorkspaceTemporaryCredentials_deleteRemoteWorkspaceTemporaryCredentials). This operation will delete the temporary SFTP space and its contents, and optionally allow you to create a new release and deploy it to one or more environments.

Temporary space expiration

Temporary spaces automatically expire 1 day after they are created.
