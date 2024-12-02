import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list/controller/todo_controller.dart';
import 'package:todo_list/data/model/todo_model.dart';

void main() {
  late TodoController todoController;
  late MockTodoStorage mockStorage;

  setUp(() {
    // Use MockTodoStorage for testing
    mockStorage = MockTodoStorage();
    todoController = TodoController(storage: mockStorage);
  });

  test('Should add a new todo to the list and save it to storage', () async {
    final todo = TodoModel(id: '1', title: 'Test Todo', isCompleted: false);

    todoController.addTodo(todo);

    // Verify the new todo is in the list
    expect(todoController.todos.length, 1,
        reason: 'A single todo should be added.');
    expect(todoController.todos.first.title, 'Test Todo',
        reason: 'The added todo should have the correct title.');
    expect(todoController.todos.first.isCompleted, false,
        reason: 'The added todo should initially be incomplete.');

    // Verify it is saved to storage
    final savedTodos = await mockStorage.loadTodos();
    expect(savedTodos.length, 1,
        reason: 'The todo should be saved in storage.');
    expect(savedTodos.first.title, 'Test Todo',
        reason: 'The saved todo should have the correct title.');
  });

  test('Should toggle a todo completion status and save the change', () async {
    final todo = TodoModel(id: '1', title: 'Test Todo', isCompleted: false);
    todoController.addTodo(todo);

    // Toggle completion
    todoController.toggleTodo(0);

    // Verify the change
    expect(todoController.todos.first.isCompleted, true,
        reason: 'The todo should be marked as completed after toggling.');

    // Verify it is saved to storage
    final savedTodos = await mockStorage.loadTodos();
    expect(savedTodos.first.isCompleted, true,
        reason: 'The completed status should be saved in storage.');
  });

  test('Should update an existing todo and reflect the changes in storage',
      () async {
    final todo = TodoModel(id: '1', title: 'Test Todo', isCompleted: false);
    todoController.addTodo(todo);

    final updatedTodo =
        TodoModel(id: '1', title: 'Updated Todo', isCompleted: true);
    todoController.updateTodo(updatedTodo);

    // Verify the update in the list
    expect(todoController.todos.first.title, 'Updated Todo',
        reason: 'The title should be updated in the list.');
    expect(todoController.todos.first.isCompleted, true,
        reason: 'The completed status should be updated in the list.');

    // Verify it is updated in storage
    final savedTodos = await mockStorage.loadTodos();
    expect(savedTodos.first.title, 'Updated Todo',
        reason: 'The updated title should be saved in storage.');
    expect(savedTodos.first.isCompleted, true,
        reason: 'The updated completed status should be saved in storage.');
  });

  test('Should remove a todo by index and save the change', () async {
    final todo1 = TodoModel(id: '1', title: 'Todo 1', isCompleted: false);
    final todo2 = TodoModel(id: '2', title: 'Todo 2', isCompleted: false);
    todoController.addTodo(todo1);
    todoController.addTodo(todo2);

    todoController.removeTodo(0);

    // Verify the todo is removed from the list
    expect(todoController.todos.length, 1,
        reason: 'One todo should be removed.');
    expect(todoController.todos.first.title, 'Todo 2',
        reason: 'The remaining todo should have the correct title.');

    // Verify the change in storage
    final savedTodos = await mockStorage.loadTodos();
    expect(savedTodos.length, 1,
        reason: 'The remaining todos should be saved in storage.');
    expect(savedTodos.first.title, 'Todo 2',
        reason: 'The saved todo should match the remaining todo in the list.');
  });

  test('Should save todos to storage when changes are made', () async {
    final todo = TodoModel(id: '1', title: 'Test Todo', isCompleted: false);
    todoController.addTodo(todo);

    await todoController.saveTodos();

    // Verify the todos are saved in storage
    final savedTodos = await mockStorage.loadTodos();
    expect(savedTodos.length, 1,
        reason: 'The todo should be saved to storage.');
    expect(savedTodos.first.title, 'Test Todo',
        reason: 'The saved todo should have the correct title.');
    expect(savedTodos.first.isCompleted, false,
        reason: 'The saved todo should have the correct completion status.');
  });

  test('Should load todos from storage into the list', () async {
    final todo = TodoModel(id: '1', title: 'Saved Todo', isCompleted: false);
    await mockStorage.saveTodos([todo]);

    await todoController.loadTodos();

    // Verify the todos are loaded into the list
    expect(todoController.todos.length, 1,
        reason: 'The todos should be loaded from storage.');
    expect(todoController.todos.first.title, 'Saved Todo',
        reason: 'The loaded todo should have the correct title.');
    expect(todoController.todos.first.isCompleted, false,
        reason: 'The loaded todo should have the correct completion status.');
  });

  test('Should handle loading an empty list of todos', () async {
    await mockStorage.saveTodos([]); // Save an empty list to storage

    await todoController.loadTodos();

    // Verify the list is empty
    expect(todoController.todos.length, 0,
        reason: 'The list should be empty when no todos are saved in storage.');
  });
}
