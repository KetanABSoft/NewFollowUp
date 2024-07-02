import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../calculate_salary.dart';

class SetWidgets extends StatefulWidget {
  const SetWidgets({Key? key}) : super(key: key);

  @override
  State<SetWidgets> createState() => _SetWidgetsState();
}

class _SetWidgetsState extends State<SetWidgets> {
  TextEditingController salaryController = TextEditingController();
  TextEditingController totalDaysController = TextEditingController();
  TextEditingController dailyShiftController = TextEditingController();
  TextEditingController employeeEmailController = TextEditingController();
  var data;
  var datas;

  @override
  void initState() {
    super.initState();
    // Uncomment the following line if you want to automatically calculate on init
    // Add();

    // Attach listeners to text controllers
    salaryController.addListener(() => Add());
    totalDaysController.addListener(() => Add());
    dailyShiftController.addListener(() => Add());
  }

  @override
  void dispose() {
    // Clean up controllers when the widget is disposed
    salaryController.dispose();
    totalDaysController.dispose();
    dailyShiftController.dispose();
    employeeEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff7c81dd),
        title: Center(
          child: Text(
            "SetWages",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Salary",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 6),
                TextFormField(
                  controller: salaryController,
                  decoration: InputDecoration(
                    labelText: "Total Salary",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Total Days",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 6),
                TextFormField(
                  controller: totalDaysController,
                  decoration: InputDecoration(
                    labelText: "Total Days",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Daily Shift",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 6),
                TextFormField(
                  controller: dailyShiftController,
                  decoration: InputDecoration(
                    labelText: "Daily Shift",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        print("Calculate button tapped");
                        Add();
                        _showDataDialog(data);
                      },
                      child: Text(
                        "Calculate",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    // if (data != null && data["hourlyRate"] != null)
                    //   Text(
                    //     "Hourly Rate: ${data["hourlyRate"]}",
                    //     style: TextStyle(
                    //       color: Colors.black,
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.w700,
                    //     ),
                    //   ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  "Set Rate Card",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  "Employee Email Id",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 6),
                TextFormField(
                  controller: employeeEmailController,
                  decoration: InputDecoration(
                    labelText: "Email ID",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Hourly Rate",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 6),
                TextFormField(
                  // controller:storedHourlyRate,
                  decoration: InputDecoration(
                    labelText: "Hourly Rate",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        print("Submit button tapped");
                        AddSetCard();
                        _showDataDialog1(data);
                      //   Navigator.push(context,MaterialPageRoute(builder: (context)=>CalculateSalary()));
                       },
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(width: 30.w,),
                    ElevatedButton(
                       onPressed: () {
                      //   print("Submit button tapped");
                      //   AddSetCard();
                      //   _showDataDialog1(data);
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>CalculateSalary()));
                      },
                      child: Text(
                        "Next",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDataDialog(Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hourly Rate'),
          content: Text('Hourly Rate: ${data["hourlyRate"]}'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
  void _showDataDialog1(Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text(' ${datas["message"]}'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  // Future<void> Add() async {
  //   double totalSalary = double.tryParse(salaryController.text) ?? 0.0;
  //   double days = double.tryParse(totalDaysController.text) ?? 0.0;
  //   double dailyShift = double.tryParse(dailyShiftController.text) ?? 0.0;
  //
  //   // Ensure all numeric values are doubles if needed
  //   Map<String, dynamic> abc = {
  //     "totalSalary": totalSalary,
  //     "days": days,
  //     "dailyShift": dailyShift,
  //   };
  //
  //   final Response response = await http.post(
  //     Uri.parse("http://103.159.85.246:4000/api/salary/calculate-hourly-wage"),
  //     body: jsonEncode(abc),
  //     headers: {
  //       'Content-Type': 'application/json; charset=utf-8',
  //     },
  //   );
  //
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       data = jsonDecode(response.body);
  //       if (data != null && data["hourlyRate"] != null) {
  //         double hourlyRate = data["hourlyRate"].toDouble(); // Ensure hourlyRate is double
  //         storeHourlyRate(hourlyRate);
  //         // Show dialog with retrieved data
  //       }
  //     });
  //   } else {
  //     print('Error: ${response.statusCode}');
  //   }
  // }
  Future<void> Add() async {
    double totalSalary = double.tryParse(salaryController.text) ?? 0.0;
    double days = double.tryParse(totalDaysController.text) ?? 0.0;
    double dailyShift = double.tryParse(dailyShiftController.text) ?? 0.0;

    // Ensure all numeric values are doubles if needed
    Map<String, dynamic> abc = {
      "totalSalary": totalSalary,
      "days": days,
      "dailyShift": dailyShift,
    };

    final Response response = await http.post(
      Uri.parse("http://103.159.85.246:4000/api/salary/calculate-hourly-wage"),
      body: jsonEncode(abc),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        data = jsonDecode(response.body);
        if (data != null && data["hourlyRate"] != null) {
          double hourlyRate = data["hourlyRate"].toDouble(); // Ensure hourlyRate is double
          storeHourlyRate(hourlyRate); // Store the hourly rate in shared preferences
          // Show dialog with retrieved data
        }
      });
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  Future<void> storeHourlyRate(double hourlyRate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('hourlyRate', hourlyRate);
  }

  Future<double> getStoredHourlyRate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('hourlyRate') ?? 0.0; // Return 0.0 if 'hourlyRate' is not found
  }

  // Future<void> storeHourlyRate(double hourlyRate) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setDouble('hourlyRate', hourlyRate);
  //   print('Hourly Rate stored in SharedPreferences: $hourlyRate');
  // }

  // Future<void> AddSetCard() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   double storedHourlyRate = prefs.getDouble('hourlyRate') ?? 0.0;
  //
  //   Map<String, dynamic> abc = {
  //     "email": employeeEmailController.text.toString(),
  //     "hourlyRate": storedHourlyRate,
  //   };
  //
  //   final Response response = await http.post(
  //     Uri.parse("http://103.159.85.246:4000/api/salary/set-rate"),
  //     body: jsonEncode(abc),
  //     headers: {
  //       'Content-Type': 'application/json; charset=utf-8',
  //     },
  //   );
  //
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       datas = jsonDecode(response.body);
  //     });
  //   } else {
  //     print('Error: ${response.statusCode}');
  //   }
  // }
  Future<void> AddSetCard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double storedHourlyRate = prefs.getDouble('hourlyRate') ?? 0.0;

    Map<String, dynamic> abc = {
      "email": employeeEmailController.text.toString(),
      "hourlyRate": storedHourlyRate,
    };

    final Response response = await http.post(
      Uri.parse("http://103.159.85.246:4000/api/salary/set-rate"),
      body: jsonEncode(abc),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        datas = jsonDecode(response.body);

        // Check if hourlyRate in response matches storedHourlyRate
        double hourlyRate = datas['hourlyRate'].toDouble();
        if (hourlyRate == storedHourlyRate) {
          // Show success dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Success"),
                content: Text("Hourly rate set successfully."),
                actions: <Widget>[
                  TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog
                    },
                  ),
                ],
              );
            },
          );
        } else {
          // Show error dialog if hourly rates don't match
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text("Hourly rate mismatch."),
                actions: <Widget>[
                  TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog
                    },
                  ),
                ],
              );
            },
          );
        }
      });
    } else {
      print('Error: ${response.statusCode}');
      // Show error message dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Failed to set hourly rate. Please try again later."),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                },
              ),
            ],
          );
        },
      );
    }
  }

}
