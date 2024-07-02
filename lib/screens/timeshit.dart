import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;

class TimeShit extends StatefulWidget {
  const TimeShit({Key? key}) : super(key: key);

  @override
  _TimeShitState createState() => _TimeShitState();
}

class _TimeShitState extends State<TimeShit> {
  TextEditingController emailController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  List<DataPoint> dataPoints = []; // Store fetched data points

  @override
  void initState() {
    super.initState();
    // Initialize any state variables if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TimeShit Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: startDateController,
              decoration: InputDecoration(
                labelText: 'Start Date',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: endDateController,
              decoration: InputDecoration(
                labelText: 'End Date',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: timeshit,
              child: Text('Fetch Data'),
            ),
            SizedBox(height: 20),
            dataPoints.isEmpty
                ? Expanded(
              child: Center(
                child: Text('No data to display'),
              ),
            )
                : Expanded(
              child: _buildLineChart(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLineChart() {
    List<charts.Series<DataPoint, DateTime>> series = [
      charts.Series<DataPoint, DateTime>(
        id: 'Work Hours',
        domainFn: (DataPoint point, _) => point.date,
        measureFn: (DataPoint point, _) => point.value,
        data: dataPoints,
      ),
    ];

    return charts.TimeSeriesChart(
      series,
      animate: true,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }

  Future<void> timeshit() async {
    final requestData = {
      'email': emailController.text.trim(),
      'startDate': startDateController.text.trim(),
      'endDate': endDateController.text.trim(),
    };
    try {
      final response = await http.post(
        Uri.parse("http://localhost:5000/api/salary/fetch-work-hours"),
        body: jsonEncode(requestData),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List<DataPoint> parsedData = parseData(jsonData);

        setState(() {
          dataPoints = parsedData;
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception during fetch operation: $e');
    }
  }

  List<DataPoint> parseData(dynamic jsonData) {
    List<DataPoint> dataPoints = [];
    for (var item in jsonData) {
      dataPoints.add(DataPoint(
        DateTime.parse(item['date']),
        double.parse(item['value'].toString()),
      ));
    }
    return dataPoints;
  }
}

class DataPoint {
  final DateTime date;
  final double value;

  DataPoint(this.date, this.value);
}
