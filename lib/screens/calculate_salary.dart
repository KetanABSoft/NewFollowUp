import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controller/calculate_salary_controller.dart';
import '../utils/text_fields.dart';

class CalculateSalary extends StatefulWidget {
  const CalculateSalary({Key? key}) : super(key: key);

  @override
  State<CalculateSalary> createState() => _CalculateSalaryState();
}

class _CalculateSalaryState extends State<CalculateSalary> {
  final CalculateSalaryController calculateSalaryController =
  Get.put(CalculateSalaryController());

  void showResponseDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (message == 'success' && calculateSalaryController.data != null) {
          return AlertDialog(
            title: Text("API Response"),
            content: Text(
                "Total Salary of Employee is ${calculateSalaryController.data["total"].toString()}"),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff7c81dd),
        title: Center(
          child: Text(
            "Calculate Salary",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: calculateSalaryController.key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Email field
                      Text(
                        "Email",
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 1.h),
                      CustomTextField(
                        controller:
                        calculateSalaryController.emailController,
                        hintText: "Email",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter email";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 3.h),

                      // Start Date field
                      Text(
                        "Start Date",
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 1.h),
                      CustomTextField(
                        controller:
                        calculateSalaryController.startDateController,
                        hintText: "Start Date",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter start date";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 3.h),

                      // End Date field
                      Text(
                        "End Date",
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 1.h),
                      CustomTextField(
                        controller:
                        calculateSalaryController.endDateController,
                        hintText: "End Date",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter end date";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 3.h),

                // Submit button
                InkWell(
                  onTap: () async {
                    if (calculateSalaryController.key.currentState!
                        .validate()) {
                      // Form is valid, handle submission logic here
                      String? responseMessage =
                      await calculateSalaryController.add();
                      if (responseMessage != null) {
                        showResponseDialog(responseMessage);
                      } else {
                        showResponseDialog("Failed to calculate salary.");
                      }
                    }
                  },
                  child: Container(
                    height: 50.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
