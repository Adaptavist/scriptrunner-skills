# Recommended Setup

- Platform: connect
- Space: SRC
- Hierarchy: external-coding
- Doc ID: doc-src-409796919
- Source: https://docs.adaptavist.com/src/latest/external-coding/recommended-setup

Any relevant tool may be used with the remote workplace file system, but we recommend [VS Code.](https://code.visualstudio.com) Our ScriptRunner Connect web editor is based on it, and with the [SFTP extension](https://marketplace.visualstudio.com/items?itemName=PhilipDaoud.sftp-neo) by Philip Daoud, syncing files becomes a seamless process. 

Known bug in SFTP extension

The third-party SFTP extension we previously recommended has a known bug that can cause the SFTP connection to go stale. If this happens, then any FTP commands you may trigger will get stuck. If this happens to you, try restarting VS Code; this usually resolves the issue.  
This is not confirmed to be the case with the currently recommended SFTP extension.

VS Code forks

This tutorial focuses on the standard version of VS Code, but AI-powered forks like [Cursor](https://cursor.com) and [Windsurf](https://windsurf.com/editor) should also work, provided they support the same SFTP extension.

## Demo

## Recommended setup

### 1️⃣ Prepare

1.  Install [Node.js](https://nodejs.org) v20+.
2.  Create a **new folder** in your local workspace and open it in _VS Code_.
3.  In _VS Code_, navigate to **Extensions** and install the **SFTP Neo extension**.  
    
    Be sure to use the one by "Philip Daoud", as it has received more updates than other forks.
    

### 2️⃣ Configure SFTP

1.  Open the **command palette (F1)** and select **SFTP: Config**.  
    This creates a default configuration file for the SFTP extension.
    1.  Alternatively, you can manually create a .vscode/sftp.json file.
        
        While setting up the SFTP credentials in our web UI, you'll receive following piece of JSON, copy it or the following into `vscode/sftp.json`:
        
        ```
{
    "name": "sr-connect-workspace",
    "host": "HOST",
    "protocol": "sftp",
    "port": 22,
    "username": "USER_NAME",
    "remotePath": "/",
    "privateKeyPath": "/path/to/your/private/key",
    "uploadOnSave": true,
    "ignore": [
        "/.vscode/sftp.json",
        "/node_modules",
		"/http_logs_*.json",
		".git"
  ]
}
```
        
        If you choose to modify the existing configuration file manually, pay attention to the `privateKeyPath`, `uploadOnSave`, and `ignore` options, which are not included by default. The `uploadOnSave` option forces the file to be automatically uploaded to the SFTP server once saved locally, improving ergonomics. The `ignore` option allows you to specify paths you don't want to upload back to the SFTP server; in this case, you should exclude your private SFTP extension configuration, the `node_modules` folder, and any HTTP logs that you generate locally.
        
          
        
2.  Ensure that _Auto Save_ is off by going to the **File menu** and unchecking **Auto Save** if its enabled.

### 3️⃣ Sync it up

You'll need to [enable the SFTP server for the workspace and generate credentials](https://docs.adaptavist.com/spaces/SRC/pages/404227156/.External+Coding+vDraft#id-.ExternalCodingvDraft-Getstarted) to complete this step.

1.  Replace the `host`, `username`, and `privateKeyPath` with your personal values if you copied the file from here. If you copied the file from our web UI, the `host` and the `username` values are already filled in for you, only `privateKeyPath` needs specifying in this case.
2.  Open the **command palette** (**F1**) and click **SFTP: Download Project**. 
3.  Confirm the selected folder, and let the files download.  
    
    This is important, if you don't select the folder, the operation will be cancelled.
    

### 4️⃣ Dependencies and IntelliSense

1.  Open the **`scripts`** folder.
2.  You may see red compilation error lines, indicating that NPM dependencies have not been installed yet. 
    1.  To fix this: Open the terminal (**Terminal** > **New** **Terminal**) and run: `npm` `install`.
    2.  Or if you're a Yarn user, run: `yarn`.
3.  Restart VS Code if error lines persist, usually this is not required, but it can take couple of seconds for VS Code to pick up on the changes.  
    Once the red lines are gone, you should have full [IntelliSense](https://code.visualstudio.com/docs/editing/intellisense) support.

At some point, VS Code may ask if you want to install recommended extensions. We recommend doing so, as this will install [Prettier](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode) and [ESLint](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint) extensions to help with formatting and code quality. If you're not prompted, you can manually install them from the _Extensions_ tab.

## Upload code

-   Save files with **CTRL/CMD + S**.
    
    -   With `uploadOnSave` enabled, uploads happen automatically.
        
    -   Without automation: **right-click,** then select **Upload File**.
        
-   Switch to the web app, wait a few seconds, and the ScriptRunner Connect web-based workspace refreshes with your changes. If that doesn't happen after 20 seconds, try refreshing your workspace manually.
    
-   Continue testing scripts manually or externally via our web UI.
    

## VCS setup

If your team uses Git or another VCS:

1.  Clone/checkout the repo instead of downloading via SFTP, given someone has already pushed the workspace copy to VCS.
    
2.  Add your own `.vscode/sftp.json` file (not stored in VCS).
    
3.  Proceed with the same workflow.
    

## Tips and tricks 😎

Here are a few things to keep in mind:

-   The SFTP extension adds an SFTP Explorer tab in VS Code once installed.
    -   You may need to restart VS Code for it to appear.
    -   This extension is helpful for exploring the remote copy without downloading files first and allows you to perform various actions by right-clicking on the files.
-   To monitor the actions of the SFTP extension, go to the **Output** tab in the _Console_ and select **sftp** from the **dropdown menu**. This is very handy for troubleshooting.
-   Occasionally, the FTP session may get stuck and not automatically reconnect (previous recommended extension). 
    -   Restarting VS Code can resolve the issue.
-   Be aware of the [limitations regarding deleting and renaming files](https://docs.adaptavist.com/spaces/SRC/pages/404227156/.External+coding+vDraft#id-.ExternalcodingvDraft-Limitations).
