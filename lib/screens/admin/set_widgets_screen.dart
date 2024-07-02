import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetWidgets extends StatefulWidget {
  const SetWidgets({super.key});

  @override
  State<SetWidgets> createState() => _SetWidgetsState();
}

class _SetWidgetsState extends State<SetWidgets> {
  TextEditingController salaryController = TextEditingController();
  TextEditingController totalDaysController = TextEditingController();
  TextEditingController dailyShiftController = TextEditingController();
  TextEditingController employeeEmailController = TextEditingController();
  var data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Add();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 250),
                child: Text(
                  "Total Salary",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Container(
                height: 48,
                child: TextFormField(
                  controller: salaryController,
                  decoration: InputDecoration(
                      labelText: "Total Salary",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:EdgeInsets.only(right: 250),
                child: Text(
                  "Total Days",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Container(
                height: 48,
                child: TextFormField(
                  controller: totalDaysController,
                  decoration: InputDecoration(
                      labelText: "Total Days",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(right: 250),
                child: Text(
                  "Daily Shift",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Container(
                height: 48,
                child: TextFormField(
                  controller: dailyShiftController,
                  decoration: InputDecoration(
                      labelText: "Daily Shift",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11))),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          print("Hiii");
                          Add();
                        },
                        child: Container(
                          height: 35,
                          width: 350,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(11)),
                          child: Center(
                              child: Text(
                            "Calculate",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w700),
                          )),
                        ),
                      ),
                      SizedBox(height: 10,),
                      if (data != null && data["hourlyRate"] != null)
                        Row(
                          children: [
                            Text("Total Hours Rate Is",style: TextStyle(color: Colors.black
                            ,fontSize: 18,fontWeight: FontWeight.w700),),
                            SizedBox(width: 10,),
                            Text(data["hourlyRate"].toString()),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Text("Set Rate Card",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 20),),
              SizedBox(height: 30,),
              Padding(
                padding: EdgeInsets.only(right: 200),
                child: Text(
                  "Employee Email Id",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Container(
                height: 48,
                child: TextFormField(
                  controller: employeeEmailController,
                  decoration: InputDecoration(
                      labelText: "Email ID",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11))),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.only(right: 250),
                child: Text(
                  "Hourly Rate",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Container(
                height: 48,
                child: TextFormField(
                  // controller:storedHourlyRate,
                  decoration: InputDecoration(
                      labelText: "Hourly Rate",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11))),
                ),
              ),
              SizedBox(height: 30,),
              GestureDetector(
                onTap: () {
                  print("Hiii");
                  AddSetCard();
                },
                child: Container(
                  height: 35,
                  width: 350,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(11)),
                  child: Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w700),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> Add() async {

    int totalSalary = int.tryParse(salaryController.text) ?? 0;
    int days = int.tryParse(totalDaysController.text) ?? 0;
    int dailyShift = int.tryParse(dailyShiftController.text) ?? 0;

    Map<String, dynamic> abc = {
      "totalSalary": totalSalary,
      "days": days,
      "dailyShift": dailyShift,
    };

    final Response response = await http.post(
      Uri.parse("http://localhost:5000/api/salary/calculate-hourly-wage"),
      body: jsonEncode(abc),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        data = jsonDecode(response.body.toString());
        print('Data Added: $data');
        storeHourlyRate(data["hourlyRate"]);
      });
    } else {
      print('Error: ${response.statusCode}');
    }
  }
  Future<void> storeHourlyRate(double hourlyRate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('hourlyRate', hourlyRate);
    print('Hourly Rate stored in SharedPreferences: $hourlyRate');
  }

  Future<void> AddSetCard() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    double storedHourlyRate = prefs.getDouble('hourlyRate') ?? 0.0;
    print('Stored Hourly Rate: $storedHourlyRate');

    Map<String, dynamic> abc = {
      "email": employeeEmailController.text.toString(),
      "hourlyRate": storedHourlyRate,
    };

    final Response response = await http.post(
      Uri.parse("http://192.168.1.19:5000/api/salary/set-rate"),
      body: jsonEncode(abc),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        data = jsonDecode(response.body.toString());
        print('Data Added: $data');
      });
    } else {
      print('Error: ${response.statusCode}');
    }
  }
}
