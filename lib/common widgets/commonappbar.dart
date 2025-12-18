import 'package:flutter/material.dart';
import 'package:amore_student_erp/common%20widgets/textwidget.dart';
import 'package:amore_student_erp/others/clors.dart';
import 'package:amore_student_erp/others/constants.dart';

AppBar commonappbar({required BuildContext context,  String? title}) {
  return AppBar(
    title: buildtext(
        text: title ?? '',
        fontsize: extralarge,
        fontcolor: Appcolor.white,
        fontweight: FontWeight.w700,),
    backgroundColor: Appcolor.darkblue,
    centerTitle: true,
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_circle_left_outlined,
        size: 35,
        color: Appcolor.white,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  );
}

// AppBar commonappbar1({required BuildContext context, required String title}) {
//   return AppBar(
//     flexibleSpace: const dashboardappbar(),
//     // actions: [
//     //   Padding(
//     //     padding: EdgeInsets.symmetric(horizontal: 15),
//     //     child: GestureDetector(
//     //       onTap: () {
//     //         Navigator.pushNamed(context, '/profilepage');
//     //       },
//     //       child: SizedBox(
//     //         height: 40,
//     //         width: 40,
//     //         child: Image.asset(menavathar),
//     //       ),
//     //     ),
//     //   )
//     // ],
//   );
// }
