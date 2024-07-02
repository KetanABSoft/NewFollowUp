import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;

class LoginController extends GetxController
{
TextEditingController usernamecontroller =TextEditingController();
TextEditingController passwordcontroller =TextEditingController();

var data;

Future<bool> EmployeeLoginApi() async {
  Map<String, dynamic> abc = {
    'email': usernamecontroller.text.trim(),
    'password': passwordcontroller.text.trim(),

  };

  try {
    final response = await http.post(
      Uri.parse("http://103.159.85.246:4000/api/subemployee/login"),
      body: jsonEncode(abc),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      print('Data Added: $data');
      return true; // Return 'success' if data is successfully added
    } else {
      print('Error: ${response.statusCode}');
      return false; // Return specific error message for failed response
    }
  } catch (e) {
    print('Exception during add operation: $e');
    return false; // Return specific error message for exception
  }
}

}