class TaskModel {
  String? id;
  String? text;
  bool? isDone;

  TaskModel({required this.id, required this.text, this.isDone = false});

  static List<TaskModel> taskList() {
    return [
      TaskModel(id: "1", text: "Spegate Cheese", isDone: true),
      TaskModel(id: "2", text: "Big Black Burbon", isDone: true),
      TaskModel(id: "3", text: "Dairy Milk"),
      TaskModel(id: "4", text: "Black Forest"),
      TaskModel(id: "5", text: "Black Forest"),
      TaskModel(id: "6", text: "Black Forest"),
      TaskModel(id: "7", text: "Black Forest"),
    ];
  }
}
