# Managed API for monday.com

- Platform: connect
- Space: SRC
- Hierarchy: managed-apis
- Doc ID: doc-src-288721919
- Source: https://docs.adaptavist.com/src/latest/managed-apis/managed-api-for-monday-com

Since monday.com uses GraphQL, we have designed our managed APIs a bit differently than the rest of the REST-backed managed API interfaces.

Low-level approach

If you do not want to use our managed API to communicate with monday.com, you can manually construct GraphQL queries and post them via the [Fetch API](https://docs.adaptavist.com/src/latest/scripting/fetch-api). Or you can also use the [gql-query-builder](https://www.npmjs.com/package/gql-query-builder) (third-party package) if you don't want to construct the GraphQL queries by hand.

When specifying parameters for the monday.com managed API call, you can specify the following options:

-   `args` - An object that allows you to define a list of arguments you would like to pass along.
-   `fields` - An object that allows you to define a list of fields to be returned. Specify `true` for the fields you would like to retrieve. Some fields have sub-fields (nested), and fields in them can have sub-fields, in which case you need to specify another object to be able to drill down. Use our code editor's IntelliSense to determine which fields are nested and which are not (see the example below). Nested fields can contain additional `args` fields if the GraphQL allows additional sub-querying to be performed.
-   `complexity` - An object that allows you to define [complexity](https://developer.monday.com/api-reference/reference/complexity) fields.
-   `errorStrategy` - An object that allows you to define error strategy scenarios. (This works the same as the other managed APIs.)
-   `headers` - An object that allows you to define HTTP request headers. (This works the same as the other managed APIs.)

Response fields

Fields returned with the response are automatically inferred from the fields you specified in the request. This means our managed API will only allow you to try to read a field you explicitly mentioned you want to have returned with the response (check the example below).

## Example

For example, let's try to get the boards from monday.com.

When we start typing out the fields, we can get the list of all supported fields and see which kind of value type the field supports. (You may need to press **CTRL + Space** to open the tooltip overlay to check the value types). In the case of the **communication** field, we can see that it accepts a `boolean` value type, which means that it is not a nested field, and we can simply ask it to be returned if we pass the `true` value to that field.

![Code editor with 'await Monday.Board.getBoards' function. Dropdown menu lists fields like 'communication', highlighted in blue, with tooltip note.](/src/files/latest/288721919/288721927/1/1727960365000/Screenshot+2024-10-03+at+14.18.40.png)

However, when looking at the `creator` field, we can see the value type to be an object which has an inner `fields`  object, which means that the field is nested (comes with sub-fields).

![Code snippet showing a highlighted 'creator' field in a dropdown list. An arrow points to a tooltip displaying 'BoardFields.creator' description.](/src/files/latest/288721919/288721926/1/1727960364000/Screenshot+2024-10-03+at+14.29.42.png)

If we now drill down to sub-fields of the `creator`, we can see a new list of fields that the `creator` object exposes, in this case `birthday` is a regular field, as it accepts the `boolean` value type.

![Code snippet shows a data request using JavaScript, highlighting ](/src/files/latest/288721919/288721925/1/1727960364000/Screenshot+2024-10-03+at+14.31.40.png)

However, `account` field is another sub-field because it accepts an object that has another set of fields under it. In other words, you can expect the field structure to be hierarchical, and looking at the expected value types, whether they are `boolean` or `objects` value types best indicate how the API call needs to be structured.

![Code snippet showing a variable assignment in JavaScript with a dropdown menu listing fields like account, birthday, and email. A tooltip describes ](/src/files/latest/288721919/288721924/1/1727960364000/Screenshot+2024-10-03+at+14.33.56.png)

Optionally, a sub-field can also accept a new set of arguments ("args") to further filter out the returned data.

![Code snippet showing JavaScript with an autocomplete dropdown. The highlighted ](/src/files/latest/288721919/288721923/1/1727960364000/Screenshot+2024-10-03+at+14.36.41.png)

Now that we have figured out which arguments we need to pass along and which fields we want to have returned, we can make the API call. In our case, asking a board containing an ID of `123` to be returned and also asking for the `creator.birthday` and creator `creator.account.name` fields to be returned.

```
const response = await Monday.Board.getBoards({
	args: {
		ids: [123]
	},
	fields: {
		creator: {
			fields: {
				birthday: true,
				account: {
					fields: {
						name: true
					}
				}
			}
		}
	}
});
```

To access the returned data, we can get the list of `boards`  from the `data` object in the `response` and since we apply type inferencing on the managed API level, we'll be only seeing the fields that we explicitly asked for in the request.

 ![Tooltip showing JavaScript code snippet details the properties of a board creator, includes birthday and name fields with true values, highlighted by arrow.](/src/files/latest/288721919/288721922/1/1727960364000/Screenshot+2024-10-03+at+14.42.57.png)

![Screenshot of code editor showing a tooltip. The highlighted word is ](/src/files/latest/288721919/288721921/1/1727960364000/Screenshot+2024-10-03+at+14.44.11.png)

![Code snippet showing an auto-complete suggestion for a JavaScript object property. Highlighted text suggests ](/src/files/latest/288721919/288721920/1/1727960364000/Screenshot+2024-10-03+at+14.44.53.png)

**Templates for monday.com ⚙️**

Interested in ScriptRunner Connect templates that use the monday.com APIs? [See them here.](https://templates.scriptrunnerconnect.com/?apps=monday.com)

## Managed API examples

Here are examples of various GraphQL queries and how you would structure them with our managed APIs.

Group

Method

GraphQL example

Manage API example

Notification

create\_notification

```
mutation {
  	create_notification (user_id: 12345678, 
		target_id: 674387, 
		text: "This is a notification", 
		target_type: Project) {
    text
  }
}
```

  

  

```
Monday.Notification.createNotification({
    args: {
        user_id: 12345678,
        target_id: 674387,
        text: "This is a notification",
        target_type: "Project"
    },
    fields: {
        text: true
    }
 })
```

Teams

teams

```
query {
    teams {
        name
        picture_url
        users {
            created_at
            phone
        }
    }
}
```

```
Monday.Team.getTeams({
    fields: {
        name: true,
        picture_url: true,
        users: {
            fields: {
                created_at: true,
                phone: true
            }
        }
    }
})
```

  

add\_teams\_to\_board

```
mutation {
    add_teams_to_board (board_id: 1234567890,
    team_ids: [654321, 123456]) {
        id
    }
}
```

```
Monday.Team.addTeamsToBoard({
    args: {
        board_id: 1234567890,
        team_ids: [654321, 123456]
    },
    fields: {
        id: true
    }
})
```

  

add\_teams\_to\_workspace

```
mutation {
    add_teams_to_workspace (workspace_id: 1234567,
    team_ids: [123456, 654321, 012345]) {
        id
    }
}
```

```
Monday.Team.deleteTeamsFromWorkspace({
    args: {
        workspace_id: 1234567,
        team_ids: [123456, 654321, 012345]
    },
    fields: {
        id: true
    }
})
```

  

delete\_teams\_from\_workspace

```
mutation {
    delete_teams_from_workspace (workspace_id: 1234567,
    team_ids: [123456, 654321, 012345]) {
        id
    }
}
```

```
Monday.Team.deleteTeamsFromWorkspace({
	args: {
    	workspace_id: 1234567,
        	team_ids: [123456, 654321, 65498]
        },
    fields: {
    	id: true
    }
})
```

Boards

boards

```
query {
    boards (ids: 1234567890) {
        name
        state
        id
        permissions
    }
}
```

```
Monday.Board.getBoards({
    args: {
        ids: [1234567890]
    },
    fields: {
        name: true,
        state: true,
        id: true,
        permissions: true  
    }
})
```

  

create\_board

```
mutation {
    create_board (board_name: "my board", board_kind: public) {
        id
    }
}
```

```
Monday.Board.createBoard({
    args: {
        board_name: "my board",
        board_kind: "public"
    },
    fields: {
        id: true
    }
})
```

  

duplicate\_board

```
mutation {
    duplicate_board(
	board_id: 1234567890,
    duplicate_type:    
    duplicate_board_with_structure)        
    {
        board {
            id
        }
    }
}
```

```
Monday.Board.duplicateBoard({
    args: {
        board_id: 1234567890,
        duplicate_type: "duplicate_board_with_structure"
    },
    fields: {
        id: true
    }
})
```

  

update\_board

```
mutation {
    update_board(board_id: 1234567890,
    board_attribute: description,
	new_value: "This is my new description")
}
```

```
Monday.Board.updateBoard({
    args: {
        board_id: 1234567890,
        board_attribute: "description",
        new_value: "This is my new description"
    }
})
```

  

archive\_board

```
mutation {
    archive_board (board_id: 1234567890) {
        id
    }
}
```

```
Monday.Board.archiveBoard({
    args: {
        board_id: 1234567890
    },
    fields: {
        id: true
    }
})
```

  

delete\_board

```
mutation {
    delete_board (board_id: 1234567890) {
        id
    }
}
```

```
Monday.Board.deleteBoard({
    args: {
        board_id: 1234567890
    },
    fields: {
        id: true
    }
})
```

  

delete\_subscribers\_from\_board

```
mutation {
    delete_subscribers_from_board(board_id: 1234567890, 
	user_ids: [12345678, 87654321, 01234567]) {
        id
    }
}
```

```
Monday.Board.deleteSubscribersFromBoard({
    args: {
        board_id: 1234567890,
        user_ids: [12345678, 87654321, 1234567]
    },
    fields: {
        id: true
    }
})
```

Groups

groups

```
query {
    boards (ids: 1234567890) {
        groups {
            title
            id
        }
    }
}
```

```
Monday.Board.Group.getGroups({
    args: {
        ids: [1234567890]
    },
    fields: {
        groups: {
            fields: {
                title: true,
                id: true
            }
        }
    }
})
```

  

create\_group

```
mutation {
    create_group (board_id: 1234567890,
    group_name: "new group", 
	relative_to: "test_group", 
    position_relative_method: before_at) {
        id
    }
}
```

```
Monday.Board.Group.createGroup({
    args: {
        board_id: 1234567890,
        group_name: "new group",
        relative_to: "test_group",
        position_relative_method: "before_at"
    },
    fields: {
        id: true
    }
})
```

  

update\_group

```
mutation {
    update_group (board_id: 1234567890,
    group_id: "test group id",
    group_attribute: relative_position_before,
    new_value: "test_group") {
        id
    }
}
```

```
Monday.Board.Group.updateGroup({
    args: {
        board_id: 1234567890,
        group_id: "test group id",
        group_attribute: "relative_position_before",
        new_value: "test_group"
    },
    fields: {
        id: true
    }
})
```

  

duplicate\_group

```
mutation {
    duplicate_group (board_id: 1234567890,
    group_id: "test group id", 
	add_to_top: true) {
        id
    }
}
```

```
Monday.Board.Group.duplicateGroup({
    args: {
        board_id: 1234567890,
        group_id: "test group id",
        add_to_top: true
    },
    fields: {
        id: true
    }
})
```

  

archive\_group

```
mutation {
    archive_group (board_id: 1234567890,
    group_id: "test group id") {
        id
        archived
    }
}
```

```
Monday.Board.Group.archiveGroup({
    args: {
        board_id: 1234567890,
        group_id: "test group id"
    },
    fields: {
        id: true,
        archived: true
    }
})
```

  

delete\_group

```
mutation {
    delete_group (board_id: 1234567890,
    group_id: "test group id") {
        id
        deleted
    }
}
```

```
Monday.Board.Group.deleteGroup({
    args: {
        board_id: 1234567890,
        group_id: "test group id"
    },
    fields: {
        id: true,
        deleted: true
    }
})
```

  

move\_item\_to\_group

```
mutation {
    move_item_to_group (item_id: 1234567890,
    group_id: "test group id") {
        id
    }
}
```

```
Monday.Item.moveItemToGroup({
    args: {
        item_id: 1234567890,
        group_id: "test group id"
    },
    fields: {
        id: true
    }
})
```

Board views

views

```
query {
    boards (ids: 1234567890) {
        views {
            type
            settings_str
            view_specific_data_str
            name
            id
        }
    }
}
```

```
Monday.Board.View.getViews({
    args: {
        ids: [1234567890]
    },
    fields: {
        views: {
            fields: {
                type: true,
                settings_str: true,
                view_specific_data_str: true,
                name: true,
                id: true
            }
        }
    }
})
```

Items

items

```
query {
    items (ids: [1234567890, 9876543210,
    2345678901]) {
        name
    }
}
```

```
Monday.Item.getItems({
    args: {
        ids: [1234567890, 9876543210, 2345678901]
    },
    fields: {
        name: true
    }
})
```

  

create\_item

```
mutation {
    create_item (board_id: 1234567890, 
	group_id: "group_one",
    item_name: "new item", 
	column_values: "{\"date\":\"2023-05-25\"}") {
        id
    }
}
```

```
Monday.Item.createItem({
    args: {
        board_id: 1234567890,
        group_id: "group_one",
        item_name: "new item",
        column_values: {
            "date" : "2023-05-25"
        }
    },
    fields: {
        id: true
    }
})
```

  

duplicate\_item

```
mutation {
    duplicate_item (board_id: 1234567890,
    item_id: 9876543210,
    with_updates: true) {
        id
    }
}
```

```
Monday.Item.duplicateItem({
    args: {
        board_id: 1234567890,
        item_id: 9876543210,
        with_updates: true
    },
    fields: {
        id: true
    }
})
```

  

move\_item\_to\_group

```
mutation {
    move_item_to_group (item_id: 1234567890,
    group_id: "group_one") {
        id
    }
}
```

```
Monday.Item.moveItemToGroup({
    args: {
        item_id: 1234567890,
        group_id: "group_one"
    },
    fields: {
        id: true
    }
})
```

  

move\_item\_to\_board

```
mutation {
    move_item_to_board (board_id:1234567890,
    group_id: "new_group",
    item_id: 9876543210, 
	columns_mapping: [
			{source: "status", target: "status2"},
    		{source: "person", target: "person"},
    		{source: "date", target: "date4"}]) {
        id
    }
}
```

```
Monday.Item.moveItemToBoard({
    args: {
        board_id:1234567890,
        group_id: "new_group",
        item_id:9876543210,
        columns_mapping: [
            {source:"status", target:"status2"},
            {source:"person", target:"person"},
            {source:"date", target:"date4"}
        ]
    },
    fields: {
        id: true
    }
})
```

  

archive\_item

```
mutation {
    archive_item (item_id: 1234567890) {
        id
    }
}
```

```
Monday.Item.archiveItem({
    args: {
        item_id: 1234567890
    },
    fields: {
        id: true
    }
})
```

  

delete\_item

```
mutation {
    delete_item (item_id: 1234567890) {
        id
    }
}
```

```
Monday.Item.deleteItem( {
    args: {
        item_id: 1234567890
    },
    fields: {
        id: true
    }
})
```

  

clear\_item\_updates

```
mutation {
    clear_item_updates (item_id: 1234567890) {
        id
    }
}
```

```
Monday.Item.clearUpdates({
    args: {
        item_id: 1234567890
    },
    fields: {
        id: true
    }
})
```

Subitems

subitems

```
query {
    items (ids: 1234567890) {
        subitems {
            id
            column_values {
                value
                text
            }
        }
    }
}
```

```
Monday.Item.Subitem.getSubitems({
    args: {
        ids: [1234567890]
    },
    fields: {
        subitems: {
            fields: {
                id: true,
                column_values: {
                    fields: {
                        value: true,
                        text: true
                    }
                }
            }
        }
    }
})
```

  

create\_subitem

```
mutation {
    create_subitem (parent_item_id: 1234567, 
		item_name: "new subitem") {
        id
        board {
            id
        }
    }
}
```

```
Monday.Item.Subitem.createSubitem({
    args: {
        parent_item_id: 1234567,
        item_name: "new subitem"
    },
    fields: {
        id: true,
        board: {
            fields: {
                id: true
            }
        }
    }
})
```

Me

me

```
query {
    me {
        is_guest
        created_at
        name
        id
    }
}
```

```
Monday.Me.getUserDetails({
    fields: {
        is_guest: true,
        created_at: true,
        name: true,
        id: true
    }
})
```

Users

users

```
query {
    users (limit: 50) {
        created_at
        email
        account {
            name
            id
        }
    }
}
```

```
Monday.User.getUsers({
    args: {
        limit: 50
    },
    fields: {
        created_at: true,
        email: true,
        account: {
            fields: {
                name: true,
                id: true
            }
        }
    }
})
```

  

add\_users\_to\_board

```
mutation {
    add_users_to_board (board_id: 1234567890,
    user_ids: [123456, 234567, 345678], 
	kind: owner) {
        id
    }
}
```

```
Monday.User.addUsersToBoard({
    args: {
        board_id: 1234567890,
        user_ids: [123456, 234567, 345678],
        kind: "owner"
    },
    fields: {
        id: true
    }
})
```

  

add\_users\_to\_workspace

```
mutation {
    add_users_to_workspace (workspace_id: 1234567,
    user_ids: [123456, 654321, 012345], 
	kind: subscriber) {
        id
    }
}
```

```
Monday.User.addUsersToWorkspace({
    args: {
        workspace_id: 1234567,
        user_ids: [123456, 654321, 2012345],
        kind: "subscriber"
    },
    fields: {
        id: true
    }
})
```

  

delete\_users\_from\_workspace

```
mutation {
    delete_users_from_workspace (workspace_id: 1234567, 
	user_ids: [123456, 654321, 012345]) {
        id
    }
}
```

```
Monday.User.deleteUsersFromWorkspace({
    args: {
        workspace_id: 1234567,
        user_ids: [123456, 654321, 2012345]
    },
    fields: {
        id: true
    }
})
```

  

```
delete_subscribers_from_board
```

```
mutation {
	delete_subscribers_from_board(board_id: 1234567890, 
	user_ids: [12345678, 87654321, 01234567]) {
    	id
	}
}
```

```
Monday.Board.deleteSubscribersFromBoard({
    args: {
        board_id: 1234567890,
        user_ids: [12345678, 87654321, 1234567]
    },
    fields: {
        id: true
    }
})
```

Files

assets

```
query {
    assets (ids: [22145900, 22145929]) {
        id
        url
        name
    }
}
```

```
Monday.File.getAssets({
    args: {
        ids: [22145900, 22145929],
    },
    fields: {
        id: true,
        url: true,
        name: true
    }
})
```

  

add\_file\_to\_update

```
mutation {
    add_file_to_update (update_id: 123456789, 
	file: YOUR_FILE) {
        id
    }
}
```

```
Monday.File.addFileToUpdate({
    args: {
        update_id: 123456789,
        file: {
            fileName: "text.txt",
            content: "some text, but you can also pass an ArrayBuffer"
        },
    },
    fields: {
        id: true
    }
})
```

  

add\_file\_to\_column

```
mutation {
    add_file_to_column (item_id: 1234567890, 
	column_id: "files", 
	file: YOUR_FILE) {
        id
    }
}
```

```
Monday.File.addFileToColumn({
    args: {
        item_id: 1234567890,
        column_id: "files",
        file: {
            fileName: 'a file.ext',
            content: "some text, but you can also pass an ArrayBuffer"
        }
    },
    fields: {
        id: true
    }
})
```

Columns

columns

```
query {
    boards (ids: 1234567890) {
        columns {
            id
            title
        }
    }
}
```

```
Monday.Board.getBoards({
	args: {
		ids: [1234567890]
	},
	fields: {
		columns: {
			fields: {
				id: true,
				title: true
			}
		}
	}
})
```

  

create\_column

```
mutation{
    create_column(board_id: 1314658881, 
	title:"Check", 
	description: "Check this if you love Mondays", 
	column_type:checkbox) {
        id
        title
        description
    }
}
```

```
Monday.Column.createColumn({
    args: {
        board_id: 1314658881,
        title:"Project domain",
        description: "This column indicates the domain of each project.",
        column_type: "status",
        defaults: {
            'labels': {
                '1': 'Information technology',
                '2': 'Human resources',
                '3': 'Customer service',
                '4': 'Other'
            }
        }
    },
    fields: {
        id: true,
        title: true,
        description: true
    }
})
```

  

create\_column (with custom labels)

```
mutation {
    create_column(board_id: 1314658881
    title: "Project domain"
    column_type: status
    description: "This column indicates the domain of each project."
    defaults: "{
		\"labels\":
			{\"1\": \"Information technology\", 
			\"2\": \"Human resources\", 
			\"3\": \"Customer service\", 
			\"4\": \"Other\"}}") {
        id
    }
}
```

```
Monday.Column.createColumn({
    args: {
        board_id: 1314658881,
        title:"Project domain",
        description: "This column indicates the domain of each project.",
        column_type: "status",
        defaults: {
            'labels': {
                '1': 'Information technology',
                '2': 'Human resources',
                '3': 'Customer service',
                '4': 'Other'
            }
        }
    },
    fields: {
        id: true,
        title: true,
        description: true
    }
})
```

  

change\_column\_value

```
mutation {
    change_column_value (board_id: 1234567890, 
	item_id: 9876543210,
    column_id: "email9", 
	value: "{\"text\": \"test@gmail.com\", \"email\": \"test@gmail.com\"}") {
        id
    }
}
```

```
Monday.Column.changeColumnValue({
    args: {
        board_id: 1234567890,
        item_id: 9876543210,
        column_id: "email9",
        value: {'text': 'test@gmail.com', 'email': 'test@gmail.com'}
    },
    fields: {
        id:true
    }
})
```

  

change\_simple\_column\_value

```
mutation {
    change_simple_column_value (board_id: 1234567890, 
	item_id: 9876543210,
    column_id: "status", 
	value: "Working on it") {
        id
    }
}
```

```
Monday.Column.changeSimpleColumnValue({
    args: {
        board_id: 1234567890,
        item_id: 9876543210,
        column_id: "status",
        value: "Working on it"
    },
    fields: {
        id: true
    }
})
```

  

change\_multiple\_column\_values

```
mutation {
    change_multiple_column_values (item_id: 1234567890, 
	board_id: 9876543210, 
	column_values: "{
		\"status\": {\"index\": 1},
		\"date4\": {\"date\": \"2021-01-01\"}, 
		\"person\" : {\"personsAndTeams\": [{\"id\": 9603417, \"kind\": \"person\"}]}}") {
        id
    }
}
```

```
Monday.Column.changeMultipleColumnValues({
    args: {
        item_id: 1234567890,
        board_id: 9876543210,
        column_values: {
            'status': {'index': 1},
            'date4': {'date': '2021-01-01'},
            'person': {
                'personsAndTeams': [
                    {'id':9603417, 'kind': 'person'}
                ]
            }
        }
    },
    fields: {
        id: true
    }
})
```

  

change\_column\_title

```
mutation {
    change_column_title (board_id: 1234567890, 
	column_id: "status", 
	title: "new_status") {
        id
    }
}
```

```
Monday.Column.changeColumnTitle({
    args: {
        board_id: 1234567890,
        column_id: "status",
        title: "new_status"
    },
    fields: {
        id: true
    }
})
```

  

change\_column\_metadata

```
mutation {
    change_column_metadata(board_id: 1234567890, 
	column_id: "date4",
    column_property: description, 
	value: "This is my awesome date column"){
        id
        title
        description
    }
}
```

```
Monday.Column.changeColumnMetadata({
    args: {
        board_id: 1234567890,
        column_id: "date4",
        column_property: description,
        value: "This is my awesome date column"
    },
    fields: {
        id: true,
        title: true,
        description: true
    }
})
```

  

delete\_column

```
mutation {
    delete_column (board_id: 1234567890, column_id: "status") {
        id
    }
}
```

```
Monday.Column.deleteColumn({
    args: {
        board_id: 1234567890,
        column_id: "status"
    },
    fields: {
        id: true
    }
})
```

Workspaces

workspaces

```
query {
    workspaces (ids: [486615]) {
        id
        name
    }
}
```

```
Monday.Workspace.getWorkspaces({
    args: {
        ids: [486615]
    }, 
	fields: {
        id: true,
        name: true
    }
})
```

  

create\_workspace

```
mutation {
    create_workspace (name: "New Cool Workspace",
    kind: open, 
	description: "This is a cool description") {
        id
        description
    }
}
```

```
Monday.Workspace.createWorkspace({
    args: {
        name:"New Cool Workspace",
        kind: "open",
        description: "This is a cool description"
    },
    fields: {
        id: true,
        description: true
    }
})
```

  

delete\_workspace

```
mutation {
    delete_workspace (workspace_id: 1234567) {
        id
    }
}
```

```
Monday.Workspace.deleteWorkspace({
    args: {
        workspace_id: 1234567
    },
    fields: {
		id: true
	}
})
```

  

add\_users\_to\_workspace

```
mutation {
    add_users_to_workspace (workspace_id: 1234567, 
	user_ids: [12345678, 87654321, 01234567], 
	kind: subscriber) {
        id
    }
}
```

```
Monday.User.addUsersToWorkspace({
    args: {
        workspace_id: 1234567,
        user_ids: [12345678, 87654321, 501234567],
        kind: "subscriber",
    }, 
	fields: {
		id: true
	}
})
```

  

delete\_users\_from\_workspace

```
mutation {
	delete_users_from_workspace (workspace_id: 1234567, 
	user_ids: [12345678, 87654321, 91234567]) {
        id
    }
}
```

```
Monday.User.deleteUsersFromWorkspace({
    args: {
        workspace_id: 1234567,
        user_ids: [12345678, 87654321, 91234567]
    }, 
	fields: { 
		id: true 
	}
})
```

  

add\_teams\_to\_workspace

```
mutation {
    add_teams_to_workspace(workspace_id: 1234567, 
	team_ids: [12345678, 87654321, 91234567]) {
        id
    }
}
```

```
Monday.Team.addTeamsToWorkspace({
    args: {
        workspace_id: 1234567,
        team_ids: [12345678, 87654321, 91234567]
    }, 
	fields: { 
		id: true
	}   
})
```

  

delete\_teams\_from\_workspace

```
mutation {
    delete_teams_from_workspace
    (workspace_id: 1234567, 
	team_ids: [12345678, 87654321, 91234567]) {
        id
    }
}
```

```
Monday.Team.deleteTeamsFromWorkspace({
    args: {
        workspace_id: 1234567,
        team_ids: [12345678, 87654321, 91234567]
    }, 
	fields: { 
		id: true 
	}   
})
```

Updates

updates

```
query {
    updates (limit: 100) {
        body
        id
        created_at
        creator {
            name
            id
        }
    }
}
```

```
Monday.Update.getUpdates({
    args: { 
		limit: 100 
	},
    fields: {
        body: true,
        id: true,
        created_at: true,
        creator: {
            fields: {
                name: true,
                id: true
            }
        }
    }
})
```

  

create\_update

```
mutation {
    create_update (item_id: 1234567890,
    body: "This update will be added to the item") {
        id
    }
}
```

```
Monday.Update.createUpdate({
    args: {
        item_id: 1234567890,
        body: "This update will be added to the item"
    }, 
	fields: { 
		id: true 
	}
})
```

  

like\_update

```
mutation {
    like_update (update_id: 1234567890) {
        id
    }
}
```

```
Monday.Update.likeUpdate({
    args: { 
		update_id: 1234567890 
	},
    fields: { 
		id: true 
	}
})
```

  

clear\_item\_updates

```
mutation {
    clear_item_updates (item_id: 1234567890) {
        id
    }
}
```

```
Monday.Item.clearUpdates({
    args: {
        item_id: 1234567890
    },
    fields: { 
		id: true 
	}
})
```

  

delete\_update

```
mutation {
    delete_update (id: 1234567890) {
        id
    }
}
```

```
Monday.Update.deleteUpdate({
    args: { 
		id: 1234567890 
	},
    fields: { 
		id: true 
	}
})
```

Complexity

query

```
query {
    complexity {
        before
        query
        after
        reset_in_x_seconds
    }
    boards (ids: 1315573556) {
    	items_page {
    		cursor
    		items {
    			id
        		name
       		}
   		}
    }
}
```

```
Monday.Board.ItemsPage.getItemsPage({
    args: {
        ids: [1315573556]
    },
    fields: {
        items_page: {
             
            fields: {
                items: {
                    fields: {
                        id: true,
                        name: true
                    }
                },
                cursor: true
            }
        }
    },
    complexity: {
        before: true,
        query: true,
        after: true,
        reset_in_x_seconds: true
    }

})
```

  

mutation

```
mutation {
	complexity {
    	query
    	before
    	after
    }
    create_item(board_id:1315573556, item_name:"test item") {
    	id
    }
}
```

```
Monday.Item.createItem({
    args: {
        board_id: 1315573556,
        item_name: 'test item'
    },
    fields: {
        id: true
    },
    complexity: {
        query: true,
        before: true,
        after: true
    }
})
```

Docs

docs

```
query {
	docs (object_ids: 123456789, limit: 1) {
    	id
    	object_id
    	settings
    	created_by {
        	id
        	name
      	}
    }
}
```

```
Monday.Doc.getDocs({
    args: {
        object_ids: [123456789],
        limit: 1
    },
    fields: {
        id: true,
        object_id: true,
        settings: true,
        created_by: {
            fields: {
                id: true,
                name: true
            }
        }
    }
})
```

  

create\_doc

```
mutation {
  	create_doc (location: {
		workspace: { 
			workspace_id: 12345678, 
			name:"New doc", 
			kind: private}}) {
    	id
  	}
}
```

```
Monday.Doc.createDoc({
    args: {
        location: {
            workspace: {
                workspace_id: 12345678,
                name: 'New doc',
                kind: 'private'
            }
        }
    },
    fields: {
        id: true
    }
})
```

Document blocks

blocks

```
query {
  	docs (ids:1234567) {
    	blocks {
      	id
      	type
      	content
    	}
  	}
}
```

```
Monday.Doc.DocBlock.getDocBlocks({
    args: {
        ids: [1234567]
    },
    fields: {
        blocks: {
            fields: {
                id: true,
                type: true,
                content: true
            }
        }
    }
})
```

  

create\_doc\_block

```
mutation {
 	create_doc_block (type: normal_text,
	doc_id: 1234567,
	after_block_id: "7f8c145-989f-48bb-b7f8-dc8f91690g42",
	content: "{\"alignment\": \"left\",
		\"direction\": \"ltr\",
		\"deltaFormat\":[{\"insert\":\"new block\"}]}") {
    	id
  	}
}
```

```
Monday.Doc.DocBlock.createDocBlock({
    args: {
        type: 'normal_text',
        doc_id: 1234567,
        after_block_id: "7f8c145-989f-48bb-b7f8-dc8f91690g42",
        content: "{\"alignment\":\"left\",\"direction\":\"ltr\",\"deltaFormat\":[{\"insert\":\"new block\"}]}"
    },
    fields: {
        id: true
    }
})
```

  

update\_doc\_block

```
mutation {
  	update_doc_block (block_id: "7f8c145-989f-48bb-b7f8-dc8f91690g42",
	content: "{\"alignment\": \"left\",
		\"direction\":\"ltr\", 
		\"deltaFormat\":[{\"insert\":\"new block\"}]}") {
    	id
  	}
}
```

```
Monday.Doc.DocBlock.updateDocBlock({
    args: {
        block_id: "7f8c145-989f-48bb-b7f8-dc8f91690g42",
        content: "{\"alignment\":\"left\",\"direction\":\"ltr\",\"deltaFormat\":[{\"insert\":\"new block\"}]}"
    },
    fields: {
        id: true
    }
})
```

  

delete\_doc\_block

```
mutation {
 	delete_doc_block (block_id: "7f8c145-989f-48bb-b7f8-dc8f91690g42") {
    	id
  	}
}
```

```
Monday.Doc.DocBlock.deleteDocBlock({
    args: {
        block_id: "7f8c145-989f-48bb-b7f8-dc8f91690g42"
    },
    fields: {
        id: true
    }
})
```

Folders

folders

```
query {
  	folders (workspace_ids: 1234567890) {
    	name
    	id
    	children {
      		id
      		name
    	}
  	}
}
```

```
Monday.Folder.getFolders({
    args:{
        workspace_ids: [1234567890]
    },
    fields: {
        name: true,
        id: true,
        children: {
            fields: {
                id: true,
                name: true
            }
        }
    }
})
```

  

create\_folder

```
mutation {
  	create_folder (name: "New folder", workspace_id: 1234567890) {
    	id
  	}
}
```

```
Monday.Folder.createFolder({
    args: {
        name: "New folder",
        workspace_id: 1234567890
    },
    fields: {
        id: true
    }
})
```

  

update\_folder

```
mutation {
  	update_folder (folder_id: 1234567890, 
		name: "Updated folder name") {
    	id
  	}
}
```

```
Monday.Folder.updateFolder({
    args: {
        folder_id: 1234567890,
        name: "Updated folder name"
    },
    fields: {
        id: true
    }
})
```

  

delete\_folder

```
mutation {
  	delete_folder (folder_id: 1234567890) {
    	id
  	}
}
```

```
Monday.Folder.deleteFolder({
    args: {
        folder_id: 1234567890
    },
    fields: {
        id: true
    }
})
```

Items page

items\_page

```
query {
  	boards (ids: 1234567890){
    	items_page (limit: 1, 
			query_params: { rules: [{ column_id: "status", 
				compare_value: [1]}], 
				operator: and }) {
      		cursor
      		items {
        		id
        		name
      		}
    	}
  	}
}
```

```
Monday.Board.ItemsPage.getItemsPage({
    args: {
        ids: [1234567890]
    },
    fields: {
        items_page: {
            args: {
                limit: 1,
                query_params: {
                    rules: [{
                        column_id: 'status',
                        compare_value: [1]
                    }],
                    operator: "and"
                }
            },
            fields: {
                cursor: true,
                items: {
                    fields: {
                        id: true,
                        name: true
                    }
                }
            }
        },
         
    }
})
```

Items page by column values

items\_page\_by\_column\_values

```
query {
  	items_page_by_column_values (limit: 50, 
		board_id: 1234567890, 
		columns: [{ column_id: "text", column_values: ["This is a text column"]}, 
			{column_id: "country", column_values: ["US", "IL"]}]) {
    	cursor
    	items {
      		id
      		name
    	}
  	}
}
```

```
Monday.ItemsPage.getItemsPageByColumnValues({
    args: {
        limit: 50,
        board_id: 1234567890, 
		columns: [{
            column_id: "text", 
			column_values: ["This is a text column"]
        },
        {
            column_id: "country", 
			column_values: ["US", "IL"]
        }] 
    },
    fields: {
        cursor: true,
        items: {
            fields: {
                id: true,
                name: true
            }
        }
    }
})
```

Tags

tags

```
query {
  	tags (ids: [1, 2, 4, 10]) {
    	name
  	}
}
```

```
Monday.Tag.getTags({
    args: { 
		ids: [1,2,4,10] 
	},
    fields: { 
		name: true 
	}
})
```

  

tags (nested inside a boards query)

```
query {
  	boards (ids: 1234567890) {
    	tags {
      		id
    	}  
  	}
}
```

```
Monday.Board.Tag.getTags({
    args: {
        ids: [1234567890]
    },
    fields: {
        tags: {
            fields: {
                id: true
            }
        }
    }
})
```

  

create\_or\_get\_tag

```
mutation {
  	create_or_get_tag (tag_name: "amazing") {
    	id
  	}
}
```

```
Monday.Tag.createOrGetTag({
    args: { 
		tag_name: 'amazing' 
	},
    fields: { 
		id: true 
	}
})
```

  

change\_column\_value

```
mutation {
  	change_column_value(board_id:1315573556, 
		item_id: 1348959142, 
		value: "{\"tag_ids\":[4720128]}", column_id: "tags") {
    	id
  	} 
}
```

```
Monday.Column.changeColumnValue({
    args: {
        board_id: 1315573556,
        item_id: 1348959142,
        value: "{\"tag_ids\":[4720128]}",
        column_id: "tags"
    },
    fields: {
        id: true
    }
})
```

Versions

versions

```
query {
 	version {
    	kind
    	value
  	}
}
```

```
Monday.Version.getVersion({
    fields: {
        kind: true,
        value: true
    }
})
```

Webhooks

webhooks

```
query {
  	webhooks(board_id: 1234567890){
    	id
    	event
    	board_id
    	config
  	}
}
```

```
Monday.Webhook.getWebhooks({
    args: {
        board_id: 123456790
    },
    fields: {
        id: true,
        event: true,
        board_id: true,
        config: true
    }
})
```

  

create\_webhook

```
mutation {
  	create_webhook (board_id: 1234567890, 
		url: "https://www.webhooks.my-webhook/test/", 
		event: change_status_column_value, 
		config: "{\"columnId\":\"status\", \"columnValue\":{\"$any$\":true}}") {
    	id
    	board_id
  	}
}
```

```
Monday.Webhook.createWebhook({
    args: {
        board_id: 1234567890,
        url: "https://www.webhooks.my-webhook/test/",
        event: 'change_status_column_value',
        config : {
            columnId: 'status',
            columnValue : {
                "$any$" : true
            }
        }  
    },
    fields: {
        id: true,
        board_id: true
    }
})
```

  

delete\_webhook

```
mutation {
  	delete_webhook (id: 12) {
    	id
    	board_id
  	}
}
```

```
Monday.Webhook.deleteWebhook({
    args: { 
		id: 12 
	},
    fields: { 
		id: true, 
		board_id: true 
	}
})
```
