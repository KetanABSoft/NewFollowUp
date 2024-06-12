// To parse this JSON data, do
//
//     final addTask = addTaskFromJson(jsonString);

import 'dart:convert';

AddTask addTaskFromJson(String str) => AddTask.fromJson(json.decode(str));

String addTaskToJson(AddTask data) => json.encode(data.toJson());

class AddTask {
  String message;
  List<Task> tasks;

  AddTask({
    required this.message,
    required this.tasks,
  });

  factory AddTask.fromJson(Map<String, dynamic> json) => AddTask(
    message: json["message"],
    tasks: List<Task>.from(json["tasks"].map((x) => Task.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "tasks": List<dynamic>.from(tasks.map((x) => x.toJson())),
  };
}

class Task {
  String title;
  String description;
  List<String> assignTo;
  DateTime startDate;
  DateTime deadlineDate;
  String startTime;
  String endTime;
  String status;
  String assignedBy;
  String id;
  int v;

  Task({
    required this.title,
    required this.description,
    required this.assignTo,
    required this.startDate,
    required this.deadlineDate,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.assignedBy,
    required this.id,
    required this.v,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    title: json["title"],
    description: json["description"],
    assignTo: List<String>.from(json["assignTo"].map((x) => x)),
    startDate: DateTime.parse(json["startDate"]),
    deadlineDate: DateTime.parse(json["deadlineDate"]),
    startTime: json["startTime"],
    endTime: json["endTime"],
    status: json["status"],
    assignedBy: json["assignedBy"],
    id: json["_id"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "assignTo": List<dynamic>.from(assignTo.map((x) => x)),
    "startDate": startDate.toIso8601String(),
    "deadlineDate": deadlineDate.toIso8601String(),
    "startTime": startTime,
    "endTime": endTime,
    "status": status,
    "assignedBy": assignedBy,
    "_id": id,
    "__v": v,
  };
}
