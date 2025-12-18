import 'package:flutter/material.dart';
import 'package:amore_student_erp/common%20widgets/commonappbar.dart';
import 'package:amore_student_erp/common%20widgets/loader.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String imgurl = ModalRoute.of(context)!.settings.arguments as String;
    return imgurl == ''
        ? const Loader()
        : Scaffold(
            appBar: commonappbar(context: context, title: 'Image'),
            body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.network(imgurl),
            ));
  }
}
