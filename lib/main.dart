import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:new_follow_up/routs/pages.dart';
import 'package:new_follow_up/screens/admin/set_widget.dart';
import 'package:new_follow_up/screens/pending_task_screen.dart';
import 'package:new_follow_up/screens/timeshit.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: ( BuildContext buildContext , Orientation orientation , DeviceType deviceType) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            // getPages: AppPages.pages,
            // initialRoute: AppPages.INITIAL_ROUTE,
             home: PendingTaskScreen(),
            // home: SetWidgets(),
          );
        }
    );
  }
}