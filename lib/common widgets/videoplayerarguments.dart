import 'package:amore_student_erp/models/videomodel/datum.dart';

class usernamepass {
  String username;
  String password;

  usernamepass(this.username, this.password);
}

class Videoplayerarguments {
  final String videourl;
  final String videoname;
  final String date;
  final int index;
  final List<Videoitem> videos;

  // Add more fields as needed

  Videoplayerarguments(
      this.videourl, this.videoname, this.date, this.index, this.videos);
}

// import 'package:amore_student_erp/models/videomodel/datum.dart';

class Assignmentarguments {
  final String? subId;
  final String subName;
  // final String date;
  // final int index;
  // final List<Videoitem> videos;

  // Add more fields as needed

  Assignmentarguments(
    this.subId,
    this.subName,
  );
}

class Assignmentuploadarguments {
  final String assignmentid;
  final String title;
  final String qus;
  final String totalmark;
  final String questionfile;
  final String teacherName;
  // final List<Videoitem> videos;

  // Add more fields as needed

  Assignmentuploadarguments(
    this.assignmentid,
    this.title,
    this.qus,
    this.totalmark,
    this.questionfile,
    this.teacherName,
  );
}
