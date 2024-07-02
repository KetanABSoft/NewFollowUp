import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../controller/clockin_controller.dart';
import '../controller/dashboard_controller.dart';
import '../utils/app_color.dart';
import '../screens/clock_in_details.dart'; // Adjust the import as per your project structure
import 'package:http/http.dart'as http;
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashboardController dashboardController = Get.put(DashboardController());
  final ClockInController controller = Get.put(ClockInController());

  bool isClockedIn = false;
  DateTime? clockInTime;
  DateTime? clockOutTime;
  late String currentDate;
  late String userLocation = '';

  @override
  void initState() {
    super.initState();
    setCurrentDate();
    requestLocationPermission();
  }

  void setCurrentDate() {
    currentDate = DateFormat('d MMMM y').format(DateTime.now());
  }

  void requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      // Permission granted, fetch location
      getUserLocation();
    } else {
      // Handle denied or restricted permission
      setState(() {
        userLocation = 'Permission denied to access location';
      });
    }
  }

  void clockInOut() async {
    setState(() {
      if (isClockedIn) {
        clockOutTime = DateTime.now();
        controller.postClockOut().then((message) {
          showResponseDialog(message);
        }).catchError((error) {
          print('Error during clock out: $error');
          showResponseDialog('Failed to clock out');
        });
      } else {
        clockInTime = DateTime.now();
        controller.postClockIn().then((message) {
          showResponseDialog(message);
        }).catchError((error) {
          print('Error during clock in: $error');
          showResponseDialog('Failed to clock in');
        });
      }
      isClockedIn = !isClockedIn;
    });
  }

  // Future<String> postClockIn() async {
  //   Map<String, dynamic> data = {
  //     'email': 'tanaya@gmail.com',
  //     'role': 'sub-employee',
  //     'ip': '103.17.159.50',
  //     'lat': '37.4219983',
  //     'long': '-122.084',
  //   };
  //
  //   try {
  //     final response = await http.post(
  //       Uri.parse("http://localhost:5000/api/salary/clock-ins"),
  //       body: jsonEncode(data),
  //       headers: {
  //         'Content-Type': 'application/json; charset=utf-8',
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       var responseData = jsonDecode(response.body);
  //       print('Clock In Response: $responseData');
  //       return 'Clock in successful'; // Return success message
  //     } else {
  //       print('Clock In Error: ${response.statusCode}');
  //       return 'Failed to clock in'; // Return specific error message for failed response
  //     }
  //   } catch (e) {
  //     print('Exception during clock in: $e');
  //     return 'Failed to clock in'; // Return specific error message for exception
  //   }
  // }

  // Future<String> postClockOut() async {
  //   Map<String, dynamic> data = {
  //     'email': 'tanaya@gmail.com',
  //     'role': 'sub-employee',
  //     'ip': '103.17.159.50',
  //     'lat': '37.4219983',
  //     'long': '-122.084',
  //   };
  //
  //   try {
  //     final response = await http.post(
  //       Uri.parse("http://localhost:5000/api/salary/clock-outs"),
  //       body: jsonEncode(data),
  //       headers: {
  //         'Content-Type': 'application/json; charset=utf-8',
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       var responseData = jsonDecode(response.body);
  //       print('Clock Out Response: $responseData');
  //       return 'Clock out successful'; // Return success message
  //     } else {
  //       print('Clock Out Error: ${response.statusCode}');
  //       return 'Failed to clock out'; // Return specific error message for failed response
  //     }
  //   } catch (e) {
  //     print('Exception during clock out: $e');
  //     return 'Failed to clock out'; // Return specific error message for exception
  //   }
  // }

  Future<String> getUserLocation() async {
    try {
      Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      print('Current latitude: ${currentPosition.latitude}, longitude: ${currentPosition.longitude}');
      return 'Lat: ${currentPosition.latitude}, Long: ${currentPosition.longitude}';
    } catch (e) {
      print('Error getting location: $e');
      return 'Error: ${e.toString()}';
    }
  }

  void showResponseDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("API Response"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String calculateWorkingHours() {
    if (clockInTime != null && clockOutTime != null) {
      Duration difference = clockOutTime!.difference(clockInTime!);
      int totalMinutes = difference.inMinutes;
      int hours = totalMinutes ~/ 60;
      int minutes = totalMinutes % 60;
      return '$hours h $minutes m';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    String token = 'your_token_here'; // Replace with your actual token
    controller.setToken(token);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 12.h,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff7c81dd), // Set app bar background color to transparent
        elevation: 0, // Remove app bar shadow
        title: Padding(
          padding: EdgeInsets.only(bottom: 8.sp),
          child: Text(
            'Task Management',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white, // Set app bar text color to white
              fontSize: 17.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: clockInOut,
            child: Padding(
              padding: EdgeInsets.only(top: 10.sp),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isClockedIn ? Icons.login : Icons.logout,
                        color: Colors.white,
                        size: 17.sp,
                      ),
                      SizedBox(width: 5), // Adjust spacing between icon and text
                      Text(
                        isClockedIn ? 'Clock Out' : 'Clock In',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  // Display clock-in time below clock-in button if clocked in
                  if (isClockedIn && clockInTime != null)
                    Text(
                      'Clock In Time: ${DateFormat.jm().format(clockInTime!)}',
                      style: TextStyle(fontSize: 11.sp, color: Colors.white),
                    ),
                  // Display clock-out time below clock-out button if clocked out
                  if (!isClockedIn && clockOutTime != null)
                    Text(
                      'Clock Out Time: ${DateFormat.jm().format(clockOutTime!)}',
                      style: TextStyle(fontSize: 11.sp, color: Colors.white),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 1.8.h, left: 12.sp, right: 12.sp),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 60.w),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ClockIn()));
                },
                child: Container(
                  height: 7.h,
                  width: 35.w,
                  decoration: BoxDecoration(
                      color: ColorsForApp.loginButtonColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white, width: 1)),
                  child: Center(
                    child: Text(
                      "Time Shift",
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 32.h, // Set the desired height for the chart
              child: TaskManagementChart(data: dashboardController.taskData),
            ),
            SizedBox(height: 2.h),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(dashboardController.items.length, (index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 8.sp),
                      child: Card(
                        child: ListTile(
                          leading: Container(
                            width: 8.w, // Adjust the width as needed
                            height: 5.h, // Adjust the height as needed
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0.sp),
                            ),
                            child: Image.asset(
                              dashboardController.icons[index], // Use the icon path from the list
                              width: 20.sp, // Adjust the icon width as needed
                              height: 20.sp, // Adjust the icon height as needed
                            ),
                          ),
                          title: Text(
                            '${dashboardController.items[index]}',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11.sp, // Font size
                              fontWeight: FontWeight.bold, // Font weight
                              color: Colors.black, // Text color
                            ),
                          ),
                          trailing: Text(
                            '${dashboardController.taskData[index].taskValue.toInt()}',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12.sp, // Font size
                              color: Colors.black, // Text color
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          onTap: () {
                            switch (index) {
                              case 0:
                                dashboardController.HandleTotalTask(context);
                                break;
                              case 1:
                                dashboardController.HandlePendingTask(context);
                                break;
                              case 2:
                                dashboardController.HandleOverdueTask(context);
                                break;
                              case 3:
                                dashboardController.HandleCompleteTask(context);
                                break;
                              case 4:
                                dashboardController.HandleSendTask(context);
                                break;
                              case 5:
                                dashboardController.HandleReciveTask(context);
                                break;
                            }
                          },
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFD700),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30.sp),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 5.sp,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Color(0xFFFFD700),
          currentIndex: dashboardController.currentIndex.value,
          onTap: _onTabTapped,
          selectedItemColor: ColorsForApp.greyColor,
          unselectedItemColor: ColorsForApp.greyColor,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add Task',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'New lead',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  Icon(Icons.notifications),
                  Positioned(
                    right: 0,
                    top: -4,
                    child: Container(
                      padding: EdgeInsets.all(3.sp),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: Text(
                        dashboardController.notificationCount.value.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 7.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      dashboardController.currentIndex.value = index;
      switch (dashboardController.currentIndex.value) {
        case 1:
          dashboardController.HandleAddTask(context);
          break;
        case 2:
          dashboardController.HandleAddLead(context);
          break;
        case 3:
          dashboardController.HandleNotifications(context);
          break;
        case 4:
          dashboardController.HandleProfile(context);
          break;
        default:
          dashboardController.HandleDashboard(context);
          break;
      }
    });
  }
}

class TaskData {
  final String taskName;
  final double taskValue;
  final Color taskColor;

  TaskData({
    required this.taskName,
    required this.taskValue,
    required this.taskColor,
  });
}

class TaskManagementChart extends StatelessWidget {
  final RxList<TaskData> data;

  TaskManagementChart({required this.data});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<charts.Series<TaskData, String>> series = [
        charts.Series<TaskData, String>(
          id: 'Tasks',
          data: data,
          domainFn: (TaskData task, _) => task.taskName,
          measureFn: (TaskData task, _) => task.taskValue,
          colorFn: (TaskData task, _) =>
              charts.ColorUtil.fromDartColor(task.taskColor),
          labelAccessorFn: (TaskData task, _) => '${task.taskValue.toInt()}',
        ),
      ];

      bool allValuesZero = data.every((task) => task.taskValue == 0);

      if (allValuesZero) {
        // If all values are zero, display a gray pie chart
        return Container(
          width: 50.0, // Adjust the width as needed
          height: 50.0, // Adjust the height as needed
          decoration: BoxDecoration(
            shape: BoxShape.circle, // Create a circular shape
            color: Colors.grey, // Set the background color to gray
          ),
          child: Center(
            child: Text(
              '0',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        );
      } else {
        try {
          return charts.PieChart(
            series,
            animate: true,
            defaultRenderer: charts.ArcRendererConfig<String>(
              arcWidth: 50,
              arcRendererDecorators: [charts.ArcLabelDecorator()],
            ),
          );
        } catch (e, stackTrace) {
          print('PieChart rendering error: $e\n$stackTrace');
          return Container();
        }
      }
    });
  }
}
