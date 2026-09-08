# Copy Field Values

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > built-in-scripts
- Doc ID: doc-sr4js-442886812
- Source: https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/copy-field-values

Use Copy Field Values to copy the values from a configured field to another on the same Jira instance. This built-in script can save you time when creating fields with the same values, eliminating the need for manual input of values.

See below for a detailed list of supported fields. If a field is not visible in your instance, then the field is not supported by this built-in script.

Notifications

When you use this built-in script to bulk update issues, users are not notified of the change according to the project notification scheme. 

## Create options

In some instances, a **Create option** checkbox becomes available for certain fields. This allows new options to be created if a matching one does not exist in the target field.

## Supported fields

See the tables below for a detailed list of [system and common custom fields](#id-.CopyCustomFieldValuesv9.x-common), [standard custom fields](#id-.CopyCustomFieldValuesv9.x-standard), and [advanced custom fields](#id-.CopyCustomFieldValuesv9.x-advanced) that are supported by this built-in script. There are some things you must bear in mind when using this built-in script:

-   Source and target fields must be different. **Copying a field's value to itself is not permitted.**
-   The fields available to you will vary depending on which version of Jira you have and whether you have installed Jira Service Management. If you cannot see a field, it is likely that it is not available on your instance. 

Copying values to the same field type

When you're copying values to a field of the same type, for example, from checkboxes to checkboxes, values will only be copied if the target field has the same values available. If the target field lacks any of the source field's values, existing selections in the target field may be cleared. For partial matches, only the shared values will be copied, and any non-matching values in the target field will be cleared.

### Supported system fields and common Jira custom fields

Source field

Supported target fields

Approvers

-   CAB
-   Change managers

CAB

-   Approvers
-   Change managers

Change completion date

-   Change start date
-   Target end
-   Target start

Change managers

-   Approvers
-   CAB

Change reason

Show/hide supported fields...

-   Change risk (Create option checkbox appears)
    
-   Change type
-   Description
-   Impact (Create option checkbox appears)
-   Investigation reason (Create option checkbox appears)
-   Pending reason (Create option checkbox appears)
-   Root cause
-   Source (Create option checkbox appears)
-   Summary
-   Urgency (Create option checkbox appears)
-   Workaround

Change risk

Show/hide supported fields...

-   Change reason (Create option checkbox appears)
-   Change type
-   Description
-   Impact (Create option checkbox appears)
-   Investigation reason (Create option checkbox appears)
-   Linked major incidents
-   Operational categorization
-   Organizations
-   Original story points
-   Parent link
-   Pending reason (Create option checkbox appears)
-   Product categorization
-   Root cause
-   Source (Create option checkbox appears)
-   Summary
-   Urgency (Create option checkbox appears)
-   Workaround

Change start date

-   Change completion date
-   Target end
-   Target start

Change type

Show/hide supported fields...

-   Change reason
-   Change risk
-   Description
-   Impact (Create option checkbox appears)
-   Investigation reason (Create option checkbox appears)
-   Linked major incidents
-   Operational categorization
-   Organizations
-   Original story points
-   Parent link
-   Pending reason (Create option checkbox appears)
-   Product categorization
-   Root cause
-   Source (Create option checkbox appears)
-   Summary
-   Urgency (Create option checkbox appears)
-   Workaround

Customer request type

-   Description
-   Environment
-   Root cause
-   Summary
-   Workaround

Description

-   Environment
-   Root cause
-   Summary
-   Workaround

Environment

-   Description
-   Root cause
-   Summary
-   Workaround

Epic color

No compatible fields

Epic link

-   Description
-   Environment
-   Root cause
-   Summary
-   Workaround

Epic name

No compatible fields

Epic status

No compatible fields

Groups

No compatible fields

Impact

Show/hide supported fields...

-   Change reason (Create option checkbox appears)
-   Change risk (Create option checkbox appears)
-   Change type (Create option checkbox appears)
-   Description
-   Environment
-   Investigation reason (Create option checkbox appears)
-   Pending reason (Create option checkbox appears)
-   Root cause
-   Source (Create option checkbox appears)
-   Summary
-   Urgency (Create option checkbox appears)
-   Workaround

Investigation reason

Show/hide supported fields...

-   Change reason (Create option checkbox appears)
-   Change risk (Create option checkbox appears)
-   Change type (Create option checkbox appears)
-   Description
-   Environment
-   Impact (Create option checkbox appears)
-   Pending reason (Create option checkbox appears)
-   Root cause
-   Source (Create option checkbox appears)
-   Summary
-   Urgency (Create option checkbox appears)
-   Workaround

Linked major incidents

No compatible fields

Operational categorization

-   Product categorization

Organizations

-   Description
-   Environment
-   Root cause
-   Summary
-   Workaround

Original story points

-   Description
-   Environment
-   Summary
-   Workaround

Parent link

No compatible fields

Pending reason

Show/hide supported fields...

-   Change reason (Create option checkbox appears)
-   Change risk (Create option checkbox appears)
-   Change type (Create option checkbox appears)
-   Description
-   Environment
-   Impact (Create option checkbox appears)
-   Investigation reason (Create option checkbox appears)
-   Root cause
-   Source (Create option checkbox appears)
-   Summary
-   Urgency (Create option checkbox appears)
-   Workaround

Product categorization

-   Operational categorization

Request participants

-   Approvers
-   CAB
-   Change managers

Root cause

-   Description
-   Environment
-   Summary
-   Workaround

Source

Show/hide supported fields...

-   Change reason (Create option checkbox appears)
-   Change risk (Create option checkbox appears)
-   Change type (Create option checkbox appears)
-   Description
-   Environment
-   Impact (Create option checkbox appears)
-   Investigation reason (Create option checkbox appears)
-   Pending reason (Create option checkbox appears)
-   Root cause
-   Summary
-   Urgency (Create option checkbox appears)
-   Workaround

Sprint

-   Description
-   Environment

Story points

-   Description
-   Environment
-   Root cause
-   Workaround

Summary

Show/hide supported fields...

-   Change reason (Create option checkbox appears)
-   Change risk (Create option checkbox appears)
-   Change type (Create option checkbox appears)
-   Description
-   Environment
-   Impact (Create option checkbox appears)
-   Investigation reason (Create option checkbox appears)
-   Pending reason (Create option checkbox appears)
-   Root cause
-   Source (Create option checkbox appears)
-   Urgency (Create option checkbox appears)
-   Workaround

Target end

-   Change completion date
-   Change start date
-   Target start

Target start

-   Change completion date
-   Change start date
-   Target end

Team

No compatible fields

Urgency

Show/hide supported fields...

-   Change reason (Create option checkbox appears)
-   Change risk (Create option checkbox appears)
-   Change type (Create option checkbox appears)
-   Description
-   Environment
-   Impact (Create option checkbox appears)
-   Investigation reason (Create option checkbox appears)
-   Pending reason (Create option checkbox appears)
-   Root cause
-   Source (Create option checkbox appears)
-   Summary
-   Workaround

Workaround

Show/hide supported fields...

-   Change reason (Create option checkbox appears)
-   Change risk (Create option checkbox appears)
-   Change type (Create option checkbox appears)
-   Description
-   Environment
-   Impact (Create option checkbox appears)
-   Investigation reason (Create option checkbox appears)
-   Pending reason (Create option checkbox appears)
-   Root cause
-   Source (Create option checkbox appears)
-   Summary
-   Urgency (Create option checkbox appears)

### Supported standard custom fields

Source field

Supported target fields

Checkboxes

-   Checkboxes
-   Radio buttons
-   Select list (multiple choices)
-   Select list (single choice)
-   Text field (single-line)

Database picker custom field

 No compatible fields

Date picker

-   Date picker
-   Date time picker

Date time picker

-   Date picker
-   Date time picker

Labels

-    Labels

Multiple user picker

-   Multiple user picker
-   User picker (single user)
-   User picker (multiple users)

If a multi user picker value is copied into a single user picker then only the first value is copied.

  

Multiple issue picker

-    Multiple issue picker

Multiple LDAP picker

-    Multiple LDAP picker

Multiple remote issue picker

-    Multiple remote issue picker

Number field

-   Number field
-   Text field (multi-line)
-   Text field (single-line)
-   Text field (read only)

Radio buttons

-   Checkboxes
-   Radio buttons
-   Select list (multiple choices)
-   Select list (single choice)

Select list (cascading)

-    Select list (cascading)

Select list (multiple choices) 

-   Checkboxes
-   Radio buttons
-   Select list (multiple choices) - Create option checkbox appears
-   Select list (single choice) - Create option checkbox appears
-   Text field (multi-line)
-   Text field (single-line)
-   Text field (read only)

For single choice select lists only the first value is copied. 

Select list (single choice) 

-   Checkboxes
-   Radio buttons
-   Select list (multiple choices) - Create option checkbox appears
-   Select list (single choice) - Create option checkbox appears
-   Text field (multi-line)
-   Text field (single-line)
-   Text field (read only)

Single custom picker

 No compatible field

Single database values picker

 No compatible fields

Single issue picker 

-    Single issue picker

Single LDAP picker

 No compatible fields

Single remote issue picker 

-    Single remote issue picker 

Text field (multi-line)

-   Select list (multiple choices)
-   Select list (single choice)
-   Text field (multi-line)
-   Text field (single-line)
-   Text field (read only)

Text field (single-line) 

-   Select list (multiple choices) - Create option checkbox appears
-   Select list (single choice) - Create option checkbox appears
-   Text field (multi-line)
-   Text field (single-line)
-   Text field (read only)

URL field 

-   Text field (multi-line)
-   Text field (single-line)
-   URL field
-   Text field (read only)

User picker (single user)

-   Multiple user picker
-   User picker (single user)
-   User picker (multiple users)

### Supported advanced custom fields

Source field

Supported target fields

Development summary

No compatible fields

Global rank

No compatible fields

Group picker (multiple groups)

  

-   Group picker (multiple groups)
-   Group picker (single group) 

  

For single group pickers only the first value is copied. 

Group picker (single group) 

-   Group picker (multiple groups)
-   Group picker (single group) 

Hidden job switch

No compatible fields

Jira released version history

-   Jira released version history

Job checkbox

-   Job checkbox

Original story points

-   Number field
-   Text field (multi-line)
-   Text field (single-line)
-   Original story points
-   Text field (read only)

Project picker (single project) 

-   Project picker (single project) 

Scripted field

No compatible fields

Text field (read only)

-   Text field (multi-line)
-   Text field (single-line)
-   Text field (read only)

User picker (multiple versions) 

  

-   Multiple user picker
-   User picker (single user)
-   User picker (multiple users)

  

If a multi user picker value is copied into a single user picker then only the first value is copied.

Version picker (multiple versions)

-   Version picker (multiple versions)
-   Version picker (single version) 

Version picker (single version) 

-   Version picker (multiple versions)
-   Version picker (single version) 

Assets object

-   Assets object
-   Assets object (legacy multiple)
-   Assets object (legacy single)
-   Assets read-only object
-   Assets referenced object (multiple)
-   Assets referenced object (single)

Assets object (legacy multiple)

-   Assets object
-   Assets object (legacy multiple)
-   Assets object (legacy single)
-   Assets read-only object
-   Assets referenced object (multiple)
-   Assets referenced object (single)

Assets object (legacy single) 

-   Assets object
-   Assets object (legacy multiple)
-   Assets object (legacy single)
-   Assets read-only object
-   Assets referenced object (multiple)
-   Assets referenced object (single)

Assets read-only object

-   Assets object
-   Assets object (legacy multiple)
-   Assets object (legacy single)
-   Assets read-only object
-   Assets referenced object (multiple)
-   Assets referenced object (single)

Assets referenced object (multiple)

-   Assets object
-   Assets object (legacy multiple)
-   Assets object (legacy single)
-   Assets read-only object
-   Assets referenced object (multiple)
-   Assets referenced object (single)

Assets referenced object (single)

-   Assets object
-   Assets object (legacy multiple)
-   Assets object (legacy single)
-   Assets read-only object
-   Assets referenced object (multiple)
-   Assets referenced object (single)

Initial watchers

-   Initial watchers

## Using this built-in script

To copy fields between supported field types:

1.  From ScriptRunner, navigate to **Built-in Scripts > Copy field values**.
2.  Select a **Filter ID**. Issues returned by this filter are modified only if they contain both the source and target fields.
    
    Only saved JQL filters show up in **Filter ID**. For more information on how to create and save custom filters see [Saving Your Search as a Filter](https://confluence.atlassian.com/jiracoreserver/saving-your-search-as-a-filter-939937724.html).
    
3.  Under **Source Field**, select a field. Values will be copied from this field to the **Target Field**.
    
    For select lists, if an option from the source field is not [configured](https://confluence.atlassian.com/adminjiraserver/configuring-a-custom-field-938847235.html) in the available target field, it is skipped. For example, the source field has options AA and BB configured, and the target field has options AA and CC configured. In this case only option AA is copied to the target field. If none of the options in the source field exist in the target and **Create Options** is unchecked, the target field will be cleared.
    
4.  Under **Target Field**, select a field. All values are copied from the **S****ource Field** to this field.
    
    If the target field already contains values, they are overwritten by any copied values.
    
5.  Select **Preview** to see the number of issues affected by the change.  
    ![Image of the copy field values built in script](/sr4js/files/latest/442886812/442886831/1/1758746742000/Copy_field_values.png)  
    
6.  Select **Run**. Source fields are copied to target fields where applicable.
    

  

* * *

## Related content

-   [Script Fields](https://docs.adaptavist.com/sr4js/latest/features/script-fields)
-   [Script Field Tutorial](https://docs.adaptavist.com/sr4js/latest/features/script-fields/script-field-tutorial)
-   [Custom Script Field Examples](https://docs.adaptavist.com/sr4js/latest/features/script-fields/custom-script-field/custom-script-field-examples)
