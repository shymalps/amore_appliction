import 'package:flutter/material.dart';
import 'package:amore_student_erp/others/constants.dart';

class Notificationpage extends StatelessWidget {
  const Notificationpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(devicewidth! * 0.1),
          child: Container(
            child: Center(
              child: Image(image: AssetImage(nottificationanimation)),
            ),
          )),
    );
  }
}
