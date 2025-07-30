import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String title;
  final bool completed;
  final VoidCallback onTap;

  TaskTile({required this.title, required this.completed, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: completed ? Colors.green[200] : Colors.white,
      title: Text(title),
      trailing: Icon(
        completed ? Icons.check_circle : Icons.radio_button_unchecked,
        color: completed ? Colors.green : Colors.grey,
      ),
      onTap: onTap,
    );
  }
}
