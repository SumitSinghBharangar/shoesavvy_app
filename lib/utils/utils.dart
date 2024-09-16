import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'styles/appcolor.dart';

class Utils {
  static void fieldfocuschange(
      BuildContext context, FocusNode current, FocusNode nextfocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextfocus);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(msg: message);
  }

  static void flushbarerrormessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        message: message,
        borderRadius: BorderRadius.circular(11),
        duration: const Duration(milliseconds: 4000),
        forwardAnimationCurve: Curves.fastEaseInToSlowEaseOut,
        reverseAnimationCurve: Curves.fastEaseInToSlowEaseOut,
        margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        animationDuration: const Duration(milliseconds: 3000),
        positionOffset: 20,
        messageColor: Colors.white,
        icon: const Icon(
          Icons.error,
          size: 28,
          color: Colors.white,
        ),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: AppColors.primaryColor,
      )..show(context),
    );
  }

  static snakbar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
      ),
      backgroundColor: Colors.black,
    ));
  }
}
