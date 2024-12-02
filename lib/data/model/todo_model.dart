enum TaskPriority { low, medium, high }

class TodoModel {
  String id;
  String title;
  String? description;
  bool isCompleted;
  DateTime? dueDate;
  TaskPriority priority;

  TodoModel({
    String? id,
    required this.title,
    this.description,
    this.isCompleted = false,
    this.dueDate,
    this.priority = TaskPriority.low,
  }) : id = id ?? DateTime.now().toString();

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'isCompleted': isCompleted,
        'dueDate': dueDate?.toIso8601String(),
        'priority': priority.index,
      };

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        isCompleted: json['isCompleted'],
        dueDate:
            json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
        priority: TaskPriority.values[json['priority'] ?? 0],
      );
}
