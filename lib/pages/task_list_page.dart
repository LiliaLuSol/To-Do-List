import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/pages/task_edit_page.dart';

import '../models/task_model.dart';
import '../utils/provider.dart';

class TaskListPage extends StatefulWidget {
  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  bool _isSelectionMode = false;
  List<int> _selectedTaskIds = [];

  @override
  void initState() {
    super.initState();
    Provider.of<TaskProvider>(context, listen: false).fetchTasks();
  }

  void _toggleSelectionMode() {
    setState(() {
      _isSelectionMode = !_isSelectionMode;
      _selectedTaskIds.clear();
    });
  }

  void _toggleTaskSelection(int taskId) {
    setState(() {
      if (_selectedTaskIds.contains(taskId)) {
        _selectedTaskIds.remove(taskId);
      } else {
        _selectedTaskIds.add(taskId);
      }
    });
  }

  void _deleteSelectedTasks() async {
    final List<int> selectedIdsCopy = List<int>.from(_selectedTaskIds);

    await Provider.of<TaskProvider>(context, listen: false)
        .deleteMultipleTasks(selectedIdsCopy);

    setState(() {
      _selectedTaskIds.clear();
      _isSelectionMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isSelectionMode
            ? 'Selected: ${_selectedTaskIds.length}'
            : 'To Do List'),
        actions: _isSelectionMode
            ? [
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: _selectedTaskIds.isEmpty
                      ? null
                      : () => _deleteSelectedTasks(),
                ),
                IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: _toggleSelectionMode,
                ),
              ]
            : [],
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          final tasks = taskProvider.tasks;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              final isSelected = _selectedTaskIds.contains(task.id);
              return GestureDetector(
                  onLongPress: () {
                    if (!_isSelectionMode) {
                      _toggleSelectionMode();
                    }
                    _toggleTaskSelection(task.id!);
                  },
                  onTap: _isSelectionMode
                      ? () => _toggleTaskSelection(task.id!)
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskEditPage(task: task),
                            ),
                          );
                        },
                  child: ListTile(
                    title: Text(task.title),
                    subtitle: Text(task.description ?? ''),
                    trailing: _isSelectionMode
                        ? Checkbox(
                            value: isSelected,
                            onChanged: (value) {
                              _toggleTaskSelection(task.id!);
                            },
                          )
                        : Checkbox(
                            value: task.isCompleted,
                            onChanged: (value) {
                              taskProvider.updateTask(
                                Task(
                                  id: task.id,
                                  title: task.title,
                                  description: task.description,
                                  category: task.category,
                                  isCompleted: value ?? false,
                                  createdAt: task.createdAt,
                                ),
                              );
                            },
                          ),
                    tileColor:
                        isSelected ? Colors.grey[300] : Colors.transparent,
                  ));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskEditPage(),
            ),
          );
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:to_do_list/widgets/custom_text_form_field.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   TextEditingController searchController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     bool status = false;
//     return Scaffold(
//       backgroundColor: Colors.cyan[400],
//       appBar: AppBar(
//         title: const Text(
//           'To Do List',
//         ),
//         titleTextStyle: const TextStyle(
//             color: Colors.pinkAccent,
//             fontSize: 30,
//             fontWeight: FontWeight.bold),
//         centerTitle: true,
//         backgroundColor: Colors.cyan[400],
//       ),
//       body: status
//           ? Stack(textDirection: TextDirection.ltr, children: <Widget>[
//               Center(
//                 child: Container(
//                   width: size.width / 1.1,
//                   height: size.height / 1.175,
//                   decoration: const BoxDecoration(
//                       color: Colors.white70,
//                       borderRadius: BorderRadius.all(Radius.circular(30))),
//                 ),
//               ),
//               Column(
//                 children: [
//                   CustomTextFormField(
//                       hintText: "Search recent task",
//                       controller: searchController,
//                       textInputType: TextInputType.text,
//                       prefix: const Icon(
//                         Icons.search,
//                         color: Colors.black26,
//                       ),
//                       fillColor: Colors.white70,
//                       onChanged: (value) {}),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Expanded(
//                       child: ListView.separated(
//                     shrinkWrap: true,
//                     itemCount: 20,
//                     itemBuilder: (context, index) {
//                       return Text('data');
//                     },
//                     separatorBuilder: (BuildContext context, int index) {
//                       return const Divider(
//                         color: Colors.blueGrey,
//                       );
//                     },
//                   )),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                 ],
//               )
//             ])
//           : Center(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.more_horiz,
//                     color: Colors.white70,
//                     size: size.height * .20,
//                   ),
//                   const SizedBox(
//                     height: 50,
//                   ),
//                   const Text(
//                     'It\'s still empty.\nAdd something!',
//                     style: TextStyle(
//                         color: Colors.black87,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 30),textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//       floatingActionButton: FloatingActionButton(
//           backgroundColor: Colors.brown[200],
//           child: Icon(
//             Icons.add_circle,
//             color: Colors.brown[900],
//           ),
//           onPressed: () {}),
//     );
//   }
// }
