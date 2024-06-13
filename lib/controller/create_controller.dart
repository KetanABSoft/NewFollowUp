import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../api/model/get_emp.dart';

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

  Future<bool> createTask() async {
    try{ final url = Uri.parse('http://localhost:5000/api/task/create');
    final payload = {
      "title": titleController.text.toString(),
      "description": "dsfghjkl",
      "assignTo": ["66545e272c6f1c12159398a4"],
      "startDate": startDateController.text.toString(),
      "deadlineDate":endDateController.text.toString(),
      "reminderDate": reminderDateController.text.toString(),
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
    if (response.statusCode == 201) {
      final responseData = json.decode(response.body);
      if (kDebugMode) {
        print("Response: $responseData");
      }
      List<dynamic> tasks = responseData['tasks'];
      return true ;
    } else {
      print("Failed to create task. Status code: ${response.statusCode}");
      return false;
    }
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
      return false ;
    }

  }

  // List<GetEmp> employees = [];
  // Future<List<GetEmp>> getEmp() async
  // {
  //  final response = await http.get(Uri.parse("http://localhost:5000/api/employee/subemployee/list"));
  //  var data = jsonDecode(response.body.toString());
  //  if(response.statusCode==200)
  //    {
  //      for(var index in data)
  //        {
  //          employees.add(GetEmp.fromJson(index));
  //          print("#################${employees.toString()}");
  //        }
  //      return employees;
  //    }
  //  else
  //    {
  //      return employees;
  //    }
  // }


// Future<List<GetEmp>> getEmp() async {
//     try
//         {
//           final response = await http.get(Uri.parse("http://localhost:5000/api/employee/subemployee/list"));
//           var data = jsonDecode(response.body.toString()) as List;
//
//           if(response.statusCode==200)
//             {
//               return data.map((e) {
//                 final map = e as Map<String , dynamic>;
//                 return GetEmp(
//                     id: map["66545d952c6f1c121593988d"],
//                     name: map["Varad"],
//                     phoneNumber: map["7385562528"],
//                     email: map["varad@gmail.com"],
//                     password: map[""],
//                     adminCompanyName: map["Acme"],
//                     v: map["0"]
//                 );
//               }).toList();
//             }
//         }on SocketException{
//       throw Exception("No Internet");
//     }
//
//     throw Exception("Error Fetching Data");
// }
}