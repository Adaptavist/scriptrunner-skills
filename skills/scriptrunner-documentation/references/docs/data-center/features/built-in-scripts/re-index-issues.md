# Re-index Issues

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > built-in-scripts
- Doc ID: doc-sr4js-441364342
- Source: https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/re-index-issues

Use _Re-index Issues_ to re-index a project or issues returned by a filter. Re-indexing may be required after a change to the database, or when an indexing issue occurs. The _Re-index Issues_ built-in script allows you to re-index only those issues affected by the changes, saving time and reducing downtime on your Jira instance.

## Using this built-in script

1.  From ScriptRunner, navigate to **Built-in Scripts→Re-index Issues**.
    
2.  To specify which issues need re-indexing, enter either a **Filter ID** or **Project Key**:
    
    1.  Pick a filter from the list to select issues by **Filter ID**. Only issues returned by this filter are re-indexed.
        
        Only saved JQL filters show up in **Filter ID**. For more information on how to create and save custom filters see [Saving Your Search as a Filter](https://confluence.atlassian.com/jiracoreserver/saving-your-search-as-a-filter-939937724.html).
        
    2.  Enter a **Project Key** to select issues based on project. All issues in the corresponding project are re-indexed.
        
3.  Click **Preview** to see an overview of how many issues will be re-indexed.
    
    ![Image of the re-index issues built in script completed](/sr4js/files/latest/441364342/441364350/1/1737998153000/reindex-issues-preview.png)
4.  Click **Run** to re-index.
