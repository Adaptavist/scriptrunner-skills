# Deployments and Environments

- Platform: connect
- Space: SRC
- Hierarchy: workspaces
- Doc ID: doc-src-194675206
- Source: https://docs.adaptavist.com/src/latest/workspaces/deployments-and-environments

ScriptRunner Connect makes use of environments, releases, and deployments to allow you to implement a managed release process and deploy your releases to multiple environments.

Consider an environment to be either "production” or "live," "staging” or "UAT," and “dev" or “test". While the terminology and number of environments you use may differ, the most common setup for developing server-side software is to have three environments, usually called `prod` , `stg`  and `dev` (or `live`, `UAT`, and `test`). The first environment represents the production environment, the second a staging environment that sometimes is also called UAT, which stands for user acceptance testing, which is an environment where newly developed features or changes are deployed for internal testing before releasing them to the production environment, and the last environment is reserved for development purposes, which is where the developer is building the software.

As hinted earlier, ScriptRunner Connect aims to implement industry-standard release management processes based on server-side software release management principles. This means that when a new software release is ready, it can be deployed to multiple environments, usually first to staging and then to production once everything looks good.

## Demo

## Terminology

-   **Release**  
    In classical server-side software, a release is a bundle of code and/or artefacts that are created at a certain point in time and usually not modified afterwards. A release can then be deployed to multiple environments, usually servers. A release in ScriptRunner Connect is a snapshot of the workspace that includes scripts, a README, and specific configuration settings related to event listeners, API connections, and scheduled triggers. These settings cannot be changed after the release has been created, and are referred to as release-specific configuration. In this documentation, we also refer to a release as a “version” since releases are identified by a version number.
-   **Environment**  
    An environment, in classical server-side software, refers to a location, often physical, where code created as part of a release can be executed, typically by a server.  
    In ScriptRunner Connect, an environment is a virtual space linked to a release and comes with environment-specific configuration that is decoupled from the release-specific configuration. This allows for editing environment-specific configuration after the release has been created, facilitating ease of management (more about that later).
-   **Deployment**  
    In classical server-side software, deployment refers to the process of moving a release into the environment, usually into a server, which then executes the new code introduced with the release.  
    In ScriptRunner Connect, a deployment refers to the activity of linking an environment with a release. In this documentation, we also refer to this activity as "target” or "targeting."

All environments must target a release to ensure access to executable code whenever an event needs to be processed.

## Default setup

By default, each new workspace starts with a default environment called _Default_. This can represent any environment for you, and you can rename the default environment to any name you like. We do not attempt to suggest which environment you should start building your workspace in; hence, the default name.

A new workspace also comes with a special release called the HEAD, which represents a version where you can make (code) changes.

**Any release you create, which will be a copy of the HEAD version at the time of creating the new release, won't allow changes after the release has been created, except for changes to environment-specific configurations that are decoupled from the release**.

The name HEAD was chosen because, in Git terminology, the HEAD represents the tip of the main branch and indicates the latest changes.

Visually, the default setup can be described as follows:

![Diagram showing two sections: ](/src/files/latest/194675206/219250712/1/1701269447000/Untitled.jpg)

## Build out your integration

You do not need to create new environments and releases when you start building out your integration.

It's quite normal to start building your new integration in the _default_ environment, regardless of the environment you will be hooking it up with, whether it is prod, stg, or _dev_. You also do not need to create new releases to apply changes while developing the integration; **in fact, the recommended option is to keep using the HEAD version as long as you can**, because if you create a new release, in order to introduce new changes into the (dev) environment, you have to create another release, leading to release pollution, which reduces how quickly you can apply new changes within a development cycle.

Keeping the initial environment you use for development purposes, targeting the HEAD version, lets you apply changes immediately without worrying about release management. 

**No other environments? No problem!**

In some cases, when you don't have any other environment to develop against other than production, there is no reason to create releases. You can keep the HEAD version targeted for your production environment. However, if you take this approach, be extra careful when introducing new changes, as they will take effect immediately.

It may be possible to partition the production environment into prod and dev parts, for example, by utilising JQL expressions in Jira webhooks to receive only events for specific spaces. This would allow you to create multiple environments and use the same connector (such as the production Jira instance) for both environments, but instead rely upon JQL filtering on the webhooks side for events partitioning.

## Create a new environment

Creating a new environment is easy:

1.  Click on the environment switcher in the workspace header.
2.  Select **Create New**.
3.  Name the new environment.

When you create a new environment, the environment-specific configuration is not copied over from the _default_ environment. Instead, you are expected to reconfigure the setup in the new environment. The new environment also targets the HEAD version by default. You can change this by clicking on the ellipsis menu (three dots) in the workspace header and selecting **Deployment Manager**, which allows you to change which environment targets which release, including the environment you just created.

**We do not recommend having a HEAD version targeted by more than a single environment, as making a change in the HEAD version would immediately apply these changes to other environments that target the HEAD version, which can lead to unexpected behaviou**r (unless it is intentional).

Creating a new environment without re-targeting to use a non-HEAD version looks as follows:

![Diagram showing two blue rectangles labeled ](/src/files/latest/194675206/219250711/1/1701269447000/Untitled+%281%29.jpg)

## Create a new release

Whenever you are ready to create a new release:

1.  Click the ellipsis menu (three dots) in the workspace header.
2.  Select **Release and Deploy**.

Next, specify the version for the new release, which becomes the identifier for the release; hence, we also refer to the release as a _version_. Any version is fine as long as it corresponds to the format of [semantic versioning](https://semver.org/) and the new version is higher than the old one.

You can also specify a label for the release, which serves as an additional identifier to help you distinguish this release from the rest.

As an optional final step, you can also deploy this new release into existing environments.

## Semantic versioning

In short, [semantic versioning](https://semver.org/) consists of three numbers: _major_, _minor_, and _patch_.

-   **Major** - The first number is the major version, which you should increase when you're introducing a major change, often involving a breaking change (backwards-incompatible).
-   **Minor** \- The second version is the minor version, which you should increase when you're adding new functionality, preferably in a backwards-compatible manner.
-   **Patch** \- The third version, the patch version, should be increased if the change is related to fixing a bug or is a change that is not considered new functionality, also in a backwards-compatible manner.

## Environment-specific configuration

Environment-specific configuration is a type of configuration that is decoupled from releases and remains editable, allowing changes to these configuration items to be applied immediately to the selected environment. When switching between environments, you may notice that some configuration items change; these are environment-specific configuration items. Some items may remain the same across environments, and it is entirely up to you to determine the correct configuration values. There are many reasons why some configuration values may need to remain the same across environments sometimes.

Environment-specific configuration items include:

-   Connector for the API connection
-   Connector for the event listener, including setup instructions, which you will need to carry out separately for each environment
-   URL path for the generic event listener
-   CRON expression for the scheduled trigger

These configuration items remain decoupled from the releases, so they can be changed easily without requiring creating new releases to apply them in environments that don't target the `HEAD` version.

## Environment switching

In the workspace header, you can find a switcher for moving between the environments. When you switch the environment, the environment-specific configuration will change accordingly.

Suppose the environment is targeting a non-HEAD version. In that case, most of the workspace will be switched into a read-only mode, and you will see the version of the code and release-specific configuration as it was at the time of creating the release.

Since you're not allowed to make any edits to the release once it has been created, only the environment-specific configuration items remain editable in the workspace. This also includes the resources you will see, which might not match the latest state in the HEAD version. For example, if you created a new resource in the HEAD version, then that resource won't be displayed in a non-HEAD version because it is out of scope for the environment that is targeting the older version, where that resource didn't exist at the time of release creation. The same is true in reverse when downgrading, meaning that resources that you might have seen before might disappear if those resources didn't exist at the time of creation of the older release.

If you are in an environment that targets the HEAD version, then everything remains editable, and any changes you make will be applied immediately to all environments targeting the HEAD version. This is why we only recommend having a single HEAD version targeted at any given time.

**A recommendation 👍🏽**

Have at least one HEAD version targeted in any of your environments; otherwise, you won't be able to introduce new changes other than via environment-specific configuration.

## Revert accidental deployments

If you accidentally deploy a version to the environment that you intended to target the HEAD version, you can revert the change by navigating to the _Deployment Manager_ module and selecting the `HEAD` version for the environment you need to revert. The _Deployment Manager_ also allows you to downgrade a version if you accidentally deploy a version to an environment you didn't intend or need to downgrade for any other reason, such as accidentally introducing a new bug with the newer version.

By default, console logs are filtered by the environment you have selected to filter out noise coming from other environments. You can disable this behaviour by unchecking 'Filter by Environment' located in the console header.

## Apply new changes

We recommend the fix-forward approach, which involves creating a new release and deploying it to any environment(s) that require the fix. This is the industry-standard process for software development, hence why ScriptRunner Connect doesn't allow edits to existing releases. In some circumstances, it's quicker to roll back to the older release. You can perform this action in the Deployment Manager module, but you must be extra careful to ensure that the rollback does not reintroduce older issues that may have been fixed in the newer versions.

When you create new API connections, event listeners, or scheduled triggers that contain environment-specific configuration, you can only apply environment-specific configuration for environments targeting non-HEAD versions after the new release (one that introduces new resources into the scope) has been deployed into these environments. 

For the HEAD version, you can apply environment-specific configuration right away when creating the new resource. **Once the environment-specific configuration is used, it remains applied even if the resource (temporarily) goes out of scope.** Out of scope means that the resource may not have been created yet or may have been deleted, depending on which version the environment is targeting. At this point, the resource is not displayed in the resource tree.

## Manually trigger scripts

When you trigger scripts manually in an environment that is targeting a non-HEAD version, you will be triggering the version of the code that is part of the release, which is the same version that you can see in the read-only code editor. To trigger the latest editable version of your code, you must do so in an environment that targets the HEAD version. We recommend keeping at least one environment targeting the HEAD version, allowing you to try out new changes quickly and efficiently.

**Outcomes**

When you trigger a script manually in the HEAD version, an unsaved version of the script will be triggered if the script is unsaved; otherwise, a saved version of the script will be triggered. Externally triggered (through event listeners) or scheduled script executions will always trigger the saved version of the script.

This exception allows you to try out a change in the HEAD version by manually triggering the script without committing to save the script first.

## An example

Let's consider an integration scenario that listens to an event from Jira (incoming) and then performs an action in Confluence (outgoing), and examine how environments and releases are utilised over time to implement the release management process.

To initiate the development process, we'll start with a single default environment and rename it to '`Dev`', which represents our development environment. We'll then connect that environment with `Jira Dev` and `Confluence Dev` instances, which represent development environments, by creating an event listener that listens to an event from `Jira Dev a`nd an API connection that connects to `Confluence Dev`.

The initial setup would look like this:

![Flowchart showing external systems, environments, and releases. ](/src/files/latest/194675206/219250710/1/1701269447000/Untitled+%282%29.jpg)

We can continue to use this setup until we have finished the initial version and are ready to release it for user acceptance testing. At that point, we can create a new environment called `Stg` and link it to `Jira Stg` and `Confluence Stg` instances that represent our staging environments. At this point, we'll also create our first release, version `1.0.0`, and deploy it to the `Stg` environment while keeping our `Dev` environment targeting the `HEAD` version so we can continue with our development efforts there.

![Flowchart depicting integration between External Systems, Environments, and Releases. Systems (green) connect to Environments (blue) with arrows labeled ](/src/files/latest/194675206/219250709/1/1701269447000/Untitled+%283%29.jpg)

Let's imagine that the `1.0.0`  release in staging looks good, and we're ready to launch it to production. We'll repeat the steps as we did for staging and create a new environment for `Prod` and hook it up with `Jira Prod` and `Confluence Prod` instances. However, we can take a shortcut in terms of deployment since we can reuse the existing `1.0.0` version, which is also targeted for production. There is no point in creating another release with a higher version to achieve deployment, since nothing has really changed. Instead, we can use the _Deployment Manager_ module to re-target the `Prod` environment from the `HEAD` version (the default version it will target when created) to target the `1.0.0` version.

![Flowchart illustrating connections between External Systems, Environments, and Releases. Green boxes indicate systems; blue, environments; teal, releases. Arrows show data flow and deployment paths.](/src/files/latest/194675206/218628356/1/1703076946000/Untitled+%2820%29.jpg)

Success. Both `Stg` and `Prod` environments are now targeting the `1.0.0` version. But let's say that we now need to make a change or fix a bug.

To accomplish this, we would make that change in the `Dev` environment, test it locally in our development instances, and once it's ready, we can make a new release with version `1.1.0` and have it deployed to `Stg` for user acceptance testing.

![Diagram showing a flow between External Systems, Environments, and Releases. Arrows indicate data movement from Jira and Confluence to Dev, Stg, and Prod environments, leading to various software releases.](/src/files/latest/194675206/218628358/1/1703076871000/Untitled+%2818%29.jpg)

Now we're successfully targeting version `1.1.0` in the `Stg` environment and `1.0.0` in `Prod` until user acceptance testing confirms that the changes introduced in version `1.1.0` are good. And when they are ready, we can again use the _Deployment Manager_ module to re-target the `Prod` environment to the `1.1.0` version without having to create yet another new release.

![Flowchart of deployment process. Three sections: External Systems, Environments, and Releases. Arrows show data flow from systems to environments, culminating in releases.](/src/files/latest/194675206/218628357/1/1703076901000/Untitled+%2819%29.jpg)

Now, let's say that the `1.1.0`  version introduced a severe bug that was not caught in user acceptance testing. We should fix it in our D`ev` environment and create a new release with version `1.1.1`. However, since we know that this bug did not exist in version `1.0.0`, we can roll back the `Prod` environment to target the `1.0.0` version using the _Deployment Manager_ module while waiting for the `1.1.1` hotfix version to be verified and confirmed in the `Stg` environment.

![Flowchart illustrating data exchange between External Systems and Environments, leading to different Releases. Arrows denote incoming, outgoing, and deployment paths.](/src/files/latest/194675206/218628359/1/1703076792000/Untitled+%2817%29.jpg)

 And, finally, when version `1.1.1` is verified to work correctly in `Stg`, we can re-target the `Prod` environment to target version `1.1.1`.

![Flowchart showing interaction between External Systems, Environments, and Releases. Green and blue boxes depict data flow and deployment progress.](/src/files/latest/194675206/218628360/1/1703076740000/Untitled+%2816%29.jpg)

Hopefully, this illustrates how you can use environments, releases, and deployments to roll-out new changes in a controlled fashion.

-   Arrows between releases don't have any real significance; they are just there to illustrate the flow of time. HEAD version, the most recent at the top, and `1.0.0` version, the oldest at the bottom.
-   Although we illustrated full separation in terms of instances being hooked up with our environments, you can mix and match and reuse the same instances across your environments.

## Environment-specific logic in scripts

In your scripts, if you need to implement specific logic that only needs to be executed in a particular environment, you can access the current environment from the `context.environment.name`.

The `context` object is always the second parameter passed into your script's entry function.

```
export default async function(event: any, context: Context) {
	if (context.environment.name === 'Staging') {
		// Do something only when the event was received from the Staging environment
	}
}
```

`context.deployment` refers to the release being targeted in the environment where the script is running.

`context.deployment` is `undefined` if the environment is targeting the HEAD version.
