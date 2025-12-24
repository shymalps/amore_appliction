import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:amore_student_erp/common%20widgets/textwidget.dart';
import 'package:amore_student_erp/others/clors.dart';
// import 'package:amore_student_erp/screens/loginpage.dart';
import 'package:amore_student_erp/others/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Splash Screen Page
class App_Splashscreen extends StatefulWidget {
  const App_Splashscreen({super.key});

  @override
  State<App_Splashscreen> createState() => _App_SplashscreenState();
}

class _App_SplashscreenState extends State<App_Splashscreen> {
  @override
  void initState() {
    super.initState();
    delayscreen();
  }

  @override
  Widget build(BuildContext context) {
    devicewidth = MediaQuery.of(context).size.width;
    deviceheight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    return Scaffold(
      backgroundColor: Appcolor.black,
      body: SafeArea(
        child: Stack(children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: devicewidth,
                    height: 150,
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Image.asset(halfcircle))),
                SizedBox(height: devicewidth! * 0.4, child: Image.asset(logo)),
                SizedBox(
                  height: 100,
                  child: Transform.rotate(
                    angle: 45 *
                        3.1415927 /
                        1, // Rotation angle in radians (45 degrees in this example)
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Image.asset(halfcircle)),
                  ),
                ),
              ]),
          Positioned(
            bottom: 10,
            child: SizedBox(
                width: devicewidth,
                height: devicewidth! * 0.15,
                child: Center(
                    child: buildtext(
                        text: 'Powerd By Coursenrich',
                        fontcolor: Appcolor.white,
                        fontsize: devicewidth! * 0.03))),
          ),
        ]),
      ),
    );
  }

  void delayscreen() async {
    print('rememberUser: $rememberUser');
    var sharedpref = await SharedPreferences.getInstance();
    rememberUser = sharedpref.getBool(KEYLOGIN);
    classid = sharedpref.getString(clsid);
    studentid = sharedpref.getString(stid);
    sectionId = sharedpref.getString(secid);
    courseid = sharedpref.getString(couid);
    Future.delayed(Duration(seconds: 5), () {
      if (kDebugMode) {
        print('rememberUser2: $rememberUser');
        print('studentid: $studentid');
        print('classid: $classid');
        print('sectionid : $sectionId');
      }

      if (rememberUser == false || rememberUser == null) {
        Navigator.pushReplacementNamed(context, '/loginpage');
      } else {
        Navigator.pushReplacementNamed(context, '/welcoepage');
      }
    });
  }
}
