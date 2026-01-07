import 'package:material_task_tracker/data/source/db/database.dart';

/// List models a list in the database
///
/// For inserting a new list, the [id] field can be left as default (0).
///
/// Null fields correspond to optional database columns
class ListDomain {
  /// Database id of the list. `0` indicates an unset/new list.
  final int id;

  /// Short, human-readable title of the task.
  final String title;

  /// Integer used to order lists.
  final int sortOrder;

  /// Whether the list is default.
  final bool isDefault;

  /// Timestamp when the list was created (set by the client).
  final DateTime createdAt;

  /// Timestamp when the list was last updated (set by the client).
  final DateTime updatedAt;

  /// Unicode value of the emoji
  /// E.g. U+1F600 for 😀
  final String? emoji;

  /// The hex value of the color
  /// E.g. #FF5733
  final String? color;

  /// Creates a new `List`.
  ///
  /// - `id` defaults to `0` for new/unsaved lists.
  /// - `title`, `sortOrder`, `createdAt`, and `updatedAt` are required.
  /// - `isDefault` defaults to `false`.
  /// - `emoji` and `color` are optional.
  const ListDomain({
    this.id = 0,
    required this.title,
    required this.sortOrder,
    this.isDefault = false,
    required this.createdAt,
    required this.updatedAt,
    this.emoji,
    this.color,
  });

  factory ListDomain.fromListItem(ListItem item) {
    return ListDomain(
      id: item.id,
      title: item.title,
      sortOrder: item.sortOrder,
      isDefault: item.isDefault,
      createdAt: item.createdAt,
      updatedAt: item.updatedAt,
      emoji: item.emoji,
      color: item.color,
    );
  }

  ListDomain copyWith({
    int? id,
    String? title,
    int? sortOrder,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? emoji,
    String? color,
  }) {
    return ListDomain(
      id: id ?? this.id,
      title: title ?? this.title,
      sortOrder: sortOrder ?? this.sortOrder,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      emoji: emoji ?? this.emoji,
      color: color ?? this.color,
    );
  }
}
