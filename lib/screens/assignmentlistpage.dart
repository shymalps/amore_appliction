import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:amore_student_erp/common%20widgets/commonappbar.dart';
import 'package:amore_student_erp/common%20widgets/textwidget.dart';
import 'package:amore_student_erp/common%20widgets/timestampconvert.dart';
import 'package:amore_student_erp/common%20widgets/videoplayerarguments.dart';
import 'package:amore_student_erp/datalayer.dart/apicalls.dart';
import 'package:amore_student_erp/models/assignmentmodel/datum.dart';

import '../common widgets/listviewbuilder.dart';

import '../others/clors.dart';
import '../others/constants.dart';

class AssignmentList extends StatefulWidget {
  const AssignmentList({super.key});

  @override
  State<AssignmentList> createState() => _AssignmentListState();
}

class _AssignmentListState extends State<AssignmentList> {
  late Assignmentarguments assignmentarguments;
  bool loading = true;
  List<Assignment> assignments = [];
  // @override
  // void initState() {
  //   super.initState();
  // }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    assignmentarguments =
        ModalRoute.of(context)!.settings.arguments as Assignmentarguments;
    _getassignmentdata();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Scaffold(
            backgroundColor: Appcolor.white,
            body: Center(
              child: SpinKitCircle(
                color: Appcolor.darkblue,
                size: 75.0,
                // lineWidth: 3.0,
              ),
            ),
          )
        : Scaffold(
            backgroundColor: Appcolor.darkblue,
            // appBar: AppBar(
            //   backgroundColor: Appcolor.darkblue,
            // ),
            appBar: commonappbar(context: context, title: 'Assignment'),
            // drawer: app_drawer(),
            body: SafeArea(
                child: Container(
              width: double.infinity,
              // height: ,
              decoration: BoxDecoration(
                  color: Appcolor.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(largeradius))),
              child: assignments.isEmpty
                  ? const Center(child: Text('No Assignments Found'))
                  // : const Center(child: Text(' Assignments Found'))

                  : Padding(
                      padding: EdgeInsets.only(
                          left: devicewidth! * 0.15,
                          right: devicewidth! * 0.15),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // buildtext(
                            //     text: heading,
                            //     fontsize: largefontsize,
                            //     fontweight: FontWeight.bold),

                            const SizedBox(
                                height:
                                    10), // Add some spacing between the heading and the list
                            Expanded(
                              child: CustomListViewBuilder(
                                itemCount: assignments.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                      onTap: () => Navigator.pushNamed(
                                          context, '/assignmentuploadpage',
                                          arguments: Assignmentuploadarguments(
                                              assignments[index].assignmentId!,
                                              assignments[index].title ?? '',
                                              assignments[index].qus ?? '',
                                              assignments[index].mark ?? '',
                                              assignments[index].fileName ?? '',
                                              assignments[index].teacherName ??
                                                  '')),
                                      child: assignmentitem(
                                          assignmentarguments.subName,
                                          assignments[index]));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            )),
          );
  }

  Padding assignmentitem(String subjectName, Assignment assignment) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
          decoration: BoxDecoration(
              color: Appcolor.blue,
              borderRadius: BorderRadius.circular(commonradius)),
          // width: devicewidth! * 0.2,
          // height: deviceheight! * 0.15,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: Appcolor.selectionblue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(devicewidth! * 0.01),
                          child: buildtext(
                              text: subjectName, fontsize: devicewidth! * 0.04),
                        )),
                    buildtext(
                        text: timeconvert(
                          assignment.createdAt,
                        ),
                        fontsize: devicewidth! * 0.03)
                  ],
                ),
              ),
              buildtext(
                  text: assignment.title ?? '', fontsize: devicewidth! * 0.04),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                buildtext(
                    text: 'By Staff: ${assignment.teacherName} ',
                    fontsize: devicewidth! * 0.03),
                assignment.submitMark != ''
                    ? buildtext(
                        text: 'Marks:${assignment.submitMark}',
                        fontsize: devicewidth! * 0.03)
                    : buildtext(text: '')
              ]),
            ]),
          )),
    );
  }

  _getassignmentdata() async {
    final result = await assignmentdata(
      assignmentarguments.subId!,
    );
    if (result != null) {
      print('entered');
      setState(() {
        loading = false;
        assignments = result.data ?? [];
        print('assignments2222${assignments.length}');
        print(loading);
        // print('assignments${assignments[1].toJson()}');
      });
    } else {
      print('no data found');
      setState(() {
        loading = false;
        assignments = [];
        print('assignments2222${assignments.length}');
        print(loading);
        // print('assignments${assignments[1].toJson()}');
      });
    }
  }
}

Padding assignmentitem(String subjectName, Assignment assignment) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Container(
        decoration: BoxDecoration(
            color: Appcolor.blue,
            borderRadius: BorderRadius.circular(commonradius)),
        // width: devicewidth! * 0.2,
        // height: deviceheight! * 0.15,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: Appcolor.selectionblue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(devicewidth! * 0.01),
                        child: buildtext(
                            text: subjectName, fontsize: devicewidth! * 0.04),
                      )),
                  buildtext(
                      text: timeconvert(
                        assignment.createdAt,
                      ),
                      fontsize: devicewidth! * 0.03)
                ],
              ),
            ),
            buildtext(
                text: assignment.title ?? '', fontsize: devicewidth! * 0.04),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              buildtext(
                  text: 'By Staff: ${assignment.teacherName} ',
                  fontsize: devicewidth! * 0.03),
              assignment.submitMark != ''
                  ? buildtext(
                      text: 'Marks:${assignment.submitMark}',
                      fontsize: devicewidth! * 0.03)
                  : buildtext(text: '')
            ]),
          ]),
        )),
  );
}
