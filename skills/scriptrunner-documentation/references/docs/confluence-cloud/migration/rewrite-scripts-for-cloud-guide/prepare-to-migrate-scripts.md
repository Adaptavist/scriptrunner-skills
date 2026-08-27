# Prepare to Migrate Scripts

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: migration > rewrite-scripts-for-cloud-guide
- Doc ID: doc-sr4cc-419662212
- Source: https://docs.adaptavist.com/sr4cc/latest/migration/rewrite-scripts-for-cloud-guide/prepare-to-migrate-scripts

## Create a test environment

A test environment is crucial in the migration process from Confluence Server/Data Center to Confluence Cloud. It allows you to experiment, test, and refine your scripts in a controlled setting before deploying them to your production environment. Below we provide details on how to set-up and use a test environment.

### Set up a Confluence Cloud test instance

1.  [Create a Confluence Cloud account](https://www.atlassian.com/try/cloud/signup?product=confluence.ondemand,jira-software.ondemand,jira-servicedesk.ondemand,jira-core.ondemand&developer=true) if you do not already have one.  
    
    Atlassian offers free trials for Confluence Cloud, allowing you to set up a test environment without incurring initial costs.
    
2.  Create a test project that mirrors your production environment as closely as possible. This includes setting up:  
    -   Spaces
    -   Page trees
    -   Configurations where they are needed

### Install ScriptRunner for Confluence Cloud

Install ScriptRunner for Confluence Cloud as described on our [Installation](https://docs.adaptavist.com/display/_PK/SR4CC/installation) page.  

We recommend you install the trial version of ScriptRunner for Confluence Cloud. This allows you to explore its features and test your scripts without immediate financial commitment.

### Use the ScriptRunner Script Console

ScriptRunner for Confluence Cloud includes the [Script Console](https://docs.adaptavist.com/display/_PK/SR4CC/script-console), similar to the one available in ScriptRunner for Confluence Server/Data Center. This feature allows you to write and test scripts in real-time and can be accessed from the ScriptRunner section within your Confluence Cloud instance.

We recommend you use the script console to do the following:

-   **Write and test scripts:** Write new scripts or adapt existing ones from your server environment. The console provides immediate feedback, allowing you to test script functionality and debug issues quickly.
-   **Experiment and iterate:** The script console is ideal for experimentation. Try different approaches, test API calls, and iterate on your scripts until they perform as expected in the cloud environment. This iterative process helps ensure that your scripts are robust and reliable.

## Analyze existing code in Server/Data Center

Before you start your migration of ScriptRunner code from Confluence Server/Data Center (DC) to Confluence Cloud, we recommend you conduct a thorough analysis of your existing codebase. This will help you streamline the migration process and ensure a smoother transition. Below we list the steps you should follow to analyze your existing code and prepare your scripts for migration.

### Step one: Understand your Server/Data Center scripts

You can use the [Script Registry](https://docs.adaptavist.com/display/_PK/SR4C/script-registry) in ScriptRunner for Confluence Server/Data Center to view all your custom scripts in one place. 

For each script, perform the following evaluation: 

-   **Identify the purpose and functionality:** Begin by clearly defining the purpose and functionality of each script in Server/Data Center. Determine what tasks the script automates, such as data validation, or external system integration. This understanding will serve as a blueprint for replicating the script's functionality in ScriptRunner for Confluence Cloud.
-   **Review space associations:** Determine which space each script is associated with. This will help you understand the script's context and scope and ensure that any project-specific configurations or dependencies are considered during the migration.

### Step two: Reduce and simplify scripts

Simplify your migration by checking your script for the following reduction opportunities: 

-   Identify duplicated scripts and consolidate them.
-   Merge similar scripts by merging scimilar scripts into a single, more efficeint script when possible. 
-   Simplify scripts wtih HAPI by reducing the amount of code that needs to be migrated over.

### Step three: Assess unused or disabled scripts

Check for scripts that are currently disabled or no longer in use. Removing these scripts before migration can help reduce clutter and focus efforts on only the necessary code.

### Step four: Evaluate external application integrations

Review any integrations with external applications or services. Determine how these integrations are currently implemented and whether they will need to be adjusted to work with Confluence Cloud's architecture.

Explore Confluence Cloud's available integration options, such as webhooks or OAuth, to maintain or enhance these connections. 

### Step five: Assess plugin dependencies

Identify any dependencies on other plugins or add-ons within your scripts. Since not all server plugins have cloud equivalents, you'll need to find alternative solutions or workarounds for these dependencies. 

Research whether the functionality provided by these plugins is available in Confluence Cloud. By conducting a comprehensive analysis of your existing ScriptRunner code, you'll be better prepared to address the challenges of migration and ensure that your scripts function effectively in the Confluence Cloud environment.

### Step six: Categorize ScriptRunner script types

Before diving into writing or adapting scripts, it's beneficial to categorize them by type and understand the specific limitations of each type in Cloud. The [Feature Parity](https://docs.adaptavist.com/sr4c/latest/migration/migrating-to-from-cloud/feature-parity) page details the parity of each ScriptRunner for Server/Data Center feature. Below is each category you should consider; visit the link to find out more about the limitations of each script:

-   [Built-In Scripts](https://docs.adaptavist.com/display/_PK/SR4CC/feature-parity#bisca)
-   [Fragments](https://docs.adaptavist.com/display/_PK/SR4CC/feature-parity#fragm)
-   [Jobs](https://docs.adaptavist.com/display/_PK/SR4CC/feature-parity)
-   [Listeners](https://docs.adaptavist.com/display/_PK/SR4CC/feature-parity#listeners)
-   [Macros](https://docs.adaptavist.com/display/_PK/SR4CC/feature-parity#m)

### Step seven: Plan a migration path for each script

For effective migration, evaluate each script individually and assign it to one of the following categories:

![(tick)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/check.svg)

The script **can** be migrated

There is complete parity and the script will work in ScriptRunner for Confluence Cloud.

**◐**

The script **cannot** be migrated but a **workaround exists**

There is partial parity and you can perform the same function using an alternative solution.

![(error)](/s/xoimh2/9116/3an53u/_/images/icons/emoticons/error.svg)

The script **cannot** be migrated and there's **no workaround**

The process or way of working should be changed.

## Next step

Check out the [Adapt scripts for Confluence Cloud](https://docs.adaptavist.com/sr4cc/latest/migration/rewrite-scripts-for-cloud-guide/adapt-scripts-for-confluence-cloud) documentation to continue rewriting your scripts for migration. 

## Other resources

-   [Feature Parity](https://docs.adaptavist.com/sr4cc/latest/migration/feature-parity)
-   [Rewriting Scripts](https://docs.adaptavist.com/sr4cc/latest/migration/rewrite-scripts-for-cloud-guide)
-   [Best Practices and Supporting Technical Information](https://docs.adaptavist.com/sr4cc/latest/migration/rewrite-scripts-for-cloud-guide/migration-best-practices-and-supporting-technical-information)
