// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Container(
//           child: Column(
//             children: <Widget>[
//               Container(
//                 height: 45.h,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage("assets/images/background.png"),
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//                 child: Stack(
//                   children: <Widget>[
//                     Positioned(
//                       left: 22.sp,
//                       width: 22.w,
//                       height: 24.h,
//                       child: FadeInUp(
//                         duration: Duration(seconds: 1),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             image: DecorationImage(
//                               image: AssetImage('assets/images/light-1.png'),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       left: 118.sp,
//                       width: 20.w,
//                       height: 17.h,
//                       child: FadeInUp(
//                         duration: Duration(milliseconds: 1200),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             image: DecorationImage(
//                               image: AssetImage('assets/images/light-2.png'),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       right: 28.sp,
//                       top: 12.sp,
//                       width: 18.w,
//                       height: 17.h,
//                       child: FadeInUp(
//                         duration: Duration(milliseconds: 1300),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             image: DecorationImage(
//                               image: AssetImage('assets/images/clock.png'),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       child: FadeInUp(
//                         duration: Duration(milliseconds: 1600),
//                         child: Container(
//                           margin: EdgeInsets.only(top: 45.sp),
//                           child: Center(
//                             child: Text(
//                               "Login",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 33.sp,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 10.sp,top: 25.sp,right: 10.sp),
//                 child: Column(
//                   children: <Widget>[
//                     FadeInUp(
//                       duration: Duration(milliseconds: 1800),
//
//                       child: Padding(
//                         padding: EdgeInsets.only(left: 15.sp,right: 15.sp),
//                         child: Container(
//                             height: 6.h,
//                             width: 90.w,
//                             child: TextFormField(
//                               controller: username,
//                               decoration: InputDecoration(
//                                 labelText: "Enter Your Email Or Username",
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(11.sp),
//                                 ),
//                                 enabledBorder:  OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(11.sp),
//                                 ),
//                                 focusedBorder:  OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(11.sp),
//                                 ),
//                               ),
//                             )
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 4.h,),
//                     FadeInUp(
//                       duration: Duration(milliseconds: 1800),
//                       // child: Container(
//                       //   padding: EdgeInsets.all(5),
//                       //   decoration: BoxDecoration(
//                       //     color: Colors.white,
//                       //     borderRadius: BorderRadius.circular(10),
//                       //     border: Border.all(
//                       //       color: Color.fromRGBO(143, 148, 251, 1),
//                       //     ),
//                       //     boxShadow: [
//                       //       BoxShadow(
//                       //         color: Color.fromRGBO(143, 148, 251, .2),
//                       //         blurRadius: 20.0,
//                       //         offset: Offset(0, 10),
//                       //       ),
//                       //     ],
//                       //   ),
//                       //   child: Column(
//                       //     children: <Widget>[
//                       //       Container(
//                       //         padding: EdgeInsets.all(8.0),
//                       //         decoration: BoxDecoration(
//                       //           border: Border(
//                       //             bottom: BorderSide(
//                       //               color: Color.fromRGBO(143, 148, 251, 1),
//                       //             ),
//                       //           ),
//                       //         ),
//                       //         child: TextField(
//                       //           decoration: InputDecoration(
//                       //             border: InputBorder.none,
//                       //             hintText: "Email or Phone number",
//                       //             hintStyle: TextStyle(color: Colors.grey[700]),
//                       //           ),
//                       //         ),
//                       //       ),
//                       //       SizedBox(height: 5.h,),
//                       //       Container(
//                       //         padding: EdgeInsets.all(8.0),
//                       //         child: TextField(
//                       //           obscureText: true,
//                       //           decoration: InputDecoration(
//                       //             border: InputBorder.none,
//                       //             hintText: "Password",
//                       //             hintStyle: TextStyle(color: Colors.grey[700]),
//                       //           ),
//                       //         ),
//                       //       ),
//                       //     ],
//                       //   ),
//                       // ),
//                       child: Padding(
//                         padding: EdgeInsets.only(left: 15.sp,right: 15.sp),
//                         child: Container(
//                             height: 6.h,
//                             width: 90.w,
//                             child: TextFormField(
//                               controller: password,
//                               decoration: InputDecoration(
//                                 labelText: "Enter Your Password",
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(11.sp),
//                                 ),
//                                 enabledBorder:  OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(11.sp),
//                                 ),
//                                 focusedBorder:  OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(11.sp),
//                                 ),
//                               ),
//                             )
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 3.h),
//                     Padding(
//                       padding: EdgeInsets.only(left: 10.sp,top: 15.sp,right: 10.sp),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: FadeInUp(
//                               duration: Duration(milliseconds: 1900),
//                               child: GestureDetector(
//                                 onTap: () async {
//                                   final SharedPreferences sharedPreferences =
//                                   await SharedPreferences.getInstance();
//                                   sharedPreferences.setString(
//                                       'username', username.text);
//                                   login(username.text, password.text);
//                                   username.clear();
//                                   password.clear();
//                                   Navigator.of(context).push(MaterialPageRoute(
//                                       builder: (context) => LoginScreen()));
//                                 },
//                                 child: Container(
//                                   height: 5.7.h,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10.sp),
//                                     gradient: LinearGradient(
//                                       colors: [
//                                         Color.fromRGBO(143, 148, 251, 1),
//                                         Color.fromRGBO(143, 148, 251, .6),
//                                       ],
//                                     ),
//                                   ),
//                                   child: Center(
//                                     child: Text(
//                                       " Admin Login",
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 5.w,),
//                           Expanded(
//                             child: FadeInUp(
//                               duration: Duration(milliseconds: 1900),
//                               child: GestureDetector(
//                                 onTap: () async {
//                                   final SharedPreferences sharedPreferences =
//                                   await SharedPreferences.getInstance();
//                                   sharedPreferences.setString(
//                                       'username', username.text);
//                                   emplogin(username.text, password.text);
//                                   username.clear();
//                                   password.clear();
//                                   Navigator.of(context).push(MaterialPageRoute(
//                                       builder: (context) => LoginScreen()));
//                                 },
//                                 child: Container(
//                                   height: 5.7.h,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10.sp),
//                                     gradient: LinearGradient(
//                                       colors: [
//                                         Color.fromRGBO(143, 148, 251, 1),
//                                         Color.fromRGBO(143, 148, 251, .6),
//                                       ],
//                                     ),
//                                   ),
//                                   child: Center(
//                                     child: Text(
//                                       "Employee Login",
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 3.h),
//                     FadeInUp(
//                       duration: Duration(milliseconds: 2000),
//                       child: Container(
//                         height: 15.h,
//                         child: Image.asset("assets/images/updated logo.png"),
//                         // child: Text(
//                         //   "Forgot Password?",
//                         //   style: TextStyle(
//                         //     color: Color.fromRGBO(143, 148, 251, 1),
//                         //   ),
//                         // ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
