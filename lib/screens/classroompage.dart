import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:amore_student_erp/common%20widgets/commonappbar.dart';
import 'package:amore_student_erp/common%20widgets/listviewbuilder.dart';
import 'package:amore_student_erp/common%20widgets/loader.dart';
import 'package:amore_student_erp/common%20widgets/textwidget.dart';
import 'package:amore_student_erp/common%20widgets/videoplayerarguments.dart';
import 'package:amore_student_erp/datalayer.dart/apicalls.dart';
import 'package:amore_student_erp/models/subjectmodel/datum.dart';
import 'package:amore_student_erp/others/clors.dart';
import 'package:amore_student_erp/others/constants.dart';
// import 'package:amore_student_erp/screens/appdrawer.dart';

class classroom_page extends StatefulWidget {
  // final String goto;
  const classroom_page({
    super.key,

    //  required this.goto
  });

  @override
  State<classroom_page> createState() => _classroom_pageState();
}

class _classroom_pageState extends State<classroom_page> {
  List<Datum>? subjects;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    _getsubjects();
  }

  @override
  Widget build(BuildContext context) {
    String goto = ModalRoute.of(context)!.settings.arguments as String;
    print(goto);
    return loading
        ? Scaffold(
            // backgroundColor: Appcolor.darkblue,
            appBar: commonappbar(context: context, title: 'Subject'),
            body: subjects != null
                ? SafeArea(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Appcolor.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(largeradius),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: devicewidth! * 0.1,
                        ),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ), // Add some spacing between the heading and the list
                              Expanded(
                                child: CustomListViewBuilder(
                                  itemCount: subjects!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                        String displayNumber = (index + 1)
                                            .toString()
                                            .padLeft(2, '0');
                                        return GestureDetector(
                                          onTap: () => gotoroute(
                                            goto,
                                            subjects![index].subjectId,
                                            subjects![index].name,
                                          ),
                                          child: subjectlist(
                                            displayNumber,
                                            subjects,
                                            index,
                                          ),
                                        );
                                      },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : const Center(child: Text('No data found')),
          )
        : const Loader();
  }

  void gotoroute(String goto, String? subId, String? subname) {
    if (goto == 'gototopic') {
      Navigator.pushNamed(context, '/topiclist', arguments: subId);
    } else if (goto == 'gotoassignment') {
      Navigator.pushNamed(
        context,
        '/Assignmentlist',
        arguments: Assignmentarguments(subId ?? '', subname ?? ''),
      );
    } else if (goto == 'gotoassessment') {
      Navigator.pushNamed(context, '/examlist', arguments: subId);
    }
  }

  Padding subjectlist(String displayNumber, List<Datum>? subjects, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Appcolor.blue,
          borderRadius: BorderRadius.circular(commonradius),
        ),
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
                  fontweight: FontWeight.bold,
                ),

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
              child: Center(
                child: buildtext(text: subjects![index]!.name!, fontsize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getsubjects() async {
    final data = await getmultirowdata(classid, sectionId);
    print('dddddddd');

    if (data != null) {
      setState(() {
        subjects = data.data;
        loading = true;
      });
    } else {
      setState(() {
        loading = true;
      });
    }
  }
}
