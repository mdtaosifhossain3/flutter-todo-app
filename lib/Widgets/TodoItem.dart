import 'package:flutter/material.dart';
import 'package:lab/const/colors.dart';
import 'package:lab/models/taskModel.dart';

class TodoItem extends StatelessWidget {
  final TaskModel task;
  final onChanged;
  final onDelete;
  const TodoItem(
      {super.key, required this.task, this.onChanged, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 4.00),
        child: Card(
          child: ListTile(
            onTap: () {
              onChanged(task);
            },
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            tileColor: Colors.white,
            leading: Icon(
              task.isDone! ? Icons.check_box : Icons.check_box_outline_blank,
              color: tdBlue,
            ),
            title: Text(
              task.text!,
              style: TextStyle(
                  decoration: task.isDone! ? TextDecoration.lineThrough : null),
            ),
            trailing: Container(
              padding: EdgeInsets.zero,
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  color: tdRed, borderRadius: BorderRadius.circular(4)),
              child: InkWell(
                  onTap: () {
                    onDelete(task.id);
                  },
                  child: const Icon(Icons.delete, color: Colors.white)),
            ),
          ),
        ));
  }
}
