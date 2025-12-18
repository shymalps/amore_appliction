import 'package:flutter/material.dart';
import 'package:amore_student_erp/common%20widgets/commonappbar.dart';
import 'package:amore_student_erp/common%20widgets/listviewbuilder.dart';
import 'package:amore_student_erp/common%20widgets/loader.dart';

import 'package:amore_student_erp/common%20widgets/textwidget.dart';
import 'package:amore_student_erp/datalayer.dart/apicalls.dart';
import 'package:amore_student_erp/models/assignmentmodel/datum.dart';
import 'package:amore_student_erp/models/progressbarmodel/datum.dart';
import 'package:amore_student_erp/others/clors.dart';
import 'package:amore_student_erp/others/constants.dart';
import 'package:amore_student_erp/screens/appdrawer.dart';
import 'package:amore_student_erp/screens/assignmentlistpage.dart';
import 'package:amore_student_erp/screens/settingspage.dart';

class Welcomepage extends StatefulWidget {
  const Welcomepage({super.key});

  @override
  State<Welcomepage> createState() => _WelcomepageState();
}

class _WelcomepageState extends State<Welcomepage> {
  List<Baritem> baritems = [];
  bool loading = true;
  @override
  void initState() {
    super.initState();
    _dashboarddata();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loader()
        : Scaffold(
            endDrawer:  Drawer(child: app_drawer()),
            // drawer: app_drawer()
            appBar: AppBar(
              flexibleSpace: Dashboardappbar(
                name: baritems[0].name ?? '',
              ),
            ),
            backgroundColor: Appcolor.darkblue,
            body: SafeArea(
              child: Container(
                decoration: const BoxDecoration(
                    gradient: AppGradients.scaffoldbackground),
                child: Column(
                  children: [
                    // dashboardappbar(),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          buildtext(
                              text:
                                  capitalization(baritems[0].datumClass ?? ''),
                              fontsize: comonfontsize,
                              fontcolor: Appcolor.white),
                          // buildtext(
                          //     text: 'Active',
                          //     fontsize: comonfontsize,
                          //     fontcolor: Appcolor.white)
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Divider(
                        color: Colors.white, // Set the color to white
                        thickness: 2, // Set the thickness of the divider
                        height: 20, // Set the height spacing around the divider
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Appcolor.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(12, 26),
                                    blurRadius: 50,
                                    spreadRadius: 0,
                                    color: Colors.grey.withOpacity(.1)),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: TextField(
                            // controller: searchController,
                            textAlign: TextAlign.left,
                            onChanged: (value) {},
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => searchpages(),
                              //   ),
                              // );
                            },
                            style: const TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              // prefixIcon: Icon(Icons.email),
                              prefixIcon: const Icon(Icons.search,
                                  size: 20, color: Color(0xffFF5A60)),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Search Courses',
                              hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(.75)),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 20.0),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                            ),
                          ),
                        ),

                        //const Padding(
                        //     padding: EdgeInsets.all(10),
                        //     child:  Row(
                        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //         children:  [

                        //           // buildtext(
                        //           //     text: 'Search Here',
                        //           //     fontcolor: Appcolor.grey),
                        //           Icon(
                        //             Icons.search,
                        //             color: Appcolor.grey,
                        //           )
                        //         ])),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                            gradient: AppGradients.background,
                            // color: Appcolor.selectionblue,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(40))),
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.all(devicewidth! * 0.05),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: devicewidth! * 0.05,
                                      horizontal: devicewidth! * 0.02),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        dashboarditem(
                                          icon: gotostudyicon,
                                          label: 'Goto Study',
                                          routeName: '/classroom',
                                          argument: 'gototopic',
                                        ),
                                        dashboarditem(
                                          icon: ecamicon,
                                          label: 'Exam',
                                          routeName: '/classroom',
                                          argument: 'gotoassessment',
                                        )
                                      ]),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: devicewidth! * 0.05,
                                      horizontal: devicewidth! * 0.02),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        dashboarditem(
                                          icon: assignmenticon,
                                          label: 'Assignment',
                                          routeName: '/classroom',
                                          argument: 'gotoassignment',
                                        ),
                                        dashboarditem(
                                          icon: profileicon,
                                          label: 'Profile',
                                          routeName: '/profilepage',
                                          argument: '',
                                        )
                                      ]),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Appcolor.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                      padding:
                                          EdgeInsets.all(devicewidth! * 0.02),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          buildtext(
                                              text: capitalization(
                                                  baritems[0].datumClass ?? ''),
                                              fontcolor: Appcolor.black,
                                              fontweight: FontWeight.w600,
                                              fontsize: largefontsize),
                                          const Divider(
                                            color: Appcolor
                                                .grey, // Set the color to white
                                            thickness:
                                                1, // Set the thickness of the divider
                                            height:
                                                20, // Set the height spacing around the divider
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Progressindicatingitem(
                                                label: 'Videos',
                                                value: getprogressvalue(
                                                    baritems[0].seenVideo ?? 0,
                                                    baritems[0].video!)
                                                // (baritems[0].seenVideo??0/ baritems[0].video!).toDouble(),
                                                ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Progressindicatingitem(
                                                label: 'Notes',
                                                value: getprogressvalue(
                                                    baritems[0].seenNotes ?? 0,
                                                    baritems[0].notes!)
                                                // (baritems[0].seenNotes??0/ baritems[0].notes!).toDouble(),
                                                ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Progressindicatingitem(
                                              label: 'Audio',
                                              value: getprogressvalue(
                                                  baritems[0].seenAudio ?? 0,
                                                  baritems[0].audio!),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                // const Assignmentlistindashboard()
                              ],
                            ),
                          ),
                        ),
                        // height: double.infinity,
                      ),
                    )
                  ],
                ),
              ),
            ));
  }

  void _dashboarddata() async {
    final result = await progressbardata();
    if (result != null) {
      setState(() {
        baritems = result.data!;
        loading = false;
      });
    } else {}

    // print(result.toString());
  }

  double getprogressvalue(int seen, int total) {
    if (total != 0) {
      return (seen / total).toDouble();
    }
    return 0;
  }
}

class Assignmentlistindashboard extends StatefulWidget {
  const Assignmentlistindashboard({
    super.key,
  });

  @override
  State<Assignmentlistindashboard> createState() =>
      _AssignmentlistindashboardState();
}

class _AssignmentlistindashboardState extends State<Assignmentlistindashboard> {
  bool loading = true;
  List<Assignment> assignments = [];
  @override
  void initState() {
    super.initState();
    _getassignmentdata();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Appcolor.white, borderRadius: BorderRadius.circular(15)),
      child: Column(children: [
        Row(
          children: [
            Expanded(flex: 1, child: Image.asset(announcementIcon)),
            Expanded(
              flex: 4,
              child: Center(
                child: buildtext(
                    text: 'New Assignment List',
                    fontweight: FontWeight.w800,
                    fontsize: largefontsize),
              ),
            ),
          ],
        ),
        const Divider(
          color: Appcolor.grey, // Set the color to white
          thickness: 3, // Set the thickness of the divider
          height: 20, // Set the height spacing around the divider
        ),
        Container(
          width: double.infinity,
          height: 50,
          color: Appcolor.blue,
        ),
        SizedBox(
          height: 20,
        ),
        assignmentitem('Abhilash', assignments[1]),
        SizedBox(
          height: 20,
        ),
        Container(
          width: double.infinity,
          height: 50,
          color: Appcolor.blue,
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: double.infinity,
          height: 50,
          color: Appcolor.blue,
        ),
        SizedBox(
          height: 20,
        ),
        // assignmentitem('Abhilash',assignments[1]),
      ]),
    );
  }

  _getassignmentdata() async {
    final result = await assignmentdata();
    if (result != null) {
      print('entered');
      setState(() {
        loading = false;
        assignments = result.data ?? [];
        print('assignments${assignments.length}');
      });
    }
  }
}

String capitalization(String name) {
  // String name = 'abhilash';
  String capitalized = '${name[0].toUpperCase()}${name.substring(1)}';
  print(capitalized);
  return capitalized; // Output: Abhilash
}

class Dashboardappbar extends StatelessWidget {
  final String name;
  const Dashboardappbar({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Appcolor.darkblue,
      child: Padding(
        padding: EdgeInsets.all(devicewidth! * 0.05).copyWith(bottom: 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  SizedBox(
                    height: devicewidth! * 0.1,
                    width: devicewidth! * 0.1,
                    child: profileimage(
                      image: menavathar,
                      border: true,
                      circle: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildtext(
                            text: 'Hello',
                            fontsize: comonfontsize,
                            fontcolor: Appcolor.white,
                            fontweight: FontWeight.w200),
                        buildtext(
                            text: capitalization(name),
                            fontsize: largefontsize,
                            fontcolor: Appcolor.white,
                            fontweight: FontWeight.w700)
                      ],
                    ),
                  )
                ],
              ),
            ),
            // GestureDetector(
            //   onTap: () => Navigator.pushNamed(context, '/appdrawer'),
            //   child: Container(
            //     decoration: BoxDecoration(
            //         color: Appcolor.white,
            //         borderRadius: BorderRadius.circular(5)),
            //     child: const Padding(
            //       padding: EdgeInsets.all(5),
            //       child: Icon(
            //         Icons.menu_rounded,
            //         color: Appcolor.black,
            //         size: 30,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class Progressindicatingitem extends StatelessWidget {
  final String label;
  final double value;
  const Progressindicatingitem({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // color: Appcolor.blue,
            child: buildtext(
                text: label,
                fontcolor: Appcolor.black,
                fontweight: FontWeight.w600,
                fontsize: comonfontsize),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildtext(text: '0%', fontsize: 10, fontcolor: Appcolor.grey),
                  buildtext(
                      text: '100%', fontsize: 10, fontcolor: Appcolor.grey)
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: value,
                  minHeight: 5,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class dashboarditem extends StatelessWidget {
  final String icon;
  final String label;
  final String routeName;
  final String argument;
  const dashboarditem({
    super.key,
    required this.icon,
    required this.label,
    required this.routeName,
    required this.argument,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, routeName, arguments: argument),
          child: Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Appcolor.darkblue, // Circle color
                  shape: BoxShape.circle,
                  // border: Border.all(
                  //   color: Colors.blue, // Border color (same as circle color for seamless look)
                  //   width: 2.0, // Border width
                  //      ),
                ),
                height: 40,
                width: 40,
                child: Padding(
                    padding: const EdgeInsets.all(5), child: Image.asset(icon)),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildtext(
                        text: 'Click Here',
                        fontsize: 10,
                        fontcolor: Appcolor.grey),
                    buildtext(
                        text: label,
                        fontsize: comonfontsize,
                        fontweight: FontWeight.w500)
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
