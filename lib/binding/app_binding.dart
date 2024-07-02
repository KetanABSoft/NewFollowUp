import 'package:get/get.dart';
import 'package:new_follow_up/controller/calculate_salary_controller.dart';
import 'package:new_follow_up/controller/clockin_controller.dart';
import 'package:new_follow_up/controller/ip_controller.dart';
import '../controller/create_controller.dart';
import '../controller/dashboard_controller.dart';
import '../controller/login_controller.dart';
import '../controller/pending_controller.dart';

class LoginBinding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}

class CreateTaskBinding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => CreateTaskController());
  }
}

class DashboardBinding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController());
  }
}

class PendingTaskBinding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => PendingTaskController());
  }
}

class ClockInBinding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => ClockInController());
  }

}

class CalculateSalaryBinding extends Bindings
{
  @override
  void dependencies() {
   Get.lazyPut(() => CalculateSalaryController());
  }

}

class IPBinding extends Bindings
{
  @override
  void dependencies() {
   Get.lazyPut(() => IPController());
  }

}