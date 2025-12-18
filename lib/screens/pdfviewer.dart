// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:amore_student_erp/common widgets/commonappbar.dart';
import 'package:amore_student_erp/others/clors.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class pdfpage extends StatefulWidget {
  const pdfpage({super.key});

// NO UI widget

  @override
  State<pdfpage> createState() => _pdfpageState();
}

class _pdfpageState extends State<pdfpage> {
  late String pdfurl;
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    pdfurl = ModalRoute.of(context)!.settings.arguments as String;

    // Simulate loading delay if needed
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonappbar(
        context: context,
        title: 'PDF',
      ),
      body: isLoading
          ? const Center(
              child: SpinKitCircle(
                color: Appcolor.darkblue,
                size: 75.0,
              ),
            )
          : SfPdfViewer.network(
              pdfurl,
              canShowScrollHead: true,
              canShowScrollStatus: true,
            ),
    );
  }
}
