import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list/controller/todo_controller.dart';
import 'package:todo_list/data/model/todo_model.dart';

void main() {
  AutomatedTestWidgetsFlutterBinding.ensureInitialized();
  late TodoController todoController;
  late MockTodoStorage mockStorage;
  setUp(() {
    // Use MockTodoStorage for testing
    mockStorage = MockTodoStorage();
    todoController = TodoController(storage: mockStorage);
  });
  test('Should add a new todo item', () {
    final todo = TodoModel(
      id: '1',
      title: 'New Task',
      description: 'Task Description',
      priority: TaskPriority.medium,
    );

    todoController.addTodo(todo);

    expect(todoController.todos.length, 1);
    expect(todoController.todos.first.title, 'New Task');
    expect(todoController.todos.first.priority, TaskPriority.medium);
  });

  test('Should toggle todo completion', () {
    final todo = TodoModel(id: '1', title: 'Task', isCompleted: false);
    todoController.addTodo(todo);

    todoController.toggleTodo(0);

    expect(todoController.todos.first.isCompleted, true);
  });

  test('Should update an existing todo item', () {
    final todo = TodoModel(id: '1', title: 'Task');
    todoController.addTodo(todo);

    final updatedTodo = TodoModel(
      id: '1',
      title: 'Updated Task',
      description: 'Updated Description',
      priority: TaskPriority.high,
    );

    todoController.updateTodo(updatedTodo);

    expect(todoController.todos.first.title, 'Updated Task');
    expect(todoController.todos.first.priority, TaskPriority.high);
  });

  test('Should remove a todo item by index', () {
    final todo = TodoModel(id: '1', title: 'Task');
    todoController.addTodo(todo);

    todoController.removeTodo(0);

    expect(todoController.todos.length, 0);
  });

  test('Should persist and load todos', () async {
    final todo = TodoModel(id: '1', title: 'Persistent Task');
    todoController.addTodo(todo);

    await todoController.saveTodos();
    todoController.todos.clear();

    await todoController.loadTodos();

    expect(todoController.todos.length, 1);
    expect(todoController.todos.first.title, 'Persistent Task');
  });
}
