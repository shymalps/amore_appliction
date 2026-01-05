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
  bool _obscurePassword = true; // Password visibility state
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  // Form validation states
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: devicewidth! * 0.6,
              child: Image.asset(invertlogo),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // buildtext(
                    //     text: 'SIGN IN',
                    //     fontweight: FontWeight.bold,
                    //     fontsize: largefontsize),
                    const SizedBox(height: 15),
                    textfield(
                      ctrl: _usernameController,
                      label: 'Email',
                      password: false,
                      errorText: _emailError,
                    ),
                    const SizedBox(height: 10),
                    textfield(
                      ctrl: _passwordController,
                      label: 'Password',
                      password: true,
                      errorText: _passwordError,
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        checkingforlogin();
                      },
                      child: signin_button(
                          text: 'Sign in',
                          isSelected: _usernameController.text.isNotEmpty &&
                              _passwordController.text.isNotEmpty,
                          tapped: tapped),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(bottom: 15),
            //       child: SizedBox(
            //           height: devicewidth! * 0.075,
            //           child: GestureDetector(
            //             onTap: () =>
            //                 Navigator.pushNamed(context, '/forgetpassword2'),
            //             child: buildtext(
            //                 text: 'Forgot Password ?',
            //                 fontcolor: Appcolor.black),
            //           )),
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }

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

  Widget textfield({
    required TextEditingController ctrl,
    required String label,
    required bool password,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: devicewidth! * 0.15,
          child: TextField(
            controller: ctrl,
            obscureText: password ? _obscurePassword : false,
            onChanged: (value) {
              setState(() {
                // Clear errors when user starts typing
                if (password) {
                  _passwordError = null;
                } else {
                  _emailError = null;
                }
              });
            },
            decoration: InputDecoration(
              label: buildtext(
                text: label,
                fontcolor: Appcolor.black,
                fontsize: 15,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.red, width: 1.5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.red, width: 2.0),
              ),
              filled: true,
              fillColor: Appcolor.white,
              // Add visibility toggle icon for password field
              suffixIcon: password
                  ? IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Appcolor.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    )
                  : null,
            ),
          ),
        ),
        // Display error message below the field
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 4),
            child: Text(
              errorText,
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
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
    final email = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    // Reset errors
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    bool hasError = false;

    // EMAIL VALIDATION
    if (email.isEmpty) {
      setState(() {
        _emailError = "Please enter your email";
      });
      hasError = true;
    } else if (!isValidEmail(email)) {
      setState(() {
        _emailError = "Please enter a valid email address";
      });
      hasError = true;
    }

    // PASSWORD VALIDATION
    if (password.isEmpty) {
      setState(() {
        _passwordError = "Please enter your password";
      });
      hasError = true;
    } else if (!isValidPassword(password)) {
      setState(() {
        _passwordError = "Password must be at least 6 characters";
      });
      hasError = true;
    }

    // If there are validation errors, return without snackbar
    if (hasError) {
      return;
    }

    // 🔄 Show loader
    setState(() {
      tapped = true;
    });

    final logindata = await login(email, password);

    if (logindata != null && logindata.message == 'Login Successfully') {
      saveuserlogin(
        logindata.data!.studentId!,
        logindata.data!.classId!,
        logindata.data!.sectionId!,
      );

      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/welcoepage');
    } else {
      showSubscriptionActiveSnackBar(
          context, 'User not exist or not activated');

      setState(() {
        tapped = false;
        _usernameController.clear();
        _passwordController.clear();
      });
    }
  }

  saveuserlogin(String stuid, clid, seid) async {
    setState(() {
      studentid = stuid;
      classid = clid;
      sectionId = seid;
    });

    var prefs = await SharedPreferences.getInstance();
    await prefs.setBool(KEYLOGIN, true);
    print('saved id is: $studentid, $classid, $sectionId');
    prefs.setString(stid, studentid!);
    prefs.setString(clsid, classid!);
    prefs.setString(secid, sectionId!);
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  bool isValidPassword(String password) {
    return password.length >= 6;
  }
}