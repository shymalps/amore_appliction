// ignore_for_file: camel_case_types

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:amore_student_erp/common%20widgets/textwidget.dart';
import 'package:amore_student_erp/common%20widgets/timestampconvert.dart';
import 'package:amore_student_erp/datalayer.dart/apicalls.dart';
import 'package:amore_student_erp/models/profileviewmodel/profileviewmodel.dart';
import 'package:amore_student_erp/others/clors.dart';
import 'package:amore_student_erp/others/constants.dart';
import 'package:amore_student_erp/screens/profiledit.dart';
import 'package:amore_student_erp/screens/settingspage.dart';

class profile_page extends StatefulWidget {
  const profile_page({super.key});

  @override
  State<profile_page> createState() => _profile_pageState();
}

class _profile_pageState extends State<profile_page> {
  Profileviewmodel? userdata;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    _getstudentdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.white,
      body: loading
          ? userdata == null
              ? const Center(
                  child: Text(
                      'We are habving a trouble to load user data. pleasse try later'),
                )
              : Padding(
                  padding: EdgeInsets.all(devicewidth! * 0.1),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildtext(
                                  text: 'Hello ${userdata!.data!.name!}',
                                  fontsize: largefontsize,
                                  fontweight: FontWeight.bold),
                              GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Profiledit())),
                                  child: buildTextIcon(
                                      icon: Icons.edit,
                                      text: 'Edit',
                                      iconSize: 20))
                            ]),
                        buildtext(
                          text: 'What do you want to learn today',
                          fontsize: smallfontsize,
                        ),
                        Container(
                          // color: Appcolor.selectionblue,
                          height: deviceheight! * .8,
                          child: Stack(children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                  height: deviceheight! * 0.6,
                                  width: devicewidth,
                                  decoration: BoxDecoration(
                                      color: Appcolor.blue,
                                      borderRadius:
                                          BorderRadius.circular(commonradius)),
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          width: devicewidth,
                                          // color: Appcolor.black,
                                          child: Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 30),
                                                child: buildtext(
                                                    text: userdata!.data!.name!,
                                                    fontsize: largefontsize,
                                                    fontweight:
                                                        FontWeight.bold)),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: Appcolor.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          commonradius)),
                                              width: devicewidth,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: SingleChildScrollView(
                                                  padding: EdgeInsets.only(
                                                      top:
                                                          deviceheight! * 0.05),
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        listitem_profile(
                                                            icon: Icons.phone,
                                                            data: userdata!
                                                                .data!.phone!),
                                                        listitem_profile(
                                                            icon: Icons.school,
                                                            data: userdata!
                                                                .data!
                                                                .className!),
                                                        listitem_profile(
                                                            icon: Icons
                                                                .calendar_month_sharp,
                                                            data: timeconvert(
                                                                userdata!.data!
                                                                    .birthday!)),
                                                        listitem_profile(
                                                            icon: Icons
                                                                .badge_outlined,
                                                            data: userdata!
                                                                .data!.roll!),
                                                        listitem_profile(
                                                            icon: Icons
                                                                .account_balance_rounded,
                                                            data: userdata!
                                                                .data!.school!),
                                                      ]),
                                                ),
                                              )),
                                        ),
                                      ),
                                      // Expanded(flex: 1, child: Container(),)
                                    ],
                                  )),
                            ),
                            Positioned(
                                top: deviceheight! * 0.1 - 10,
                                left: devicewidth! * 0.2,
                                child: SizedBox(
                                    height: deviceheight! * 0.2,
                                    width: deviceheight! * 0.2,
                                    child: profileimage(
                                      image: userdata!.data!.profileImg ?? '',
                                      // image: userdata!.data!.profileImg!,
                                      border: true,
                                      circle: true,
                                    )))
                          ]),
                        ),
                      ],
                    ),
                  ),
                )
          : const Center(
              child: SpinKitCircle(
                color: Appcolor.darkblue,
                size: 75.0,
                // lineWidth: 3.0,
              ),
            ),
    );
  }

  Padding listitem_profile({required IconData icon, required String data}) {
    return Padding(
      padding: EdgeInsets.only(left: 15),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Appcolor.blue),
              child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    icon,
                    color: Appcolor.white,
                  )),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: buildtext(text: data)),
          ],
        ),
        Divider(
          color: Appcolor.blue, // Set the color to white
          thickness: 1, // Set the thickness of the divider
          // height: 20,
        ) // Set the height spacing around the divider  )
      ]),
    );

    // Column(

    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     buildtext(text: label),
    //     Container(
    //         width: devicewidth,
    //         decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(8),
    //             border: Border.all(color: Appcolor.blue)),
    //         child: Padding(
    //           padding: EdgeInsets.all(5),
    //           child: buildtext(text: data),
    //         ))
    //   ],
    // );
  }

  Future<void> _getstudentdata() async {
    final logindata = await profileview();
    print("-----------------------------------------");
    // print(logindata!.data!.profileImg!);

    // if (logindata != null) {}
    setState(() {
      userdata = logindata;
      loading = true;
    });
  }
  // void _pickImageAndClose(BuildContext context, ImageSource source) {
  //   controller.pickImage(source);
  //   Navigator.of(context).pop();
  // }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:amore_student_erp/others/clors.dart';
// import 'package:amore_student_erp/others/constants.dart';

// class profile_page extends StatelessWidget {
//   const profile_page({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Appcolor.white,
//       body: SafeArea(
//           child: Padding(
//         padding: EdgeInsets.all(devicewidth! * 0.1),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Hello Peter',
//               style: TextStyle(
//                   fontSize: largefontsize, fontWeight: FontWeight.w800),
//             ),
//             Text(
//               'What do you want to learn today ',
//               style: TextStyle(
//                 fontSize: smallfontsize,
//               ),
//             ),
//             Center(
//                 child: Expanded(
//               child: Container(
//                 color: Appcolor.blue,
//                 height: deviceheight! * .8,
//                 child: Center(
//                     child: Container(
//                   height: deviceheight! * 0.7,
//                   decoration: BoxDecoration(color: Appcolor.white),
//                   child: Stack(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(color: Appcolor.darkblue),
//                       )
//                     ],
//                   ),
//                 )),
//               ),
//             ))
//           ],
//         ),
//       )),
//     );
//   }
// }

// // class ProfileCard extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       width: 300,
// //       padding: EdgeInsets.all(16.0),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(16.0),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.grey.withOpacity(0.5),
// //             spreadRadius: 5,
// //             blurRadius: 7,
// //             offset: Offset(0, 3), // changes position of shadow
// //           ),
// //         ],
// //       ),
// //       child: Column(
// //         children: [
// //           CircleAvatar(
// //             radius: 40,
// //             backgroundColor: Colors.blue,
// //             child: Icon(
// //               Icons.person,
// //               size: 50,
// //               color: Colors.white,
// //             ),
// //           ),
// //           SizedBox(height: 16),
// //           Text(
// //             'Peter John',
// //             style: TextStyle(
// //               fontSize: 24,
// //               fontWeight: FontWeight.bold,
// //             ),
// //           ),
// //           SizedBox(height: 16),
// //           InfoRow(label: 'Class', value: '9th'),
// //           InfoRow(label: 'Date of Birth', value: '12 October 2010'),
// //           InfoRow(label: 'Admission Number', value: 'DPS15624'),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class InfoRow extends StatelessWidget {
// //   final String label;
// //   final String value;

// //   InfoRow({required this.label, required this.value});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 4.0),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: [
// //           Text(
// //             label,
// //             style: TextStyle(
// //               fontSize: 16,
// //               fontWeight: FontWeight.w500,
// //             ),
// //           ),
// //           Text(
// //             value,
// //             style: TextStyle(
// //               fontSize: 16,
// //               fontWeight: FontWeight.w400,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
