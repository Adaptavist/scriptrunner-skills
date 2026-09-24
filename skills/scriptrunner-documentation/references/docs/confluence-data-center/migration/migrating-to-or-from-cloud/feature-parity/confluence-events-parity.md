# Confluence Events Parity

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Migration > Migrating to or from Cloud > Feature Parity
- Doc ID: doc-sr4c-36bdbad2-6e63-4ad9-879e-4dc976ed227c-ed2429fb041515b4
- Source: https://docs.adaptavist.com/sr4c/latest/migration#migrating-to-or-from-cloud--en#feature-parity--en#confluence-events-parity--en

Find which Confluence events differ between ScriptRunner for Confluence Server/DC and Cloud.

To work with our Event Listeners scripts, you must select an event for each listener. Event availability for Cloud and Data Center follow:

| Key | Definition |
| --- | --- |
|  | Available |
|  | Not Available |

## Attachment Events

| Event | Server/DC | Cloud | Cloud Name |
| --- | --- | --- | --- |
| AttachmentBatchUploadCompletedEvent |  |  |  |
| AttachmentBatchUploadedCreatedEvent |  |  |  |
| AttachmentCreateEvent |  |  | Attachment Created |
| AttachmentEvent |  |  |  |
| AttachmentRemoveEvent |  |  | Attachment Removed |
| AttachmentTrashedEvent |  |  | Attachment Trashed |
| AttachmentUpdateEvent |  |  | Attachment Updated |
| AttachmentVersionRemovedEvent |  |  |  |
| AttachmentViewEvent |  |  | Attachment Viewed |
| GeneralAttachmentBatchUploadCompletedEvent |  |  |  |
| GeneralAttachmentCreateEvent |  |  |  |
| GeneralAttachmentRemoveEvent |  |  |  |
| GeneralAttachmentRestoreEvent |  |  |  |
| GeneralAttachmentUpdateEvent |  |  |  |
| GeneralAttachmentVersionRemoveEvent |  |  |  |
| HiddenAttachmentBatchUploadCompletedEvent |  |  |  |
| HiddenAttachmentCreateEvent |  |  |  |
| HiddenAttachmentRemoveEvent |  |  |  |
| HiddenAttachmentRestoreEvent |  |  |  |
| HiddenAttachmentUpdateEvent |  |  |  |
| HiddenAttachmentVersionRemoveEvent |  |  |  |
| ProfilePictureThumbnailViewEvent |  |  |  |
| ProfilePictureViewEvent |  |  |  |
| ThumbnailViewEvent |  |  |  |

## Blog Events

| Event | Server/DC | Cloud | Cloud Name |
| --- | --- | --- | --- |
| BlogPostCreateEvent |  |  | Blog Created |
| BlogPostEvent |  |  |  |
| BlogPostInfoViewEvent |  |  |  |
| BlogPostMovedEvent |  |  |  |
| BlogPostRemoveEvent |  |  | Blog Removed |
| BlogPostRestoreEvent |  |  | Blog Restored |
| BlogPostTrashedEvent |  |  | Blog Trashed |
| BlogPostUpdateEvent |  |  | Blog Updated |
| BlogPostViewEvent |  |  | Blog Views |

## Comment Events

| Event | Server/DC | Cloud | Cloud Name |
| --- | --- | --- | --- |
| CommentCreateEvent |  |  | Comment Created |
| CommentEvent |  |  |  |
| CommentRemoveEvent |  |  | Comment Removed |
| CommentUpdateEvent |  |  | Comment Updated |

## Directory Events

| Event | Server/DC | Cloud | Cloud Name |
| --- | --- | --- | --- |
| AllPasswordsExpiredEvent |  |  |  |
| AutoGroupCreatedEvent |  |  |  |
| AuthGroupMembershipCreatedEvent |  |  |  |
| AuthGroupMembershipDeletedEvent |  |  |  |
| AutoUserCreatedEvent |  |  |  |
| AutoUserUpdatedEvent |  |  |  |
| AzureGroupsRemovedEvent |  |  |  |
| DirectoryCreatedEvent |  |  |  |
| DirectoryDeletedEvent |  |  |  |
| DirectoryUpdatedEvent |  |  |  |
| GroupAttributeDeletedEvent |  |  |  |
| GroupAttributeStoredEvent |  |  |  |
| GroupCreatedEvent |  |  |  |
| GroupDeletedEvent |  |  |  |
| GroupMembershipCreatedEvent |  |  |  |
| GroupMembershipDeletedEvent |  |  |  |
| GroupMembershipsCreatedEvent |  |  |  |
| GroupMembershipsDeletedEvent |  |  |  |
| GroupUpdatedEvent |  |  |  |
| ResetPasswordEvent |  |  |  |
| RoleCreatedEvent |  |  |  |
| RoleDeletedEvent |  |  |  |
| RoleMembershipCreatedEvent |  |  |  |
| RoleMembershipDeletedEvent |  |  |  |
| RoleUpdatedEvent |  |  |  |
| UserAttributeDeletedEvent |  |  |  |
| UserAttributeStoredEvent |  |  |  |
| UserAuthenticatedEvent |  |  |  |
| UserAuthenticationFailedInvalidAuthenticationEvent |  |  |  |
| UserCreatedFromDirectorySynchronizationEvent |  |  |  |
| UserCreatedEvent |  |  | User Created |
| UserCredentialUpdatedEvent |  |  |  |
| UserCredentialValidationFailedEvent |  |  |  |
| UserEmailChangedEvent |  |  |  |
| UserRenamedEvent |  |  |  |
| UserDeletedEvent |  |  |  |
| UserEditedEvent |  |  |  |
| UserUpdatedEvent |  |  |  |
| UsersDeletedEvent |  |  |  |

## Label Events

| Event | Server/DC | Cloud | Cloud Name |
| --- | --- | --- | --- |
| LabelAddEvent |  |  | Label Added |
| LabelCreateEvent |  |  | Label Created |
| LabelDeleteEvent |  |  | Label Deleted |
| LabelEvent |  |  |  |
| LabelRemoveEvent |  |  | Label Removed |

## Like Events

| Event | Server/DC | Cloud | Cloud Name |
| --- | --- | --- | --- |
| LikeCreatedEvent |  |  |  |
| LikeRemovedEvent |  |  |  |
| AbstractLikeEvent |  |  |  |

## Page Events

| Event | Server/DC | Cloud | Cloud Name |
| --- | --- | --- | --- |
| AbstractCopyPageHierarchyEvent |  |  |  |
| AbstractPageHierarchyEvent |  |  |  |
| CopyPageHierarchyFinishEvent |  |  |  |
| CopyPageHierarchyStartEvent |  |  |  |
| DeletePageHierarchyFinishEvent |  |  |  |
| DeletePageHierarchyStartEvent |  |  |  |
| PageChildrenReorderEvent |  |  | Page Children Reordered |
| PageCopyEvent |  |  |  |
| PageCreateEvent |  |  | Page Created |
| PageCreateFromTemplateEvent |  |  |  |
| PageEvent |  |  |  |
| PageInfoViewEvent |  |  |  |
| PageMoveEvent |  |  | Page Moved |
| PageRemoveEvent |  |  | Page Removed |
| PageRestoreEvent |  |  | Page Restored |
| PageTrashedEvent |  |  | Page Trashed |
| PageUpdateEvent |  |  | Page Updated |
| PageViewEvent |  |  | Page Viewed |

## Space Events

| Event | Server/DC | Cloud | Cloud Name |
| --- | --- | --- | --- |
| AttachmentListViewEvent |  |  |  |
| PageListViewEvent |  |  |  |
| RemoveSpaceViewEvent |  |  |  |
| SpaceAdminViewEvent |  |  |  |
| SpaceArchivedEvent |  |  |  |
| SpaceContentWillRemoveEvent |  |  |  |
| SpaceDetailsWillRemoveEvent |  |  |  |
| SpaceCreateEvent |  |  | Space Created |
| SpaceEvent |  |  |  |
| SpaceLabelsViewEvent |  |  |  |
| SpaceLogoUpdateEvent |  |  | Space Logo Updated |
| SpacePermissionsUpdatedEvent |  |  | Space Permissions Updated |
| SpacePermissionsViewEvent |  |  |  |
| SpaceRemoveEvent |  |  | Space Removed |
| SpaceTrashContentEvent |  |  |  |
| SpaceTrashEmptyEvent |  |  |  |
| SpaceTrashPurgeAllContentEvent |  |  |  |
| SpaceTrashRestoreContentEvent |  |  |  |
| SpaceTrashViewEvent |  |  |  |
| SpaceUnArchivedEvent |  |  |  |
| SpaceUpdateEvent |  |  | Space Updated |
| TemplateListViewEvent |  |  |  |

## Other Events

| Event | Server/DC | Cloud | Cloud Name |
| --- | --- | --- | --- |
| PageCreatedEvent |  |  | Page Created |
| PageMovedEvent |  |  | Page Moved |
| PagedTrashedEvent |  |  | Page Trashed |
| SpacePermissionChangeEvent |  |  | Space Permissions Updated |
| SpacePermissionRemoveEvent |  |  |  |
| SpacePermissionSaveEvent |  |  |  |
| SpacePermissionRemoveForGroupEvent |  |  |  |
| SpacePermissionRemoveForUserEvent |  |  |  |
| SpacePermissionRemoveFromSpaceEvent |  |  |  |
| UserMacroAddedEvent |  |  |  |
| UserMacroRemovedEvent |  |  |  |
| UserVerificationTokenCleanUpEvent |  |  |  |
| ViewGeneralConfigEvent |  |  |  |
| ViewLicenseEvent |  |  |  |
| ViewMyDraftsEvent |  |  |  |
| ViewMyFavoritesEvent |  |  |  |
| ViewMyWatchesEvent |  |  |  |
| ViewNetworkEvent |  |  |  |
| XStreamStateChangedEvent |  |  |  |
| XWorkStateChangeEvent |  |  |  |
| ZduFinalizationRequestEvent |  |  |  |
| ZduStartEvent |  |  |  |

## User Events

| Event | Server/DC | Cloud | Cloud Name |
| --- | --- | --- | --- |
| ConfirmEmailAddressEvent |  |  |  |
| DomainRestrictedUserSignupEvent |  |  |  |
| GroupInviteUserSignupEvent |  |  |  |
| PublicUserSignupEvent |  |  |  |
| UserCreateEvent |  |  | User Created |
| UserDeactivateEvent |  |  | User Deactivated |
| UserEvent |  |  |  |
| UserProfilePictureUpdateEvent |  |  |  |
| UserReactivateEvent |  |  | User Reactivated |
| UserRemoveCompletedEvent |  |  |  |
| UserRemoveEvent |  |  | User Removed |
| UserSignupEvent |  |  |  |
