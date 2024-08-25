import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task_model.dart';
import '../utils/provider.dart';

class TaskEditPage extends StatefulWidget {
  final Task? task;

  const TaskEditPage({Key? key, this.task}) : super(key: key);

  @override
  _TaskEditPageState createState() => _TaskEditPageState();
}

class _TaskEditPageState extends State<TaskEditPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description ?? '';
      _categoryController.text = widget.task!.category;
      _isCompleted = widget.task!.isCompleted;
    }
  }

  void _saveTask() {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final category = _categoryController.text;
    final isCompleted = _isCompleted;

    if (title.isEmpty || category.isEmpty) return;

    final task = Task(
      id: widget.task?.id,
      title: title,
      description: description,
      category: category,
      isCompleted: isCompleted,
      createdAt: DateTime.now().toIso8601String(),
    );

    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    if (widget.task == null) {
      taskProvider.addTask(task);
    } else {
      taskProvider.updateTask(task);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.task == null ? 'Add Task' : 'Edit Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(labelText: 'Category'),
            ),
            Row(
              children: [
                Text('Completed'),
                Checkbox(
                  value: _isCompleted,
                  onChanged: (value) {
                    setState(() {
                      _isCompleted = value!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveTask,
              child: Text(widget.task == null ? 'Add Task' : 'Update Task'),
            ),
          ],
        ),
      ),
    );
  }
}