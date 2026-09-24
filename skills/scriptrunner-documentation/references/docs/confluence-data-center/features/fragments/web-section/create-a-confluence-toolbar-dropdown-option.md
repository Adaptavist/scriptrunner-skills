# Create a Confluence Toolbar Dropdown Option

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Fragments > Web Section
- Doc ID: doc-sr4c-3dc65442-a33a-4068-b1f9-a6d50f7a440b-8d95235b75bfa197
- Source: https://docs.adaptavist.com/sr4c/latest/features#fragments--en#web-section--en#create-a-confluence-toolbar-dropdown-option--en

A two-step process for a workaround to influde Javascript to add necessary classes and attributes to the partent of a dropdown.

If a web section does not work correctly in Confluence, there is a workaround. You can include JavaScript (JS) to add necessary classes and attributes to the parent dropdown to make it work. Follow this two-step process to create a dropdown section that includes JS:

## Part one: Create a web item

The first step of this process is to add a web item. This creates the main button in the toolbar:

1.  Navigate to General Configuration > ScriptRunner > Fragments.
2.  Select Create Fragment.
3.  Select Custom Web Item.
4.  Fill out the form to create your web item:
    
5.  Select Add.

This is the menu button you will see after clicking Add:

## Part two: Create a web panel

This process's second step is adding a web panel, which adds the dropdown buttons. Follow these steps:

1.  Navigate to General Configuration > ScriptRunner > Fragments.
2.  Select Create Fragment.
3.  Select Show a Web Panel.
4.  Fill out the form to create a web panel to add a web section, child menu, and JS:
    
    Tip: Code for Provider Class/Script Field
    
    The code used in the example follows:
    
    ```
    writer.write("""
    <nav id="child-menu-link-content" class="aui-dropdown2 aui-style-default" aria-hidden="true">
        <div class="aui-dropdown2-section">
            <ul id="child-menu-link-leading" class="menu-hidden">
                <li><a href="https://google.com">Google</a></li>
            </ul>
        </div>
    </nav>
     
    <script lang="text/javascript">
        function addDropdownAttributes(link, name){
            link.attr("aria-haspopup", "true");
            link.attr("aria-owns", name + "-menu-link-content")
            link.addClass("aui-nav-link");
            link.addClass("aui-dropdown2-trigger");
        }
     
        var srDropDown = AJS.\$('a#parent-dropdown');
        addDropdownAttributes(srDropDown, "child");
    </script>
    """)
    ```
    
5.  Select Add.

The dropdown appears like this in the Confluence instance:
