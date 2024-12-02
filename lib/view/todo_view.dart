import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animations/animations.dart';
import 'package:todo_list/view/widgets/task_card.dart';
import '../controller/todo_controller.dart';
import '../core/consts.dart';
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
              return TaskCard(
                todo: todo,
                index: index,
                onDismissed: (index) => _todoController.removeTodo(index),
                onToggleCompleted: (index) => _todoController.toggleTodo(index),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AddTaskDetailView(existingTask: todo),
                  ),
                ),
              );
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
}
