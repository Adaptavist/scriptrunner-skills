# Generate Events

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Built-in scripts
- Doc ID: doc-sr4js-c70c6211-8c8e-4a99-91b6-125b6a0c6e12-7d30eeb136b13e9c
- Source: https://docs.adaptavist.com/sr4js/latest/features#built-in-scripts--en#generate-events--en

Use the _Generate Events_ built-in script to force ScriptRunner to fire an event to be consumed by a listener.

For example, you have set up automation to improve your service desk process using a listener. This listener consumes all subsequent new _Issue Created_ events, but does not take into account issues created before automation. You want all issues to be aligned, and for all existing issues to go through the new automation process. Use _Generate Events_ to fire an _Issue Created_ event for existing issues, allowing them to be picked up by the listener and passed through automation.

## Using this built-in script

1.  From ScriptRunner, navigate to the Built-in Scripts tab and click Generate Events.
2.  In Event, select the event you want ScriptRunner to fire.
    
    For example, if the listener you are trying to activate is listening for an _Issue Created_ event, select the Issue Created option.
    
3.  Enter a Filter ID.
    
    All issues affected will have an event generated.
    
    OR
    
4.  Enter a Project ID.
    
    All issues in this project have an event generated.
    
    Note:
    
    Only saved JQL filters show up in Filter ID. For more information on how to create and save custom filters, see [Saving Your Search as a Filter](https://confluence.atlassian.com/jiracoreserver/saving-your-search-as-a-filter-939937724.html)
    
5.  Click Run to fire the selected event for all issues returned by the set filters.
    
    The number of issues affected displays under _Results_.
