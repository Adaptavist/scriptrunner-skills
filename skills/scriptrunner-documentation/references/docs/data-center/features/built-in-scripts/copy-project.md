# Copy Project

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > built-in-scripts
- Doc ID: doc-sr4js-441364299
- Source: https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/copy-project

Use the _Copy Projects_ built-in script to create a new project based on the configuration of an existing project in the Jira instance, allowing administration users to quickly and efficiently create projects without the need for timely manual configuration. This script copies the following to a new project:

-   Schemes
    
-   Role memberships
    
-   Custom field configurations
    
-   Agile boards related to the project (Optional)
    
-   Filters and dashboards that begin with the project key (Optional)
    
    This is useful when processes require giving new users a tailored dashboard and a set of filters related to their project.
    
-   Versions (Optional)
    
-   Components (Optional)
    
-   Issues and their attachments (Optional. Components and Versions must be selected)
    
    This is useful for creating template projects with issues and template documents.
    
    When copying issues, all links on issues in the source project will be copied exactly, with one exception: Intra-project links are reproduced on the respective issues in the copied project. For example, if you are copying project A to project B, and issue A1 depends on A2, then B1 will depend on B2.
    
    Be aware that issue statuses are not copied with the project. All issues are reset to the create state.
    

## Using this built-in script

1.  From ScriptRunner, navigate to **Built-in Scripts→Copy Project**.
2.  Under **Source Project**, select the project you wish to copy.
    
3.  In **Target Project Key**, enter the key for the project to be created.
    
4.  In **Target Project Name**, enter the full name of the project to be created.
    
5.  Optionally, tick checkboxes to define what is copied to the new project. Additional options are available if a Service Desk project is selected in **Source Project**:
    
    1.  Tick **Copy Versions** to copy all versions.
        
    2.  Tick **Copy Components** to copy all components.
        
    3.  Tick **Copy Issues** to copy all issues. This requires both **Copy Versions** and **Copy Components** to be ticked.
        
    4.  Tick **Copy Project-Specific Dashboards and Filters**, to copy all dashboards and filters beginning with the project key of the source project.
        
        Service Desk only:
        
    5.  Tick **Copy Service Desk Request Types** to copy all request types from the source Service Desk project.
        
    6.  Tick **Copy Queue** to copy the **Source Project** queue to the target project, replacing the default project queues.
        
    7.  Tick **Copy Service Desk Organizations** to copy project specific organizations to the target project.
        
    8.  Tick **Copy SLA** to copy the **Source Project** SLA to the target project, replacing the default project SLAs.
        
        ![Image of the copy project built in script](/sr4js/files/latest/441364299/441364302/1/1737995613000/copy_project_optional.png)
6.  From **Copy Rapid Board**, select the name of a rapid board. A board in the new project will be set up using the configuration of the selected board. To copy no board configurations select **Do not copy board**.
7.  In **Target Board Name**, type the name of the new board which will be created using the configuration of the board selected in **Copy Rapid Board**. If no board was selected leave blank.
    
8.  Click **Preview** to check if validation has passed.
    
    ![](/sr4js/files/latest/441364299/441364303/1/1737995614000/copy_project_preview.png)
9.  Click **Run** to create the new project.
