import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:amore_student_erp/common%20widgets/commonappbar.dart';
import 'package:amore_student_erp/common%20widgets/listviewbuilder.dart';
import 'package:amore_student_erp/common%20widgets/textwidget.dart';
import 'package:amore_student_erp/common%20widgets/videoplayerarguments.dart';
import 'package:amore_student_erp/others/clors.dart';
import 'package:amore_student_erp/others/constants.dart';
import 'package:amore_student_erp/screens/studymaterialslisting.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class Videoplayer extends StatefulWidget {
  const Videoplayer({super.key});

  @override
  State<Videoplayer> createState() => _VideoplayerState();
}

class _VideoplayerState extends State<Videoplayer> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  late Videoplayerarguments videoargument;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    videoargument =
        ModalRoute.of(context)!.settings.arguments as Videoplayerarguments;
    _videoPlayerController = VideoPlayerController.network(
        videoargument.videourl
        // "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"

        );
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9, // Adjust as needed
      autoPlay: true,
      looping: false,
      // Other customization options...
    );
  }

  @override
  void dispose() {
    print('Disposed');
    _videoPlayerController.dispose();
    _chewieController.dispose();
    WakelockPlus.disable();
    // checkwakelock();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final Videoplayerarguments videoargument = ModalRoute.of(context)!.settings.arguments as Videoplayerarguments;
    return Scaffold(
      appBar: commonappbar(context: context, title: 'Video Player'),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            videoplayerscreen(
                chewieController: _chewieController,
                videoargument: videoargument),
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: devicewidth! * 0.01,
                    horizontal: devicewidth! * 0.05),
                child: buildtext(
                    text: 'Recent Videos', fontsize: devicewidth! * 0.06)),
            videoargument.videos.isNotEmpty
                ? Expanded(
                    child: CustomListViewBuilder(
                      itemCount: videoargument.videos.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == videoargument.index) {
                          return const SizedBox
                              .shrink(); // Returns an empty widget
                        }
                        return GestureDetector(
                            onTap: () {
                              _videoPlayerController.dispose();
                              _chewieController.dispose();
                              //                       print('sujith${videoargument.videos[index].name!}');

                              // print(' dispose');
                              Navigator.pushNamed(context, '/videoplayer',
                                  arguments: Videoplayerarguments(
                                      videoargument.videos[index].name ?? '',
                                      videoargument.videos[index].videoname ??
                                          '',
                                      videoargument.videos[index].createdAt ??
                                          '',
                                      index,
                                      videoargument.videos));
                            },
                            child: studymateriallistitem(
                              heading: videoargument.videos[index].videoname!,
                              size:
                                  '${videoargument.videos[index].fileSizeMb}MB' ??
                                      '',
                              date: '21-05-24',
                              icon: videoicon,
                            ));
                      },
                    ),
                  )
                : Center(
                    child: buildtext(text: 'No Recent videos found'),
                  )

            // Text(videoargument.videoname),
            // Text(videoargument.videourl),
            // Text(videoargument.date),Text(videoargument.index.toString()),
          ],
        ),
      ),
    );
  }
}

class videoplayerscreen extends StatelessWidget {
  const videoplayerscreen({
    super.key,
    required ChewieController chewieController,
    required this.videoargument,
  }) : _chewieController = chewieController;

  final ChewieController _chewieController;
  final Videoplayerarguments videoargument;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: Chewie(
            controller: _chewieController,
          ),
        ),
        Container(
          decoration: const BoxDecoration(color: Appcolor.lightblue),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              const CircleAvatar(
                radius: 25, // Adjust the size as needed
                // backgroundImage: NetworkImage(
                //   '',
                // ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: buildtext(
                    text: videoargument.videoname, fontcolor: Appcolor.white),
              )
            ]),
          ),
        )
      ]),
    );
  }
}
