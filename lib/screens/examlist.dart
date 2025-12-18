import 'package:flutter/material.dart';
import 'package:amore_student_erp/common%20widgets/commonappbar.dart';
import 'package:amore_student_erp/common%20widgets/listviewbuilder.dart';
import 'package:amore_student_erp/common%20widgets/loader.dart';
import 'package:amore_student_erp/common%20widgets/snackbar.dart';
import 'package:amore_student_erp/common%20widgets/textwidget.dart';
import 'package:amore_student_erp/datalayer.dart/apicalls.dart';
import 'package:amore_student_erp/models/examlistdata/datum.dart';

import 'package:amore_student_erp/others/clors.dart';
import 'package:amore_student_erp/others/constants.dart';

class Examlistpage extends StatefulWidget {
  const Examlistpage({super.key});

  @override
  State<Examlistpage> createState() => _ExamlistpageState();
}

class _ExamlistpageState extends State<Examlistpage> {
  List<Exam>? examlist;
  bool loading = false;
  String subid = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    subid = ModalRoute.of(context)!.settings.arguments as String;
    // print('subid is $subid');
    _getexamlist();
  }

  @override
  Widget build(BuildContext context) {
    subid = ModalRoute.of(context)!.settings.arguments as String;
    print('subid is $subid');
    return loading
        ?
        //  examlist == null
        //     ? const Scaffold(
        //         body: Center(
        //         child: Text('No Exam Available Now'),
        //       ))
        //     :
        Scaffold(
            backgroundColor: Appcolor.darkblue,
            appBar: commonappbar(context: context, title: 'Exams'),
            body: SafeArea(
              child: Container(
                width: double.infinity,
                // height: ,
                decoration: BoxDecoration(
                    color: Appcolor.white,
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(largeradius))),
                child: examlist == null
                    ? const Center(child: Text('No Exam Available Now'))
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
                                  itemCount: examlist!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    String displayNumber =
                                        (index + 1).toString().padLeft(2, '0');
                                    return GestureDetector(
                                        onTap: () {
                                          _goto(examlist![index].button,
                                              examlist![index].examId!);
                                          // print(examlist![index].examId);
                                          // Navigator.pushNamed(
                                          //     context, '/examattendpage',
                                          //     arguments:
                                          //         examlist![index].examId);
                                        },
                                        child: examlistitem(
                                            displayNumber, examlist![index]

                                            // subjects,
                                            // index
                                            ));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ),
          )
        : const Loader();
  }

  Padding examlistitem(
    String displayNumber,
    Exam examlist,
    // int index
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
            color: Appcolor.blue,
            borderRadius: BorderRadius.circular(commonradius)),
        // width: devicewidth! * 0.2,
        height: deviceheight! * 0.15,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: FittedBox(
                  fit: BoxFit.cover,
                  child: buildtext(
                      text: displayNumber,
                      fontcolor: Appcolor.white,
                      fontsize: devicewidth! * 0.3,
                      fontweight: FontWeight.bold)

                  // Text(
                  //   displayNumber,
                  //   style: TextStyle(
                  //       color: Appcolor.white,
                  //       fontSize: devicewidth! * 0.2,
                  //       fontWeight: FontWeight.w800),
                  // ),
                  ),
            ),
            Expanded(
              flex: 2,
              // color: Appcolor.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildtext(
                      text: examlist.name!,
                      //  subjects![index]!.name!,
                      fontsize: comonfontsize),
                  buildtext(
                      text: examlist.button! == 'Missed'
                          ? 'you missed the exam'
                          : examlist.button! == 'View Result'
                              ? 'you can view result now'
                              : 'you can start exam now',
                      //  subjects![index]!.name!,
                      fontsize: 10,
                      fontcolor: examlist.button! == 'Missed'
                          ? Colors.red
                          : examlist.button! == 'View Result'
                              ? Colors.green
                              : Colors.amber)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _getexamlist() async {
    print(subid);
    final data = await getexamlist(subid);
    print('Loading is true');
    print(data == null);
    if (data != null) {
      if (data.data != null) {
        setState(() {
          examlist = (data.data)!;
          loading = true;
        });
      } else {
        setState(() {
          print('Loading is true');
          loading = true;
        });
      }
    }
  }

  _goto(String? value, String eamid) {
    print(value);
    if (value == 'View Result') {
      Navigator.pushNamed(context, '/examcomplete', arguments: eamid);
    } else if (value == 'Start Now') {
      Navigator.pushReplacementNamed(context, '/examattendpage',
          arguments: eamid);
    } else {
      showSubscriptionActiveSnackBar(context, "You didn't attend the exam");
    }
  }
}

// : const SpinKitCircle(
//                         color: Appcolor.darkblue,
//                         size: 75.0,
//                       )

//  loading
//                     ?
