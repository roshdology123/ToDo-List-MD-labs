import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../data/model/todo_model.dart';

abstract class TodoStorageInterface {
  Future<void> saveTodos(List<TodoModel> todos);
  Future<List<TodoModel>> loadTodos();
}

class SharedPreferenceStorage implements TodoStorageInterface {
  @override
  Future<void> saveTodos(List<TodoModel> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final todoJsonList = todos.map((todo) => todo.toJson()).toList();
    await prefs.setString('todos', json.encode(todoJsonList));
  }

  @override
  Future<List<TodoModel>> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todoJsonString = prefs.getString('todos');

    if (todoJsonString != null) {
      final List<dynamic> todoJsonList = json.decode(todoJsonString);
      return todoJsonList
          .map<TodoModel>((json) => TodoModel.fromJson(json))
          .toList();
    }
    return [];
  }
}

class MockTodoStorage implements TodoStorageInterface {
  List<TodoModel> _mockTodos = [];

  @override
  Future<void> saveTodos(List<TodoModel> todos) async {
    _mockTodos = List.from(todos);
  }

  @override
  Future<List<TodoModel>> loadTodos() async {
    return List.from(_mockTodos);
  }
}

class TodoController extends GetxController {
  final RxList<TodoModel> todos = <TodoModel>[].obs;
  final TodoStorageInterface storage;

  TodoController({TodoStorageInterface? storage})
      : storage = storage ?? SharedPreferenceStorage();

  @override
  void onInit() {
    super.onInit();
    loadTodos();
  }

  void addTodo(TodoModel todo) {
    todos.add(todo);
    saveTodos();
  }

  void updateTodo(TodoModel updatedTodo) {
    final index = todos.indexWhere((todo) => todo.id == updatedTodo.id);
    if (index != -1) {
      todos[index] = updatedTodo;
      todos.refresh();
      saveTodos();
    }
  }

  void removeTodo(int index) {
    todos.removeAt(index);
    saveTodos();
  }

  void toggleTodo(int index) {
    todos[index].isCompleted = !todos[index].isCompleted;
    todos.refresh();
    saveTodos();
  }

  Future<void> saveTodos() async {
    await storage.saveTodos(todos);
  }

  Future<void> loadTodos() async {
    final loadedTodos = await storage.loadTodos();
    todos.value = loadedTodos;
  }
}
