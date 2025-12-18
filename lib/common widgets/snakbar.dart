import 'package:flutter/material.dart';

void showCustomSnackbar({
  required BuildContext context,
  required String message,
  Color backgroundColor = Colors.blue,
  Duration duration = const Duration(seconds: 3),
  SnackBarAction? action,
}) {
  // Hide any previous snackbar
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  // Show the new snackbar
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: backgroundColor,
      duration: duration,
      action: action,
    ),
  );
}
