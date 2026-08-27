# Rename Labels

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: features > built-in-scripts > space-administration-built-in-scripts
- Doc ID: doc-sr4cc-114204510
- Source: https://docs.adaptavist.com/sr4cc/latest/features/built-in-scripts/space-administration-built-in-scripts/rename-labels

### Using _Rename Labels_, you can rename labels on a space or all spaces.

## Run the script

To run this script, follow these steps: 

1.  Decide if you want to work with all spaces or specific spaces.
    -   If you want to work with all spaces, check the **All Spaces** checkbox.
    -   If you want to work with specific spaces, select them in **Spaces**.
2.  Specify the label that you want to rename for **Choose Label**. 
    
3.  Specify the new replacement label name for **New Name**. 
    
    Labels are not case-sensitive.
    
    Labels can't contain spaces or uppercase letters. If you want a label to contain more than one word, use an underscore or a hyphen, which are the only two special characters allowed. They can contain a maximum of 255 characters.
    
4.  Select **Run**.  
    ![](/sr4cc/files/latest/114204290/128387461/3/1779824263000/image2021-12-14_13-13-2.png)
    

### Results

After you select **Run**, your results appear: 

![](/sr4cc/files/latest/114204290/179608791/1/1684782305000/rename_labels_results.png)

## Example

### Replace an incorrect label

A user added the label `style guide` to several pages, not realizing that spaces aren't allowed in labels, so there were two labels added: `style` and `guide.` The space administrator can use _Rename Labels_ to change one of the labels to `styleguide`, and use _Bulk Add or Remove Labels_ to delete the other label.

For this part of the label fixing, follow these steps: 

1.  Select _Product Documentation_ (or the name of the space you want to work with) for **Space**.
2.  Enter _style_ for **Choose Label**. 
3.  Enter _styleguide_ for **New Name**. 
4.  Select **Run**.   
    ![](/sr4cc/files/latest/114204290/179608790/1/1684782893000/rename_labels_example.png)

#### Results

You will get your success message.

![](/sr4cc/files/latest/114204290/179608791/1/1684782305000/rename_labels_results.png)

Now, navigate to Bulk Add or Remove Labels on One or More Pages to delete the `guide` label.
