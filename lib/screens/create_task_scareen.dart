import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:new_follow_up/controller/create_controller.dart';
import 'package:new_follow_up/widgets/common_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../api/model/get_emp.dart';
import '../controller/dashboard_controller.dart';
import '../routs/routs.dart';
import '../utils/text_fields.dart';
import 'dashboard_screen.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  CreateTaskController createTaskController = Get.put(CreateTaskController());
  DashboardController dashboardController = Get.put(DashboardController());

  Future<List<GetEmp>> getEmp() async {
    try {
      final response = await http.get(
          Uri.parse("http://localhost:5000/api/employee/subemployee/list"));
      var data = jsonDecode(response.body.toString()) as List;
      print("#############$data");
      if (response.statusCode == 200) {
        return data.map((e) {
          final map = e as Map<String, dynamic>;
          return GetEmp(
              id: map["6662bb237eb0fa05e62b4ed4"],
              name: map["Varad"],
              phoneNumber: map["7385562528"],
              email: map["varad@gmail.com"],
              adminCompanyName: map["Acme"],
              v: map["0"],
              password:
                  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImtldGFuQGdtYWlsLmNvbSIsInJvbGUiOiJzdXBlckFkbWluIiwiaWF0IjoxNzE4Mjc4MTI3fQ.HbiuQN9eaScsvRw-TVCA4JvWZhSZpm48g0MRbbrCDTs');
        }).toList();
      }
    } on SocketException {
      throw Exception("No Internet");
    }

    throw Exception("Error Fetching Data");
  }

  var selectValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff7c81dd),
        elevation: 0,
        title: Text(
          'Add Task',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.to(DashboardScreen());
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 18.sp, right: 18.sp, top: 20.sp),
          child: Column(
            children: [
              Form(
                  key: createTaskController.create_task_key,
                  child: Column(
                    children: [
                      Container(
                        height: 5.5.h,
                        child: TextFormField(
                          controller: createTaskController.titleController,
                          decoration: InputDecoration(
                              labelText: 'Title',
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7))),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7)))),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 5.5.h,
                              width: 45.w,
                              child: TextFormField(
                                controller:
                                    createTaskController.startDateController,
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.date_range,
                                    size: 20.sp,
                                  ),
                                  labelText: 'Start Date',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontSize: 11.5.sp),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                  ),
                                ),
                                readOnly: true,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime(2100),
                                  );
                                  if (pickedDate != null) {
                                    DateTime currentDateWithoutTime = DateTime(
                                      DateTime.now().year,
                                      DateTime.now().month,
                                      DateTime.now().day,
                                    );
                                    DateTime pickedDateWithoutTime = DateTime(
                                      pickedDate.year,
                                      pickedDate.month,
                                      pickedDate.day,
                                    );

                                    if (pickedDateWithoutTime
                                            .isAfter(currentDateWithoutTime) ||
                                        pickedDateWithoutTime.isAtSameMomentAs(
                                            currentDateWithoutTime)) {
                                      String formattedStartDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);

                                      setState(() {
                                        createTaskController.startDateController
                                            .text = formattedStartDate;
                                      });

                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      await prefs.setString(
                                          'startDate', formattedStartDate);
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('Invalid Date',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins')),
                                            content: Text(
                                                'Please select a date that is today or in the future.',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins')),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('OK',
                                                    style: TextStyle(
                                                        fontFamily: 'Poppins')),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 14.0.sp),
                          Expanded(
                            child: Container(
                              height: 5.5.h,
                              width: 45.w,
                              child: TextFormField(
                                controller:
                                    createTaskController.endDateController,
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.date_range,
                                    size: 20.sp,
                                  ),
                                  labelText: 'End Date',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 11.5.sp,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                  ),
                                ),
                                readOnly: true,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime(2100),
                                  );
                                  if (pickedDate != null) {
                                    DateTime currentDateWithoutTime = DateTime(
                                      DateTime.now().year,
                                      DateTime.now().month,
                                      DateTime.now().day,
                                    );
                                    DateTime pickedDateWithoutTime = DateTime(
                                      pickedDate.year,
                                      pickedDate.month,
                                      pickedDate.day,
                                    );

                                    DateTime startDate =
                                        DateFormat('yyyy-MM-dd').parse(
                                            createTaskController
                                                .startDateController.text);

                                    if (pickedDateWithoutTime
                                            .isAfter(startDate) ||
                                        pickedDateWithoutTime
                                            .isAtSameMomentAs(startDate)) {
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);

                                      setState(() {
                                        createTaskController.endDateController
                                            .text = formattedDate;
                                      });

                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      await prefs.setString(
                                          'deadline_date', formattedDate);
                                    } else {
                                      // Display an error message for invalid end date
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('Invalid End Date',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins')),
                                            content: Text(
                                                'End date should be after or the same as the start date. Please select the correct date.',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins')),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('OK',
                                                    style: TextStyle(
                                                        fontFamily: 'Poppins')),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 5.5.h,
                              width: 45.w,
                              child: TextField(
                                controller:
                                    createTaskController.startTimeController,
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.timer,
                                      size: 20.sp,
                                    ),
                                    labelText: 'Start Time',
                                    labelStyle: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                        fontSize: 11.5.sp),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7))),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7))),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7)))),
                                readOnly: true,
                                onTap: () async {
                                  DateTime now = DateTime.now();
                                  print("iwontcorrecttime");

                                  DateFormat dateFormat = DateFormat(
                                      'yyyy-MM-dd'); // Format for the start date

                                  DateTime selectedStartDate =
                                      createTaskController.startDateController
                                              .text.isNotEmpty
                                          ? dateFormat.parse(
                                              createTaskController
                                                  .startDateController.text)
                                          : DateTime(0);
                                  print(selectedStartDate);
                                  print(DateTime(now.year, now.month, now.day));
                                  if (selectedStartDate.isAfter(
                                      DateTime(now.year, now.month, now.day))) {
                                    TimeOfDay? pickedTime =
                                        await showTimePicker(
                                      initialTime: TimeOfDay.now(),
                                      context: context,
                                    );

                                    if (pickedTime != null) {
                                      DateTime now = DateTime.now();
                                      String formattedTime =
                                          DateFormat('HH:mm:ss').format(
                                        DateTime(now.year, now.month, now.day,
                                            pickedTime.hour, pickedTime.minute),
                                      );
                                      String endTimenew =
                                          DateFormat('HH:mm:ss').format(
                                        DateTime(
                                            now.year,
                                            now.month,
                                            now.day,
                                            pickedTime.hour + 1,
                                            pickedTime.minute),
                                      );
                                      // Delay the execution of setState
                                      Future.delayed(Duration.zero, () {
                                        setState(() {
                                          createTaskController
                                              .startTimeController
                                              .text = formattedTime;
                                        });
                                      });
                                      //}
                                    } else {
                                      print("Time is not selected");
                                    }
                                  } else {
                                    TimeOfDay? pickedTime =
                                        await showTimePicker(
                                      initialTime: TimeOfDay.now(),
                                      context: context,
                                    );

                                    if (pickedTime != null) {
                                      DateTime now = DateTime.now();
                                      TimeOfDay currentTimeOfDay =
                                          TimeOfDay.fromDateTime(now);
                                      if (pickedTime.hour <
                                              currentTimeOfDay.hour ||
                                          (pickedTime.hour ==
                                                  currentTimeOfDay.hour &&
                                              pickedTime.minute <
                                                  currentTimeOfDay.minute)) {
                                        // Show error dialog
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text('Invalid Time',
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins')),
                                              content: Text(
                                                  'Please select the correct time.',
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins')),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('OK',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Poppins')),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      } else {
                                        String formattedTime =
                                            DateFormat('HH:mm:ss').format(
                                          DateTime(
                                              now.year,
                                              now.month,
                                              now.day,
                                              pickedTime.hour,
                                              pickedTime.minute),
                                        );

                                        String endTimenew =
                                            DateFormat('HH:mm:ss').format(
                                          DateTime(
                                              now.year,
                                              now.month,
                                              now.day,
                                              pickedTime.hour + 1,
                                              pickedTime.minute),
                                        );
                                        Future.delayed(Duration.zero, () {
                                          setState(() {
                                            createTaskController
                                                .startTimeController
                                                .text = formattedTime;
                                          });
                                        });
                                      }
                                    } else {
                                      print("Time is not selected");
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 14.0.sp),
                          Expanded(
                            child: Container(
                              height: 5.5.h,
                              width: 45.w,
                              child: TextField(
                                controller:
                                    createTaskController.endTimeController,
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.timer,
                                      size: 25.sp,
                                    ),
                                    labelText: 'End Time',
                                    labelStyle: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                        fontSize: 11.5.sp),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7))),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7))),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7)))),
                                readOnly: true,
                                onTap: () async {
                                  DateTime now = DateTime.now();
                                  DateFormat dateFormat = DateFormat(
                                      'yyyy-MM-dd'); // Format for the start date
                                  DateTime selectedStartDate =
                                      createTaskController.startDateController
                                              .text.isNotEmpty
                                          ? dateFormat.parse(
                                              createTaskController
                                                  .startDateController.text)
                                          : DateTime(0);
                                  DateTime selectedendtDate =
                                      createTaskController
                                              .endDateController.text.isNotEmpty
                                          ? dateFormat.parse(
                                              createTaskController
                                                  .endDateController.text)
                                          : DateTime(0);
                                  print(selectedStartDate);
                                  print(selectedendtDate);
                                  if (selectedendtDate
                                      .isAfter(selectedStartDate)) {
                                    TimeOfDay? pickedTime =
                                        await showTimePicker(
                                      initialTime: TimeOfDay.now(),
                                      context: context,
                                    );
                                    if (pickedTime != null) {
                                      DateTime now = DateTime.now();

                                      String formattedTime =
                                          DateFormat('HH:mm:ss').format(
                                        DateTime(now.year, now.month, now.day,
                                            pickedTime.hour, pickedTime.minute),
                                      );
                                      setState(() {
                                        createTaskController.endTimeController
                                            .text = formattedTime;
                                      });

                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      await prefs.setString(
                                          'endTime', formattedTime);
                                    }
                                  } else {
                                    TimeOfDay? pickedTime =
                                        await showTimePicker(
                                      initialTime: TimeOfDay.now(),
                                      context: context,
                                    );
                                    if (pickedTime != null) {
                                      DateTime currentDateWithoutTime =
                                          DateTime(
                                              DateTime.now().year,
                                              DateTime.now().month,
                                              DateTime.now().day);

                                      DateTime now = DateTime.now();
                                      TimeOfDay currentTimeOfDay =
                                          TimeOfDay.fromDateTime(now);
                                      print(currentDateWithoutTime);
                                      DateTime selectedendtDate =
                                          createTaskController.endDateController
                                                  .text.isNotEmpty
                                              ? dateFormat.parse(
                                                  createTaskController
                                                      .endDateController.text)
                                              : DateTime(0);

                                      if ((pickedTime.hour <
                                              currentTimeOfDay.hour ||
                                          (pickedTime.hour ==
                                                  currentTimeOfDay.hour &&
                                              pickedTime.minute <
                                                  currentTimeOfDay.minute))) {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text('Invalid Time',
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins')),
                                              content: Text(
                                                  'Please select the correct time.',
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins')),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('OK',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Poppins')),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      } else {
                                        String formattedTime =
                                            DateFormat('HH:mm:ss').format(
                                          DateTime(
                                              now.year,
                                              now.month,
                                              now.day,
                                              pickedTime.hour,
                                              pickedTime.minute),
                                        );
                                        Future.delayed(Duration.zero, () {
                                          setState(() {
                                            createTaskController
                                                .endTimeController
                                                .text = formattedTime;
                                          });
                                        });
                                      }
                                    } else {
                                      print("Time is not selected");
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Reminder:-",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 5.5.h,
                              width: 45.w,
                              child: TextFormField(
                                controller:
                                    createTaskController.reminderDateController,
                                decoration: InputDecoration(
                                    icon: Icon(Icons.date_range, size: 20.sp),
                                    labelText: 'Reminder Date',
                                    labelStyle: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                        fontSize: 11.5.sp),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7))),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7))),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7)))),
                                readOnly: true,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime(2100),
                                  );
                                  if (pickedDate != null) {
                                    DateTime currentDateWithoutTime = DateTime(
                                      DateTime.now().year,
                                      DateTime.now().month,
                                      DateTime.now().day,
                                    );
                                    DateTime pickedDateWithoutTime = DateTime(
                                      pickedDate.year,
                                      pickedDate.month,
                                      pickedDate.day,
                                    );

                                    DateTime startDate =
                                        DateFormat('yyyy-MM-dd').parse(
                                            createTaskController
                                                .startDateController.text);
                                    DateTime endDate = DateFormat('yyyy-MM-dd')
                                        .parse(createTaskController
                                            .endDateController.text);

                                    if ((pickedDateWithoutTime
                                                .isAfter(startDate) ||
                                            pickedDateWithoutTime
                                                .isAtSameMomentAs(startDate)) &&
                                        (pickedDateWithoutTime
                                                .isBefore(endDate) ||
                                            pickedDateWithoutTime
                                                .isAtSameMomentAs(endDate))) {
                                      setState(() {
                                        createTaskController
                                                .reminderDateController.text =
                                            DateFormat('yyyy-MM-dd')
                                                .format(pickedDate);
                                      });

                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      await prefs.setString(
                                          'reminderDate',
                                          createTaskController
                                              .reminderDateController.text);
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('Invalid Reminder Date',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins')),
                                            content: Text(
                                                'Please select a date between the start date and end date.',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins')),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('OK',
                                                    style: TextStyle(
                                                        fontFamily: 'Poppins')),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 14.0.sp),
                          Expanded(
                            child: Container(
                              height: 5.5.h,
                              width: 45.w,
                              child: TextField(
                                controller:
                                    createTaskController.reminderTimeController,
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.timer,
                                      size: 25,
                                    ),
                                    labelText: 'Reminder Time',
                                    labelStyle: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                        fontSize: 11.5.sp),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7))),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7))),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7)))),
                                readOnly: true,
                                onTap: () async {
                                  DateTime now = DateTime.now();
                                  DateFormat dateFormat = DateFormat(
                                      'yyyy-MM-dd'); // Format for the start date

                                  DateTime selectedStartDate =
                                      createTaskController.startDateController
                                              .text.isNotEmpty
                                          ? dateFormat.parse(
                                              createTaskController
                                                  .startDateController.text)
                                          : DateTime(0);
                                  DateTime selectedendtDate =
                                      createTaskController
                                              .endDateController.text.isNotEmpty
                                          ? dateFormat.parse(
                                              createTaskController
                                                  .endDateController.text)
                                          : DateTime(0);
                                  print("justcheck");
                                  print(selectedStartDate);
                                  print(selectedendtDate);
                                  if (selectedendtDate
                                      .isAfter(selectedStartDate)) {
                                    TimeOfDay? pickedTime =
                                        await showTimePicker(
                                      initialTime: TimeOfDay.now(),
                                      context: context,
                                    );
                                    if (pickedTime != null) {
                                      DateTime now = DateTime.now();
                                      String formattedTime =
                                          DateFormat('HH:mm:ss').format(
                                        DateTime(now.year, now.month, now.day,
                                            pickedTime.hour, pickedTime.minute),
                                      );
                                      setState(() {
                                        createTaskController
                                            .reminderTimeController
                                            .text = formattedTime;
                                      });
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      await prefs.setString(
                                          'endTime', formattedTime);
                                    }
                                  } else {
                                    TimeOfDay? pickedTime =
                                        await showTimePicker(
                                      initialTime: TimeOfDay.now(),
                                      context: context,
                                    );
                                    if (pickedTime != null) {
                                      DateTime currentDateWithoutTime =
                                          DateTime(
                                              DateTime.now().year,
                                              DateTime.now().month,
                                              DateTime.now().day);
                                      DateTime now = DateTime.now();
                                      TimeOfDay currentTimeOfDay =
                                          TimeOfDay.fromDateTime(now);
                                      print(currentDateWithoutTime);
                                      DateTime selectedendtDate =
                                          createTaskController.endDateController
                                                  .text.isNotEmpty
                                              ? dateFormat.parse(
                                                  createTaskController
                                                      .endDateController.text)
                                              : DateTime(0);
                                      if ((pickedTime.hour <
                                              currentTimeOfDay.hour ||
                                          (pickedTime.hour ==
                                                  currentTimeOfDay.hour &&
                                              pickedTime.minute <
                                                  currentTimeOfDay.minute))) {
                                        // Show error dialog
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text('Invalid Time',
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins')),
                                              content: Text(
                                                  'Please select the correct time.',
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins')),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('OK',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Poppins')),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      } else {
                                        String formattedTime =
                                            DateFormat('HH:mm:ss').format(
                                          DateTime(
                                              now.year,
                                              now.month,
                                              now.day,
                                              pickedTime.hour,
                                              pickedTime.minute),
                                        );
                                        Future.delayed(Duration.zero, () {
                                          setState(() {
                                            createTaskController
                                                .reminderTimeController
                                                .text = formattedTime;
                                          });
                                        });
                                      }
                                    } else {
                                      print("Time is not selected");
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      FutureBuilder(
                          future: getEmp(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return DropdownButton(
                                  hint: Text("Select Value"),
                                  items: snapshot.data!.map((e) {
                                    return DropdownMenuItem(
                                      value: e.name.toString(),
                                      child: Text(e.name.toString()),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectValue = value;
                                    });
                                  });
                            } else {
                              // return Center(child: CircularProgressIndicator());
                              return Text("No Data");
                            }
                          }),
                      SizedBox(height: 4.h),
                      Container(
                        height: 20.h,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(7)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 5.sp),
                              child: Row(
                                children: [
                                  SizedBox(width: 6.w),
                                  Text(
                                    "Select Employee",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  SizedBox(width: 28.w),
                                  Text(
                                    "select",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  SizedBox(width: 7.w),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     showModalBottomSheet(
                                  //       context: context,
                                  //       builder: (context) {
                                  //         return FutureBuilder(
                                  //           future: createTaskController.getEmp(),
                                  //           builder: (snapshot , index){
                                  //             return  ListView.builder(
                                  //               itemCount: createTaskController.abc.length,
                                  //               itemBuilder: (context, index) {
                                  //                 return Obx(
                                  //                       () => Column(
                                  //                     children: [
                                  //                       ListTile(
                                  //                         title: Text(
                                  //                             createTaskController
                                  //                                 .abc[index]),
                                  //                         trailing: Checkbox(
                                  //                           value: createTaskController
                                  //                               .selectedItems
                                  //                               .contains(
                                  //                               createTaskController
                                  //                                   .abc[index]),
                                  //                           onChanged: (bool? value) {
                                  //                             if (value == true) {
                                  //                               createTaskController
                                  //                                   .selectedItems
                                  //                                   .add(
                                  //                                   createTaskController
                                  //                                       .abc[
                                  //                                   index]);
                                  //                             } else {
                                  //                               createTaskController
                                  //                                   .selectedItems
                                  //                                   .remove(
                                  //                                   createTaskController
                                  //                                       .abc[
                                  //                                   index]);
                                  //                             }
                                  //                           },
                                  //                         ),
                                  //                       ),
                                  //                     ],
                                  //                   ),
                                  //                 );
                                  //               },
                                  //             );
                                  //           },
                                  //
                                  //         );
                                  //       },
                                  //     );
                                  //   },
                                  //   child: Icon(Icons.arrow_drop_down),
                                  // ),

                                  // FutureBuilder(
                                  //     future: getEmp(),
                                  //     builder: (context , snapshot){
                                  //       if(snapshot.hasData)
                                  //         {
                                  //           return DropdownButton(
                                  //             hint: Text("Select Value"),
                                  //               items: snapshot.data!.map((e){
                                  //                 return DropdownMenuItem(
                                  //                     value: e.name.toString(),
                                  //                     child: Text(e.name.toString())
                                  //                 );
                                  //               }).toList(),
                                  //               onChanged: (value){
                                  //                 setState(() {
                                  //                   selectValue=value;
                                  //                 });
                                  //               }
                                  //           );
                                  //         }
                                  //       else{
                                  //         return Center(child: CircularProgressIndicator());
                                  //       }
                                  //     }
                                  // )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Obx(
                              () => Expanded(
                                child:
                                    createTaskController.selectedItems.isEmpty
                                        ? Text(
                                            'Select Items',
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 11.5.sp),
                                          )
                                        : ListView.builder(
                                            itemCount: createTaskController
                                                .selectedItems.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 2.sp,
                                                    horizontal: 5.sp),
                                                child: Text(
                                                  createTaskController
                                                      .selectedItems[index],
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 11.5.sp,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              SizedBox(
                height: 3.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: CommonButton(
                        height: 5.h,
                        width: 50.w,
                        onPressed: () {},
                        label: "Upload Audio"),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Expanded(
                    child: CommonButton(
                        height: 5.h,
                        width: 50.w,
                        onPressed: () {},
                        label: "Upload Photo"),
                  ),
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
          CommonButton(
            onPressed: () async {
              bool taskCreated = await createTaskController.createTask();
              if (taskCreated) {
                // Show dialog box here
                showDialog(
                  context: context, // Pass the context from the build method
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text("Task Created"),
                      // content: Text("Your task has been successfully created."),
                      actions: <Widget>[
                        TextButton(
                          child: Text("OK"),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                            Get.toNamed(Routs.DASHBOARD_ROUTE); // Navigate to dashboard
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
            label: "Save",
          )

          ],
          ),
        ),
      ),
    );
  }
}
