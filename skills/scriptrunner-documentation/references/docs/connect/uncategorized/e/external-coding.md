# External Coding

- Platform: connect
- Space: SRC
- Hierarchy: n/a
- Doc ID: doc-src-409796915
- Source: https://docs.adaptavist.com/src/latest/external-coding

Feature availability

This feature is available only for paid users on non-legacy plans.  
If you would like to try this feature, you can [request a free trial](https://docs.adaptavist.com/src/latest/release-notes#id-.ReleaseNotesvDraft-ProPlanFreeTrial) from within the app that will grant you access to all restricted features.

## Table of contents

## Overview

External coding enables you to edit ScriptRunner Connect scripts locally using your preferred integrated development environment (IDE) and workflows. For example, you can use an IDE or a code editor to push code to Git for peer reviews. The key advantage of working on your local file system is the use of professional tools like IDEs, which offer more power and customization than our web-based editor. 🧰

Benefits:

-   Edit with VS Code, IntelliJ, or any preferred IDE.
-   Integrate with Git for version control and peer reviews.
-   Maintain a faster, more flexible coding workflow.
-   [Use your own AI tool](https://docs.adaptavist.com/src/latest/external-coding/working-with-ai-agents) to vibe code integrations.

How it works:

-   Enable Secure File Transfer Protocol (SFTP) in your workspace.
-   Connect with an SFTP client or IDE plugin.
-   Download scripts to your local environment, edit them however you see fit and upload them back once done.
-   View and test your changes in the ScriptRunner Connect web-based app or [run them locally](https://docs.adaptavist.com/src/latest/external-coding/test-and-run-scripts-locally).

Enabling external coding replaces our web app code editor. By downloading the files, modifying them locally, and uploading the changes back, you replicate the process of opening a file in our web-based editor, making modifications to the script, and then saving the changes. While this feature offers great flexibility regarding the tools you can use, we recommend using our internally tested setup for optimal performance and leveraging [AI agents to write code for you](https://docs.adaptavist.com/src/latest/external-coding/working-with-ai-agents).

## Demo

### Edit scripts only

Currently, the remote file system supports editing scripts only. Any additional tasks, such as configuring the workspace, must be done from the web app.

Best practice

We recommend a dual-screen setup, with one screen dedicated to the web app and another to your local IDE or editor. 

## Setup

### 1️⃣ Enable SFTP:

1.  From your desired workspace, click the **three-dot menu** in the _workspace header_ and select **Remote workspace** (by default, available for paid users only).
2.  Click **Enable SFTP Server** (if this hasn't been done on the workspace just yet, otherwise, skip to the second step).

### 2️⃣ Generate SFTP credentials:

1.  Click **Generate SFTP Credentials**.
    1.  A _private key_ is generated for download. Save the private key securely.
        
        Save your private key
        
        Only one private key is generated for personal use, so it's crucial not to lose it. You will use the same private key to connect to any other workspace as well.
        
        If you lose the private key, you can generate a new one via the _profile page_, invalidating the old one. As a result, you'll need to update any local configurations that used the old key to incorporate the new one.
        
2.  Once your credentials are generated, you'll receive a unique _username_ linked to your personal account and the workspace for which you created the credentials.  
    
    Private key already exists
    
    If you already have private key generated previously, you won't receive an option to download it again, you're expected to use the private key you already have downloaded.
    

### 3️⃣ Connect with SFTP client:

-   Open and connect to your desired workspace file system that supports SFTP protocol using the _hostname, port, username,_ and _private key_ generated in ScriptRunner Connect web app.

Many FTP clients can be used. Macs have built-in command-line tools like `ftp` and `scp`. [FileZilla](https://filezilla-project.org/) is a popular third-party client.

For a seamless experience, we recommend using [VSCode with the SFTP extension](https://docs.adaptavist.com/src/latest/external-coding/recommended-setup).

## Local development

The remote file system is structured as a [Node](https://nodejs.org) project. To use it fully, ensure you've installed Node 20 or higher on your local machine.

To use local development:

1.  Using a TypeScript or JavaScript-capable IDE or code editor, download and open the ScriptRunner Connect files.
2.  Install [NPM](https://www.npmjs.com) dependencies.  
    Once the required packages are installed, any IntelliSense-related errors should disappear, allowing you to start editing your scripts locally.
    1.  Do this by running the **`npm install`** command. If you're using [Yarn](https://yarnpkg.com), run **`yarn.`**
        
        Installing packages repeatedly
        
        You may need to install NPM packages again after having introduces changes to your workspace and have downloaded new changes locally. To minimise the need to repeat this step, we recommend setting up your workspace as much as possible in terms of setting up all required Event Listeners and API Connections, then enabling the remote workspace feature, download the files and then installing the packages.
        
3.  Make desired changes locally.  
    We highly recommend [using AI agent workflows](https://docs.adaptavist.com/src/latest/external-coding/working-with-ai-agents) to increase your delivery speed.
4.  Upload the modified files to the SFTP server.
    1.  The files are then processed, typically in about 10-20 seconds. After that, you'll receive a notification regarding the workspace changes in the ScripRunner Connect web app. If that doesn't happen, refresh your workspace manually by refreshing the browser tab.

HEAD version

The remote file system always exposes the `HEAD` version of the workspace. It does not support exposing a deployed version through the remote file system. The structure for environments variables ([parameters](https://docs.adaptavist.com/src/latest/workspaces/parameters)) is always based on your default environment, even if your default environment no longer targets the `HEAD` version.

Simultaneous editing

Unlike the web-based app, the remote file system does not have a locking mechanism to prevent simultaneous modifications.  
To avoid team members overwriting each other's changes, it is strongly recommended that you secure a workspace edit lock in the ScriptRunner Connect web-based app before editing scripts via the remote file system and have your team follow this practice. 

### Batteries included 🔋

When you enable the remote workspace, you get a ready-to-go Node project, recognized by most IDEs as a TypeScript powered Node setup. 

What's included:

-   **[Prettier](https://prettier.io)** for code formatting with sensible defaults.
-   **[ESLint](https://eslint.org)** for static code analysis, also with good defaults.
-   **[Jest](https://jestjs.io)** for running automated tests locally.

The web editor doesn’t offer these features, so local editing significantly improves your developer experience, including the option to [use AI agents](https://docs.adaptavist.com/src/latest/external-coding/working-with-ai-agents) to do the heavy lifting. For instance, [floating promises](https://typescript-eslint.io/rules/no-floating-promises) can lead to race condition bugs that our web-based editor does not highlight. However, the default [ESLint](https://eslint.org) configuration in the remote file system includes a rule to warn against them.

Freedom of choice

If our default file system structure and configuration doesn't suit your needs, you are free to modify it to your liking (except the structure of the `scripts` folder). However, if you make significant changes to the project structure beyond just editing scripts locally, we recommend storing these changes in version control system or back them up externally. When you disable the SFTP server, which can be used to pull in new updates to the file system structure that the ScriptRunner Connect team may introduce over time, you will lose any custom changes you may have made to your file system structure. Backing up your workspace file system externally allows you to retain these changes in this particular case.

### Turn off auto-save

Please turn off the auto-save feature in your IDE or code editor while developing locally. Auto-saving can put excessive strain on our resources by processing incomplete files. Instead, upload the file only after you have finished editing it. However, we recognize that AI agents usually make changes quite rapidly on the fly; this is allowed because this behavior usually cannot be avoided.

With our [recommended setup using VS Code and the SFTP extension](https://docs.adaptavist.com/src/latest/external-coding/recommended-setup), you can configure the upload to occur automatically when you save the script. If you prefer to enable the auto-save feature, please adjust your IDE or code editor to save less frequently. 

We provide an out-of-the-box configuration for this in VS Code via the `.vscode/settings.json` file.

Traffic monitored

There are no monthly quotas on the number of file uploads to the SFTP server. However, we will monitor usage and may impose quotas if we detect abuse to prevent excessive traffic.

### Required files only

Please refrain from uploading files that are not necessary for the ScriptRunner Connect web app's functionality, to help us reduce overall traffic. This primarily includes the `node_modules` directory, which is generated when you run **`npm install`** or **`yarn`**. This folder contains a large number of files needed only for local development. When using our recommended VS Code and SFTP extension setup, we provide a configuration that automatically excludes the `node_modules` folder, so you don't need to take extra steps.

Exceptions

As an exception, reasonable deviations are allowed for additional configurations you may want to add to your workspace. This ensures that when others download files from the SFTP server, they receive these additions. For example, you can include test files which are executed locally but are essential for verifying the correct functionality of your workspace.

VCS recommended

We recommend storing your master copy in a version control system (VCS) like Git so that any additions can be fetched from there instead.

### Remote file system structure 🗂️

Click here to see how the remote file system is organized.

The remote file system is a ready-to-use TypeScript powered Node project. It requires no manual changes; just open it in a compatible IDE.  
Here's how the remote file system is organized:

-   `.vscode:` Folder for [VS Code](https://code.visualstudio.com/) specific configurations, our recommended code editor.
    -   `extensions.json:` Recommended VS Code extensions, including ESLint for highlighting linter issues, Prettier for code formatting, and SFTP for seamless server integration.
    -   `settings.json:` Recommended settings for VS Code.
-   `node:` A folder for running code locally in Node, primarily for executing tests.
    -   `tests:` Folder for developing local tests, a pre-configured location for Jest. 
    -   `apiRegistry.ts:` File for registering mocked [Managed APIs](https://docs.adaptavist.com/src/latest/managed-apis) to run code/tests locally.
    -   `global.d.ts:` Global types for locally running scripts in Node.
    -   `jest.config.ts:` Jest configuration file.
    -   `runtimeMocks.ts:` Contains [ScriptRunner Connect runtime](https://docs.adaptavist.com/src/latest/scripting/runtime)\-specific mocks for the Node runtime.
    -   `tsconfig.json:` TypeScript configuration for running code locally in Node.
-   `scripts:` Folder containing workspace scripts.
    -   `api:` A folder with local setups of [API Connections](https://docs.adaptavist.com/src/latest/workspaces/api-connections) with Managed APIs.  
        Do not modify files here, as manual changes will be overwritten.
    -   `{scriptName}.ts:` Workspace script(s).
-   `.prettierrc:` Prettier configuration file.
-   `[AGENTS.md](http://AGENTS.md)`: [Instructions for AI agents](https://agents.md/).
-   `[AGENTS_TESTING.md](http://AGENTS_TESTING.md)`: Extended instructions for AI agents how to go about building test suite.
-   `[AGENTS_ANNEX.md](http://AGENTS_ANNEX.md)`: Extended instructions for AI agents that you can add on top of baseline instructions or overwrite baseline instructions. This file by default does not exist, you're expected to create it if you need to include additional instructions.
-   `eslint.config.json:` ESLint configuration file.
-   `ev_params.ts:` TypeScript types generated for configured [parameters](https://docs.adaptavist.com/src/latest/workspaces/parameters) (environment variables).  
    Do not modify this file, as changes will be overwritten. The default environment of your workspace is always used to generate parameter types, even if your default environment is not pointing to `HEAD` version.
-   `package.json:` Node project configuration.
-   `tsconfig.base.json:` Base TypeScript configuration file.
-   `tsconfig.json:` TypeScript configuration file.

### Package.json modifications

If you want to add third-party NPM packages to your local copy, please use our online [package manager](https://docs.adaptavist.com/src/latest/workspaces/package-manager). Otherwise, you risk losing locally installed addition if you or anyone else uses the online package manager, which will overwrite the `package.json` file. However, for dependencies needed only for local use, you can add them directly to the '`devDependencies'` section of your `package.json`. These changes won't be overwritten. This approach is recommended because it avoids unnecessarily pulling dev dependencies into the regular workspace, which could slow it down.

### ScriptRunner Connect runtime vs Node runtime

Our project has two different `tsconfig.json` files: one in the root directory and another inside the `node` folder. This setup exists because the API surface of ScriptRunner Connect's runtime differs from that of Node's API. However, you might still need to use Node's API when running code locally.

The project is configured to use ScriptRunner Connect's runtime types throughout, except within the `node` folder, where Node's API takes precedence. Therefore, scripts intended to run locally should be placed inside the _`node`_ folder.

#### Example

For example, this distinction is evident when accessing the `crypto.subtle` namespace. Both ScriptRunner Connect and Node runtimes support the `web.crypto` standard, but ScriptRunner Connect's version is currently partial and lacks some methods. If you access `crypto.subtle` outside the `node` folder, you'll see the support for the following methods:

![](/src/files/latest/409796915/409796917/1/1752147513000/image-2025-7-9_17-5-9.png)

However, if you access the same namespace within _`node`_ folder, you should see a longer list for full support:

![](/src/files/latest/409796915/409796916/1/1752147512000/image-2025-7-9_17-6-16.png)

## Use a version control system

Enabling the remote workspace file system makes it easy to obtain a workspace copy that can be stored in a VCS, like Git.

Benefits:

1.  Implement custom workflows (peer reviews, tracking changes).
    
2.  Maintain a master copy separate from local edits.
    

Limitations:

-   CI/CD pipeline deployment is not currently supported. Deploying from CI/CD directly to HEAD is unsafe due to potential conflicts.
    
-   The remote file system only exposes the HEAD version.
    

Future plans:

-   Special access for CI/CD deployments to support safe automated deployments.
    
-   Public REST API for [release creation and deployment](https://docs.adaptavist.com/src/latest/workspaces/deployments-and-environments) will be added once secure processes exist.
    

## Turn off the SFTP server

To turn off the SFTP server:

1.  Select **Remote workspace** from the workspace menu.
2.  First revoke your credentials by pressing on **Revoke SFTP credentials**.
3.  Then press on **Disable SFTP server**.

Data loss

 Use this option cautiously, as it will revoke everyone's access and erase the contents of the remote workspace. Turning off the server could result in data loss, especially if you stored additional configuration or tests solely on the SFTP server. We recommend using a version control system, like Git, to store the master copy of the workspace for any modifications.

Restoring default state

Turning off the SFTP server can be useful to revert to the default state if irreversible changes have occurred, such as accidentally deleting default files that can't be easily restored. You can regenerate default files by disabling and re-enabling the remote workspace file system, which can be useful if new structural changes were introduced by ScriptRunner Connect team after you have already enable the feature for your workspace.

## Limitations

Click here to see feature limitations.

Here are a few limitations to be aware of with this feature:

-   Removing Team Members
    -   When you remove someone from a team and they have SFTP enabled for certain workspaces, their credentials will be revoked. However, their FTP session will remain active until it times out, allowing them to read and edit workspace content until then.
-   Deleting Scripts
    -   Deleting a script via the remote file system will not remove it from the workspace.
    -   To delete a script, you must first delete it from the ScriptRunner Connect web-based app and then from your local copy.
-   Renaming Scripts
    -   Some FTP clients may create a new file when you rename a script, creating a new script file in the actual workspace while the old one remains.
    -   To avoid this, rename the script in the web-based app to ensure any linked [Event Listeners](https://docs.adaptavist.com/src/latest/workspaces/event-listeners) are updated.
    -   You can then download the changes, which might leave the old version in your local copy to be deleted manually.
