import 'package:flutter/material.dart';
import 'package:amore_student_erp/common%20widgets/snackbar.dart';
import 'package:amore_student_erp/common%20widgets/textwidget.dart';
import 'package:amore_student_erp/datalayer.dart/apicalls.dart';
import 'package:amore_student_erp/others/clors.dart';
import 'package:amore_student_erp/others/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login_page extends StatefulWidget {
  const Login_page({super.key});

  @override
  State<Login_page> createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  int selectedindex = 0;
  bool tapped = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    _usernameController.dispose();

    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: backgroundgradient),
        child:
            // SingleChildScrollView(
            // child:
            Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // color: Appcolor.black,
              height: devicewidth! * 0.3,
              child: Image.asset(invertlogo),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildtext(
                        text: 'SIGN IN',
                        fontweight: FontWeight.bold,
                        fontsize: largefontsize),
                    const SizedBox(
                      height: 15,
                    ),
                    textfield(
                        ctrl: _usernameController,
                        label: 'Username',
                        password: false),
                    const SizedBox(
                      height: 10,
                    ),
                    textfield(
                        ctrl: _passwordController,
                        label: 'Password',
                        password: true),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        checkingforlogin();
                      },
                      child: signin_button(
                          text: 'Sign in',
                          isSelected: _usernameController.text != '' ||
                              _passwordController.text != '',
                          tapped: tapped),
                    )
                  ],
                ),
              ),
              // color: Colors.white,
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: SizedBox(
                      // color: Appcolor.black,
                      height: devicewidth! * 0.075,
                      child: GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, '/forgetpassword2'),
                        child: buildtext(
                            text: 'Forgot Password ?',
                            fontcolor: Appcolor.black),
                      )
                      // Image.asset(invertlogo),
                      ),
                ),
              ],
            )
          ],
        ),
        // ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget signin_button(
      {required String text, required bool isSelected, required bool tapped}) {
    return Container(
      height: devicewidth! * 0.125,
      width: devicewidth! * .4,
      decoration: BoxDecoration(
        color: isSelected ? Appcolor.darkblue : Appcolor.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: tapped
          ? const SpinKitFadingCircle(
              color: Appcolor.black,
              size: 30.0,
              // lineWidth: 3.0,
            )
          : Center(
              child: Text(text,
                  style: TextStyle(
                      color: isSelected ? Appcolor.white : Appcolor.black,
                      fontWeight: FontWeight.w900,
                      fontSize: largefontsize)),
            ),
    );
  }

  Widget textfield(
      {required TextEditingController ctrl,
      required String label,
      required bool password}) {
    return SizedBox(
      // decoration: BoxDecoration(
      //   // color: Colors.white,
      //   borderRadius: BorderRadius.circular(8),
      // ),
      height: devicewidth! * 0.15,
      child: TextField(
        controller: ctrl,
        obscureText: password,
        onChanged: (value) {
          setState(() {
            ctrl.text = value;
          });
        },
        decoration: InputDecoration(
          // focusColor: Appcolor.black,
          label: buildtext(
            text: label,
            fontcolor: Appcolor.black,
            fontsize: 15,
            // fontweight: FontWeight.bold,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: Appcolor.white,
        ),
      ),
    );
  }

  Widget Login_type_container({
    required String text,
    required bool isSelected,
  }) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Appcolor.blue),
          color: isSelected ? Appcolor.darkblue : Appcolor.white,
          borderRadius: BorderRadius.circular(10)),
      width: devicewidth! * 0.3,
      height: deviceheight! * 0.075,
      child: Center(
          child: buildtext(
              text: text,
              fontcolor: isSelected ? Appcolor.white : Appcolor.black,
              fontsize: 15,
              fontweight: FontWeight.bold)),
    );
  }

  Future<void> checkingforlogin() async {
    // if (selectedindex == 1 || selectedindex == 2) {
    print('condition1');
    if (_usernameController.text != '' && _passwordController.text != '') {
      setState(() {
        tapped = !tapped;
      });
      print('condition1');
      final logindata =
          await login(_usernameController.text, _passwordController.text);

      // print(logindata!.message);
      // print(_usernameController.text);
      // print(_usernameController.text);

      // clearcontroller();

      if (logindata != null && logindata.message == 'Login Successfully') {
        saveuserlogin(logindata.data!.studentId!, logindata.data!.classId!,
            logindata.data!.sectionId!);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, '/welcoepage');
      } else {
        showSubscriptionActiveSnackBar(
            // ignore: use_build_context_synchronously
            context,
            'User not exist or not activated');
        setState(() {
          tapped = !tapped;
          _usernameController.clear();
          _passwordController.clear();
        });
      }
    } else {
      showSubscriptionActiveSnackBar(
          context, "Login Credentials Can't be empty");
    }
    // } else {
    //   showSubscriptionActiveSnackBar(context, 'Select a Logintype');
    // }
  }

  saveuserlogin(String stuid, clid, seid) async {
    setState(() {
      studentid = stuid;
      classid = clid;
      sectionId = seid;
    });
    // Perform login logic here

    // For example, simulate a login by setting isLoggedIn to true
    var prefs = await SharedPreferences.getInstance();
    await prefs.setBool(KEYLOGIN, true);
    print('saved id is: $studentid, $classid, $sectionId');
    prefs.setString(stid, studentid!);
    prefs.setString(clsid, classid!);
    prefs.setString(secid, sectionId!);
    // var sharedPref = await SharedPreferences.getInstance();
  }
}
