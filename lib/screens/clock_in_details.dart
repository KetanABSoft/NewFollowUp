import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';
import '../controller/clockin_controller.dart';
import 'package:fl_chart/fl_chart.dart';

class ClockIn extends StatefulWidget {
  const ClockIn({Key? key}) : super(key: key);

  @override
  _ClockInState createState() => _ClockInState();
}

class _ClockInState extends State<ClockIn> {
  final ClockInController controller = Get.put(ClockInController());

  bool isClockedIn = false;
  DateTime? clockInTime;
  DateTime? clockOutTime;
  late String currentDate;
  late String userLocation = '';

  // State variables for start date and end date
  DateTime? startDate;
  DateTime? endDate;
  String email = '';

  @override
  void initState() {
    super.initState();
    setCurrentDate();
    requestLocationPermission();
    controller.timeshit();
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
        getUserLocation().then((value) {
          setState(() {
            userLocation = value;
            print('Clock Out Location: $userLocation');
          });
        }).catchError((error) {
          print('Error getting location: $error');
        });
      } else {
        clockInTime = DateTime.now();
        getUserLocation().then((value) {
          setState(() {
            userLocation = value;
            print('Clock In Location: $userLocation');
          });
        }).catchError((error) {
          print('Error getting location: $error');
        });
      }
      isClockedIn = !isClockedIn;
    });
  }

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
  //
  // var data;
  Map<String, double> workHoursByDate = {
    "2024-06-28": 0,
    "2024-06-29": 0.02645861111111111,
    // Add more dates as needed
  };

  // Future<void> fetchDataAndUpdateMap() async {
  //   try {
  //     // Call timeshit to fetch data
  //     String? result = await controller.timeshit();
  //
  //     if (result == 'success') {
  //       // Update workHoursByDate with fetched data
  //       // Assuming data is structured like {'date': hours}
  //       (controller.data as Map<String, dynamic>).forEach((date, hours) {
  //         workHoursByDate[date] = hours.toDouble();
  //       });
  //
  //       // Print updated map
  //       print('Updated workHoursByDate: $workHoursByDate');
  //
  //       // setState to update the UI if needed
  //       setState(() {});
  //     } else {
  //       print('Failed to fetch data: $result');
  //       // Handle error case if needed
  //     }
  //   } catch (e) {
  //     print('Exception during fetch operation: $e');
  //     // Handle exception case if needed
  //   }
  // }

  //
  //
  List<FlSpot> generateDataPoints() {
    List<FlSpot> dataPoints = [];

    // Iterate through workHoursByDate and convert each entry to FlSpot
    workHoursByDate.forEach((date, hours) {
      // Extract day from date for x-axis (assuming dates are in chronological order)
      int dayIndex = DateTime.parse(date).weekday - 1; // This gives day of the week (1 = Monday, ..., 7 = Sunday)

      // Create FlSpot using day index as x-axis and hours as y-axis
      dataPoints.add(FlSpot(dayIndex.toDouble(), hours));
    });

    return dataPoints;
  }

  //
  // List<FlSpot> generateDataPoints() {
  //   List<FlSpot> dataPoints = [];
  //
  //   // Iterate through workHoursByDate and convert each entry to FlSpot
  //   controller.workHoursByDate.forEach((date, hours) {
  //     // Extract day from date for x-axis (assuming dates are in chronological order)
  //     DateTime dateTime = DateTime.parse(date);
  //     int dayIndex = dateTime.weekday - 1; // This gives day of the week (1 = Monday, ..., 7 = Sunday)
  //
  //     // Create FlSpot using day index as x-axis and hours as y-axis
  //     dataPoints.add(FlSpot(dayIndex.toDouble(), hours));
  //   });
  //
  //   return dataPoints;
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff7c81dd),
        title: Center(
          child: Text(
            "Time Sheet",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Colors.white),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(height: 1.h),
                  // Email text field
               Form(child: Column(children: [
                 Padding(
                   padding: EdgeInsets.only(right: 1.sp),
                   child: Container(
                     height: 8.h,
                     width: 100.w,
                     child: TextField(
                       controller: controller.emailController,
                       decoration: InputDecoration(
                         labelText: 'Email',
                         hintText: 'Enter your email',
                         border: OutlineInputBorder(),
                       ),
                       // onChanged: (value) {
                       //   setState(() {
                       //     email = value;
                       //   });
                       // },
                     ),
                   ),
                 ),
                 SizedBox(height: 2.h),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     // Start Date text field
                     Expanded(
                       child: Container(
                         height: 8.h,
                         width: 30.w,
                         child: TextField(
                           controller: controller.startDateController,
                           decoration: InputDecoration(
                             labelText: 'Start Date',
                             hintText: 'Select Start Date',
                             border: OutlineInputBorder(),
                           ),
                           readOnly: true,
                           onTap: () async {
                             DateTime? pickedDate = await showDatePicker(
                               context: context,
                               initialDate: startDate ?? DateTime.now(),
                               firstDate: DateTime(2020),
                               lastDate: DateTime(2030),
                             );
                             if (pickedDate != null && pickedDate != startDate) {
                               setState(() {
                                 startDate = pickedDate;
                                 controller.startDateController.text = DateFormat('yyyy-MM-dd ').format(startDate!);
                                 //   startDate: DateFormat('yyyy-MM-dd').format(startDate!),

                               });
                             }
                           },
                         ),
                       ),
                     ),
                     SizedBox(width: 10.sp),
                     // End Date text field
                     Expanded(
                       child: Container(
                         height: 8.h,
                         width: 30.w,
                         child: TextField(
                           controller: controller.endDateController,
                           decoration: InputDecoration(
                             labelText: 'End Date',
                             hintText: 'Select End Date',
                             border: OutlineInputBorder(),
                           ),
                           readOnly: true,
                           onTap: () async {
                             DateTime? pickedDate = await showDatePicker(
                               context: context,
                               initialDate: endDate ?? DateTime.now(),
                               firstDate: DateTime(2020),
                               lastDate: DateTime(2030),
                             );
                             if (pickedDate != null && pickedDate != endDate) {
                               setState(() {
                                 endDate = pickedDate;
                                 controller.endDateController.text = DateFormat('y-MM-d').format(endDate!);
                               });
                             }
                           },
                         ),
                       ),
                     ),
                   ],
                 ),

                 SizedBox(height: 1.h),
                 ElevatedButton(
                   onPressed: () {
                     // Validate email format before proceeding
                     // if (isValidEmail(email) && startDate != null && endDate != null) {
                     //   // Post data to server
                     //   controller.timeshit();
                     // } else {
                     //   // Show error or prompt user to enter valid email
                     //   showDialog(
                     //     context: context,
                     //     builder: (context) => AlertDialog(
                     //       title: Text('Error'),
                     //       content: Text('Please enter a valid email address and select start/end dates.'),
                     //       actions: <Widget>[
                     //         TextButton(
                     //           onPressed: () => Navigator.pop(context),
                     //           child: Text('OK'),
                     //         ),
                     //       ],
                     //     ),
                     //   );
                     // }
                     if (controller.Key.currentState!.validate()) {
                       controller.timeshit();
                       // controller.postDataToServer(
                       //   email: controller.emailController.text,
                       //   startDate: DateFormat('yyyy-MM-dd').format(startDate!),
                       //   endDate: DateFormat('yyyy-MM-dd').format(endDate!),
                       //
                       // );
                     }
                     else{
                       showDialog(
                                context: context,
                               builder: (context) => AlertDialog(
                           title: Text('Error'),
                                 content: Text('Please enter a valid email address and select start/end dates.'),
                                 actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                     }
                   },
                   child: Text('Show Chart'),
                 ),
               ],))
                ],
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  height: 40.h,
                  width: 100.w,
                  child: buildLineChart(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLineChart() {
    return Container(
      height: 300,
      padding: EdgeInsets.all(16),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            drawHorizontalLine: true,
          ),
          titlesData: FlTitlesData(
              show: true,
              bottomTitles:AxisTitles(
                sideTitles:  SideTitles(
                  showTitles: true,
                  reservedSize: 22,
                  // getTextStyles: (value) => const TextStyle(color: Colors.black, fontSize: 10),
                  getTitlesWidget: (value ,meta) {
                    switch (value.toInt()) {
                      case 0:
                        return Text("Mon");
                      case 1:
                        return Text("Tue");
                      case 2:
                        return Text("Wed");
                      case 3:
                        return Text("Thu");
                      case 4:
                        return Text("Fri");
                      case 5:
                        return Text("Sat");
                      case 6:
                        return Text("Sun");
                      default:
                        return Text("");
                    }
                  },
                ),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              )
            // leftTitles:AxisTitles(
            //   sideTitles: SideTitles(
            //     showTitles: true,
            //     reservedSize: 28,
            //     // getTextStyles: (value) => const TextStyle(color: Colors.black, fontSize: 10),
            //     getTitlesWidget: (value ,meta) {
            //       // Example: Convert 3.0 to '3'
            //       return Text(' value.toInt().toString()');
            //     },
            //   ),
            // )

          ),
          borderData: FlBorderData(
              show: true,
              // border: Border.all(color: Colors.black, width: 1),
              border: Border(
                  left: BorderSide(
                      color: Colors.black,width: 1
                  ),
                  bottom: BorderSide(
                      color: Colors.black,
                      width: 1
                  )
              )
          ),
          lineBarsData: [
            LineChartBarData(
              spots: generateDataPoints(),
              isCurved: true,
              color: Colors.blue,
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: FlDotData(show: true),
              belowBarData: BarAreaData(show: false),
            ),
          ],
          // minY: 0,
          // maxX: 6,
          // lineTouchData: LineTouchData(
          //   enabled: true,
          //   touchTooltipData: LineTouchTooltipData(
          //     // tooltipBgColor: Colors.blue.withOpacity(0.8),
          //     getTooltipItems: (touchedSpots) {
          //       return touchedSpots.map((LineBarSpot touchedSpot) {
          //         final flSpot = touchedSpot;
          //         return LineTooltipItem(
          //           '${flSpot.x}, ${flSpot.y}',
          //           TextStyle(color: Colors.blue),
          //         );
          //       }).toList();
          minY: 0,
          maxX: 6,
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((LineBarSpot touchedSpot) {
                  final flSpot = touchedSpot;
                  // Get the date corresponding to the day index
                  DateTime date = DateTime.now().subtract(Duration(days: (6 - flSpot.x.toInt())));
                  String formattedDate = DateFormat('yyyy-MM-dd').format(date);
                  return LineTooltipItem(
                    '$formattedDate, ${flSpot.y}',
                    TextStyle(color: Colors.blue),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }
  // bool isValidEmail(String input) {
  //   final RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]$');
  //   return regex.hasMatch(input);
  // }
}
