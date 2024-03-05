import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';

class Utils {
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  // FLUSH BAR FOR ERROR MESSAGE STATUS
  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          forwardAnimationCurve: Curves.decelerate,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          padding: const EdgeInsets.all(15),
          message: message,
          duration: const Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
          borderRadius: BorderRadius.circular(16),
          backgroundColor: Colors.red,
          reverseAnimationCurve: Curves.easeInOut,
          positionOffset: 20,
          icon: const Icon(
            Icons.error,
            size: 25,
            color: Colors.white,
          ),
        )..show(context));
  }

  // FLUSH BAR FOR SUCCESS MESSAGE STATUS
  static void flushBarMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          forwardAnimationCurve: Curves.decelerate,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          padding: const EdgeInsets.all(15),
          message: message,
          duration: const Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
          backgroundColor: Colors.white24,
          borderRadius: BorderRadius.circular(16),
          reverseAnimationCurve: Curves.easeInOut,
          positionOffset: 20,
          icon: const Icon(
            Icons.error,
            size: 25,
            color: Colors.white,
          ),
        )..show(context));
  }
}
