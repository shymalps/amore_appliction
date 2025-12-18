import 'dart:io';

import 'package:amore_student_erp/screens/invoicepage.dart';
import 'package:amore_student_erp/screens/student_attendance.dart';
import 'package:amore_student_erp/screens/zoomlist.dart';
import 'package:flutter/material.dart';
import 'package:amore_student_erp/others/clors.dart';
import 'package:amore_student_erp/screens/apicheck.dart';
import 'package:amore_student_erp/screens/appdrawer.dart';
import 'package:amore_student_erp/screens/assignmentlistpage.dart';
import 'package:amore_student_erp/screens/assignmentuploadpage.dart';
import 'package:amore_student_erp/screens/audioplayer.dart';
import 'package:amore_student_erp/screens/classroompage.dart';
import 'package:amore_student_erp/screens/examattendpage.dart';
import 'package:amore_student_erp/screens/examcomplete.dart';
import 'package:amore_student_erp/screens/examlist.dart';
import 'package:amore_student_erp/screens/forgetpassword.dart';
import 'package:amore_student_erp/screens/imageviewer.dart';
import 'package:amore_student_erp/screens/liveclassroom.dart';
import 'package:amore_student_erp/screens/loginpage.dart';
import 'package:amore_student_erp/screens/navigationbar.dart';
import 'package:amore_student_erp/screens/pdfviewer.dart';
import 'package:amore_student_erp/screens/profilepage.dart';
import 'package:amore_student_erp/screens/resultview.dart';
import 'package:amore_student_erp/screens/settingspage.dart';
import 'package:amore_student_erp/screens/splashscreen.dart';
import 'package:amore_student_erp/screens/studymaterialslisting.dart';
import 'package:amore_student_erp/screens/timetablepage.dart';
import 'package:amore_student_erp/screens/topiclist.dart';
import 'package:amore_student_erp/screens/videoplayer.dart';
import 'package:get/get.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/loginpage': (context) => const Login_page(),
        '/welcoepage': (context) => Navigationbar(),
        '/classroom': (context) => const classroom_page(),
        '/liveclassroom': (context) => MeetingListScreen(),
        '/profilepage': (context) => const profile_page(),
        '/forgetpassword': (context) => const forgetpassword(),
        '/topiclist': (context) => const topiclist(),
        '/studymaterials': (context) => const Studymaterialslisting(),
        '/timetable': (context) => const TimetableScreen(studentId: ''),
        '/apicheck': (context) => const MyWidget(),
        '/appdrawer': (context) => app_drawer(),
        '/Assignmentlist': (context) => AssignmentList(),
        '/pdfview': (context) => const pdfpage(),
        '/imageviewer': (context) => const ImageViewer(),
        '/videoplayer': (context) => const Videoplayer(),
        '/settings': (context) => const Settings(),
        '/examlist': (context) => const Examlistpage(),
        '/examattendpage': (context) => const Examattendpage(),
        '/examcomplete': (context) => CongratulationPage(),
        '/audioplayer': (context) => const Audioplayer(),
        '/assignmentuploadpage': (context) => const Assignmentuploadpage(),
        '/examresultview': (context) => const Examresultsnew(),
        '/forgetpassword2': (context) => const ForgetpasswordStep2(),
        '/invoicepage': (context) => const InvoicePage(
          // studentId: "26",
        ),
        '/AttendanceScreen': (context) => const AttendanceScreen(
          // studentId: "30",
          // classId: "1",
          // sectionId: "1",
          // courseId: "3",
          // subjectId: "3",
        ),
      },
      title: 'Amore Learning',
      theme: ThemeData(
        appBarTheme: AppBarTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Appcolor.blue),
        useMaterial3: true,
      ),
      home: const App_Splashscreen(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
