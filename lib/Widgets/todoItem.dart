import 'package:flutter/material.dart';
import 'package:lab/constants/colors.dart';
import 'package:lab/models/task_model.dart';

class TodoItem extends StatelessWidget {
  final TaskModel task;
  final Function? onChanged;
  final Function? onDelete;
  final Function? onEdit;
  const TodoItem(
      {super.key,
      required this.task,
      this.onChanged,
      this.onDelete,
      this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 8.00),
        child: Card(
          child: ListTile(
            onTap: () {
              onChanged!(task);
            },
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            tileColor: whiteColor,
            leading: Icon(
              task.isDone! ? Icons.check_box : Icons.check_box_outline_blank,
              color: primaryColor,
            ),
            title: Text(
              task.text!,
              style: TextStyle(
                decoration: task.isDone! ? TextDecoration.lineThrough : null,
                color: backgroundColor,
                fontSize: 16,
                decorationColor: redColor, // Change this to your desired color
              ),
            ),
            trailing: Container(
              padding: EdgeInsets.zero,
              width: 75,
              height: 35,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      onEdit!(task.id);
                    },
                    child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            color: greyColor,
                            borderRadius: BorderRadius.circular(4)),
                        child: const Icon(Icons.edit, color: whiteColor)),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      onDelete!(task.id);
                    },
                    child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            color: redColor,
                            borderRadius: BorderRadius.circular(4)),
                        child: const Icon(Icons.delete, color: whiteColor)),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
