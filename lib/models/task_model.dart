class TaskModel {
  String? id;
  String? text;
  bool? isDone;

  TaskModel({required this.id, required this.text, this.isDone = false});

  static List<TaskModel> taskList() {
    return [
      TaskModel(id: "1", text: "Create Naivation Bar", isDone: true),
      TaskModel(id: "2", text: "Splash Screen", isDone: true),
      TaskModel(id: "3", text: "Integrate Firebase"),
      TaskModel(id: "4", text: "Impliment Rest Api"),
      TaskModel(id: "5", text: "Adding Dailogue Box"),
      TaskModel(id: "6", text: "Enable Dark Mode"),
      TaskModel(id: "7", text: "Refactor Code"),
    ];
  }
}
