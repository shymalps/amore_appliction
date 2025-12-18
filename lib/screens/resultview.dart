import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:amore_student_erp/datalayer.dart/apicalls.dart';
import 'package:amore_student_erp/models/examresultmodel/datum.dart';
import 'package:amore_student_erp/models/examresultmodel/examresultmodel.dart';

import 'package:amore_student_erp/others/clors.dart';
import 'package:amore_student_erp/others/constants.dart';

class Examresultsnew extends StatefulWidget {
  // final String examid;
  const Examresultsnew({
    super.key,
  });

  @override
  State<Examresultsnew> createState() => _ExamresultsnewState();
}

class _ExamresultsnewState extends State<Examresultsnew> {
  Examresultmodel exresult = Examresultmodel();
  int skip = 0;
  String examid = '';
  // int wrong = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   getresults();
  // }
  void didChangeDependencies() {
    super.didChangeDependencies();
    examid = ModalRoute.of(context)!.settings.arguments as String;
    // Retrieve the subjectId when dependencies change
    getresults(examid != null ? examid : '');
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    // print('userId!$userId');
    // print('widget.examid${widget.examid}');

    return Scaffold(
      body: exresult.data == null
          ? Center(
              child: SpinKitCircle(
                color: Appcolor.darkblue,
                size: 75.0,
                // lineWidth: 3.0,
              ),
            )
          : SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                    left: _width * 0.05,
                    right: _width * 0.05,
                    top: _width * 0.05),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Appcolor.selectionblue)),
                        child: Padding(
                            padding: EdgeInsets.all(_width * 0.02),
                            child: buildText2(
                                'Score: ${exresult.fResult!.totalAns}/${exresult.data!.length}',
                                Appcolor.black,
                                _width * 0.06)),
                      ),
                      SizedBox(
                        height: _width * 0.05,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.green,
                                  )),
                              child: Padding(
                                  padding: EdgeInsets.all(_width * 0.01),
                                  child: buildText2(
                                      'CORRECT\n ${exresult.fResult!.totalAns}',
                                      Appcolor.black,
                                      _width * 0.04)),
                            ),
                          ),
                          SizedBox(
                            width: _width * 0.05,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 192, 92, 85)
                                  // borderRadius: BorderRadius.circular(5),
                                  // border: Border.all(color: Appcolor.green)
                                  ),
                              child: Padding(
                                  padding: EdgeInsets.all(_width * 0.01),
                                  child: Center(
                                    child: buildText2(
                                        'WRONG\n ${exresult.data!.length - skip - exresult.fResult!.totalAns}',
                                        Appcolor.black,
                                        _width * 0.04),
                                  )),
                            ),
                          ),
                          SizedBox(
                            width: _width * 0.05,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Appcolor.grey
                                  // borderRadius: BorderRadius.circular(5),
                                  // border: Border.all(color: Appcolor.green)
                                  ),
                              child: Padding(
                                  padding: EdgeInsets.all(_width * 0.01),
                                  child: buildText2('SKIPPED\n $skip',
                                      Appcolor.black, _width * 0.04)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: _width * 0.05,
                      ),
                      for (int i = 0; i < exresult.data!.length; i++)
                        answerlistitem(_width, i, exresult.data![i]),
                      // CustomListViewBuilder(
                      //   // itemCount: exresult.data!.length,
                      //   itemCount: 10,
                      //   itemBuilder: (BuildContext context, int index) {
                      //     return answerlistitem(_width);
                      //   },
                      // ),

                      SizedBox(
                        height: _width * 0.05,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Column answerlistitem(double _width, int i, Datum result) {
    print('Incrementing skip1');
    return Column(children: [
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.green)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(
                    top: _width * 0.02,
                    left: _width * 0.05,
                    bottom: _width * 0.02),
                child: buildText(
                    exresult.data![i].yourAns == 'Skip'
                        ? 'Skipped'
                        : exresult.data![i].yourAns! ==
                                exresult.data![i].currectAnwser
                            ? 'Correct'
                            : 'Incorrect',
                    exresult.data![i].yourAns == 'Skip'
                        ? Colors.amber
                        : exresult.data![i].yourAns! ==
                                exresult.data![i].currectAnwser
                            ? Colors.green
                            : Colors.red,
                    _width * 0.04)),
            const Divider(
              color: Colors.green,
              thickness: 1,
              // indent: 16,
              // endIndent: 16,
            ),
            Padding(
              padding: EdgeInsets.all(_width * 0.03),
              child: buildText(result.qns ?? '', Appcolor.black, _width * 0.04,
                  maxlines: 1000),
            ),

            optioitem(_width, result.optionA ?? '', result.currectAnwser ?? '',
                result.yourAns ?? ''),
            // SizedBox(
            //   height: _width * 0.01,
            // ),
            optioitem(_width, result.optionB ?? '', result.currectAnwser ?? '',
                result.yourAns ?? ''),

            optioitem(_width, result.optionC ?? '', result.currectAnwser ?? '',
                result.yourAns ?? ''),

            optioitem(_width, result.optionD ?? '', result.currectAnwser ?? '',
                result.yourAns ?? ''),
            result.optionE != ''
                ? optioitem(_width, result.optionE ?? '',
                    result.currectAnwser ?? '', result.yourAns ?? '')
                : SizedBox.shrink(),
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: _width * 0.03, vertical: _width * 0.01),
                child: buildText(
                    'Your ans: ${result.yourAns}',
                    result.yourAns == result.currectAnwser
                        ? Colors.green
                        : Colors.red,
                    _width * 0.04))
          ],
        ),
      ),
      SizedBox(
        height: _width * 0.05,
      )
    ]);
  }

  Padding optioitem(double _width, String text, String crctans, String yurans) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: _width * 0.03, vertical: _width * 0.01),
      child: Row(children: [
        Container(
            child: Icon(Icons.circle,
                color: text == crctans ? Colors.green : Appcolor.grey)),
        Expanded(
            // padding: EdgeInsets.all(2),
            child: Padding(
          padding: EdgeInsets.all(_width * 0.01),
          child: buildText(text, Appcolor.black, _width * 0.04, maxlines: 10),
        ))
      ]),
    );
  }

  Future<void> getresults(String examid) async {
    final result = await examresult(studentid!, examid);
    if (result != null) {
      setState(() {
        exresult = result;
      });
      count();
    }
  }

  void count() {
    for (int i = 0; i < exresult.data!.length; i++) {
      if (exresult.data![i].yourAns == 'Skip') {
        skip++;
      }
    }
  }
}
// import 'package:flutter/material.dart';

// // Define a custom reusable ListViewBuilder widget
// class CustomListViewBuilder extends StatelessWidget {
//   final int itemCount;
//   final IndexedWidgetBuilder itemBuilder;
//   final ScrollPhysics? physics;
//   final EdgeInsetsGeometry? padding;
//   final bool shrinkWrap;

//   const CustomListViewBuilder({
//     Key? key,
//     required this.itemCount,
//     required this.itemBuilder,
//     this.physics,
//     this.padding,
//     this.shrinkWrap = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: itemCount,
//       itemBuilder: itemBuilder,
//       physics: physics,
//       padding: padding,
//       shrinkWrap: shrinkWrap,
//     );
//   }
// }

class CustomListViewBuilder extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final Axis scrollDirection;
  final ScrollController? controller;

  const CustomListViewBuilder({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    this.physics,
    this.padding,
    this.shrinkWrap = false,
    this.scrollDirection = Axis.vertical,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      controller: controller,
      physics: physics,
      padding: padding,
      shrinkWrap: shrinkWrap,
      scrollDirection: scrollDirection,
    );
  }
}

Widget buildText(String text, Color textColor, double fontSize,
    {int maxlines = 3}) {
  return Text(
    text,
    //  textAlign: TextAlign.center
    //  , // Pass the text parameter here

    maxLines: maxlines,
    softWrap: true,
    overflow: TextOverflow.ellipsis,
    // textAlign: TextAlign.center,
    style: TextStyle(
      color: textColor,
      fontSize: fontSize,
      fontFamily: 'Rubik',
      fontWeight: FontWeight.w700,
    ),
  );
}

Widget buildText2(String text, Color textColor, double fontSize,
    {int maxlines = 3}) {
  return Text(
    text,
    //  textAlign: TextAlign.center
    //  , // Pass the text parameter here

    maxLines: maxlines,
    softWrap: true,
    overflow: TextOverflow.ellipsis,
    textAlign: TextAlign.center,
    style: TextStyle(
      color: textColor,
      fontSize: fontSize,
      fontFamily: 'Rubik',
      fontWeight: FontWeight.w700,
    ),
  );
}
