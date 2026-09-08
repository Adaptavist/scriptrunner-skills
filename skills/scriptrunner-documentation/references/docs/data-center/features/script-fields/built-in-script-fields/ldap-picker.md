# LDAP Picker

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > script-fields > built-in-script-fields
- Doc ID: doc-sr4js-442887921
- Source: https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/ldap-picker

The _LDAP Picker_ scripted field displays LDAP records returned by a pre-configured search query from a [connected LDAP server](https://docs.adaptavist.com/sr4js/latest/features/resources/ldap-connection).

Examples for usage include:

-   Pick a user in a specific department, or with a certain manager.
    
-   Selection of any other entity type in your corporate LDAP instance.
    

Before creating an _LDAP Picker_ field, you must set up a connection to the target LDAP server in the [Resources](https://docs.adaptavist.com/sr4js/latest/features/resources) tab.

### Usage

1.  Enter the field name, and select the LDAP server this field will work with.
    
2.  Enter a search query. You can use this search query to specify a base DN for the query, to select the `objectClass`, and any other criteria you need.
    
    See the **Example scipts** modal for examples.
    
    For help with the query, you should contact your _Directory Services_ department, or a local subject matter expert.
    
3.  Specify the _Search Attribute_. This attribute will be appended to the query when the Jira user starts typing. If the field is for picking a user, then searching on surname (the LDAP attribute is typically `sn`) is your best choice.
    
4.  Specify the _Display Attribute_. This is the attribute that is used for displaying, both in the select box, and in the _View Issue_ screen.
    

Example field configuration:

![Image example of LDAP picker setup](/sr4js/files/latest/442887921/442887933/1/1758746891000/LDAP_picker.png)

and in use:

![](/sr4js/files/latest/442887921/442887924/1/1758746891000/ldap-picker-usage.png)
