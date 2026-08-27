# Finding Objects IDs in monday.com

- Platform: connect
- Space: SRC
- Hierarchy: get-started
- Doc ID: doc-src-288721929
- Source: https://docs.adaptavist.com/src/latest/get-started/finding-objects-ids-in-monday-com

Use this page to learn how to obtain the IDs for [Monday.com](http://monday.com) objects, like boards, items, and columns. When you have the IDs of your desired objects, you can use them in your scripts.

Enter developer mode 💻

To find object IDs, you must [enable developer mode](https://developer.monday.com/api-reference/docs/getting-started-1#developer-mode). This enables viewing IDs in the UI and/or shows IDs in the browser URL. 

Not sure how to find the ID of an object you need to use in a script? Check out [Managed API for monday.com](https://docs.adaptavist.com/src/latest/managed-apis/managed-api-for-monday-com).

Click one of the following links to view more information about finding object IDs in monday.com: 

## Account

To find the account ID, execute the following GraphQL in the API playground: 

```
query {
	account {
		id
		name
	}
}
```

You can access the API playground by navigating to **Account** > **Developers** > **API Playground** on [monday.com](http://monday.com).

## Boards

To see the board ID, click on the board and check the browser URL. For example, the board URL should look like `[https://youraccount.monday.com/boards/123456789](https://youraccount.monday.com/boards/123456789)`. The `123456789` part is the ID.

![A screenshot of the Board ID shown in the URL. ](/src/files/latest/288721929/288721933/1/1728397702000/board-id.png)

## Board views

To find the board view URL, click on a board view and check the browser URL. The board view URL should look like `[https://youraccount.monday.com/boards/123456789/views/987654321](https://youraccount.monday.com/boards/123456789/views/987654321)`. The board view URL is the last sequence of numbers in the URL, `987654321`.

![A screenshot of the Board URL in the address bar.](/src/files/latest/288721929/288721934/1/1728397702000/boardview-id.png)

## Column

To find the column ID, hover over a column title and click the ellipses. A pop-up dialog displays the ID. Click on it to copy it to your clipboard.

![The column ID highlighted in the Monday.com interface.](/src/files/latest/288721929/288721935/1/1728397702000/column-id.png)

## Document (Monday doc)

To get the document ID, click on a document to bring up the document pop-up. On the top left of the screen, you can see the document ID:

![The Document ID highlighted in the document pop-up.](/src/files/latest/288721929/288721936/1/1728397702000/document-id.png)

As indicated in the image, the URL does not have the document ID.

Document block

You can find a document block's ID by using the following GQL query:

```
query {
	docs(ids: 123-YOUR-DOCUMENT-ID-7938) { //change this with your document ID
		blocks {
			id
			content
		}
	}
}
```

Alternatively, you could run this script in ScriptRunner Connect and check the logs: 

```
import Monday from "./api/monday";

export default async function(event: any, context: Context):
Promise<void> {

	const resp = await Monday.Doc.DocBlock.getDocBlocks({
		args: {
			ids: [23-YOUR-DOCUMENT-ID-7938]
		},
		fields: {
			blocks: {
				fields: {
					id: true,
					content: true
				}
			}
		}
	})

	resp.data.docs.forEach ( doc => {
		doc.blocks.forEach( block => {
			console.log(`Block with id : "${block.id}" and
content: ${block.content} `);
		})
	})
}
```

A third way to find the document block ID is as follows:

1.  Right-click on the document block, then click **Copy Link**.
2.  Paste the link into a text editor.
3.  Find the value that follows the `blockid`.

![A screenshot of copying the link for the associated document block.](/src/files/latest/288721929/288721937/1/1728397703000/documentblock-id.png)

The URL should look like `https://youraccount.monday.com/boards/123456789/pulses/123456789?doc_id=123456789&blockId=fbe7c7eb-e575-48aa-a52d-132aec26fdf4`. In this case, the document block ID is `fbe7c7eb-e575-48aa-a52d-132aec26fdf4`. 

## File (asset)

To find a file ID, click on a file to open the asset screen. The URL should look like `https://youraccount.monday.com/boards/1321359671/pulses/132135968C?asset_id=30284600`. The file ID is the sequence of numbers at the end of the URL, `30284600`. 

![The File ID highlighted in the URL.](/src/files/latest/288721929/288721938/1/1728397703000/asset-id.png)

## Folder

Click the ellipses next to the folder title to find the folder ID. The ID will appear in the pop-up dialog box.

![The Folder ID shown from the ellipsis pop-up options.](/src/files/latest/288721929/288721939/1/1728397703000/folder-id.png)

## Group

Currently, you cannot find a group ID by looking at the UI. You can find them with a GraphQL query in monday.com's API playground. 

```
query {
	boards(ids: 123-BOARD_ID-789) { //make sure to replace this board ID with the board you are working with
		groups {
			id
			title
		}
	}
}
```

![Example Board ID and Group IDs shown in the Monday.com interface.](/src/files/latest/288721929/288721940/1/1728397703000/group-id-help.png)

Alternatively, you could run this script in ScriptRunner Connect and check the logs: 

```
import Monday from "./api/monday";

export default async function(event: any, context: Context):
Promise<void> {

	const resp = await Monday.Board.Group.getGroups({
		args: {
			ids: [ 123-BOARD_ID-789 ]
		},
		fields: {
			groups: {
				fields: {
					id: true,
					title: true
				}
			}
		}
	})
	resp.data.boards.forEach ( board => {
		board.groups.forEach( group => {
			console.log(`Id for group ${group.title} is "$
{group.id}"`);
		})
	})
}
```

![Example Board ID and Group IDs shown in the ScriptRunner Connect interface.](/src/files/latest/288721929/288721941/1/1728397703000/item_id.png)

## Item/subitem

To find an item or subitem ID, click on it and check the browser URL. The URL should look like `https://youraccount.monday.com/boards/123456789/pulses/987987987`. The item ID is the last number sequence in the URL, which in this case is `987987987`.

![The associated item ID highlighted in the URL.](/src/files/latest/288721929/288721942/1/1728397703000/item-2.png)

Alternatively, you can add the column type _Item ID_, which allows you to copy an item ID to your clipboard by clicking on a value in the column.

![The Item ID option shown in Monday.com.](/src/files/latest/288721929/288721943/1/1728397703000/item-1.png)

Here, you can see the ID on the board once you add the _Item ID_ column type: 

![Item IDs shown in the associated column on Monday.com.](/src/files/latest/288721929/288721944/1/1728397703000/board-with-IDs.png)

## Item update

To find the ID of an item update, follow these steps:

1.  Click on an item and open the _Updates_ section.
2.  Click the ellipses, then click **Copy Link to Update**. 
3.  Paste the link into a text editor. 

The URL that is pasted should look like `https://youraccount.monday.com/boards/123456789/pulses/654654654/posts/789789798`. The item update ID is the last number sequence in the URL, `789789798.` 

## Team

You can find the team ID by running a GQL like this: 

```
query {
	teams {
		id
		name
	}
}
```

Alternatively, you could run this script in ScriptRunner Connect and check the logs: 

```
import Monday from "./api/monday";

export default async function(event: any, context: Context):
Promise<void> {

	const resp = await Monday.Team.getTeams({
		fields: {
			id: true,
			name: true
		}
	})

	resp.data.teams.forEach ( team => {
		console.log(`Team with id : ${team.id} and name: "$
{team.name}" `);
	})
}
```

## User

To find the user ID, open the user page for a user and look at the browser URL:

![The User ID shown in the URL.](/src/files/latest/288721929/288721930/1/1728397702000/user-ID.png)

## Webhook

To find the webhook ID, find your webhook in the board automations. There, you'll find the webhook ID labelled as _Automation ID_.

![The Webhook ID shown on the webhook automations board.](/src/files/latest/288721929/288721931/1/1728397702000/webhook-id.png)

## Workspace

To find the workspace ID, click on the workspace and check the browser URL. The URL should look like `https://youraccount.monday.com/workspaces/123456`. The workspace ID is the last number sequence in the URL, `123456`.

![The workspace ID shown in the URL.](/src/files/latest/288721929/288721932/1/1728397702000/workspace-id.png)
