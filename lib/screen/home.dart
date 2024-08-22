import 'package:flutter/material.dart';
import 'package:lab/Widgets/todoItem.dart';
import 'package:lab/constants/colors.dart';
import 'package:lab/models/task_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  late String taskId;
  bool isEdit = false;
  bool isInputFieldCollapsed = true;
  //tasklist
  final taskList = TaskModel.taskList();

  //get the data
  final textClt = TextEditingController();

  //filter data
  List<TaskModel> findTask = [];

  @override
  void initState() {
    findTask = taskList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(),
        resizeToAvoidBottomInset: isInputFieldCollapsed ? true : false,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12.00, vertical: 15.00),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    searchBox(),
                    Container(
                      padding: const EdgeInsets.only(top: 30.00, bottom: 8),
                      child: const Text("My Tasks",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          for (TaskModel task in findTask)
                            TodoItem(
                              task: task,
                              onChanged: handeTodoChanged,
                              onDelete: handleTaskDelete,
                              onEdit: handleTaskEdit,
                            ),
                          const SizedBox(
                            height: 70,
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: const [
                              BoxShadow(
                                  color: greyColor,
                                  blurRadius: 1.00,
                                  spreadRadius: 0.00,
                                  offset: Offset(0.0, 0.0))
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: TextField(
                            onTap: () {
                              setState(() {
                                isInputFieldCollapsed = true;
                              });
                            },
                            controller: textClt,
                            style: const TextStyle(color: greyColor),
                            decoration: const InputDecoration(
                              hintText: "Add Task...",
                              hintStyle: TextStyle(color: greyColor),
                              contentPadding: EdgeInsets.only(left: 15),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          isEdit
                              ? handleTaskEditSubmit()
                              : handleTask(textClt.text);
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14.00,
                            ),
                            elevation: 10.00,
                            backgroundColor: primaryColor,
                            foregroundColor: whiteColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4))),
                        child: const Icon(
                          Icons.add,
                          size: 30,
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void handeTodoChanged(TaskModel task) {
    setState(() {
      task.isDone = !task.isDone!;
    });
  }

  void handleTaskEdit(String id) {
    isEdit = true;
    final foundItem = taskList.firstWhere((item) => item.id == id);
    taskId = foundItem.id.toString();

    textClt.text = foundItem.text.toString();
  }

  void handleTaskEditSubmit() {
    isEdit = false;
    setState(() {
      final foundItem = taskList.firstWhere((item) => item.id == taskId);

      foundItem.text = textClt.text;
      textClt.text = '';
    });
  }

  void handleTaskDelete(String id) {
    setState(() {
      taskList.removeWhere((element) => element.id == id);
    });
  }

  handleTask(String task) {
    if (textClt.text == '') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please Enter a Task"),
        dismissDirection: DismissDirection.horizontal,
      ));
      return;
    } else {
      setState(() {
        taskList.add(TaskModel(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          text: task,
        ));
      });

      textClt.clear();
      return;
    }
  }

  void runFilter(String keyWord) {
    List<TaskModel> result = [];

    if (keyWord.isEmpty) {
      result = taskList;
    } else {
      result = taskList
          .where((element) =>
              element.text!.toLowerCase().contains(keyWord.toLowerCase()))
          .toList();
    }

    setState(() {
      findTask = result;
    });
  }

  _buildAppbar() {
    return AppBar(
      elevation: 0.00,
      leading: const Icon(
        Icons.menu,
        size: 35.00,
        color: whiteColor,
      ),
      title: const Text(
        "GetTODOs",
        style: TextStyle(
            fontWeight: FontWeight.bold, color: greyColor, fontSize: 24),
      ),
      centerTitle: true,
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: CircleAvatar(
            backgroundColor: primaryColor,
            child: Icon(Icons.person, size: 20.00),
          ),
        )
      ],
    );
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.00),
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(24.00)),
      child: TextField(
        onTap: () {
          setState(() {
            isInputFieldCollapsed = false;
          });
        },
        onChanged: (value) => runFilter(value),
        style: const TextStyle(color: greyColor),
        decoration: const InputDecoration(
            hintText: "Search Here...",
            hintStyle: TextStyle(fontSize: 14.00, color: greyColor),
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              color: greyColor,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 30)),
      ),
    );
  }
}
