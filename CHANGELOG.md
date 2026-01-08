# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Features in Development

#### Feature Branch: `feature/lists`

This branch implements task list/category functionality to organize tasks.

##### Added
- **List Database Model** (2025-12-31)
  - Added database schema for task lists/categories
  - Implemented `ListItems` table structure

- **Database Migration to Version 2** (2026-01-04)
  - Migrated database schema from version 1 to version 2
  - Added `list_items` table with proper relationships
  - Implemented database triggers for maintaining data integrity
  - Added migration tests to ensure data consistency

- **List Viewing Drawer** (2026-01-07)
  - Added navigation drawer for viewing all lists
  - Implemented `ListRepository` for data access
  - Created list domain model with full CRUD operations
  - Added drawer UI components (header and list section)
  - Integrated list viewing with home screen

- **List Creation Functionality** (2026-01-07)
  - Implemented list creation dialog
  - Added list management functionality in database service
  - Enhanced list repository with create operations
  - Integrated list creation with the drawer UI

##### Fixed
- **List Creation UI** (2026-01-07)
  - Fixed text field not clearing after list creation
  - Improved user experience in list management dialog

- **Database Schema** (2026-01-07)
  - Moved default values for `createdAt` and `updatedAt` from triggers to table definitions
  - Improved schema consistency and maintainability

## [0.2.1] - 2025-12-31

### Changed
- **Android Package Refactor**
  - Renamed Android package name for better organization
  - Updated package structure from `com.example.tasktracker.task_tracker` to `dev.architxkumar.mtt`
  - Added multiple MainActivity entries for package compatibility
  - Updated build configuration and Android-specific files

## [0.2] - 2025-12-31

Initial release with core task management features.

### Added
- Task creation with title, description, and due date
- Task sorting by creation time, due date, or manual order
- State persistence to restore last selected task filter on app restart
- Task filtering to hide completed tasks
- Task deletion functionality
- Task update functionality
- Task detail viewing
- Linux platform support
- Web platform support
- Windows platform support

### Features
- Material Design themed UI
- Local data persistence using Drift (SQLite)
- MVVM architecture with Provider for state management
- Offline-first design
- Task completion tracking

---

## Summary of Active Development Branches

### `development` Branch
Currently aligned with v0.2.1 on master, containing only the Android package rename refactor.

### `feature/lists` Branch (6 commits ahead of v0.2)
Active development of task list/category organization feature:
- Complete database migration infrastructure (v1 → v2)
- List creation and viewing functionality
- Navigation drawer for list management
- Foundation for organizing tasks into different lists/categories

**Status**: Feature implementation in progress, not yet merged to development or master.
