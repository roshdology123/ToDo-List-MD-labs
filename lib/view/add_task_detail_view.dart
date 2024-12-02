import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/view/widgets/text_input.dart';
import '../controller/todo_controller.dart';
import '../core/consts.dart';
import '../data/model/todo_model.dart';

class AddTaskDetailView extends StatefulWidget {
  final TodoModel? existingTask;

  const AddTaskDetailView({super.key, this.existingTask});

  @override
  State<AddTaskDetailView> createState() => _AddTaskDetailViewState();
}

class _AddTaskDetailViewState extends State<AddTaskDetailView> {
  final TodoController _todoController = Get.find();

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late DateTime? _selectedDate;
  late TaskPriority _selectedPriority;

  @override
  void initState() {
    super.initState();
    _titleController =
        TextEditingController(text: widget.existingTask?.title ?? '');
    _descriptionController =
        TextEditingController(text: widget.existingTask?.description ?? '');
    _selectedDate = widget.existingTask?.dueDate;
    _selectedPriority = widget.existingTask?.priority ?? TaskPriority.low;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.existingTask == null ? 'Create New Task' : 'Edit Task'),
        backgroundColor: lightTurquoise,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTitleField(),
            const SizedBox(height: 16),
            _buildDescriptionField(),
            const SizedBox(height: 16),
            _buildDueDatePicker(),
            const SizedBox(height: 16),
            _buildPrioritySelector(),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveTask,
              style: ElevatedButton.styleFrom(
                backgroundColor: lightTurquoise,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                widget.existingTask == null ? 'Create Task' : 'Update Task',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildTitleField() {
    return TextInput(
      controller: _titleController,
      label: 'Task Title',
      icon: Icons.title,
    );
  }

  Widget _buildDescriptionField() {
    return TextInput(
      controller: _descriptionController,
      icon: Icons.description,
      label: 'Task Description',
      maxLines: 3,
      maxLength: 300,
    );
  }

  Widget _buildDueDatePicker() {
    return Row(
      children: [
        Expanded(
          child: Text(
            _selectedDate == null
                ? 'No due date'
                : 'Due: ${DateFormat('dd MMM yyyy').format(_selectedDate!)}',
            style: const TextStyle(fontSize: 16),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.calendar_today, color: heavyTurquoise),
          onPressed: _showDatePicker,
        ),
      ],
    );
  }

  Widget _buildPrioritySelector() {
    return Row(
      children: [
        const Text('Priority:', style: TextStyle(fontSize: 16)),
        const SizedBox(width: 16),
        ...TaskPriority.values.map((priority) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ChoiceChip(
                label: Text(_getPriorityText(priority)),
                selected: _selectedPriority == priority,
                onSelected: (_) {
                  setState(() {
                    _selectedPriority = priority;
                  });
                },
                selectedColor: _getPriorityColor(priority),
              ),
            )),
      ],
    );
  }

  void _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveTask() {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Title is required')),
      );
      return;
    }

    final task = TodoModel(
      id: widget.existingTask?.id,
      title: title,
      description: _descriptionController.text.trim(),
      dueDate: _selectedDate,
      priority: _selectedPriority,
      isCompleted: widget.existingTask?.isCompleted ?? false,
    );

    if (widget.existingTask == null) {
      _todoController.addTodo(task);
    } else {
      _todoController.updateTodo(task);
    }

    Navigator.of(context).pop();
  }

  String _getPriorityText(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.low:
        return 'Low';
      case TaskPriority.medium:
        return 'Medium';
      case TaskPriority.high:
        return 'High';
    }
  }

  Color _getPriorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.low:
        return Colors.green;
      case TaskPriority.medium:
        return Colors.orange;
      case TaskPriority.high:
        return Colors.red;
    }
  }
}
