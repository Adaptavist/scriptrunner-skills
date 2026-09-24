# HAPI Changelog

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Release Notes
- Doc ID: doc-sr4c-5827de30-a89d-4a5a-b147-4b50c9914582-9aea9332a9d398d2
- Source: https://docs.adaptavist.com/sr4c/latest/release-notes/hapi-changelog

Find the latest updates and enhancements to [HAPI](../../confluence-cloud/uncategorized/h/hapi.md) on this page.

## Compatibility policy

We will try to maintain HAPI compatibility between releases. Unfortunately, we can't promise never to change HAPI—such a promise does not align with the key goal of being compatible with the Confluence API. If the Confluence API changes substantially, e.g. in Confluence 8, HAPI may need to change too.

## Breaking changes policy

HAPI is a new API, therefore breaking changes may need to be introduced as we respond to feedback from our customers. We will endeavour to avoid making breaking changes if at all possible, if such changes are introduced they will be communicated via this changelog and in release notes.

In the future a more rigid breaking change policy may be introduced after responding to initial feedback from customers.

## Changelog

### 9.23.0

Warning: HAPI breaking change advanced notice

The HAPI page iterator will be moved. Currently, the page iterator is `import com.adaptavist.hapi.confluence.cql.PageIterator`. It will be updated to `import com.adaptavist.hapi.confluence.pages.PageIterator`.

Please update your HAPI scripts now to avoid broken scripts.

### 8.15.0

HAPI is released!
