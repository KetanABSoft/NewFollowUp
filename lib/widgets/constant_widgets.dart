// Snack bar for showing error message
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../utils/app_color.dart';
import '../utils/text_style.dart';

errorSnackBar({String title = 'Failure', String? message}) {
  return Get.showSnackbar(
    GetSnackBar(
      titleText: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          height: 1.0,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.left,
      ),
      messageText: Text(
        message!,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          height: 1.0,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.left,
      ),
      snackPosition: SnackPosition.TOP,
      shouldIconPulse: true,
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.red.withOpacity(0.80),
      icon: const Icon(Icons.gpp_bad_outlined, size: 30.0, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 2),
      animationDuration: const Duration(milliseconds: 700),
    ),
  );
}

// Custom dialog
Future<dynamic> customSimpleDialog({
  required BuildContext context,
  Widget? title,
  Widget? description,
  String? noText,
  Function()? onNo,
  String? yesText,
  Function()? onYes,
  bool? preventToClose,
  bool? isButtonVisible = true,
  bool? barrierDismissible = false,
}) {
  return showDialog(
    barrierDismissible: barrierDismissible!,
    context: context,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async {
          return preventToClose ?? true;
        },
        child: SimpleDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
          contentPadding: const EdgeInsets.only(top: 5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: title!,
          children: [
            SizedBox(
              width: 100.w,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: description!,
                    ),
                    const SizedBox(height: 20),
                    Visibility(
                      visible: isButtonVisible == true ? true : false,
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: onNo ??
                                      () {
                                    Get.back();
                                  },
                              child: Container(
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: ColorsForApp.greyColor,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  noText ?? 'No',
                                  style: TextHelper.size15.copyWith(
                                    color: ColorsForApp.blackColor,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.7,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: onYes,
                              child: Container(
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: ColorsForApp.primaryColor,
                                  borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(15),
                                  ),
                                ),
                                child: Text(
                                  yesText ?? 'Yes',
                                  style: TextHelper.size15.copyWith(
                                    color: ColorsForApp.whiteColor,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.7,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}