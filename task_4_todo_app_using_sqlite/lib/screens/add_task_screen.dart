import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_data_provider.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    late String newTaskTitle;

    return Container(
      color: const Color(0xff757575),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.lightBlueAccent,
                fontSize: 26,
              ),
            ),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (newText) {
                newTaskTitle = newText;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                Provider.of<TaskDataProvider>(context, listen: false)
                    .addTask(newTaskTitle);
                Navigator.pop(context);
              },
              style: const ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(Colors.white),
                backgroundColor: WidgetStatePropertyAll(Colors.lightBlueAccent),
              ),
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
