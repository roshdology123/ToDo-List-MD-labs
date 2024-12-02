import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/controller/todo_controller.dart';
import 'package:todo_list/data/model/todo_model.dart';
import 'package:todo_list/view/add_task_detail_view.dart';

void main() {
  AutomatedTestWidgetsFlutterBinding.ensureInitialized();

  late TodoController todoController;

  setUp(() {
    // Initialize a mock SharedPreferences
    SharedPreferences.setMockInitialValues({});

    // Initialize and register the controller
    todoController = TodoController();
    Get.put(todoController); // Make the controller accessible in the test
  });

  tearDown(() {
    // Clean up after each test
    Get.delete<TodoController>();
  });

  testWidgets('Should display task details for editing',
      (WidgetTester tester) async {
    // Arrange
    final todo = TodoModel(
      id: '1',
      title: 'Existing Task',
      description: 'Task Description',
      priority: TaskPriority.high,
    );

    // Act
    await tester.pumpWidget(
      GetMaterialApp(
        home: AddTaskDetailView(existingTask: todo),
      ),
    );

    // Assert
    // Narrow down to the TextField within the AddTaskDetailView
    final descriptionFieldFinder = find.descendant(
      of: find.byType(AddTaskDetailView),
      matching: find.widgetWithText(TextField, 'Task Description'),
    );

    expect(descriptionFieldFinder, findsOneWidget);

    // Verify the title field separately
    final titleFieldFinder = find.descendant(
      of: find.byType(AddTaskDetailView),
      matching: find.widgetWithText(TextField, 'Existing Task'),
    );

    expect(titleFieldFinder, findsOneWidget);
  });

  testWidgets('Should create a new task', (WidgetTester tester) async {
    await tester.pumpWidget(
      const GetMaterialApp(
        home: AddTaskDetailView(),
      ),
    );

    // Enter task title
    await tester.enterText(find.byType(TextField).at(0), 'New Task');

    // Tap the 'Create Task' button
    await tester.tap(find.text('Create Task'));
    await tester.pump();

    // Assert that the task is added to the controller
    expect(todoController.todos.length, 1);
    expect(todoController.todos.first.title, 'New Task');
  });

  testWidgets('Should validate title input', (WidgetTester tester) async {
    await tester.pumpWidget(
      const GetMaterialApp(
        home: AddTaskDetailView(),
      ),
    );

    // Tap the 'Create Task' button without entering a title
    await tester.tap(find.text('Create Task'));
    await tester.pump();

    // Assert that the validation error message is shown
    expect(find.text('Title is required'), findsOneWidget);
  });
}
