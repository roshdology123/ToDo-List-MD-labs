import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/view/widgets/priority_indicator.dart';

import '../../data/model/todo_model.dart';

class TaskMetadata extends StatelessWidget {
  final TodoModel todo;

  const TaskMetadata({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (todo.dueDate != null)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  DateFormat('dd MMM').format(todo.dueDate!),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        PriorityIndicator(priority: todo.priority),
      ],
    );
  }
}
