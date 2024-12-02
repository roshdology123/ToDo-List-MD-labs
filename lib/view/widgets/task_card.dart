import 'package:flutter/material.dart';
import 'package:todo_list/view/widgets/dismiss_background.dart';
import 'package:todo_list/view/widgets/task_metadata.dart';

import '../../data/model/todo_model.dart';

class TaskCard extends StatelessWidget {
  final TodoModel todo;
  final int index;
  final void Function(int index) onDismissed;
  final void Function(int index) onToggleCompleted;
  final void Function() onTap;

  const TaskCard({
    super.key,
    required this.todo,
    required this.index,
    required this.onDismissed,
    required this.onToggleCompleted,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id),
      background: const DismissBackground(),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismissed(index),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          title: Text(
            todo.title,
            style: TextStyle(
              decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (todo.description != null && todo.description!.isNotEmpty)
                Text(
                  todo.description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              const SizedBox(height: 8),
              TaskMetadata(todo: todo),
            ],
          ),
          trailing: Checkbox(
            value: todo.isCompleted,
            onChanged: (_) => onToggleCompleted(index),
            activeColor: Colors.green,
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
