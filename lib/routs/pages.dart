import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:new_follow_up/binding/app_binding.dart';
import 'package:new_follow_up/routs/routs.dart';
import 'package:new_follow_up/screens/create_task_scareen.dart';
import 'package:new_follow_up/screens/dashboard_screen.dart';

import '../screens/login_screen.dart';
class AppPages {
  static String INITIAL_ROUTE = Routs.DASHBOARD_ROUTE;

  static final pages =
  [
    // GetPage(
    //     name: Routs.LOGIN_ROUTE,
    //     page: () => LoginScreen(),
    //     binding:LoginBinding()
    // ),
    GetPage(
        name: Routs.CREATE_TASK_ROUTE,
        page: () => CreateTaskScreen(),
        binding:CreateTaskBinding()
    ),
    GetPage(
        name: Routs.DASHBOARD_ROUTE,
        page: () => DashboardScreen(),
        binding:DashboardBinding()
    ),
  ];
}