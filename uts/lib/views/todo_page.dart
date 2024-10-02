import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/todo_provider.dart';  

class TodoPage extends StatelessWidget {
  final TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider To-Do List'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: taskController,
              decoration: InputDecoration(
                labelText: 'Add a new task',
                labelStyle: TextStyle(color: Colors.deepPurple),
                filled: true,
                fillColor: Colors.deepPurple.shade50,
                prefixIcon: Icon(Icons.task, color: Colors.deepPurple),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.deepPurple),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Consumer<TodoProvider>(
                builder: (context, provider, child) {
                  return provider.todos.isEmpty
                      ? Center(
                          child: Text(
                            'No tasks yet, add some!',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: provider.todos.length,
                          itemBuilder: (context, index) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 4,
                              margin: EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                leading: Checkbox(
                                  value: provider.todos[index].isDone,
                                  onChanged: (bool? value) {
                                    provider.toggleTaskStatus(index);
                                  },
                                ),
                                title: Text(
                                  provider.todos[index].title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    decoration: provider.todos[index].isDone
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete,
                                      color: Colors.redAccent),
                                  onPressed: () => provider.removeTask(index),
                                ),
                              ),
                            );
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          if (taskController.text.isNotEmpty) {
            Provider.of<TodoProvider>(context, listen: false)
                .addTask(taskController.text);
            taskController.clear();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
