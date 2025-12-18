import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:amore_student_erp/common%20widgets/commonappbar.dart';
import 'package:amore_student_erp/common%20widgets/listviewbuilder.dart';
import 'package:amore_student_erp/common%20widgets/pdfnamecleaner.dart';
import 'package:amore_student_erp/common%20widgets/snakbar.dart';
import 'package:amore_student_erp/common%20widgets/tabbarbuilder.dart';
import 'package:amore_student_erp/common%20widgets/textwidget.dart';
import 'package:amore_student_erp/common%20widgets/timestampconvert.dart';
import 'package:amore_student_erp/common%20widgets/videoplayerarguments.dart';
import 'package:amore_student_erp/datalayer.dart/apicalls.dart';
import 'package:amore_student_erp/models/audiomodel/datum.dart';
import 'package:amore_student_erp/models/notesmodel/datum.dart';
import 'package:amore_student_erp/models/videomodel/datum.dart';
import 'package:amore_student_erp/others/clors.dart';
import 'package:amore_student_erp/others/constants.dart';

class Studymaterialslisting extends StatefulWidget {
  const Studymaterialslisting({super.key});

  @override
  State<Studymaterialslisting> createState() => _StudymaterialslistingState();
}

class _StudymaterialslistingState extends State<Studymaterialslisting>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String topicId = '';

  final _selectedColor = Appcolor.darkblue;
  final _unselectedColor = Appcolor.black;
  final _tabs = const [
    Tab(child: Text('Videos')),
    Tab(child: Text('Audios')),
    Tab(child: Text('Notes')),
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (topicId == '') {
      topicId = ModalRoute.of(context)!.settings.arguments as String;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.darkblue,
      appBar: commonappbar(context: context, title: 'Study Materials'),
      body: SafeArea(
          child: Container(
        width: double.infinity,
        // height: ,
        decoration: BoxDecoration(
            // color: Appcolor.white,
            gradient: AppGradients.background,
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(largeradius))),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBar(
                controller: _tabController,
                labelColor: _selectedColor,
                unselectedLabelColor: _unselectedColor,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: MaterialDesignIndicator(
                  indicatorHeight: 6,
                  indicatorColor: _selectedColor,
                ),
                tabs: _tabs,
              ),
              Expanded(
                  child: TabBarView(
                controller: _tabController,
                children: [
                  videotab(
                    topicId: topicId,
                  ),
                  Audiolisttab(
                    topicId: topicId,
                  ),
                  Notelisttab(
                    topicId: topicId,
                  )
                ],
              )),
            ],
          ),
        ),
      )),
    );
  }
}

class videotab extends StatefulWidget {
  final String topicId;
  const videotab({
    super.key,
    required this.topicId,
  });

  @override
  State<videotab> createState() => _videotabState();
}

class _videotabState extends State<videotab> {
  bool loading = false;
  bool nodata = false;
  List<Videoitem>? videos;
  @override
  void initState() {
    super.initState();
    _getvideo();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? videos == null
            ? const Center(child: Text('No data found'))
            : Container(
                color: Appcolor.transparent,
                height: double.infinity,
                width: double.infinity,
                child: Column(children: [
                  Expanded(
                    child: CustomListViewBuilder(
                      itemCount: videos!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, '/videoplayer',
                                arguments: Videoplayerarguments(
                                    videos![index].name ?? '',
                                    videos![index].videoname ?? '',
                                    videos![index].createdAt ?? '',
                                    index,
                                    videos!)),
                            child: studymateriallistitem(
                              heading: videos![index].videoname ?? '',
                              size: videos![index].fileSizeMb == null
                                  ? ''
                                  : '${videos![index].fileSizeMb} MB',
                              date: timeconvert(videos![index].createdAt),
                              icon: videoicon,
                            ));
                      },
                    ),
                  ),
                ]),
              )
        : nodata
            ? const Center(child: Text('No data found'))
            : const Center(
                child: SpinKitCircle(
                  color: Appcolor.darkblue,
                  size: 75.0,
                  // lineWidth: 3.0,
                ),
              );
  }

  _getvideo() async {
    final data = await getvideos(
      'video',
      widget.topicId,
    );
    if (data != null) {
      if (data.data != null) {
        setState(() {
          loading = true;
          videos = data.data;
        });
      }
    } else {
      setState(() {
        nodata = true;
      });
    }
  }
}

class Audiolisttab extends StatefulWidget {
  final String topicId;
  const Audiolisttab({
    super.key,
    required this.topicId,
  });

  @override
  State<Audiolisttab> createState() => _AudiolisttabState();
}

class _AudiolisttabState extends State<Audiolisttab> {
  bool loading = false;
  bool nodata = false;
  List<Audiolist>? audios;
  @override
  void initState() {
    super.initState();
    _getaudio();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? audios == null
            ? const Center(child: Text('No data found'))
            : Container(
                color: Appcolor.transparent,
                height: double.infinity,
                width: double.infinity,
                child: Column(children: [
                  Expanded(
                    child: CustomListViewBuilder(
                      itemCount: audios!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, '/audioplayer',
                                arguments: audios![index].name),

                            // onTap: () =>
                            // Image.asset('asset/images/iconvideo.png')
                            //     Navigator.pushNamed(context, '/topiclist'),
                            child: studymateriallistitem(
                              heading: audios![index].title ?? '',
                              size: audios![index].fileSizeMb ?? '',
                              date: timeconvert(audios![index].createdAt),
                              icon: audioicon,
                            ));
                      },
                    ),
                  ),
                ]),
              )
        : nodata
            ? const Center(child: Text('No data found'))
            : const Center(
                child: SpinKitCircle(
                  color: Appcolor.darkblue,
                  size: 75.0,
                  // lineWidth: 3.0,
                ),
              );
  }

  _getaudio() async {
    final data = await getaudio('audio', widget.topicId);
    if (data != null) {
      if (data.data != null) {
        setState(() {
          loading = true;
          audios = data.data;
        });
      }
    } else {
      setState(() {
        nodata = true;
      });
    }
  }
}

class Notelisttab extends StatefulWidget {
  final String topicId;
  const Notelisttab({
    super.key,
    required this.topicId,
  });

  @override
  State<Notelisttab> createState() => _NotelisttabState();
}

class _NotelisttabState extends State<Notelisttab> {
  bool loading = false;
  bool nodata = false;
  List<Noteitem>? notes = [];
  @override
  void initState() {
    super.initState();
    _getnotes();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Container(
            color: Appcolor.transparent,
            height: double.infinity,
            width: double.infinity,
            // child: Expanded(
            child: CustomListViewBuilder(
              itemCount: notes!.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () => fileopener(index),
                    child: studymateriallistitem(
                      heading: '${notes![index].title}',
                      size: '${notes![index].fileSizeMb} MB',
                      date: '21-02-24',
                      icon: noteicon,
                    ));
              },
            ),
            // ),
          )
        : nodata
            ? const Center(child: Text('No notes found'))
            : const Center(
                child: SpinKitCircle(
                  color: Appcolor.darkblue,
                  size: 75.0,
                  // lineWidth: 3.0,
                ),
              );
  }

  Future<void> _getnotes() async {
    final data = await getnote(
      'notes',
      widget.topicId,
    );

    if (data != null) {
      if (data.data != null) {
        setState(() {
          loading = true;
          notes = data.data;
        });
      }
    } else {
      setState(() {
        nodata = true;
      });
    }
  }

  void fileopener(int index) {
    if (checkFileExtension(cleanresponse(notes![index].fileName), '.pdf') ==
        true) {
      Navigator.pushNamed(context, '/pdfview',
          arguments: cleanresponse(notes![index].fileName));
    } else if (checkFileExtension(
                cleanresponse(notes![index].fileName), '.png') ==
            true ||
        checkFileExtension(cleanresponse(notes![index].fileName), '.jpg') ==
            true ||
        checkFileExtension(cleanresponse(notes![index].fileName), '.jpeg') ==
            true) {
      Navigator.pushNamed(context, '/imageviewer',
          arguments: cleanresponse(notes![index].fileName));
    } else if (checkFileExtension(
                cleanresponse(notes![index].fileName), '.ppt') ==
            true ||
        checkFileExtension(cleanresponse(notes![index].fileName), '.pptx') ==
            true) {
    } else {
      showCustomSnackbar(
        context: context,
        message: 'File type not supported',
        backgroundColor: Appcolor.selectionblue,
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Close',
          textColor: Colors.black,
          onPressed: () {
            // Add your undo logic here
          },
        ),
      );
    }
  }

  bool checkFileExtension(String url, String extension) {
    String lowercaseUrl = url.toLowerCase();
    return lowercaseUrl.endsWith(extension);
  }
}

class studymateriallistitem extends StatelessWidget {
  final String heading;
  final String size;
  final String date;
  final String icon;
  const studymateriallistitem({
    super.key,
    required this.heading,
    required this.size,
    required this.date,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.transparent,
            border: Border(bottom: BorderSide(color: Appcolor.grey, width: 1))),
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    decoration: BoxDecoration(
                        color: Appcolor.blue,
                        borderRadius: BorderRadius.circular(10)),
                    height: 75,
                    // width: 50,

                    child: Center(child: Image.asset(icon))),
              ),
            ),
            Expanded(
                flex: 3,
                child: Container(
                  // height: 75,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildtext(
                            text: heading,
                            fontcolor: Appcolor.black,
                            fontsize: devicewidth! * 0.04),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildtext(
                                  text: size,
                                  fontcolor: Appcolor.black,
                                  fontweight: FontWeight.w200),
                              buildtext(
                                  text: date,
                                  fontcolor: Appcolor.black,
                                  fontweight: FontWeight.w200),
                            ])
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
