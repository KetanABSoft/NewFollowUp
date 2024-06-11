import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreateTaskController extends GetxController
{
  final GlobalKey<FormState> create_task_key = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController reminderDateController = TextEditingController();
  TextEditingController reminderTimeController = TextEditingController();

}