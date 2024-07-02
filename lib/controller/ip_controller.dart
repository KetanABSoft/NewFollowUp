import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;

class IPController extends GetxController
{
  TextEditingController ipAddresscontroller =TextEditingController();
  var data;

  Future<String?> IPAddress() async {
    Map<String, dynamic> abc = {
      'ip': ipAddresscontroller.text.toString(),

    };

    try {
      final response = await http.post(
        Uri.parse("http://103.159.85.246:4000/api/salary/ip"),
        body: jsonEncode(abc),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      if (response.statusCode == 201) {
        data = jsonDecode(response.body.toString());
        print('Data Added: $data');
        return 'success'; // Return 'success' if data is successfully added
      } else {
        print('Error: ${response.statusCode}');
        return 'Error: ${response.statusCode}'; // Return specific error message for failed response
      }
    } catch (e) {
      print('Exception during add operation: $e');
      return 'Exception during fetch operation: $e'; // Return specific error message for exception
    }
  }
}