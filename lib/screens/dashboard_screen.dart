import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../controller/dashboard_controller.dart';
import '../utils/app_color.dart';
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}
class _DashboardScreenState extends State<DashboardScreen> {
  DashboardController dashboardController = Get.find();
  void _onTabTapped(int index) {
    setState(() {
      dashboardController.currentIndex.value = index;
      if ( dashboardController.currentIndex.value == 1) {
        dashboardController.HandleAddTask(context);
      } else if ( dashboardController.currentIndex.value == 2) {
       dashboardController.HandleAddLead(context);
      } else if ( dashboardController.currentIndex.value == 3) {
       dashboardController.HandleNotifications(context);
      } else if ( dashboardController.currentIndex.value == 4) {
      dashboardController.HandleProfile(context);
      } else {
       dashboardController.HandleDashboard(context);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor:
        Color(0xff7c81dd), // Set app bar background color to transparent
        elevation: 0, // Remove app bar shadow
        title: Text(
          'Task Management',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white, // Set app bar text color to white
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 1.8.h, left: 12.sp, right: 12.sp),
        child: Column(
          children: [
            Container(
              height: 32.h, // Set the desired height for the chart
              child: TaskManagementChart(data: dashboardController.taskData),
            ),
            SizedBox(height: 2.h,),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(dashboardController.items.length, (index) {
                    return Padding(
                      padding:  EdgeInsets.only(top: 8.sp),
                      child: Card(
                        child: ListTile(
                          leading: Container(
                            width: 8.w, // Adjust the width as needed
                            height: 5.h, // Adjust the height as needed
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0
                                  .sp), // Adjust the border radius as needed
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

