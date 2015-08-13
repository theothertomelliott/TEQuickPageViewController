# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased][unreleased]

### Added
- This change log.
- Travis configuration, current build status is now visible in README.md.
- Unit tests created for wraparound and non-wraparound page sequence creation, along with the case where there are multiple TEQuickPageViewControllers in a single storyboard. These tests are run as part of the Travis build.

## [2.1.0] - 2015-06-03

### Added
- Extended page option for TEQuickPageViewController instances. This option removes the black bar at the bottom of the page view controller, extending the page views over this space.
- Tint options for the page indicator, to avoid invisible indicators when using a similarly colored view.

## [2.0.0] - 2015-02-27

### Changed
- The sequence of pages can now be defined using segues rather than setting ordered ids on each page View. This makes it possible to see the order of your pages at a glance, and changing the order is as simple as dragging a segue.

## [1.0.0] - 2015-02-14

### Added
- TEQuickPageViewController is an extension of UIPageViewController that allows configuration of a set of scrollable pages in a Storyboard without any code. Views are attached to the sequence of pages by setting identifiers that correspond to the parent page view controller.

[unreleased]: https://github.com/theothertomelliott/TEQuickPageViewController/compare/2.1.0...2.1.1
[2.1.0]: https://github.com/theothertomelliott/TEQuickPageViewController/compare/2.0.0...2.1.0
[2.0.0]: https://github.com/theothertomelliott/TEQuickPageViewController/compare/1.0.0...2.0.0
[1.0.0]: https://github.com/theothertomelliott/TEQuickPageViewController/commit/c0143ef7a7b3bd65e2aa6be2ca2bcc4d601f54f9
