// import 'package:flutter/cupertino.dart';
import 'dart:ui';

import 'package:amore_student_erp/models/profileviewmodel/profileviewmodel.dart';
import 'package:amore_student_erp/screens/invoicepage.dart';
import 'package:flutter/material.dart';
import 'package:amore_student_erp/common%20widgets/commonappbar.dart';
import 'package:amore_student_erp/common%20widgets/textwidget.dart';
// import 'package:amore_student_erp/common%20widgets/customtile.dart';
import 'package:amore_student_erp/others/clors.dart';
import 'package:amore_student_erp/others/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class app_drawer extends StatelessWidget {
  // app_drawer({super.key, required this.userdata});
  // Profileviewmodel? userdata;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: devicewidth,
      backgroundColor: Appcolor.white,
      child: Scaffold(
        // appBar: commonappbar(context: context),
        body: Container(
          decoration: BoxDecoration(
            color: Appcolor.blue,
            borderRadius: BorderRadius.circular(commonradius),
          ),
          // height: deviceheight! * .8,
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: deviceheight! * .9,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(top: devicewidth! * 0.2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       flex: 1,
                        //       child: SizedBox(
                        //         height: 40,
                        //         width: 40,
                        //         child: Image.asset(menavathar),
                        //       ),
                        //     ),
                        //     Expanded(
                        //       flex: 3,
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           buildtext(text: 'Hello'),
                        //           buildtext(
                        //             text:userdata!.data!.name! ,
                        //             fontsize: extralarge,
                        //             fontweight: FontWeight.w800,
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Divider(
                            color: Colors.white, // Set the color to white
                            thickness: 2, // Set the thickness of the divider
                            height:
                                20, // Set the height spacing around the divider
                          ),
                        ),
                        const SizedBox(height: 50),
                        CustomTile(
                          icon: Image.asset(
                            classroom,
                            width: 25,
                            height: 25,
                            color: Appcolor.black,
                          ),
                          title: 'Classroom',
                          routename: '/classroom',
                          argument: 'gototopic',
                        ),
                        CustomTile(
                          icon: Image.asset(
                            liveclass,
                            width: 25,
                            height: 25,
                            color: Appcolor.black,
                          ),
                          title: 'Live Classroom',
                          routename: '/liveclassroom',
                        ),
                        CustomTile(
                          icon: Image.asset(
                            assingnment,
                            width: 25,
                            height: 25,
                            color: Appcolor.black,
                          ),
                          title: 'Assignment',
                          routename: '/classroom',
                          argument: 'gotoassignment',
                        ),
                        CustomTile(
                          icon: Image.asset(
                            assesment,
                            width: 25,
                            height: 25,
                            color: Appcolor.black,
                          ),
                          title: 'Assessment',
                          routename: '/classroom',
                          argument: 'gotoassessment',
                        ),
                        CustomTile(
                          icon: Image.asset(
                            timetable,
                            width: 25,
                            height: 25,
                            color: Appcolor.black,
                          ),
                          title: 'Time Table',
                          routename: '/timetable',
                        ),
                        CustomTile(
                          icon: Image.asset(
                            attendanceicon,
                            width: 25,
                            height: 25,
                            color: Appcolor.black,
                          ),
                          title: 'Attendance',
                          routename: '/AttendanceScreen',
                        ),

                        CustomTile(
                          icon: Image.asset(
                            invoice,
                            width: 25,
                            height: 25,
                            color: Appcolor.black,
                          ),
                          title: 'Invoice',
                          routename: '/invoicepage',
                        ),
                        CustomTile(
                          icon: Image.asset(
                            settings,
                            width: 25,
                            height: 25,
                            color: Appcolor.black,
                          ),
                          title: 'Settings',
                          routename: '/settings',
                        ),
                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     CustomTile(
                        //       icon: Image.asset(
                        //         settings,
                        //         width: 25,
                        //         height: 25,
                        //         color: Appcolor.black,
                        //       ),
                        //       title: 'Settings',
                        //       routename: '/welcoepage',
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: deviceheight! * 0.1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomTilelogout(
                      icon: Image.asset(
                        settings,
                        width: 25,
                        height: 25,
                        color: Appcolor.black,
                      ),
                      title: 'Logout',
                      routename: '/loginpage',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:amore_student_erp/others/clors.dart';

class CustomTile extends StatefulWidget {
  final Widget? icon;
  final String title;
  final String routename;
  final String? argument;
  const CustomTile({
    Key? key,
    this.icon,
    required this.title,
    required this.routename,
    this.argument,
  }) : super(key: key);

  @override
  State<CustomTile> createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile> {
  bool selection = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selection = true;
        });

        // print(rememberUser);
        Navigator.pop(context);
        Navigator.pushNamed(
          context,
          widget.routename,
          arguments: widget.argument ?? '',
        );
      },
      child: Container(
        color: selection ? Appcolor.selectionblue : Colors.transparent,
        child: ListTile(
          leading: widget.icon,
          title: buildtext(text: widget.title, fontsize: 20),

          //  Text(widget.title),

          // Container(
          //   height: 0.5,
          //   color: Colors.grey,
          // ),
        ),
      ),
    );
  }
}

class CustomTilelogout extends StatefulWidget {
  final Widget? icon;
  final String title;
  final String routename;
  const CustomTilelogout({
    Key? key,
    this.icon,
    required this.title,
    required this.routename,
  }) : super(key: key);

  @override
  State<CustomTilelogout> createState() => _CustomTilelogoutState();
}

class _CustomTilelogoutState extends State<CustomTilelogout> {
  bool selection = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          selection = true;
        });
        var sharedPref = await SharedPreferences.getInstance();
        sharedPref.setBool(KEYLOGIN, false);
        Navigator.pop(context);
        Navigator.pushNamedAndRemoveUntil(
          context,
          widget.routename,

          (route) => false,
        );
      },
      child: Container(
        color: selection ? Appcolor.selectionblue : Colors.transparent,
        child: ListTile(
          leading: widget.icon,
          title: buildtext(text: widget.title, fontsize: 20),

          //  Text(widget.title),

          // Container(
          //   height: 0.5,
          //   color: Colors.grey,
          // ),
        ),
      ),
    );
  }
}
