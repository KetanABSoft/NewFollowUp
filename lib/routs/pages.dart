import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:new_follow_up/binding/app_binding.dart';
import 'package:new_follow_up/routs/routs.dart';
import 'package:new_follow_up/screens/calculate_salary.dart';
import 'package:new_follow_up/screens/clock_in_details.dart';
import 'package:new_follow_up/screens/create_task_scareen.dart';
import 'package:new_follow_up/screens/dashboard_screen.dart';
import 'package:new_follow_up/screens/ip_address.dart';
import 'package:new_follow_up/screens/pending_task_screen.dart';

import '../screens/login_screen.dart';
class AppPages {
  static String INITIAL_ROUTE = Routs.LOGIN_ROUTE;

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
    GetPage(
        name: Routs.PENDING_TASK_ROUTE,
        page: () => PendingTaskScreen(),
        binding:PendingTaskBinding()
    ),
    GetPage(
        name: Routs.CLOCKIN_ROUTE,
        page:()=>ClockIn(),
        binding: ClockInBinding()
    ),
    GetPage(
        name: Routs.CALCULATE_SALARY_ROUTE,
        page: ()=>CalculateSalary(),
        binding: CalculateSalaryBinding()
    ),
    GetPage(
        name:Routs.LOGIN_ROUTE,
        page: ()=>LoginScreen(),
       binding: LoginBinding()
    ),
    GetPage(
        name:Routs.IP_ROUTE,
        page: ()=>IpAddressScreen(),
        binding: IPBinding()
    )
  ];
}