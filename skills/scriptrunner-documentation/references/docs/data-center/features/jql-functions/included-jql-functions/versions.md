# Versions

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > JQL Functions > Included JQL Functions
- Doc ID: doc-sr4js-50aa93a9-b22f-4a0e-93f0-0d4aaf148ede-158a1659425d1803
- Source: https://docs.adaptavist.com/sr4js/latest/features#jql-functions--en#included-jql-functions--en#versions--en

## releaseDate

```
releaseDate(release date query)
```

Finds issues by the release date of the associated version ( _fix versions_, _affects versions_, version custom fields).

For example to find issues that have a fix version of any release that is due in the next ten days:

```
fixVersion in releaseDate("after now() before 10d")
```

To find issues where the fix version will be released on a given day:

```
fixVersion in releaseDate("on 2016/09/07")
```

You can use any of the following predicates in these version functions:

| Name | Argument Type |
| --- | --- |
| after - commented after | date or date expression, or date function, eg startOfDay(), lastLogin() |
| before - commented before | date or date expression, or date function |
| on - commented on this day | date or date expression, or date function |

## startDate

```
startDate(start date query)
```

Finds issues by the start date of the associated version ( _fix versions_, _affects versions_, version custom fields).

For example to find any issues that have a fix version that is not going to start until two weeks from now:

```
fixVersion in startDate("after 14d")
```

You can use any of the predicates in [Versions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/versions).

## overdue

```
overdue([release date query])
```

Finds issues by whether the associated version is _overdue_, optionally querying further on the release date.

An overdue version is one that is a) unreleased, and b) has it's release date in the past.

To find all issues that are supposed to be fix in an overdue version:

```
fixVersion in overdue()
```

Find all issues with a fix version, that is at least two weeks overdue:

```
fixVersion in overdue("before -14d")
```

## earliestUnreleasedVersionByReleaseDate

```
earliestUnreleasedVersionByReleaseDate(project key, [true/false includeArchived])
```

Returns the earliest unreleased version by _release date_, as distinct from the built-function earliestUnreleasedVersion, which sorts by the version ordering.

By default archived versions are not considered. If you wish to take into account archived versions, add `"true"` as a second argument, e.g.:

```
earliestUnreleasedVersionByReleaseDate('JRA', 'true')
```

## archivedVersions

```
fixVersion in archivedVersions()
```

Returns versions that have been archived. To find only versions that have not been archived just negate the query:

```
fixVersion not in archivedVersions()
```
