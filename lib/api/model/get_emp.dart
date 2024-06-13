// To parse this JSON data, do
//
//     final getEmp = getEmpFromJson(jsonString);

import 'dart:convert';

List<GetEmp> getEmpFromJson(String str) => List<GetEmp>.from(json.decode(str).map((x) => GetEmp.fromJson(x)));

String getEmpToJson(List<GetEmp> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetEmp {
  String id;
  String name;
  String phoneNumber;
  String email;
  String password;
  String? adminUserId;
  String adminCompanyName;
  int v;

  GetEmp({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.password,
    this.adminUserId,
    required this.adminCompanyName,
    required this.v,
  });

  factory GetEmp.fromJson(Map<String, dynamic> json) => GetEmp(
    id: json["_id"],
    name: json["name"],
    phoneNumber: json["phoneNumber"],
    email: json["email"],
    password: json["password"],
    adminUserId: json["adminUserId"],
    adminCompanyName: json["adminCompanyName"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "phoneNumber": phoneNumber,
    "email": email,
    "password": password,
    "adminUserId": adminUserId,
    "adminCompanyName": adminCompanyName,
    "__v": v,
  };
}
