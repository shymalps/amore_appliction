import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:amore_student_erp/others/clors.dart';
import 'package:amore_student_erp/others/constants.dart';

class Audioplayer extends StatefulWidget {
  // final String url;
  const Audioplayer({
    key,
    // required this.url,
  }) : super(key: key);
  @override
  AudioplayerState createState() => AudioplayerState();
}

class AudioplayerState extends State<Audioplayer> {
  AudioPlayer audioPlayer = AudioPlayer();
  Duration _duration = Duration();
  Duration _position = Duration();
  bool isPlaying = false;
  late String url;
  //     'https://databackupservices.sgp1.digitaloceanspaces.com/klass/audios/(1712308079)testaudio.mp3';

  @override
  void initState() {
    super.initState();

    audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        _duration = duration;
      });
    });

    audioPlayer.onPositionChanged.listen((Duration position) {
      setState(() {
        _position = position;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    url = ModalRoute.of(context)!.settings.arguments as String;
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Audio Player'),
      // ),
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(gradient: AppGradients.background),
          // color: Colors.amber,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          // child: Image.asset(
          //   'assets/backgroundlms.jpg',
          //   fit: BoxFit.cover,
          // ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width * 0.01,
          right: MediaQuery.of(context).size.width * 0.01,
          top: MediaQuery.of(context).size.height * 0.1,
          child: Column(children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)),
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  child: isPlaying
                      ? Image.asset(audioplay)
                      // LottieBuilder.asset(
                      //     'assets/audioplayjson.json',
                      //     width: 200,
                      //     height: 200,
                      //   )
                      : Image.asset(audioplay)),
            ),
            SizedBox(
              height: 50,
            ),
            Slider(
              activeColor: Colors.orange,
              value: _position.inMilliseconds.toDouble(),
              min: 0.0,
              max: _duration.inMilliseconds.toDouble(),
              onChanged: (double value) {
                seekToPosition(value);
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ' ${_position.inMinutes}:${(_position.inSeconds % 60).toString().padLeft(2, '0')}',
                  ),
                  Text(
                    ' ${_duration.inMinutes}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}',
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton.outlined(
                    color: Colors.orange,
                    iconSize: 80,
                    onPressed: () {
                      if (isPlaying) {
                        pauseAudio();
                      } else {
                        playAudio();
                      }
                    },
                    icon: isPlaying
                        ? Icon(Icons.pause_circle_filled_rounded)
                        : Icon(Icons.play_circle_filled_rounded)
                    // isPlaying ?Icons.play_circle :Icons.pause_circle
                    ),
              ],
            ),
          ]),
        ),
      ]),
    );
  }

  Future<void> playAudio() async {
    // String url =
    //     "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3";
    try {
      await audioPlayer.play(UrlSource(url));
      // await audioPlayer.play(url);
      setState(() {
        isPlaying = true;
      });
      print("Audio played successfully");
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  void pauseAudio() {
    audioPlayer.pause();
    setState(() {
      isPlaying = false;
      setState(() {
        isPlaying = false;
      });
    });
  }

  void stopAudio() {
    audioPlayer.stop();
  }

  void seekToPosition(double value) {
    Duration duration = Duration(milliseconds: value.toInt());
    audioPlayer.seek(duration);
  }
}

/////////////////////////////////////////////////////////////////////////

// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';

// import 'package:lottie/lottie.dart';

// class audioplayer extends StatefulWidget {
//   // final url;
//   audioplayer({
//     key,
//   }) : super(key: key);
//   @override
//   _audioplayerState createState() => _audioplayerState();
// }

// class _audioplayerState extends State<audioplayer> {
//   AudioPlayer audioPlayer = AudioPlayer();
//   Duration _duration = Duration();
//   Duration _position = Duration();
//   bool isPlaying = false;

//   @override
//   void initState() {
//     super.initState();

//     audioPlayer.onDurationChanged.listen((Duration duration) {
//       setState(() {
//         _duration = duration;
//       });
//     });

//     audioPlayer.onPositionChanged.listen((Duration position) {
//       setState(() {
//         _position = position;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     audioPlayer.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('Audio Player'),
//       // ),
//       body: Stack(children: [
//         Container(
//             // color: Colors.amber,
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,
//             child: Image.asset(
//               'assets/backgroundlms.jpg',
//               fit: BoxFit.cover,
//             )),
//         Positioned(
//           left: MediaQuery.of(context).size.width * 0.01,
//           right: MediaQuery.of(context).size.width * 0.01,
//           top: MediaQuery.of(context).size.height * 0.1,
//           child: Column(children: [
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 15),
//               child: Container(
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(25)),
//                   height: MediaQuery.of(context).size.height * 0.5,
//                   width: MediaQuery.of(context).size.width,
//                   child: isPlaying
//                       ? LottieBuilder.asset(
//                           'assets/audioplayjson.json',
//                           width: 200,
//                           height: 200,
//                         )
//                       : Image.asset('assets/audio default icon.png')),
//             ),
//             SizedBox(
//               height: 50,
//             ),
//             Slider(
//               activeColor: Colors.orange,
//               value: _position.inMilliseconds.toDouble(),
//               min: 0.0,
//               max: _duration.inMilliseconds.toDouble(),
//               onChanged: (double value) {
//                 seekToPosition(value);
//               },
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     ' ${_position.inMinutes}:${(_position.inSeconds % 60).toString().padLeft(2, '0')}',
//                   ),
//                   Text(
//                     ' ${_duration.inMinutes}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}',
//                   ),
//                 ],
//               ),
//             ),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 IconButton.outlined(
//                     color: Colors.orange,
//                     iconSize: 80,
//                     onPressed: () {
//                       if (isPlaying) {
//                         pauseAudio();
//                       } else {
//                         playAudio();
//                       }
//                     },
//                     icon: isPlaying
//                         ? Icon(Icons.pause_circle_filled_rounded)
//                         : Icon(Icons.play_circle_filled_rounded)
//                     // isPlaying ?Icons.play_circle :Icons.pause_circle
//                     ),
//               ],
//             ),
//           ]),
//         ),
//       ]),
//     );
//   }

//   Future<void> playAudio() async {
//     String url =
//         "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3";
//     try {
//       await audioPlayer.play(UrlSource(url));
//       // await audioPlayer.play(url);
//       setState(() {
//         isPlaying = true;
//       });
//       print("Audio played successfully");
//     } catch (e) {
//       print("Error playing audio: $e");
//     }
//   }

//   void pauseAudio() {
//     audioPlayer.pause();
//     setState(() {
//       isPlaying = false;
//       setState(() {
//         isPlaying = false;
//       });
//     });
//   }

//   void stopAudio() {
//     audioPlayer.stop();
//   }

//   void seekToPosition(double value) {
//     Duration duration = Duration(milliseconds: value.toInt());
//     audioPlayer.seek(duration);
//   }
// }
