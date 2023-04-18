import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TodoItem {
  final int? id;
  final String? title;
  final String? description;
  final bool isDone;
  TodoItem({
    this.id,
    this.title,
    this.description,
    required this.isDone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone,
    };
  }

  factory TodoItem.fromMap(Map<String, dynamic> map) {
    return TodoItem(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      isDone: map['isDone'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoItem.fromJson(String source) => TodoItem.fromMap(json.decode(source) as Map<String, dynamic>);

  TodoItem copyWith({
    int? id,
    String? title,
    String? description,
    bool? isDone,
  }) {
    return TodoItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  String toString() {
    return 'TodoItem(id: $id, title: $title, description: $description, isDone: $isDone)';
  }
}
