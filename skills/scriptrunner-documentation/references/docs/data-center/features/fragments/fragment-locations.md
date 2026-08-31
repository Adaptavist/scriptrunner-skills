# Fragment Locations

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > fragments
- Doc ID: doc-sr4js-442886101
- Source: https://docs.adaptavist.com/sr4js/latest/features/fragments/fragment-locations

Fragment locations are key to creating a [Fragment](https://docs.adaptavist.com/display/_PK/SR4JS/script-fragments). For example, if you want to create a button (web link), or banner (web panel), you need to know where to put it. 

## Web item and web panel locations

The following pages highlight a number of fragment locations you can find throughout Jira. These pages are not an extensive list of fragment locations but list the locations we think you might want to use:

###### [Web Item Locations](https://docs.adaptavist.com/sr4js/latest/features/fragments/fragment-locations/web-item-locations)

Discover fragment locations where you can add a custom link or button. 

###### [Web Panel Locations](https://docs.adaptavist.com/sr4js/latest/features/fragments/fragment-locations/web-panel-locations)

Discover fragment locations where you can add a custom banner. 

## Fragment locator

If you want a complete list of fragment locations, or if you require binding variables for a fragment location, you should enable the [fragment locator](https://docs.adaptavist.com/display/_PK/SR4JS/script-fragments#fragment-locator). 

Enabling the fragment locator will change the appearance of every page for every single user, so this feature **should not** be enabled in a production system. If you are not working on a production system, you can enable the fragment locator.

## Using web item and web panel locations

Fragment locations tend to start with either **Item:** or **Panel:** to indicate the type of fragment. An **[Item](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-item)** location typically indicates a predefined section where you can add a link or a button. A **[Panel](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-panel)** location is somewhere you can add a custom banner. 

When referring to a fragment location in a UI fragment, you do not need to include **Item:**, **Panel:** or **location:** in the name. For example, if the fragment location is `Item:home_link/dashboard_link_main`, when prompted to enter a location you would need to enter or find `home_link/dashboard_link_main.`

  

* * *

## Related content

-   [Fragments](https://docs.adaptavist.com/display/_PK/SR4JS/script-fragments)
-   [Web Item](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-item)
-   [Web Panel](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-panel)
