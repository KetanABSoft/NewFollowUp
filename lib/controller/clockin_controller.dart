import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ClockInController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  final GlobalKey<FormState> Key = GlobalKey<FormState>();


  RxString jwtToken = ''.obs;
  RxString deviceId = ''.obs; // RxString to hold device ID
  RxString publicIp = ''.obs;
  RxString Email = ''.obs; // RxString to hold user's email
  RxString Role = ''.obs;
  // var workHoursByDate = {}.obs;// RxString to hold user's role

  void setToken(String newToken) {
    jwtToken.value = newToken;
    decodeToken();
  }

  void decodeToken() {
    try {
      String? tokenValue = jwtToken.value; // Get the token value
      if (tokenValue == null || tokenValue.isEmpty) {
        throw Exception('Token is null or empty');
      }
      // Split the token into its parts: header, payload, and signature
      List<String> parts = tokenValue.split('.');

      // Ensure that the token has the expected number of parts (header, payload, signature)
      if (parts.length != 3) {
        throw Exception('Invalid token format');
      }

      // Decode the payload from base64Url encoding
      String payload = parts[1];
      String decodedPayload = utf8.decode(base64Url.decode(base64Url.normalize(payload)));

      // Parse the JSON data in the payload
      Map<String, dynamic> payloadData = jsonDecode(decodedPayload);

      // Example of accessing data from the payload
      String userId = payloadData['sub'] ?? ''; // User ID
      String email = payloadData['email'] ?? '';
      String role = payloadData['role'] ?? '';
      String fullName = payloadData['name'] ?? '';
      String username = payloadData['username'] ?? '';
      int issuedAt = payloadData['iat'] ?? 0; // Issued at (timestamp)

      // Print or use the decoded data
      print('User ID: $userId');
      print('Email: $email');
      print('Role: $role');
      print('Full Name: $fullName');
      print('Username: $username');
      print('Issued At: $issuedAt');

      // Update RxString values
      Email.value = email;
      Role.value = role;

      // Optionally, store the decoded data in variables or use them further in your application
    } catch (e) {
      print('Error decoding token: $e');
      // Optionally handle errors or re-throw as needed
    }
  }

  void getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId.value = androidInfo.id; // Update RxString with device ID
        print('Device ID: ${deviceId.value}');
      } else if (Platform.isIOS) {
        // Handle iOS device info retrieval
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceId.value = iosInfo.identifierForVendor ?? '';
        print('Device ID: ${deviceId.value}');
      }
    } catch (e) {
      print('Error retrieving device info: $e');
    }
  }

  Future<void> postData(double latitude, double longitude) async {
    try {
      // Example of using Email or Role values in the POST data
      Map<String, dynamic> data = {
        'email': Email.value,
        'role': Role.value,
        'latitude': 37.4219983,
        'longitude': -122.084,
        'ip_addresses': ['103.17.159.50', '103.17.159.51'], // List of IP addresses
      };

      final response = await http.post(
        Uri.parse("http://103.159.85.246:4000/api/salary/clock-ins"),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print('Data Added: $responseData');
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending data: $e');
    }
  }

  Future<String> postClockIn() async {
    Map<String, dynamic> data = {
      'email': 'tanaya@gmail.com',
      'role': 'sub-employee',
      'ip': '103.17.159.50',
      'lat': '37.4219983',
      'long': '-122.084',
    };

    try {
      final response = await http.post(
        Uri.parse("http://103.159.85.246:4000/api/salary/clock-ins"),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print('Clock In Response: $responseData');
        return 'Clock in successful'; // Return success message
      } else {
        print('Clock In Error: ${response.statusCode}');
        return 'Failed to clock in'; // Return specific error message for failed response
      }
    } catch (e) {
      print('Exception during clock in: $e');
      return 'Failed to clock in'; // Return specific error message for exception
    }
  }



  Future<String> postClockOut() async {
    Map<String, dynamic> data = {
      'email': 'tanaya@gmail.com',
      'role': 'sub-employee',
      'ip': '103.17.159.50',
      'lat': '37.4219983',
      'long': '-122.084',
    };

    try {
      final response = await http.post(
        Uri.parse("http://103.159.85.246:4000/api/salary/clock-outs"),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print('Clock Out Response: $responseData');
        return 'Clock out successful'; // Return success message
      } else {
        print('Clock Out Error: ${response.statusCode}');
        return 'Failed to clock out'; // Return specific error message for failed response
      }
    } catch (e) {
      print('Exception during clock out: $e');
      return 'Failed to clock out'; // Return specific error message for exception
    }
  }

  late String email;
  DateTime? startDate;
  DateTime? endDate;

  // Initialize workHoursByDate with an empty map
  Map<String, double> workHoursByDate = {};
  Future<void> timeshit() async {
    final requestData = {
      'email': emailController.text.trim(),
      'startDate': startDate != null ? startDate!.toIso8601String() : null,
      'endDate': endDate != null ? endDate!.toIso8601String() : null,
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
        final responseData = jsonDecode(response.body) as Map<String, dynamic>;
        workHoursByDate.clear(); // Clear existing data before updating
        responseData.forEach((date, hours) {
          workHoursByDate[date] = hours.toDouble();
        });
        print('Work Hours by Date: $workHoursByDate');
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception during fetch operation: $e');
    }
  }

  // Map<String, double> workHoursByDate = {}; // Define workHoursByDate as a member variable

//   Future<void> timeshit() async {
//     final requestData = {
//       'email': "tanaya@gmail.com",
//       'startDate': "2024-06-24",
//       'endDate': "2024-06-26",
//     };
// print("@@@@@@@#########$requestData");
//     try {
//       final response = await http.post(
//         Uri.parse("http://localhost:5000/api/salary/fetch-work-hours"),
//         body: jsonEncode(requestData),
//         headers: {
//           'Content-Type': 'application/json; charset=utf-8',
//         },
//       );
// print('Ketan');
//
//       if (response.statusCode == 200) {
//         var responseData = jsonDecode(response.body.toString());
//         print("####@@@@$responseData");
//         // Assuming responseData is structured like {'date': hours}
//         // responseData.forEach((date, hours) {
//         //   workHoursByDate[date] = hours.toDouble();
//         // });
//
//         // Now workHoursByDate is populated with fetched data
//         // print('Data: $workHoursByDate');
//       } else {
//         print('######Error: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Exception during fetch operation: $e');
//     }
//   }

  // RxMap<String, dynamic> workHoursByDate = {}.obs; // RxMap with <String, dynamic>
  //
  // var data; // Property to store fetched data
  //
  // Future<String?> timeshit() async {
  //   Map<String, dynamic> requestData = {
  //     'email': "tanaya@gmail.com",
  //     'startDate': "2024-06-24",
  //     'endDate': "2024-06-26",
  //   };
  //
  //   try {
  //     final response = await http.post(
  //       Uri.parse("http://localhost:5000/api/salary/fetch-work-hours"),
  //       body: jsonEncode(requestData),
  //       headers: {
  //         'Content-Type': 'application/json; charset=utf-8',
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       var fetchedData = jsonDecode(response.body);
  //       data = fetchedData; // Store fetched data in 'data' property
  //       workHoursByDate.assign(Map<String, dynamic>.from(fetchedData)); // Update RxMap with fetched data
  //       print('Data Added: $data');
  //       return 'success';
  //     } else {
  //       print('Error: ${response.statusCode}');
  //       return 'Error: ${response.statusCode}';
  //     }
  //   } catch (e) {
  //     print('Exception during add operation: $e');
  //     return 'Exception during fetch operation: $e';
  //   }
  // }
}
