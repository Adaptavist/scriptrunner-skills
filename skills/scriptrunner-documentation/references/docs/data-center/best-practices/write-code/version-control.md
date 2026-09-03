# Version Control

- Platform: data-center
- Space: SR4JS
- Hierarchy: best-practices > write-code
- Doc ID: doc-sr4js-101624455
- Source: https://docs.adaptavist.com/sr4js/latest/best-practices/write-code/version-control

For large instances with multiple administrators, we recommend you establish a version control system (VCS) to maintain your ScriptRunner scripts. Maintaining scripts within a VCS records changes to individual scripts over time, allowing you to revert changes and access old script versions if needed. When troubleshooting, the VCS history may contain meta-information on why a particular change was made, when it was made, and who initiated the change.

Below is an example strategy using the popular VCS [Git](https://git-scm.com/) for maintaining script versioning across your instance.

This is a suggested workflow. As each instance is unique, administrators should implement a strategy that works for them.

We assume readers have a basic understanding of a Git workflow and familiarity with a command-line interface.

  

1.  Set up an account in a Git repository management solution (such as Bitbucket) for the server user.
    
2.  Create a repository in the Git repository management software, and add read-only access for the server user account created in the previous step.
    
3.  If you use a staging environment for testing, create a _staging_ branch (which we will refer to as _staging_) from the _main_ branch on the repository management solution. All script changes are first merged to the _staging_ branch.
    
4.  Run the following command on the server:
    
    ```
git clone <RepoUrl> <ScriptRoot>
```
    
5.  On your local machine, clone the repo locally:
    
    ```
git clone <RepoUrl> <ScriptRoot>
```
    
6.  Create a tracking branch off the _staging_ branch. This new branch is your _development_ branch. Make changes to the scripts using an Integrated Development Environment (IDE). For example, you want to fix a bug in one of your scripts so create a branch called `bugfix/fix-null-pointer-exception`.
    
    ```
git checkout -b bugfix/fix-null-pointer-exception origin/staging
```
    
7.  Once all changes have been made locally commit them:
    
    ```
git add .
git commit
```
    
8.  Push the changes for review:
    
    ```
git push origin HEAD:refs/heads/bugfix/fix-null-pointer-exception
```
    
9.  Open a PR for review, targeting the _staging_ branch.
    
10.  Once the PR has been approved. Merge it into the _staging_ branch.
     
     It is possible to branch straight from _main_ if a staging site is not required.
     
11.  Test the _staging_ branch on your _staging_ environment. When the _staging_ branch is stable and ready to move to _production_, create a PR from _staging_ to _main_. Review the PR, and merge the changes to _main_.
     
12.  To update _production_ manually, log into the server, navigate to the script roots, and run `git pull` to refresh the local _main_ branch on the server.
     
     To ensure the _Script Roots_ repository is always up-to-date, set up an automatic crontab rule to continually pull the _main_ branch on the server. This approach means users do not need server file access as the _main_ branch updates are automatically pulled.
