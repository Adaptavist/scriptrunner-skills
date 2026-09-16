# Version Control

- Platform: data-center
- Space: SR4JS
- Hierarchy: Best Practices > Write Code
- Doc ID: doc-sr4js-2602d2c9-d77b-49d3-876e-b631f7077440-c4b0c67516fd5379
- Source: https://docs.adaptavist.com/sr4js/latest/best-practices/write-code#version-control--en

For large instances with multiple administrators, we recommend you establish a version control system (VCS) to maintain your ScriptRunner scripts. Maintaining scripts within a VCS records changes to individual scripts over time, allowing you to revert changes and access old script versions if needed. When troubleshooting, the VCS history may contain meta-information on why a particular change was made, when it was made, and who initiated the change.

Below is an example strategy using the popular VCS [Git](https://git-scm.com/) for maintaining script versioning across your instance.

Note: This is a suggested workflow. As each instance is unique, administrators should implement a strategy that works for them.

CAUTION: We assume readers have a basic understanding of a Git workflow and familiarity with a command-line interface.

1.  Set up an account in a Git repository management solution (such as Bitbucket) for the server user.
2.  Create a repository in the Git repository management software, and add read-only access for the server user account created in the previous step.
3.  If you use a staging environment for testing, create a staging branch (which we will refer to as staging) from the main branch on the repository management solution. All script changes are first merged to the staging branch.
4.  Run the following command on the server: 
    
    ```
    git clone <RepoUrl> <ScriptRoot>
    ```
    
5.  On your local machine, clone the repo locally: 
    
    ```
    git clone <RepoUrl> <ScriptRoot>
    ```
    
6.  Create a tracking branch off the staging branch. This new branch is your development branch. Make changes to the scripts using an Integrated Development Environment (IDE). For example, you want to fix a bug in one of your scripts so create a branch called `bugfix/fix-null-pointer-exception`. 
    
    ```
    git checkout -b bugfix/fix-null-pointer-exception origin/staging
    ```
    
7.  Once all changes have been made locally, commit them: 
    
    ```
    git add .
    git commit
    ```
    
8.  Push the changes for review: 
    
    ```
    git push origin HEAD:refs/heads/bugfix/fix-null-pointer-exception
    ```
    
9.  Open a PR for review, targeting the staging branch.
10.  Once the PR has been approved, merge it into the staging branch.
     
     Note: It is possible to branch straight from main if a staging site is not required.
     
11.  Test the staging branch on your staging environment. When the staging branch is stable and ready to move to production, create a PR from staging to main.
12.  Review the PR, and merge the changes to main.
13.  To update production manually, log into the server, navigate to the script roots, and run `git pull` to refresh the local main branch on the server.
14.  To ensure the Script Roots repository is always up-to-date, set up an automatic crontab rule to continually pull the main branch on the server. This approach means users do not need server file access as the main branch updates are automatically pulled.
