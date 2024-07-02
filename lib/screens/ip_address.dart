import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_follow_up/controller/ip_controller.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controller/calculate_salary_controller.dart';
import '../utils/text_fields.dart';
import 'admin/set_widget.dart';
class IpAddressScreen extends StatefulWidget {
  @override
  State<IpAddressScreen> createState() => _IpAddressScreenState();
}

class _IpAddressScreenState extends State<IpAddressScreen> {
  final IPController ipController = Get.put(IPController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff7c81dd),
        title: Center(
          child: Text(
            "IP Address",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: ipController.ipAddresscontroller,
              decoration: InputDecoration(
                hintText: "Enter IP Address Here",
                hintStyle: TextStyle(fontSize: 11.sp, color: Colors.grey.shade700),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.sp),
            GestureDetector(
              onTap: () async {
                await ipController.IPAddress();
                if (ipController.data != null) {
                  showResponseDialog('success');
                } else {
                  showResponseDialog('Error: Unable to fetch data');
                }
              },
              child: Container(
                height: 5.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Submit",
                    style: TextStyle(fontSize: 14.sp, color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 3.h,),
            GestureDetector(
              onTap: () async {
                Navigator.push(context,MaterialPageRoute(builder: (context)=>SetWidgets()));
              },
              child: Container(
                height: 5.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Next",
                    style: TextStyle(fontSize: 14.sp, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showResponseDialog(String message) {
    showDialog(
      context: context, // Use the context from the current build method
      builder: (BuildContext context) {
        if (message == 'success' && ipController.data != null) {
          return AlertDialog(
            title: Text("API Response"),
            content: Text(
              " ${ipController.data!['message']}",
            ),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        } else {
          return AlertDialog(
            title: Text("API Response"),
            content: Text("Error: $message"),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
      },
    );
  }
}
