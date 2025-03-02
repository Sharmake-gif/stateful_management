import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'State Management',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TaskListScreen(),
    );
  }
}

class Task {
  String name;
  bool completed;
  String priority;

  Task({required this.name, this.completed = false, this.priority = 'Low'});
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Task> tasks = [];
  final TextEditingController taskController = TextEditingController();
  String selectedPriority = 'Low';

  void addTask() {
    if (taskController.text.isNotEmpty) {
      setState(() {
        tasks.add(Task(name: taskController.text, priority: selectedPriority));
        taskController.clear();
      });
    }
  }

  void toggleComplete(int index) {
    setState(() {
      tasks[index].completed = !tasks[index].completed;
    });
  }

  void removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('State Management')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: tasks[index].completed,
                        onChanged: (_) => toggleComplete(index),
                      ),
                      Expanded(
                        child: Text(
                          tasks[index].name,
                          style: TextStyle(
                            decoration: tasks[index].completed
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => removeTask(index),
                      ),
                    ],
                  ),
                  subtitle: Text('Priority: ${tasks[index].priority}'),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: taskController,
                  decoration: InputDecoration(
                    labelText: 'Enter the task name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(width: 10),
              DropdownButton<String>(
                value: selectedPriority,
                items: ['Low', 'Medium', 'High']
                    .map((priority) => DropdownMenuItem(
                          value: priority,
                          child: Text(priority),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedPriority = value!;
                  });
                },
              ),
              SizedBox(width: 10),
              IconButton(
                icon: Icon(Icons.add, color: Colors.blue),
                onPressed: addTask,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
