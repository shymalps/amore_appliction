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
import 'package:intl/intl.dart';

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
            appBar: AppBar(
  backgroundColor: Appcolor.darkblue,
  elevation: 0,
  toolbarHeight: 90,
  titleSpacing: 15,
  title: Row(
    children: [
      SizedBox(
        height: 50,
        width: 50,
        child: profileimage(
          image: menavathar,
          border: true,
          circle: false,
        ),
      ),
      const SizedBox(width: 12),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildtext(
            text: 'Welcome back,',
            fontsize: 12,
            fontcolor: Appcolor.white,
            fontweight: FontWeight.w400,
          ),
          buildtext(
            text: capitalization(baritems[0].name!.trim()),
            fontsize: 16,
            fontcolor: Appcolor.white,
            fontweight: FontWeight.w700,
          ),
        ],
      ),
    ],
  ),
),
endDrawer: Drawer(child: app_drawer()),


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
                              text: '${baritems[0].department ?? '' }(',
                              fontsize: comonfontsize,
                              fontcolor: Appcolor.white),
                          buildtext(
                              text:
                                  '${baritems[0].datumClass ?? ''})',
                              fontsize: comonfontsize,
                              fontcolor: Appcolor.white),
                
                                 
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
                    ),    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: buildtext(
                                  text: baritems[0].section ?? '',
                                  fontsize: comonfontsize,
                                  fontcolor: Appcolor.white),
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
                                          label: 'Exam        ',
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
                                          icon: liveC,
                                          label: 'Live Class',
                                          routeName: '/liveclassroom',
                                          argument: '',
                                        )
                                      ]),
                                ),
                                const SizedBox(height: 10),
                                     Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 1, vertical: 1),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Appcolor.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.08),
                                      blurRadius: 15,
                                      offset: const Offset(0, 5),
                                    )
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      buildtext(
                                          text: 'Learning Progress',
                                          fontcolor: Appcolor.black,
                                          fontweight: FontWeight.w700,
                                          fontsize: 16),
                                      const SizedBox(height: 16),
                                      CompactProgressIndicator(
                                        label: 'Videos',
                                        value: getprogressvalue(
                                            baritems[0].seenVideo ?? 0,
                                            baritems[0].video!),
                                        seen: baritems[0].seenVideo ?? 0,
                                        total: baritems[0].video!,
                                      ),
                                      const SizedBox(height: 12),
                                      CompactProgressIndicator(
                                        label: 'Notes',
                                        value: getprogressvalue(
                                            baritems[0].seenNotes ?? 0,
                                            baritems[0].notes!),
                                        seen: baritems[0].seenNotes ?? 0,
                                        total: baritems[0].notes!,
                                      ),
                                      const SizedBox(height: 12),
                                      CompactProgressIndicator(
                                        label: 'Audio',
                                        value: getprogressvalue(
                                            baritems[0].seenAudio ?? 0,
                                            baritems[0].audio!),
                                        seen: baritems[0].seenAudio ?? 0,
                                        total: baritems[0].audio!,
                                      ),
                                      
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            
                                // const Assignmentlistindashboard()
                                    Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 1, vertical: 10),
                              child: CourseTimelineWidget(
                                startDate: baritems[0].startDate.toString() ?? 'N/A' ,
                                endDate: baritems[0].endDate.toString() ?? 'N/A' ,
                                
                              ),
                            ),

                            const SizedBox(height: 20),
                              
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
        const SizedBox(
          height: 20,
        ),
        assignmentitem('Abhilash', assignments[1]),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: double.infinity,
          height: 50,
          color: Appcolor.blue,
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: double.infinity,
          height: 50,
          color: Appcolor.blue,
        ),
        const SizedBox(
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
class CompactProgressIndicator extends StatelessWidget {
  final String label;
  final double value;
  final int seen;
  final int total;

  const CompactProgressIndicator({
    super.key,
    required this.label,
    required this.value,
    required this.seen,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (value * 100).toStringAsFixed(0);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildtext(
              text: label,
              fontcolor: Appcolor.black,
              fontweight: FontWeight.w600,
              fontsize: 13,
            ),
            buildtext(
              text: '$seen/$total • $percentage%',
              fontcolor: Appcolor.grey,
              fontsize: 11,
              fontweight: FontWeight.w500,
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 5,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(
              Color(0xFF1E3A8A),
            ),
          ),
        ),
      ],
    );
  }
}

String capitalization(String name) {
  // String name = 'abhilash';
  String capitalized = '${name[0].toUpperCase()}${name.substring(1)}';
  print(capitalized);
  return capitalized; // Output: Abhilash
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

class CourseTimelineWidget extends StatelessWidget {
  final String startDate;
  final String endDate;
  // final int hoursCompleted;
  // final int totalHours;

  const CourseTimelineWidget({
    super.key,
    required this.startDate,
    required this.endDate,
    // required this.hoursCompleted,
    // required this.totalHours,
  });

  @override
  Widget build(BuildContext context) {

    DateTime parseBackendDate(String date) {
  try {
    // Expected backend format: dd/MM/yyyy
    return DateFormat('dd/MM/yyyy').parse(date);
  } catch (_) {
    // fallback to today to prevent crashes
    return DateTime.now();
  }
}

    // Calculate days
final start = parseBackendDate(startDate);
final end   = parseBackendDate(endDate);
    final today = DateTime.now();

    final totalDays = end.difference(start).inDays;
    final daysCompleted = today.difference(start).inDays;
    final daysRemaining = end.difference(today).inDays;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildtext(
              text: 'Course Timeline',
              fontcolor: Appcolor.black,
              fontweight: FontWeight.w700,
              fontsize: 16,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _TimelineInfoItem(
                    label: 'Start Date',
                    value: _formatDate(startDate),
                    icon: Icons.calendar_today,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _TimelineInfoItem(
                    label: 'End Date',
                    value: _formatDate(endDate),
                    icon: Icons.event,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Row(
            //   children: [
            //     Expanded(
            //       child: _TimelineInfoItem(
            //         label: 'Hours Completed',
            //         value: '$hoursCompleted hrs',
            //         icon: Icons.access_time,
            //       ),
            //     ),
            //     const SizedBox(width: 12),
            //     Expanded(
            //       child: _TimelineInfoItem(
            //         label: 'Total Hours',
            //         value: '$totalHours hrs',
            //         icon: Icons.hourglass_full,
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E3A8A).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Color(0xFF1E3A8A),
                    size: 18,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: buildtext(
                      text: '$daysCompleted days over, $daysRemaining days remain',
                      fontcolor: const Color(0xFF1E3A8A),
                      fontsize: 12,
                      fontweight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

String _formatDate(String dateString) {
      DateTime parseBackendDate(String date) {
  try {
    // Expected backend format: dd/MM/yyyy
    return DateFormat('dd/MM/yyyy').parse(date);
  } catch (_) {
    // fallback to today to prevent crashes
    return DateTime.now();
  }
}
  final date = parseBackendDate(dateString);
  return DateFormat('dd MMM yyyy').format(date);
}

}

class _TimelineInfoItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _TimelineInfoItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Appcolor.darkblue.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 14,
                color: Appcolor.grey,
              ),
              const SizedBox(width: 6),
              buildtext(
                text: label,
                fontcolor: Appcolor.grey,
                fontsize: 10,
                fontweight: FontWeight.w500,
              ),
            ],
          ),
          const SizedBox(height: 4),
          buildtext(
            text: value,
            fontcolor: Appcolor.black,
            fontsize: 13,
            fontweight: FontWeight.w700,
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

class ClassInfoCard extends StatelessWidget {
  final String className;
  final String department;
  final String section;

  const ClassInfoCard({
    super.key,
    required this.className,
    required this.department,
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
    
            
            buildtext(
              text: capitalization(className),
              fontcolor: Appcolor.black,
              fontsize: 20,
              fontweight: FontWeight.w700,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _InfoChip(
                    label: 'Department',
                    value: department,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _InfoChip(
                    label: 'Section',
                    value: section,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final String value;

  const _InfoChip({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Appcolor.darkblue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildtext(
            text: label,
            fontcolor: Appcolor.grey,
            fontsize: 10,
            fontweight: FontWeight.w500,
          ),
          const SizedBox(height: 4),
          buildtext(
            text: value,
            fontcolor: Appcolor.black,
            fontsize: 12,
            fontweight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
