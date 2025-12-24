import 'package:flutter/cupertino.dart';

/////////////////////Asset images
String logo = 'asset/images/applogo.png';
String invertlogo = 'asset/images/applogo.png';
String menavathar = 'asset/images/3davatharmen.png';
String girlavthar = 'asset/images/3davatharwomen.png';
String assesment = 'asset/images/assesment.png';
String assingnment = 'asset/images/assignment.png';
String classroom = 'asset/images/classroomicon.png';
String liveclass = 'asset/images/liveclassicon.png';
String messenger = 'asset/images/messenger.png';
String settings = 'asset/images/settings.png';
String timetable = 'asset/images/timetable.png';
String halfcircle = 'asset/images/halfcircle.png';
String clipboard = 'asset/images/clipboardicon.png';
String videoicon = 'asset/images/iconvideo.png';
String audioicon = 'asset/images/iconaudio.png';
String noteicon = 'asset/images/iconnote.png';
String gotostudyicon = 'asset/images/Storytelling.png';
String assignmenticon = 'asset/images/Sign Document.png';
String ecamicon = 'asset/images/Pass Fail.png';
String profileicon = 'asset/images/Client Management.png';
String announcementIcon = 'asset/images/Megaphone.png';
String certificateborder = 'asset/images/certificateborder.png';
String audioplay = 'asset/images/audio default icon.png';
String nottificationanimation = 'asset/images/nottification.gif';
String invoice = 'asset/images/invoice.png';
String attendanceicon = 'asset/images/attendence.png';
///////////////////////////////////////comon sizes
double? deviceheight;
double? devicewidth;
int comonpadding = 10;

double comonfontsize = 15;
double largefontsize = 20;
double smallfontsize = 12;
double commonradius = 15;
double largeradius = 25;
double extralarge = 24;

//////////////////////////////////////////////////////////////////
LinearGradient backgroundgradient = const LinearGradient(
  colors: [Color.fromRGBO(255, 255, 255, 1), Color.fromRGBO(229, 245, 125, 1)],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

String baseurl = 'https://live.amorelearningschool.com/index.php?api';

////////////////////////////////////////////
///for save userlogin

const String KEYLOGIN = 'login';
const String stid = 'stu_id';
const String clsid = 'cls_id';
const String secid = 'sec_id';
const String couid = 'cou_id';
bool? rememberUser;
String? studentid;
String? classid;
String? sectionId;
String? courseid;
