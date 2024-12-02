import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animations/animations.dart';
import 'package:intl/intl.dart';
import '../controller/todo_controller.dart';
import '../core/consts.dart';
import '../data/model/todo_model.dart';
import 'add_task_detail_view.dart';

class AnimatedTodoView extends StatefulWidget {
  const AnimatedTodoView({super.key});

  @override
  State<AnimatedTodoView> createState() => _AnimatedTodoViewState();
}

class _AnimatedTodoViewState extends State<AnimatedTodoView> {
  final TodoController _todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Todo List',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: lightTurquoise,
      ),
      body: Obx(() => ListView.builder(
            itemCount: _todoController.todos.length,
            itemBuilder: (context, index) {
              final todo = _todoController.todos[index];
              return _buildTaskCard(todo, index);
            },
          )),
      floatingActionButton: OpenContainer(
        closedBuilder: (context, openContainer) => FloatingActionButton(
          onPressed: openContainer,
          backgroundColor: lightTurquoise,
          child: const Icon(Icons.add),
        ),
        openBuilder: (context, closeContainer) => const AddTaskDetailView(),
        closedElevation: 6,
        openElevation: 6,
        transitionType: ContainerTransitionType.fadeThrough,
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
    );
  }

  Widget _buildTaskCard(TodoModel todo, int index) {
    return Dismissible(
      key: Key(todo.id),
      background: _buildDismissBackground(),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => _todoController.removeTodo(index),
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
              _buildTaskMetadata(todo),
            ],
          ),
          trailing: Checkbox(
            value: todo.isCompleted,
            onChanged: (_) => _todoController.toggleTodo(index),
            activeColor: Colors.green,
          ),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AddTaskDetailView(existingTask: todo),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskMetadata(TodoModel todo) {
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
        _buildPriorityIndicator(todo.priority),
      ],
    );
  }

  Widget _buildPriorityIndicator(TaskPriority priority) {
    Color priorityColor;
    switch (priority) {
      case TaskPriority.low:
        priorityColor = Colors.green;
        break;
      case TaskPriority.medium:
        priorityColor = Colors.orange;
        break;
      case TaskPriority.high:
        priorityColor = Colors.red;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: priorityColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        priority.toString().split('.').last.toUpperCase(),
        style: TextStyle(
          color: priorityColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDismissBackground() {
    return Container(
      color: Colors.red,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      child: const Icon(Icons.delete, color: Colors.white),
    );
  }
}
