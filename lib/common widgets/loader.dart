import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:amore_student_erp/others/clors.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Appcolor.white,
      body: Center(
        child: SpinKitCircle(
          color: Appcolor.darkblue,
          size: 75.0,
          // lineWidth: 3.0,
        ),
      ),
    );
  }
}
