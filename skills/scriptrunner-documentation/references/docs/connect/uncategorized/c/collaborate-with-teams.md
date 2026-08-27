# Collaborate with Teams

- Platform: connect
- Space: SRC
- Hierarchy: n/a
- Doc ID: doc-src-194675415
- Source: https://docs.adaptavist.com/src/latest/collaborate-with-teams

Teams in ScriptRunner Connect allow colleagues and clients to come together and collaborate within a shared space within the app. 

The Teams module in ScriptRunner Connect:

-   Serves as a container for sharing workspaces with others
-   Provides a dashboard of usage statistics on connectors, script invocations, and record storage shared by the entire group
-   Makes it easy to manage members and admins of the teams
-   Consolidates billing options, plans, and limits.

Wanna jump ahead?

-   [Creating a Team](#id-.CollaboratewithTeamsvCurrent-creating-an-org)
-   [Sharing a Workspace with a Team](#id-.CollaboratewithTeamsvCurrent-sharing-a-workspace)

## Collaboration

Workspaces within a team can be shared with coworkers and/or clients, which allows these other members to view and edit the workspace.

A workspace can be edited only by a single member at a time. Any other members who access the workspace while it is being edited are shown a read-only version of the workspace. Members in the read-only version can assume edit control over the workspace by removing edit control from the current editor. The same principle applies to private workspaces opened in multiple browser tabs or by another person using the same user account.

**Shared user accounts 🧕 🧑**

Sharing user accounts for the purpose of resource sharing is not a recommended practice. Use the _Teams_ module instead.

### Common editing courtesy 

Taking edit control over the workspace is instantaneous. Give a heads-up to the person currently editing the workspace so they can save their changes.

## Shared connectors

Connectors in workspaces shared within a team are shared implicitly, meaning that other members of the team who can access the workspace can use the connectors attached to your workspace without explicit permission. Implicitly shared connectors can only be used by triggering scripts from the workspace using the connectors.

Other members of the workspace cannot edit or reauthorize implicitly shared connectors.

### Connector ownership

Use caution when making changes to API connections or event listeners that have an implicitly shared connector attached. Once you make a change, you cannot reattach a connector that was implicitly shared before. In other words, you can only attach connectors that you personally own. If such a mistake happens, contact the person who owns the connector and ask them to reattach the connector.

**Future consideration 💡 🤔**

We're considering adding a feature that allows explicit connector sharing so other team members can use, edit, and reauthorize shared connectors in any of their workspaces within the same team without the aforementioned limitations.

Like this idea? [Let us know!](https://scriptrunnerconnect.nolt.io/top)

## Creating a team

1.  Click **Teams** on the left-side navigation to access the module. 
2.  Click **Create New**.  
    The Team wizard appears.
3.  Complete the details on the three Team wizard screens.
    1.  Enter the Team details, including the team name, description, and logo, then click **Next**.
    2.  Select a plan, then click **Next**.
        
        **Pricing plans—a few things to remember! 👈 👌**
        
        -   Keep in mind that each team has a separate price plan.
        -   Adaptavist partners receive one ScriptRunner Connect Platinum tier for free, in which they can host all their integrations.
        
    3.  Input the billing contact information, then click **Create**.  
        Your new team is created, and the dashboard appears.

**Attention, Adaptavist Partners!** 📢

Once your team is created, you can request ScriptRunner Connect discount codes and activate your free Platinum Plan through the support page of the Adaptavist Partner Portal. Enjoy!

## Share a workspace with a team

Workspaces can be shared with a single team. You can share workspaces with team administrators only (enabled by default) or with all team members.

Here's how to do it.

1.  Click **Workspaces** on the left-side navigation to access the module. 
2.  Open the workspace you want to share with a team.
3.  Click **Workspace Actions (ellipses menu) > Edit Workspace** on the right side of the workspace.  
    ![The ](/src/files/latest/194675415/194675412/1/1695215912000/edit-workspace.png)  
    The _Edit Workspace_ dialog appears.   
      
    
4.  Select a team from the **Add to Team** dropdown list.   
    ![The ](/src/files/latest/194675415/194675413/1/1695215912000/add-to-a-team.png)  
      
    
5.  Click **Save**.   
    The workspace is added to the team, and the shared badge appears at the workspace header.  
    ![The shared badge highlighted in the workspace screen.](/src/files/latest/194675415/194675414/1/1695215912000/team-badge.png)

Now you can click **Share** while viewing the workspace to access sharing options. You can also review and update team member roles by going to **Teams > Member Management**.

**Future consideration 💡 🤔**

We're considering adding a third option to share the workspace with select members only.

Like this idea? [Let us know!](https://scriptrunnerconnect.nolt.io/top)

### Team role details

Teams offer three different roles: _Member_, _Admin_, and _Super Admin_.

_Members_ can do the following:

-   Associate workspaces with teams they are members of
-   Access workspaces that are explicitly shared with all members
-   View team usage metrics
-   View team details
-   View teams members

_Admins_ can do the following (in addition to the Member role):

-   Access all workspaces associated with the team
-   Invite new members to the team
-   Edit roles of admins and members (but not super admins)
-   Change workspace-sharing settings
-   Move workspaces from one team to another (if at least an admin on both teams)

_Super Admins_ can do the following (in addition to the Admin role):

-   Edit the roles of all members
-   Change team plans
-   Change team billing details
-   Change billing options
-   Delete a team
