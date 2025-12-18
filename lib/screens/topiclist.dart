import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:amore_student_erp/common%20widgets/commonappbar.dart';
import 'package:amore_student_erp/common%20widgets/listviewbuilder.dart';
import 'package:amore_student_erp/common%20widgets/textwidget.dart';
import 'package:amore_student_erp/datalayer.dart/apicalls.dart';
import 'package:amore_student_erp/models/topicmodel/datum.dart';
import 'package:amore_student_erp/others/clors.dart';
import 'package:amore_student_erp/others/constants.dart';
import 'package:lottie/lottie.dart';

class topiclist extends StatefulWidget {
  const topiclist({super.key});

  @override
  State<topiclist> createState() => _topiclistState();
}

class _topiclistState extends State<topiclist> {
  List<topicitem> topics = [];
  String subjectId = '';
  bool loading = false;
  bool nodata = false;

  @override
  void initState() {
    super.initState();
    // _gettopics();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Retrieve the subjectId when dependencies change
    if (subjectId == '') {
      subjectId = ModalRoute.of(context)!.settings.arguments as String;
      _gettopics(subjectId);
      // Pass subjectId to the method
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Scaffold(
            backgroundColor: Appcolor.darkblue,
            appBar: commonappbar(context: context, title: 'Topic'),
            body: SafeArea(
                child: nodata
                    ? const Scaffold(
                        body: SafeArea(
                          child: Center(child: Text('No topic Found')),
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        // height: ,
                        decoration: BoxDecoration(
                            gradient: AppGradients.background,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(largeradius))),
                        child: Padding(
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
                                    itemCount: topics.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                          onTap: () => Navigator.pushNamed(
                                              context, '/studymaterials',
                                              arguments: topics[index].topicId),
                                          child: topiclist(
                                              topics[index].topic.toString()));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
          )
        : Scaffold(
            backgroundColor: Appcolor.white,
            body: Center(
              child: SpinKitCircle(
                color: Appcolor.darkblue,
                size: 75.0,
                // lineWidth: 3.0,
              ),
            ),
          );
  }

  Padding topiclist(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Appcolor.selectionblue),
            color: Appcolor.blue,
            borderRadius: BorderRadius.circular(commonradius)),
        // width: devicewidth! * 0.2,
        // height: deviceheight! * 0.15,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                      height: 100, width: 100, child: Image.asset(clipboard))

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
              child: buildtext(text: label, fontsize: 20),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _gettopics(String subjectId) async {
    // final String subjectId = ModalRoute.of(context)!.settings.arguments as String;
    final data = await getmultirowdatatopic(
        'topic', 'subject_id', subjectId, 'audio', 'topic_id');

    print('data$data');

    if (data != null) {
      if (data.data != null) {
        setState(() {
          topics = data.data ?? [];
          loading = true;
        });
      }
    } else {
      setState(() {
        loading = true;
        nodata = true;
      });
    }
  }
}
