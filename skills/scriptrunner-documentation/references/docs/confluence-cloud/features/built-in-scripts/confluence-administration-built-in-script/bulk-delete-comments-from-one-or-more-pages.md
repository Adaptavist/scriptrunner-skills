# Bulk Delete Comments from One or More Pages

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: features > built-in-scripts > confluence-administration-built-in-script
- Doc ID: doc-sr4cc-114204185
- Source: https://docs.adaptavist.com/sr4cc/latest/features/built-in-scripts/confluence-administration-built-in-script/bulk-delete-comments-from-one-or-more-pages

Use _Bulk Delete Comments from One or More Pages_ to delete all comments that are older than a specified age from one or more pages. You can select all pages within a page tree (a page and all of its children), select individual pages within a space, or a combination of both.

## Run the script

To run the script, follow these steps: 

1.  Select the **Space**.
    
2.  Select the parent or children pages you want to update for **Select a Space**. 
    
3.  For **Select Minimum Age of Comments to Be Deleted**, choose the minimum age of comments to be deleted.
    
    Comments older than the minimum specified age will be deleted. For example if you select the _1 day option_, comments older than a day will be deleted on your specified pages.
    
4.  Select **Run**.  
    ![](/sr4cc/files/latest/114204185/128387450/2/1686597944000/image2021-12-15_9-3-42.png)

### Results

Once you select Run, the results will appear. The results will tell you how many comments were deleted and how many pages they were on. 

![](/sr4cc/files/latest/114204185/179608761/1/1684778442000/generic_results.png)

## Example

### Remove comments from one page

Follow these steps to remove all comments from one page: 

1.  Enter _HR_ for **Space** to select the _Internal HR Space_. 
2.  Select the pages you want to work with for **Select a Space**. For this example, we're picking Role _Salaries_. 
3.  Select _1 day_ for **Select Minimum Age of Comments to Be Deleted** to choose comments that have been created more than 24 hours ago. 
4.  Select **Run**.   
    ![](/sr4cc/files/latest/114204185/179608760/1/1684778477000/bulk_delete_comments_example.png)

#### Results

After you select **Run**, the results appear: 

![](/sr4cc/files/latest/114204185/179608759/1/1684778544000/bulk_delete_comments_example_results.png)
