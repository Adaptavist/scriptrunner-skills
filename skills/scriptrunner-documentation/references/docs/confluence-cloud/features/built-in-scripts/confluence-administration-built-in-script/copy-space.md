# Copy Space

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: features > built-in-scripts > confluence-administration-built-in-script
- Doc ID: doc-sr4cc-114204248
- Source: https://docs.adaptavist.com/sr4cc/latest/features/built-in-scripts/confluence-administration-built-in-script/copy-space

Using _Copy Space_, you can make a complete copy of an existing space.

The following data is automatically copied:

-   All pages and blogs
    
-   Space description
    
-   Space templates
    

The following data is optionally copied:

-   Attachments
    
-   Labels
    

Information about copying permissions

Previously, you could choose to copy the permissions of a space if you had a paid version of Confluence Cloud. This is no longer supported, so we removed the option to copy permissions. When you copy a space, default permissions are always applied.

The following data is not supported and is not copied:

-   Permissions
-   Page likes
    
-   Comment likes
    

## Use the script

To use this script, follow these steps:

1.  Select the **Space** you wish to copy.
    
2.  Add a unique **New Space Key**.
    
3.  Specify your **New Space Name**.
    
4.  Select if you want to copy across **Attachments** and/or **Labels** by checking the box next to the options.
    
5.  Select **Run**.  
    ![](/sr4cc/files/latest/114204248/233243145/1/1707325599000/copy-space.png)
    

### Results

After you select **Run**, these are the results you will see every time you run the script: 

![](/sr4cc/files/latest/114204248/179608780/1/1684956812000/copy_space_results.png)

## Example

### Copy a demonstration space

If you have a client demonstration of new features, you might want to copy a template space to do your demo. Follow these steps: 

1.  Select the template space for **Space**. In this example, it's _Client Demonstration Space (CDS)._ 
2.  Enter the **New Space Key**, _CQLDS_ for CQL Demonstration Space. 
3.  Enter the **New Space Name** of _Client Demonstration for CQL_. 
4.  Check **Copy Attachments** and **Copy Labels** to copy everything into the new space. 
5.  Select **Run**.   
    ![](/sr4cc/files/latest/114204248/233243144/1/1707325620000/copy-space-example.png)

#### Results

The results message appears: 

![](/sr4cc/files/latest/114204248/179608780/1/1684956812000/copy_space_results.png)
