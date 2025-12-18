import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:amore_student_erp/common%20widgets/commonappbar.dart';
import 'package:amore_student_erp/common%20widgets/textwidget.dart';
import 'package:amore_student_erp/others/clors.dart';
import 'package:amore_student_erp/others/constants.dart';
import 'package:amore_student_erp/screens/appdrawer.dart';

class live_classroom extends StatefulWidget {
  final String heading;
  const live_classroom({super.key, required this.heading});

  @override
  State<live_classroom> createState() => _live_classroomState();
}

class _live_classroomState extends State<live_classroom> {
  final TextEditingController _classidcontroller = TextEditingController();
  String clasroomid = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.darkblue,
      appBar: commonappbar(context: context, title: widget.heading),
      drawer:  app_drawer(),
      body: SafeArea(
          child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Appcolor.white,
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(largeradius))),
        child: Padding(
          padding: EdgeInsets.only(
              left: devicewidth! * 0.1, right: devicewidth! * 0.1),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Appcolor.blue,
                    borderRadius: BorderRadius.circular(commonradius)),
                height: deviceheight! * 0.4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      textfield(
                          ctrl: _classidcontroller,
                          label: 'enter classroom id'),
                      const SizedBox(
                        height: 10,
                      ),
                      join_button(
                          isSelected: clasroomid != '', text: 'Join Section')
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Appcolor.blue,
                    borderRadius: BorderRadius.circular(commonradius)),
                height: 50,
                width: devicewidth,
                child: Center(
                    child: buildtext(
                        text: 'Previous Sessions',
                        fontweight: FontWeight.bold,
                        fontsize: 20)),
              )
            ],
          ),
        ),
      )),
    );
  }

  Widget textfield(
      {required TextEditingController ctrl, required String label}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        height: devicewidth! * 0.1,
        child: TextField(
          onChanged: (value) {
            setState(() {
              clasroomid = ctrl.text;
            });
          },
          controller: ctrl,
          decoration: InputDecoration(
            label: buildtext(text: label),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget join_button({
    required String text,
    required bool isSelected,
  }) {
    return Container(
      height: devicewidth! * 0.1,
      width: devicewidth! * .4,
      // width: 100,
      decoration: BoxDecoration(
        color: isSelected ? Appcolor.darkblue : Appcolor.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: buildtext(
            text: text,
            fontcolor: isSelected ? Appcolor.white : Appcolor.black,
            fontweight: FontWeight.w900,
            fontsize: largefontsize),
      ),
    );
  }
}
