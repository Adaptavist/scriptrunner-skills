# 2023 Release Notes

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: release-notes > older-release-notes
- Doc ID: doc-sr4cc-454394482
- Source: https://docs.adaptavist.com/sr4cc/latest/release-notes/older-release-notes/2023-release-notes

## October 2023

### Groovy version upgrade

We updated ScriptRunner for Confluence Cloud to Groovy 4 on October 4 2023! 

#### Other new features in Groovy 4: 

The following are the most significant new features that have been added in Groovy 4 :

-   [Switch expressions](https://groovy-lang.org/releasenotes/groovy-4.0.html#Groovy4.0-switch-expressions) which, unlike switch statements, are optimized towards branches that handle one case and break out rather than fall through to the next case.
-   [Sealed types](https://groovy-lang.org/releasenotes/groovy-4.0.html#Groovy4.0-sealed-types)
-   [Records](https://groovy-lang.org/releasenotes/groovy-4.0.html#Groovy4.0-new-records)
-   [Ranges have been enhanced](https://groovy-lang.org/releasenotes/groovy-4.0.html#_enhanced_ranges) with support for ranges open on the left, for example, `3<..5`, or both sides, for example, `0<..<3`
-   [Support for annotating generic types](https://groovy-lang.org/releasenotes/groovy-4.0.html#_jsr308_improvements_incubating), for example `List<@IntRange(min = 0, max = 10) Integer>`

Please have a look at the [Groovy 4 Release Notes](https://groovy-lang.org/releasenotes/groovy-4.0.html) for a complete list of new features.

Breaking changes that could affect your scripts

Visit [Breaking Changes](https://docs.adaptavist.com/sr4cc/latest/release-notes/breaking-changes) to learn how Groovy 4 could affect and break your scripts.
