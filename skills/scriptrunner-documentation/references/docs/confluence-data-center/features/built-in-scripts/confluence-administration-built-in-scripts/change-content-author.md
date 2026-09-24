# Change Content Author

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Built-In Scripts > Confluence Administration Built-In Scripts
- Doc ID: doc-sr4c-bb0f783d-6224-4133-be58-03b36240d331-7bb0b7258dc09141
- Source: https://docs.adaptavist.com/sr4c/latest/features#built-in-scripts--en#confluence-administration-built-in-scripts--en#change-content-author--en

Using this built-in script, you can change the author of Confluence content, like pages, blog posts, comments and attachments.

You can only change the original _Created By_ author; the _Page History_ and the _Last Modified_ authors of the content are unmodified after this script runs.

## Run the script

Follow these steps to run the built-in script:

Warning: Regardless of the space where you run this script, it affects every space where you are a space admin unless otherwise specified in the CQL query.

1.  Navigate to General Configuration > ScriptRunner > Built-In Scripts.
2.  Select Change Content Author.
3.  Enter a CQL statement to identify what content and users you want to work with in CQL Query.
    
    Tip: CQL tips
    
    -   CQL autocomplete is available on this field. Start typing to see possible CQL statements.
    -   See the [CQL Guide](https://docs.adaptavist.com/sr4c/latest/get-started/cql-guide) for help with CQL.
    -   Click Show Examples to reveal more CQL examples.
    
4.  Select the author to work with by using their username in New Author.
5.  Select Run.
    
    You can select Preview instead of Run to view changes before implementing them.
    

Once you select Run, the Result of the script appears in a bulleted lists letting you know what was updated.

## Example

Let's say your product team had a brainstorming week in a particular space, called _Development Planning_ (spacekey is _DP_). During a refinement meeting, the team decided what ideas would be put on the roadmap and labelled them with `product_roadmap`. Now, you want your tech lead to be assigned to all of those different pages, blogs, and attachments with that label. Follow these steps to change the original content author:

1.  Navigate to General Configuration > ScriptRunner > Built-In Scripts.
2.  Select Change Content Author.
3.  For CQL Query, enter space = DP AND label = product\_roadmap.
4.  For New Author, enter tech\_lead.
5.  Select Run.
    

Each page in the _Development Planning_ space that was labeled as the `product_roadmap` are now assigned to the _tech\_lead_ as the original content author, no matter who they were created by.
