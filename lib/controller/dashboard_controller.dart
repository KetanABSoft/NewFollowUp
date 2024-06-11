import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/create_task_scareen.dart';
import '../screens/dashboard_screen.dart';
class DashboardController extends GetxController
{

  RxInt currentIndex=0.obs;
  RxInt notificationCount = 0.obs;

  void HandleAddTask(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('titleaudio');
    preferences.remove('startdateaudio');
    preferences.remove('deadlinedateaudio');
    preferences.remove('starttimeaudio');
    preferences.remove('endtimeaudio');
    preferences.remove('picaudio');
    preferences.remove('selectedValues');
   // Get.to(AddTask(audioPath: AppString.audiourl));
    Get.to(CreateTaskScreen());
  }

  void HandleAddLead(BuildContext context) {
    //Get.to(CreateLead(id: "0", task: ''));
  }

  void HandleNotifications(BuildContext context) async {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) =>
    //         NotificationScreen(admin_type: admintype.toString()),
    //   ),
    // );
  }
  void HandleDashboard(BuildContext context) {
    // Get.to(DashboardScreen());
  }

  void HandleProfile(BuildContext context) {
    // Get.to(profilemanagement());
  }

  final RxList<TaskData> taskData = <TaskData>[
    TaskData(
      taskName: 'Task',
      taskValue: 15,
      taskColor: Colors.blue,
    ),
    TaskData(
      taskName: 'Pending',
      taskValue: 5,
      taskColor: Color.fromARGB(255, 77, 77, 174),
    ),
    TaskData(
      taskName: 'Overdue',
      taskValue: 4,
      taskColor: Colors.red.withOpacity(0.9),
    ),
    TaskData(
      taskName: 'Completed',
      taskValue: 4,
      taskColor: Colors.green.withOpacity(0.9),
    ),
    TaskData(
      taskName: 'Send',
      taskValue: 10,
      taskColor: Color.fromARGB(255, 230, 200, 32),
    ),
    TaskData(
      taskName: 'Receive',
      taskValue: 12,
      taskColor: Colors.orange,
    ),
  ].obs;

  final RxList<String> items = [
    'Total Task',
    'Task Pending',
    'Task Overdue',
    'Task Completed',
    'Task Send',
    'Task Receive'
  ].obs;
  final RxList<String> icons = [
    'assets/images/totaltask.png',
    'assets/images/Pendingtask.png',
    'assets/images/Overduetask.png',
    'assets/images/Completedtask.png',
    'assets/images/Taskreceived.png',
    'assets/images/Tasksend.png',
  ].obs;
  final RxList<Color> colors = [
    Colors.blue,
    Color.fromARGB(255, 77, 77, 174),
    Colors.red.withOpacity(0.9),
    Colors.green.withOpacity(0.9),
    Color.fromARGB(255, 230, 200, 32),
    Colors.orange,
  ].obs;

  void HandleTotalTask(BuildContext context) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => TotalTask(admin_type: admintype.toString()),
    //   ),
    // );
  }

  void HandlePendingTask(BuildContext context) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) =>
    //         Taskincompletednew(admin_type: admintype.toString()),
    //   ),
    // );
  }

  void HandleOverdueTask(BuildContext context) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => OverdueTasknew(admin_type: admintype.toString()),
    //   ),
    // );
  }

  void HandleCompleteTask(BuildContext context) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => CompletedTask(admin_type: admintype.toString()),
    //   ),
    // );
  }

  void HandleReciveTask(BuildContext context) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => ReceiveTask(admin_type: admintype.toString()),
    //   ),
    // );
  }

  void HandleSendTask(BuildContext context) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => SendTask(admin_type: admintype.toString()),
    //   ),
    // );
  }
}