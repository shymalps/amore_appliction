import 'package:flutter/material.dart';
import 'package:amore_student_erp/common%20widgets/textwidget.dart';
import 'package:amore_student_erp/datalayer.dart/apicalls.dart';
import 'package:amore_student_erp/models/examresultmodel/examresultmodel.dart';
import 'package:amore_student_erp/others/clors.dart';
import 'dart:async';

import 'package:amore_student_erp/others/constants.dart';
import 'package:lottie/lottie.dart';

class CongratulationPage extends StatefulWidget {
  @override
  _CongratulationPageState createState() => _CongratulationPageState();
}

class _CongratulationPageState extends State<CongratulationPage> {
  double _opacity = 1.0;
  bool _showContainer = false;
  Examresultmodel exresult = Examresultmodel();
  int skip = 0;
  String examid = '';

  @override
  void initState() {
    super.initState();
    // Start the animation after a delay
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _opacity = 0.0;
      });

      // Wait for the fade-out animation to complete, then switch to the container
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _showContainer = true;
        });
      });
    });
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    examid = ModalRoute.of(context)!.settings.arguments as String;
    // Retrieve the subjectId when dependencies change
    getresults(examid != null ? examid : '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: AppGradients.background),
        child: Center(
          child: _showContainer
              ? _buildContainer()
              : _buildCongratulationMessage(),
        ),
      ),
    );
  }

  Widget _buildCongratulationMessage() {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(seconds: 1),
      child: Center(
        child: Stack(
          children: [
            Lottie.asset('asset/images/examcomplete.json'),
            Positioned(
              top: devicewidth! * 0.3,
              left: devicewidth! * 0.1,
              child: buildtext(
                  text: 'Congratulations',
                  fontsize: devicewidth! * 0.1,
                  fontcolor: Appcolor.darkblue),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContainer() {
    return Padding(
      padding: EdgeInsets.all(devicewidth! * 0.05),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          decoration: BoxDecoration(
              color: Appcolor.white, border: Border.all(color: Appcolor.grey)),
          width: double.infinity,
          height: devicewidth! * 0.65,
          // color: Colors.green,
          child: Stack(children: [
            Column(
              children: [
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Center(child: null
                            // buildtext(
                            //     text: 'Your Mark\n ${exresult.fResult!.totalMark}/${exresult.data!.length}',
                            //     fontsize: devicewidth! * 0.04)
                            )),
                    Expanded(
                        flex: 1,
                        child: SizedBox(
                            height: devicewidth! * 0.4,
                            width: devicewidth! * 0.4,
                            child: Lottie.asset(
                                'asset/images/exambadgejson.json'))),
                    Expanded(
                        flex: 1,
                        child: Center(child: null
                            // buildtext(text: 'Time\n 5:00')
                            ))
                  ],
                )),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: Center(child: null
                              // buildtext(
                              //   text: 'Your Mark\n ${exresult.fResult!.totalMark}/${exresult.data!.length}',
                              //   fontsize: devicewidth! * 0.04)
                              )),
                      Expanded(
                          child: Center(
                              child: buildtext(
                                  text:
                                      'Your Mark\n ${exresult.fResult!.totalMark}/${exresult.data!.length}',
                                  fontsize: devicewidth! * 0.04))),
                      Expanded(
                          child: Center(child: null
                              // buildtext(
                              //     text: ' Result\n   Pass',
                              //     fontsize: devicewidth! * 0.04)
                              ))
                    ],
                  ),
                )
              ],
            ),
            Image.asset(certificateborder)
          ]),
        ),
        SizedBox(
          height: devicewidth! * 0.05,
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/examresultview',
              arguments: examid),
          child: Container(
            width: double.infinity,
            height: devicewidth! * 0.1,
            decoration: BoxDecoration(
                color: Appcolor.darkblue,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: buildtext(
                    text: 'View Solutions',
                    fontcolor: Appcolor.white,
                    fontsize: devicewidth! * 0.04)),
          ),
        )
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
// import 'package:amore_student_erp/common%20widgets/textwidget.dart';
// import 'package:amore_student_erp/others/clors.dart';
// import 'dart:async';
// import 'package:audioplayers/audioplayers.dart'; // Import audioplayers
// import 'package:amore_student_erp/others/constants.dart';
// import 'package:lottie/lottie.dart';

// class CongratulationPage extends StatefulWidget {
//   @override
//   _CongratulationPageState createState() => _CongratulationPageState();
// }

// class _CongratulationPageState extends State<CongratulationPage> {
//   double _opacity = 1.0;
//   bool _showContainer = false;
//   late AudioPlayer _audioPlayer; // Declare AudioPlayer instance

//   @override
//   void initState() {
//     super.initState();
//     _audioPlayer = AudioPlayer(); // Initialize AudioPlayer

//     // Start the animation after a delay
//     Future.delayed(const Duration(seconds: 2), () {
//       setState(() {
//         _opacity = 0.0;
//       });

//       // Wait for the fade-out animation to complete, then switch to the container
//       Future.delayed(const Duration(seconds: 2), () {
//         setState(() {
//           _showContainer = true;
//         });
//       });
//     });

//     // Play victory sound
//     _playVictorySound();
//   }

//   @override
//   void dispose() {
//     _audioPlayer.dispose(); // Dispose of the audio player
//     super.dispose();
//   }

//   Future<void> _playVictorySound() async {
//     // Play the sound
//     await _audioPlayer.play(AssetSource(
//         'asset/images/success-fanfare-trumpets-6185.mp3')); // Adjust the path if necessary
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: const BoxDecoration(gradient: AppGradients.background),
//         child: Center(
//           child: _showContainer
//               ? _buildContainer()
//               : _buildCongratulationMessage(),
//         ),
//       ),
//     );
//   }

//   Widget _buildCongratulationMessage() {
//     return AnimatedOpacity(
//       opacity: _opacity,
//       duration: const Duration(seconds: 1),
//       child: Center(
//         child: Stack(
//           children: [
//             Lottie.asset('asset/images/examcomplete.json'),
//             Positioned(
//               top: devicewidth! * 0.3,
//               left: devicewidth! * 0.1,
//               child: buildtext(
//                 text: 'Congratulations',
//                 fontsize: devicewidth! * 0.1,
//                 fontcolor: Appcolor.darkblue,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildContainer() {
//     return Padding(
//       padding: EdgeInsets.all(devicewidth! * 0.05),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Appcolor.white,
//           border: Border.all(color: Appcolor.grey),
//         ),
//         width: double.infinity,
//         height: devicewidth! * 0.65,
//         child: Stack(
//           children: [
//             Column(
//               children: [
//                 Expanded(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         flex: 1,
//                         child: Center(
//                           child: buildtext(
//                             text: 'Your Mark\n 20/50',
//                             fontsize: devicewidth! * 0.04,
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 1,
//                         child: SizedBox(
//                           height: devicewidth! * 0.4,
//                           width: devicewidth! * 0.4,
//                           child:
//                               Lottie.asset('asset/images/exambadgejson.json'),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 1,
//                         child: Center(
//                           child: buildtext(text: 'Time\n 5:00'),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Expanded(
//                         child: Center(
//                           child: buildtext(
//                             text: ' Percentage\n       99%',
//                             fontsize: devicewidth! * 0.04,
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: Center(
//                           child: buildtext(
//                               text: 'COMPLETED',
//                               fontsize: devicewidth! * 0.04,
//                               fontcolor: Colors.green,
//                               fontweight: FontWeight.bold),
//                         ),
//                       ),
//                       Expanded(
//                         child: Center(
//                           child: buildtext(
//                             text: ' Result\n   Pass',
//                             fontsize: devicewidth! * 0.04,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             Image.asset(certificateborder),
//           ],
//         ),
//       ),
//     );
//   }
// }
