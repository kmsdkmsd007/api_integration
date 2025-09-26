import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

class FlushBarHelper {
  static void flushBarErrorMessage(BuildContext context, String message) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          forwardAnimationCurve: Curves.decelerate,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(16),
          message: message,
          backgroundColor: Colors.red,
          borderRadius: BorderRadius.circular(15),
          duration: const Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
        )..show(context));
  }

  static void flushBarSuccessMessage(BuildContext context, String message) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          forwardAnimationCurve: Curves.decelerate,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(16),
          backgroundColor: Colors.green,
          message: message,
          borderRadius: BorderRadius.circular(15),
          duration: const Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
        )..show(context));
  }

  static void flushBarLoadingMessage(BuildContext context, String message) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          forwardAnimationCurve: Curves.decelerate,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(16),
          message: message,
          borderRadius: BorderRadius.circular(15),
          duration: const Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
        )..show(context));
  }
}
