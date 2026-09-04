# Fragments

- Platform: data-center
- Space: SR4JS
- Hierarchy: features
- Doc ID: doc-sr4js-442886041
- Source: https://docs.adaptavist.com/sr4js/latest/features/fragments

![](/sr4js/files/latest/442886041/441364782/1/1750863614000/sr-icon-cloud.png)

**Migrating to Jira Cloud? This feature has partial parity for Web Panels only in Cloud. Check out our [Cloud Feature Parity documentation](https://docs.adaptavist.com/display/_PK/SR4JC/feature-parity#ui-fragments) for more details.**

ScriptRunner UI Fragments allow you to customize the UI of your Jira instance. With the UI Fragments feature, you can quickly hide a particular issue action from specific users, add buttons to menus or pages, create buttons to open custom dialogs, create additional sections of HTML on the issue view page, and so much more. We recommend you read the Atlassian documentation on web fragments for [Jira](https://developer.atlassian.com/server/jira/platform/web-fragments-4227124/) for a general overview of fragments. 

## Available built-in UI Fragments

We have developed a number of built-in script fragments for you to use to customize your Jira instance:

-   [Custom web item](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-item): Create a custom link or button in a location of your choice.
-   [Show a web panel](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-panel): Create a section of HTML content, such as a custom banner, in a location of your choice.
-   [Create a custom web section](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-section): Create a new area, within a location of your choice, that can be used to hold web items.
-   [Hide system or plugin UI element](https://docs.adaptavist.com/sr4js/latest/features/fragments/hide-ui-element-built-in-script): Hide buttons, menus, or other UI elements so they are no longer visible for users.
-   [Constrained create issue dialog](https://docs.adaptavist.com/sr4js/latest/features/fragments/create-constrained-issue): Create a menu item that opens the _Create Issue_ dialog with a predefined project and issue type.
-   [Planning board context menu item](https://docs.adaptavist.com/sr4js/latest/features/fragments/board-context-menu-item): Create a menu item in the _context menu_ (right-click) of issues in a _Scrum_ or _Kanban_ board.
-   [Install web resource](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-resource): Include JavaScript and CSS resources into certain contexts.
-   [Custom web item provider](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-item-provider-built-in-script): Dynamically generate web items according to the current circumstances.
-   [Raw xml module](https://docs.adaptavist.com/sr4js/latest/features/fragments/raw-xml-module-built-in-script): Customize your UI using XML alone.

We recommend you test in a development environment before deploying to your production environment.

## How to use UI Fragments

ScriptRunner UI Fragments have been created to simplify the creation of plugin modules described in the [web fragments for Jira documentation](https://developer.atlassian.com/server/jira/platform/web-fragments-4227124/). You may want to use our UI Fragments built-in scripts to:

-   Create a custom banner
-   Create a custom button
-   Hide a UI element
-   Customize your CSS

All of the built-in scripts produce XML that is similar, but not interchangeable with, the XML found in a [plugin descriptor](https://developer.atlassian.com/confdev/confluence-plugin-guide/writing-confluence-plugins/creating-your-plugin-descriptor). You will notice that, for usability reasons, the forms do not provide all the possible configuration elements available in plugins. As an example, the web-item built-in script does not give you the option to provide a _tooltip_ for the web-item link, or a velocity context provider, or an icon URL. You can work around this limitation using the [raw XML module](https://docs.adaptavist.com/sr4js/latest/features/fragments/raw-xml-module-built-in-script) script.

### Duplicate a fragment

With ScriptRunner, you can easily duplicate a UI fragment from a fragment's ellipsis menu. The following happens when you duplicate a fragment:

-   The duplicated fragment automatically appears at the bottom of your _Fragments_ list.
-   The duplicated fragment is prefixed with "Copy of".
-   If applicable, the key for the duplicated fragment is suffixed with the first available number. For example, "-1" if it's the first time a fragment has been duplicated.
-   The duplicated fragment is automatically disabled. We recommend you edit the fragment before you enable it.

![Image showing what a duplicated fragment looks like](/sr4js/files/latest/442886041/442886055/1/1758746541000/Duplicate_fragment_2.jpg)

You can duplicate a UI fragment as follows:

1.  Navigate to **ScriptRunner > UI Fragments**. 
2.  Locate the fragment you wish to duplicate. 
3.  Select the ellipsis menu for your chosen fragment and choose **Duplicate**.  
    ![Image highlighting how to duplicate a fragment](/sr4js/files/latest/442886041/442886050/1/1758746541000/Duplicate_example.png)  
    The duplicated fragment appears at the bottom of your _Fragments_ list. 
4.  Select the ellipsis menu for the duplicated fragment and choose **Edit**.
5.  Edit the duplicated fragment with any details you want to add or change. 
6.  Select **Update**. You are returned to the **UI Fragments** page.
7.  When you're ready to enable the duplicated fragment, select the ellipsis menu and select **Enable**.  
    ![Image showing the Enable button selected](/sr4js/files/latest/442886041/442886082/1/1758746543000/Enable_duplicate.jpg)

## Fragment locator

The _Fragment Locator_ tool is designed to show you the location/section where you can put these fragments. You can also check out the [Fragment Locations](https://docs.adaptavist.com/sr4js/latest/features/fragments/fragment-locations) pages for a list of common [web item](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-item) and [web panel](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-panel) locations.

Currently, fragment locations only display as buttons when they have related binding information. 

![Image showing what fragment locations look like](/sr4js/files/latest/442886041/442886083/1/1758746543000/Fragment_locations_new.png)

### Enable/disable the fragment locator

You can enable/disable the fragment locator when you are creating/editing a fragment that requires a location:

![Image showing fragment locator within a fragment](/sr4js/files/latest/442886041/442886044/1/1758746541000/Enable_locator.png)

You can also enable/disable the fragment locator as follows:

1.  From ScriptRunner, navigate to **UI Fragments**. 
2.  On the _Fragments_ page, select the locator toggle to enable/disable.
    
    If you select enable, locations will display for every user on your instance, so should not be enabled in a production system. We recommend you only enable the fragment locator if you are working on a test system.
    
    ![Image showing location of fragment locator highlighted](/sr4js/files/latest/442886041/442886064/1/1758746542000/Fragment_location_new.png)
    
    Copy the location path
    
    You can copy the location path by selecting the **copy** button from the UI fragment dropdown.  
    ![](/sr4js/files/latest/442886041/442886086/1/1758746543000/Copy_location_path.png) 
    
    This feature is location-dependent to locations that have binding variables associated with them. 
    

### Create a fragment from a location

You have the following options available to you when you select the dropdown from a fragment location:

-   **Create web panel** or **Create web item**. When you select this option you are immediately taken to the [Custom web item](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-item) or [Show a web panel](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-panel) page. On these pages the **Location** dropdown is automatically filled with the location you came from. 
-   **See more fragments**. When you select this option you are immediately taken to the **Create UI Fragments** page where you can select a fragment of your choice.
    
    This option does not automatically fill the **Location** dropdown. We recommend you copy the location before you select this option. 
    

![](/sr4js/files/latest/442886041/442886087/1/1758746543000/Create_fragment.png)

## Fragment binding variables

The variables available to you with UI Fragments depends on the fragment location. The _[Fragment Locator](#id-.ScriptFragmentsv9.x-fragment-locator)_ tool can help you see which variables are available for you to use, so your scripts run as you would expect.

Fragment binding variables are context specific and knowing the available binding variables in certain context could help you to avoid unexpected scripting errors. Binding variables available for fragments when writing a script include `issue`, `jiraHelper`, and `log`. The `issue` variable can potentially be null if we cannot get the issue from the context, and `jiraHelper` can also be null if Jira does not provide it for the location where you choose to place your fragment. For example, a project settings location has no issue in the context as there is no issue on the screen, and Jira does not provide the `jiraHelper` variable within most locations on the service desk portal side.

### Access binding information

You can access binding information through the help button on any script editor:

![](/sr4js/files/latest/442886041/442886065/1/1758746542000/Binding+information.png)

### Portal specific web panels

If you want to display a web panel for a specific Service Management portal in `servicedesk.portal.header` location, create a web panel with following code in the condition section:

```
portal.id == 1
```

This code will work in portal window as binding variable _portal_ is available in Service Management portal context. But the code will throw groovy missing property exception in user window as the variable is not available in Service Management user window. To avoid this kind of scenario you should check the availability of the variable where applicable:

```
binding.variables.get("portal") && portal.id == 1
```

Test your fragment from different contexts within the Jira UI to avoid unexpected errors. If contexts are missing certain variables you will need to alter your script to check availability of the variables to avoid exceptions.
