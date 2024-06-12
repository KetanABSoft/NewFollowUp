import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../api/model/add_task.dart';
import '../screens/dashboard_screen.dart';

class CreateTaskController extends GetxController
{
  final GlobalKey<FormState> create_task_key = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController reminderDateController = TextEditingController();
  TextEditingController reminderTimeController = TextEditingController();

  RxList abc =[
    "Ketan","Sakshi","Sonam","Pramod","Sohil","Rohit","Harshad","Pooja"
  ].obs;

  RxList<String> selectedItems = <String>[].obs;

  Future<void> createTask() async {
    final url = Uri.parse('http://localhost:5000/api/task/create');
    final payload = {
      "title": "wertyui",
      "description": "dsfghjkl",
      "assignTo": ["66545e272c6f1c12159398a4"],
      "startDate": "2024-06-07T00:00:00.000Z",
      "deadlineDate": "2024-06-09T00:00:00.000Z",
      "reminderDate": "2024-06-08T00:00:00.000Z",
      "startTime": "11:42 AM",
      "endTime": "11:40 AM",
      "reminderTime": "11:40 AM",
      "status": "pending",
      "assignedBy": ["66545d952c6f1c121593988b"]
    };
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(payload),
    );
print("###################$payload");
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print("Response: $responseData");
      List<dynamic> tasks = responseData['tasks'];
      Get.to(DashboardScreen());
    } else {
      print("Failed to create task. Status code: ${response.statusCode}");
    }
  }
}