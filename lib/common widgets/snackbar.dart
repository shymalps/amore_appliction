import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showSubscriptionActiveSnackBar(BuildContext context, String msg) {
  final snackBar = SnackBar(
    content: Text(msg),
    duration: Duration(seconds: 3), // Optional: Set the duration
    action: SnackBarAction(
      label: 'Close',
      onPressed: () {},
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
