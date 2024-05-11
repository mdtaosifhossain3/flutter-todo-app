import 'package:flutter/material.dart';
import 'package:lab/Widgets/TodoItem.dart';
import 'package:lab/const/colors.dart';
import 'package:lab/models/taskModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
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
    return Scaffold(
      backgroundColor: tdBgColor,
      appBar: _buildAppbar(),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 18.00, vertical: 15.00),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    searchBox(),
                    Container(
                      padding: const EdgeInsets.only(top: 40.00, bottom: 15),
                      child: const Text("My Tasks",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500)),
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          for (TaskModel task in findTask)
                            TodoItem(
                                task: task,
                                onChanged: handeTodoChanged,
                                onDelete: handleTaskDelete),
                          const SizedBox(
                            height: 70,
                          )
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
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10.00,
                                  spreadRadius: 0.00,
                                  offset: Offset(0.0, 0.0))
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: textClt,
                            decoration: const InputDecoration(
                                hintText: "Add Task...",
                                contentPadding: EdgeInsets.only(left: 15),
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          handleTask(textClt.text);
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14.00,
                            ),
                            elevation: 10.00,
                            backgroundColor: tdBlue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6))),
                        child: const Icon(
                          Icons.add,
                          size: 38,
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

  void handleTaskDelete(String id) {
    setState(() {
      taskList.removeWhere((element) => element.id == id);
    });
  }

  void handleTask(String task) {
    setState(() {
      taskList.add(TaskModel(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        text: task,
      ));
    });

    textClt.clear();
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
      backgroundColor: tdBgColor,
      foregroundColor: Colors.black,
      leading: const Icon(Icons.menu, size: 35.00),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: CircleAvatar(
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
          color: Colors.white, borderRadius: BorderRadius.circular(24.00)),
      child: TextField(
        onChanged: (value) => runFilter(value),
        decoration: const InputDecoration(
            hintText: "Search Here...",
            hintStyle: TextStyle(fontSize: 14.00),
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 30)),
      ),
    );
  }
}
