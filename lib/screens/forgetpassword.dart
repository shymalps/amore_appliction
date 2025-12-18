import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:amore_student_erp/common%20widgets/snackbar.dart';
import 'package:amore_student_erp/common%20widgets/textwidget.dart';
import 'package:amore_student_erp/common%20widgets/videoplayerarguments.dart';
import 'package:amore_student_erp/common%20widgets/videoplayerarguments.dart';
import 'package:amore_student_erp/datalayer.dart/apicalls.dart';
import 'package:amore_student_erp/models/otpmodel/otpmodel.dart';
import 'package:amore_student_erp/others/clors.dart';
import 'package:amore_student_erp/others/constants.dart';

class forgetpassword extends StatefulWidget {
  const forgetpassword({super.key});

  @override
  State<forgetpassword> createState() => _forgetpasswordState();
}

class _forgetpasswordState extends State<forgetpassword> {
  final TextEditingController _newpasswordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  bool tapped = false;
  // late usernamepass usernamepass;

  @override
  Widget build(BuildContext context) {
    final username = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(gradient: backgroundgradient),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          buildtext(
              text: 'RESET PASSWORD',
              fontweight: FontWeight.bold,
              fontsize: largefontsize),
          const SizedBox(
            height: 15,
          ),
          textfield(
              ctrl: _newpasswordController,
              label: 'New Password',
              password: true),
          const SizedBox(
            height: 15,
          ),
          textfield(
              ctrl: _confirmpasswordController,
              label: 'Confirm Password',
              password: true),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              reset_password(username);
            },
            child: reset_button(
                text: 'Update',
                isSelected: _newpasswordController.text != '' &&
                    _confirmpasswordController.text != '',
                tapped: tapped),
          ),
        ]),
      ),
    ));
  }

  Future<void> reset_password(String usernmame) async {
    if (_confirmpasswordController.text == _newpasswordController.text) {
      // showOtpBottomSheet(context);
      String reponse =
          await updatepassword(usernmame, _newpasswordController.text);
      print(reponse);
      if (reponse == 'success') {
        showSubscriptionActiveSnackBar(
            // ignore: use_build_context_synchronously
            context,
            'Password Updated');
        Navigator.pop(context);
      } else {
        showSubscriptionActiveSnackBar(
            // ignore: use_build_context_synchronously
            context,
            'Password Updation Failed');
      }
    } else {
      showSubscriptionActiveSnackBar(
          // ignore: use_build_context_synchronously
          context,
          'Password does not match');
    }
  }

  Widget reset_button(
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
              color: Appcolor.blue,
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

  void showOtpBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Enter OTP',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                OtpTextField(
                  numberOfFields: 4,
                  borderColor: Appcolor.blue,
                  showFieldAsBox: true,
                  onCodeChanged: (String code) {
                    // Handle validation or event here if needed
                  },
                  onSubmit: (String otp) {
                    // Handle OTP submission here
                    print("OTP Entered: $otp");
                    Navigator.pop(
                        context); // Close bottom sheet after submission
                  },
                ),
                SizedBox(height: 20),
                reset_button(text: 'CONFIRM', isSelected: true, tapped: tapped)
              ],
            ),
          ),
        );
      },
    );
  }
}

class ForgetpasswordStep2 extends StatefulWidget {
  const ForgetpasswordStep2({super.key});

  @override
  State<ForgetpasswordStep2> createState() => ForgetpasswordStep2State();
}

class ForgetpasswordStep2State extends State<ForgetpasswordStep2> {
  // late usernamepass arguments;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool tapped = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(gradient: backgroundgradient),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          buildtext(
              text: 'RESET PASSWORD',
              fontweight: FontWeight.bold,
              fontsize: largefontsize),
          const SizedBox(
            height: 15,
          ),
          textfield(
              ctrl: _usernameController,
              label: 'Enter Username',
              password: false),
          const SizedBox(
            height: 15,
          ),
          //         numberfield(
          // ctrl: _otpController,
          // label: 'Enter OTP',
          //  password: false),
          const SizedBox(
            height: 15,
          ),
          // textfield(
          // ctrl: _confirmpasswordController,
          // label: 'Confirm Password',
          // password: true),
          GestureDetector(
            onTap: () async {
              if (_usernameController.text != '') {
                setState(() {
                  tapped = true;
                });
                String otp = await sentotp();
                print('the otp is $otp');
                setState(() {
                  tapped = false;
                });
                if (otp != '') {
                  showOtpBottomSheet(
                    context,
                    otp,
                  );
                }
                //  showOtpBottomSheet(context);
              } else {
                showSubscriptionActiveSnackBar(
                    // ignore: use_build_context_synchronously
                    context,
                    'Please Enter Username');
              }
            },
            child: reset_button(
                text: 'Sent OTP',
                isSelected: _usernameController.text != '',
                tapped: tapped),
          ),
          // GestureDetector(onTap: () {
          //   reset();
          // },
          //   child: reset_button(
          //                 text: 'Confirm',
          //                 isSelected: _usernameController.text != '' ,
          //                 tapped: tapped
          //                 ),
          // ),
        ]),
      ),
    ));
  }

  Future<String> sentotp() async {
    final data = await otpsend(_usernameController.text);
    if (data == null) {
      showSubscriptionActiveSnackBar(
          // ignore: use_build_context_synchronously
          context,
          'User not exist or not activated');
      return '';
    } else {
      print(data!.message);
      print(data.data.otp);

      return data.data.otp.toString();
    }
  }

  void reset() {
    if (_usernameController.text.contains('@gmail')) {
      Navigator.pushNamed(context, '/forgetpassword');
    } else {
      showSubscriptionActiveSnackBar(
          // ignore: use_build_context_synchronously
          context,
          'username does not match');
    }
  }

  Widget reset_button(
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
              color: Appcolor.blue,
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

  Widget numberfield(
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
        keyboardType: TextInputType.number,
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

  void showOtpBottomSheet(BuildContext context, String value) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        bool isvisible = false;
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Enter OTP',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                OtpTextField(
                  numberOfFields: 4,
                  borderColor: Appcolor.blue,
                  showFieldAsBox: true,
                  onCodeChanged: (String code) {
                    // Handle validation or event here if needed
                  },
                  onSubmit: (String otp) {
                    if (value == otp) {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                        context,
                        '/forgetpassword',
                        arguments: _usernameController.text,
                      );
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("ERROR"),
                              content: Text('Ivalid OTP'),
                            );
                          });
                      //  Navigator.pop(context);
                      //   showSubscriptionActiveSnackBar(
                      //     // ignore: use_build_context_synchronously
                      //     context,
                      //     'Invalid OTP');
                    }
                    // Handle OTP submission here
                    // print("OTP Entered: $otp");
                    // setState(() {
                    //   enteredotp = otp;
                    // });
                    // if(value==otp){
                    //   Navigator.pop(context);
                    // }else{
                    //   showSubscriptionActiveSnackBar(
                    //     // ignore: use_build_context_synchronously
                    //     context,
                    //     'Invalid OTP');
                    // }
                    // Close bottom sheet after submission
                  },
                ),
                SizedBox(height: 20),
                Visibility(
                  visible: isvisible,
                  child: const Text(
                    'Otp is Invalid',
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // print('enteredotp: $enteredotp');
                    // if(value==enteredotp){
                    //   Navigator.pop(context);
                    // }else{
                    //   setState(() {

                    //   });
                    //   showSubscriptionActiveSnackBar(
                    //     // ignore: use_build_context_synchronously
                    //     context,
                    //     'Invalid OTP');
                    // }
                  },
                  child: reset_button(
                      text: 'CONFIRM', isSelected: true, tapped: tapped),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
