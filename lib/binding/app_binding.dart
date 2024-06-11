import 'package:get/get.dart';
import '../controller/create_task_controller.dart';
import '../controller/dashboard_controller.dart';
import '../controller/login_controller.dart';

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