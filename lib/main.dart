import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/view/todo_view.dart';

import 'controller/todo_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut<TodoController>(() => TodoController());
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AnimatedTodoView(),
    );
  }
}
