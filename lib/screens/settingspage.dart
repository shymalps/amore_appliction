import 'dart:async';

import 'package:flutter/material.dart';
import 'package:amore_student_erp/common%20widgets/commonappbar.dart';
import 'package:amore_student_erp/common%20widgets/textwidget.dart';
import 'package:amore_student_erp/others/clors.dart';
import 'package:amore_student_erp/others/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Appcolor.darkblue,
        appBar: commonappbar(context: context, title: 'Settings'),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(largeradius)),
                color: Appcolor.white),
            child: SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.only(top: deviceheight! * 0.05),
                  child: SizedBox(
                      height: deviceheight! * 0.2,
                      width: deviceheight! * 0.2,
                      child: profileimage(
                        image: menavathar,
                        border: true,
                        circle: false,
                      )),
                ),
                // SizedBox(
                //   height: deviceheight! * 0.02,
                // ),
                // const settinglistitem(
                //   text: 'Manage Password',
                // ),
                // SizedBox(
                //   height: deviceheight! * 0.02,
                // ),
                // const settinglistitem(
                //   text: 'Feedback',
                // ),
                SizedBox(
                  height: deviceheight! * 0.02,
                ),
                GestureDetector(
                  onTap: () => launchUrl(Uri.parse(
                      'https://sites.google.com/view/amorelearning-privacy')),
                  child: const settinglistitem(
                    text: 'Privacy Policy',
                  ),
                ),
                SizedBox(
                  height: deviceheight! * 0.02,
                ),
                // GestureDetector(
                //   onTap: () => launchUrl(Uri.parse(
                //       'https://klass-erp.alp-ts.in/index.php?login/terms')),
                //   child: const settinglistitem(
                //     text: 'Teerms & Conditions',
                //   ),
                // ),
              ]),
            )));
  }
}

void _launchURL(String url) async {
  Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $url';
  }
}

class settinglistitem extends StatelessWidget {
  final String text;
  const settinglistitem({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: devicewidth! * 0.08),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Appcolor.selectionblue),
          color: Appcolor.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
            padding: EdgeInsets.all(devicewidth! * 0.025),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildtext(
                    text: text,
                    fontsize: devicewidth! * 0.05,
                  ),
                  Icon(Icons.arrow_forward_ios_rounded)
                ])),
      ),
    );
  }
}

class profileimage extends StatefulWidget {
  final String image;
  final bool border;
  final bool circle;
  const profileimage({
    super.key,
    required this.image,
    required this.border,
    required this.circle,
  });

  @override
  State<profileimage> createState() => _profileimageState();
}

class _profileimageState extends State<profileimage> {
  List<Color> gradientColors = [Colors.blue, Colors.green];
  int colorIndex = 0;
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        colorIndex = (colorIndex + 1) % gradientColors.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      // width: devicewidth!,
      // height: devicewidth!,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              gradientColors[colorIndex],
              gradientColors[(colorIndex + 1) % gradientColors.length],
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          // color:widget.circle? Appcolor.blue:null,
          shape: BoxShape.circle,
          border: widget.border
              ? null
              // Border.all(
              //         color: Appcolor.white,
              //         width: 4.0,
              //       )
              : null),
      duration: const Duration(seconds: 3),
      child: ClipOval(
        child: FadeInImage.assetNetwork(
          placeholder: menavathar, // Placeholder image path
          image: widget.image, // URL of the image
          fit: BoxFit.cover,
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset(
              menavathar, // Fallback asset image path
              fit: BoxFit.cover,
            );
          },
        ),

        // Image.network(
        //   widget.image,
        //   fit: BoxFit.cover,
        // ),
      ),
    );
  }
}
