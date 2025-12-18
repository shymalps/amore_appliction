import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:amore_student_erp/common%20widgets/commonappbar.dart';
import 'package:amore_student_erp/common%20widgets/listviewbuilder.dart';
import 'package:amore_student_erp/common%20widgets/loader.dart';
import 'package:amore_student_erp/common%20widgets/snackbar.dart';
import 'package:amore_student_erp/common%20widgets/textwidget.dart';
import 'package:amore_student_erp/datalayer.dart/apicalls.dart';
import 'package:amore_student_erp/models/examquestionmodel/datum.dart';
import 'package:amore_student_erp/models/examquestionmodel/exam.dart';
import 'package:amore_student_erp/models/examquestionmodel/examquestionmodel.dart';
import 'package:amore_student_erp/others/clors.dart';
import 'package:amore_student_erp/others/constants.dart';
import 'dart:async';

import 'package:lottie/lottie.dart';

class Examattendpage extends StatefulWidget {
  const Examattendpage({super.key});

  @override
  State<Examattendpage> createState() => _ExamattendpageState();
}

class _ExamattendpageState extends State<Examattendpage> {
  final ScrollController _scrollController = ScrollController();
  int currentIndex = 0;
  String correctOption = '';
  bool timerfinished = false;
  String examid = '';
  Exam? examdata = Exam();
  List<Questions> questions = [];
  bool loading = false;
  bool loading2 = false;
  bool somethingwrong = false;
  @override
  // void initState() {
  //   super.initState();
  //   _getquestions();
  // }
  void didChangeDependencies() {
    super.didChangeDependencies();
    examid = ModalRoute.of(context)!.settings.arguments as String;
    // Retrieve the subjectId when dependencies change
    _getquestions(examid != null ? examid : '');
  }

  @override
  Widget build(BuildContext context) {
    if (loading2 == false) {
      return const Loader();
    } else if (somethingwrong == true) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(gradient: AppGradients.background),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: devicewidth! * 0.5,
                    child: Lottie.asset('asset/images/examtimeout.json')),
                buildtext(
                    text: 'OOPS!',
                    fontsize: devicewidth! * 0.1,
                    fontcolor: const Color.fromARGB(255, 190, 38, 27),
                    fontweight: FontWeight.w700),
                buildtext(
                    text: 'Something went wrong please try again later',
                    fontsize: devicewidth! * 0.04)
              ],
            ),
          ),
        ),
      );
    } else {
      if (timerfinished) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: devicewidth! * 0.5,
                      child: Lottie.asset('asset/images/examtimeout.json')),
                  buildtext(
                      text: 'OOPS!',
                      fontsize: devicewidth! * 0.1,
                      fontcolor: const Color.fromARGB(255, 190, 38, 27),
                      fontweight: FontWeight.w700),
                  buildtext(
                      text: 'Exam Time Out', fontsize: devicewidth! * 0.04)
                ],
              ),
            ),
          ),
        );
      } else if (currentIndex + 1 > questions.length) {
        return Scaffold(
          body: Center(
            child: Visibility(
                visible: currentIndex + 1 >= questions.length,
                child: GestureDetector(
                    onTap: () => _examcomplete(),
                    child: finalSubmitButton(
                      text: 'Complete Exam',
                      tapped: false,
                    ))),
          ),
        );
      } else {
        return Scaffold(
          backgroundColor: Appcolor.darkblue,
          appBar: commonappbar(context: context, title: 'Exam'),
          body: SafeArea(
              child: Container(
                  decoration: BoxDecoration(
                    // color: Appcolor.white,
                    gradient: AppGradients.background,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(largeradius),
                    ),
                  ),
                  // width: double.infinity,
                  height: double.infinity,
                  child: loading
                      ? SingleChildScrollView(
                          child: Column(
                            children: [
                              CountdownTimer(
                                time: 10,
                                onTimerFinish: handleTimerFinish,
                              ),
                              questionnumberlist(questions.length),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: devicewidth! * 0.05),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Appcolor.blue),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.all(devicewidth! * 0.025),
                                    child: buildtext(
                                        fontsize: devicewidth! * 0.04,
                                        maxlines: 100,
                                        text:
                                            questions[currentIndex].qns ?? ''),
                                  ),
                                ),
                              ),
                              SizedBox(height: devicewidth! * 0.05),
                              GestureDetector(
                                  onTap: () => setState(() {
                                        correctOption = 'A';
                                      }),
                                  child: examoption('A',
                                      questions[currentIndex].optiona ?? '')),
                              GestureDetector(
                                  onTap: () => setState(() {
                                        correctOption = 'B';
                                      }),
                                  child: examoption('B',
                                      questions[currentIndex].optionb ?? '')),
                              GestureDetector(
                                  onTap: () => setState(() {
                                        correctOption = 'C';
                                      }),
                                  child: examoption('C',
                                      questions[currentIndex].optionc ?? '')),
                              GestureDetector(
                                  onTap: () => setState(() {
                                        correctOption = 'D';
                                      }),
                                  child: examoption('D',
                                      questions[currentIndex].optiond ?? '')),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: devicewidth! * 0.05,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () => _previous(),
                                      child: exambutton(
                                        icon: Icons.fast_rewind_rounded,
                                      ),
                                    ),
                                    // SizedBox(
                                    //   width: devicewidth! * 0.05,
                                    // ),
                                    GestureDetector(
                                        onTap: () => _clear(),
                                        child: exambutton(label: 'Clear')),
                                    // SizedBox(
                                    //   width: devicewidth! * 0.05,
                                    // ),
                                    GestureDetector(
                                        onTap: () => _skip(),
                                        child: exambutton(label: 'Skip')),
                                    // SizedBox(
                                    //   width: devicewidth! * 0.05,
                                    // ),
                                    GestureDetector(
                                      onTap: () => _next(),
                                      child: exambutton(
                                        icon: Icons.fast_forward_rounded,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: devicewidth! * 0.05,
                              ),
                              // buildtext(text: correctOption),

                              SizedBox(height: devicewidth! * 0.05),
                            ],
                          ),
                        )
                      : const SpinKitCircle(
                          color: Appcolor.darkblue,
                          size: 75.0,
                        ))),
        );
      }
    }
  }

  Container exambutton({String? label, IconData? icon}) {
    return
        //  Expanded(
        // flex: 1,
        // child:
        Container(
            width: devicewidth! * 0.2,
            decoration: BoxDecoration(
                color: Appcolor.blue, borderRadius: BorderRadius.circular(10)),
            // color: Appcolor.blue,
            child: Padding(
                padding: EdgeInsets.all(devicewidth! * 0.025),
                child: icon == null
                    ? Center(
                        child: buildtext(
                            text: label!, fontsize: devicewidth! * 0.04))
                    : Center(
                        child: Icon(
                        icon,
                        size: devicewidth! * 0.05,
                      ))));
    // );
  }

  Padding examoption(String value, String answer) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: devicewidth! * 0.05, vertical: devicewidth! * 0.025),
      child: Container(
        // height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
            border: correctOption == value
                ? Border.all(color: Appcolor.darkblue)
                : Border.all(color: Appcolor.blue),
            borderRadius: BorderRadius.circular(10)),
        child: Row(children: [
          Padding(
              padding: EdgeInsets.all(devicewidth! * 0.01),
              child: Container(child: questionoptions(value))),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(devicewidth! * 0.01),
              child: buildtext(
                  maxlines: 100, text: answer, fontsize: devicewidth! * 0.04),
            ),
          ),
        ]),
      ),
    );
  }

  SizedBox questionnumberlist(int value) {
    return SizedBox(
      // color: Appcolor.selectionblue,
      width: double.infinity,
      height: devicewidth! * 0.3,
      child: Row(
        children: [
          Expanded(
            child: CustomListViewBuilder(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              itemCount: value,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: const EdgeInsets.all(5),
                    child: questionnumberwidget(
                        '${index + 1}', (currentIndex + 1).toString()));
              },
            ),
          )
        ],
      ),
    );
  }

  Container questionnumberwidget(String value, String currentIndex) {
    return Container(
      width: devicewidth! * 0.1, // Width of the circle
      height: devicewidth! * 0.1, // Height of the circle
      decoration: BoxDecoration(
        border:
            currentIndex == value ? Border.all(color: Appcolor.darkblue) : null,
        shape: BoxShape.circle,
        gradient: currentIndex == value
            ? const LinearGradient(
                colors: [Appcolor.white, Appcolor.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : const LinearGradient(
                colors: [Appcolor.white, Appcolor.selectionblue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
      ),
      child: Center(
          child: buildtext(text: 'Q$value', fontsize: devicewidth! * 0.04)),
    );
  }

  Container questionoptions(
    String value,
  ) {
    return Container(
      width: devicewidth! * 0.1, // Width of the circle
      height: devicewidth! * 0.1, // Height of the circle
      decoration: const BoxDecoration(
        // border:
        //     currentIndex == value ? Border.all(color: Appcolor.darkblue) : null,
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Appcolor.white, Appcolor.selectionblue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child:
          Center(child: buildtext(text: value, fontsize: devicewidth! * 0.04)),
    );
  }

  Future<void> _getquestions(String id) async {
    final result = await startexam(id);

    if (result != null) {
      setState(() {
        examdata = result.exam;
        questions = result.data!;
        loading = true;
        loading2 = true;
      });
    } else {
      // Navigator.pushReplacementNamed(context, '/welcoepage');
      setState(() {
        timerfinished = true;
      });

      showSubscriptionActiveSnackBar(
          context, 'Something went wrong Please try again later');
    }

    // print('sujith ${questions.length}');
    // print('sujith ${questions.toString()}');
  }

  _previous() {
    print(currentIndex);
    if (currentIndex > 0) {
      print(currentIndex);
      setState(() {
        currentIndex = currentIndex - 1;
      });
    } else {
      showSubscriptionActiveSnackBar(context, 'Already on first question');
    }
  }

  Future<void> _next() async {
    if (currentIndex + 1 <= questions.length && correctOption.isNotEmpty) {
      setState(() {
        loading = false;
      });
      String? result = await nextquestion(examdata!.id.toString(),
          correctOption, questions[currentIndex].id.toString());
      print('result $result');
      if (result == 'Successfully') {
        setState(() {
          correctOption = '';

          // print('$correctOption');
          currentIndex = currentIndex + 1;
          // print('$currentIndex');
          loading = true;
          //  print('$loading');
        });
      } else if (result == 'Something wrong') {
        setState(() {
          correctOption = '';

          // print('$correctOption');
          currentIndex = currentIndex + 1;
          // print('$currentIndex');
          loading = true;
          //  print('$loading');
        });

        // showSubscriptionActiveSnackBar(
        //     context, 'Something went the answer may be stored');
      }
    } else {
      showSubscriptionActiveSnackBar(
          // ignore: use_build_context_synchronously
          context,
          'Please Select a answer to continue');
    }
  }

  void handleTimerFinish(bool finished) {
    setState(() {
      timerfinished = finished;
    });
    // Do something with the variable `timerFinished` when the timer finishes
  }

  void _clear() {
    if (correctOption.isNotEmpty) {
      setState(() {
        correctOption = '';
      });
      showSubscriptionActiveSnackBar(
          // ignore: use_build_context_synchronously
          context,
          'Answer clear successfully');
    } else {
      showSubscriptionActiveSnackBar(
          // ignore: use_build_context_synchronously
          context,
          'Select an answer to clear');
    }
  }

  Future<void> _skip() async {
    if (currentIndex + 1 <= questions.length && correctOption.isEmpty) {
      setState(() {
        loading = false;
      });
      String? result = await nextquestion(
          examdata!.id.toString(), '', questions[currentIndex].id.toString());
      if (result == 'Successfully') {
        setState(() {
          currentIndex = currentIndex + 1;
          loading = true;
        });
      } else if (result == 'Something wrong') {
        setState(() {
          currentIndex = currentIndex + 1;
          loading = true;
        });
      }
    } else {
      showSubscriptionActiveSnackBar(
          context, 'please clear the selection to skip');
    }
  }

  _examcomplete() {
    Navigator.pushReplacementNamed(context, '/examcomplete');
  }

  Widget finalSubmitButton({required String text, required bool tapped}) {
    return Container(
      height: devicewidth! * 0.125,
      width: devicewidth! * .4,
      decoration: BoxDecoration(
        color: Appcolor.darkblue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: tapped
          ? const SpinKitFadingCircle(
              color: Appcolor.blue,
              size: 30.0,
              // lineWidth: 3.0,
            )
          : Center(
              child: Text(text,
                  style: TextStyle(
                      color: Appcolor.white,
                      fontWeight: FontWeight.w900,
                      fontSize: devicewidth! * 0.04)),
            ),
    );
  }
}

class CountdownTimer extends StatefulWidget {
  final int time;
  final Function(bool) onTimerFinish; // Callback function

  const CountdownTimer({
    Key? key,
    required this.time,
    required this.onTimerFinish,
  }) : super(key: key);

  @override
  CountdownTimerState createState() => CountdownTimerState();
}

class CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  late int _countdown; // Initial countdown value in seconds

  @override
  void initState() {
    super.initState();
    // _countdown = 10;
    _countdown = widget.time * 60; // Convert minutes to seconds
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_countdown == 0) {
          timer.cancel();
          // Invoke callback with true when timer finishes
          widget.onTimerFinish(true);
        } else {
          setState(() {
            _countdown--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      // width: 100,
      // height: 50,
      child: TextButton.icon(
        onPressed: () {},
        icon: Icon(
          Icons.access_time_sharp,
          color: Colors.grey,
        ),
        label: Text(
          ' ${_countdown ~/ 60} : ${_countdown % 60}  ', // Displaying minutes and seconds
          style: TextStyle(fontSize: devicewidth! * 0.04, color: Colors.black),
        ),
      ),
    );
  }
}
