import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:amore_student_erp/models/invoicemodel/invoicemodel.dart';
import 'package:amore_student_erp/models/student_attendance_model/attendance_model.dart';
import 'package:amore_student_erp/models/time_table/time_table.dart';
// import 'package:amore_student_erp/models/timetable_model.dart/time_table.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:amore_student_erp/datalayer.dart/urls.dart';
import 'package:amore_student_erp/models/assignmentmodel/assignmentmodel.dart';
import 'package:amore_student_erp/models/audiomodel/audiomodel.dart';
import 'package:amore_student_erp/models/examlistdata/examlistdata.dart';
import 'package:amore_student_erp/models/examquestionmodel/examquestionmodel.dart';
import 'package:amore_student_erp/models/examresultmodel/examresultmodel.dart';
import 'package:amore_student_erp/models/loginmodel/loginmodel.dart';
import 'package:amore_student_erp/models/notesmodel/notesmodel.dart';
import 'package:amore_student_erp/models/otpmodel/otpmodel.dart';
import 'package:amore_student_erp/models/profileviewmodel/profileviewmodel.dart';
import 'package:amore_student_erp/models/progressbarmodel/progressbarmodel.dart';
import 'package:amore_student_erp/models/subjectmodel/subjectmodel.dart';
import 'package:amore_student_erp/models/timetablemodel/timetablemodel.dart';
import 'package:amore_student_erp/models/topicmodel/topicmodel.dart';
import 'package:amore_student_erp/models/videomodel/videomodel.dart';
import 'package:amore_student_erp/others/constants.dart';

Future<String> updatepassword(String email, String password) async {
  try {
    final response = await post(
      Uri.parse(URLS.updatepassword),
      body: {'email': email, 'password': password},
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      final bodyasjson = jsonDecode(response.body) as Map<String, dynamic>;
      print(response.body);
      if (bodyasjson['status'] == 'success') {
        print(response.body);
        print('object');
        return 'success';
      } else {
        return 'failed';
      }
    } else {
      return 'failed2';
    }
  } catch (e) {
    throw Exception('Failed to fetch dat: $e');
  }
}

Future<InvoiceResponse?> getStudentInvoice(String studentId) async {
  try {
    final url = URLS.invoiceview;

    print(" API CALL for invoice → $url");
    print(" Sending Student ID → $studentId");

    final response = await post(
      Uri.parse(url),
      body: {'student_id': studentId},
    );

    print(" API STATUS CODE → ${response.statusCode}");
    print(" API RAW RESPONSE → ${response.body}");

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      print(" DECODED JSON → $jsonBody");

      if (jsonBody['status'] != 'error') {
        return InvoiceResponse.fromJson(jsonBody);
      } else {
        print(" API Returned Error Status: ${jsonBody['message']}");
      }
    } else {
      print(" API Error: Status Code ${response.statusCode}");
    }
  } catch (e) {
    print(" EXCEPTION → $e");
  }
  return null;
}

Future<AttendanceResponse?> getstudentattendance(
  String studentId,
  String classId,
  String sectionId,
  String courseId,
  String SubjectId,
) async {
  try {
    final url = URLS.studentAttendanceView;
    print(" API CALL IN ATTENDENCES → $url");
    print(" Sending Student ID for attendance → $studentId");

    final response = await post(
      Uri.parse(url),
      body: {
        'student_id': studentId,
        'class_id': classId,
        'section_id': sectionId,
        'course_id': courseId,
        'subject_id': SubjectId,
        
      },
    );

    print(" API STATUS CODE IN ATTENDENCE → ${response.statusCode}");
    print(" API RAW RESPONSE → ${response.body}");

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      print(" DECODED JSON → $jsonBody");

      if (jsonBody['status'] != 'error') {
        return AttendanceResponse.fromJson(jsonBody);
      } else {
        print(" API Returned Error Status: ${jsonBody['message']}");
      }
    } else {
      print(" API Error: Status Code ${response.statusCode}");
    }
  } catch (e) {
    print(" EXCEPTION → $e");
  }
  return null;
}

Future<Loginmodel?> login(String email, String password) async {
  try {
    print('condition1');

    print(URLS.loginurl);
    final response = await post(
      Uri.parse(URLS.loginurl),
      body: {'username': email, 'password': password},
    );

    if (kDebugMode) {
      print(response.statusCode);
      print(response.body);
      print(response.statusCode);
    }

    if (response.statusCode == 200) {
      final bodyasjson = jsonDecode(response.body) as Map<String, dynamic>;
      if (bodyasjson['status'] != 'error') {
        final data = Loginmodel.fromJson(bodyasjson);
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

Future<Loginmodel?> getsinglerowdata(
  String tablename,
  String parameter,
  String studentid,
) async {
  try {
    final response = await post(
      Uri.parse(URLS.gettablesinrow),
      body: {'tname': tablename, 'where': parameter, 'value': studentid},
    );

    if (response.statusCode == 200) {
      final bodyasjson = jsonDecode(response.body) as Map<String, dynamic>;
      if (bodyasjson['status'] != 'error') {
        final data = Loginmodel.fromJson(bodyasjson);
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

// Future<PeriodResponse?> getperioddata(String classid, String sectionid) async {
//   try {
//     final response = await post(
//       Uri.parse(URLS.getperioddata),
//       body: {
//         'class_id': classid,
//         'section_id': sectionid,
//       },
//     );

//     print("API STATUS CODE → ${response.statusCode}");
//     print("API RAW RESPONSE → ${response.body}");

//     if (response.statusCode == 200) {
//       final jsonBody = jsonDecode(response.body);
//       print("DECODED JSON → $jsonBody");

//       if (jsonBody['status'] != 'error') {
//         return PeriodResponse.fromJson(jsonBody);
//       } else {
//         print("API Returned Error: ${jsonBody['message']}");
//         return null;
//       }
//     } else {
//       print("API HTTP Error: ${response.statusCode}");
//       return null;
//     }
//   } catch (e) {
//     print("EXCEPTION → $e");
//     return null;
//   }
// }

Future<PeriodResponse?> getperioddata(String studentId) async {
  try {
    final response = await post(
      Uri.parse(URLS.getperioddata),
      body: {'student_id':studentid },
    );
    print("API CALL → ${URLS.getperioddata}");
    print("SENT student ID → $studentid");

    print("API STATUS → ${response.statusCode}");
    print("API BODY → ${response.body}");

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);

      if (jsonBody['status'] == 'success') {
        return PeriodResponse.fromJson(jsonBody);
      }
    }
    return null;
  } catch (e) {
    print("API ERROR → $e");
    return null;
  }
}

Future<Subjectmodel?> getmultirowdata(
  String tablename,
  String parameter,
  String? clasid,
  String retCount,
  String tWhere,
) async {
  try {
    final response = await post(
      Uri.parse(URLS.gettablemultirow),
      body: {
        'tname': tablename,
        'where': parameter,
        'value': clasid,
        'return_table_count': retCount,
        't_where': tWhere,
      },
    );

    if (response.statusCode == 200) {
      final bodyasjson = jsonDecode(response.body) as Map<String, dynamic>;

      if (bodyasjson['status'] != 'error') {
        final data = Subjectmodel.fromJson(bodyasjson);

        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

Future<Topicmodel?> getmultirowdatatopic(
  String tablename,
  String parameter,
  String? clasid,
  String retCount,
  String tWhere,
) async {
  try {
    final response = await post(
      Uri.parse(URLS.gettablemultirow),
      body: {
        'tname': tablename,
        'where': parameter,
        'value': clasid,
        'return_table_count': retCount,
        't_where': tWhere,
      },
    );

    if (response.statusCode == 200) {
      final bodyasjson = jsonDecode(response.body) as Map<String, dynamic>;

      if (bodyasjson['status'] != 'error') {
        final data = Topicmodel.fromJson(bodyasjson);

        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

Future<Profileviewmodel?> profileview() async {
  try {
    final response = await post(
      Uri.parse(URLS.profileview),
      body: {'student_id': studentid},
    );
    print("-----------------------------------------");
    print(studentid);
    print(response.body);
    if (response.statusCode == 200) {
      final bodyasjson = jsonDecode(response.body) as Map<String, dynamic>;

      if (bodyasjson['status'] != 'error') {
        final data = Profileviewmodel.fromJson(bodyasjson);

        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

Future<Notesmodel?> getnote(String tablename, String? topicid) async {
  try {
    final response = await post(
      Uri.parse(URLS.gettablemultirow),
      body: {
        // 'tname': 'note',
        // 'where': parameter,
        // 'value': topicid,
        'tname': tablename,
        'where': 'topic_id',
        'value': topicid,
      },
    );
    if (kDebugMode) {
      // print(URLS.gettablemultirow);
      // print(response.statusCode);
      // print(response.body);
    }
    if (response.statusCode == 200) {
      final bodyasjson = jsonDecode(response.body) as Map<String, dynamic>;

      if (bodyasjson['status'] != 'error') {
        final data = Notesmodel.fromJson(bodyasjson);
        // print(data.data![1].subjectId);
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    // print(e.toString());
    return null;
  }
}

Future<Videomodel?> getvideos(String tablename, String? topicid) async {
  try {
    final response = await post(
      Uri.parse(URLS.gettablemultirow),
      body: {
        // 'tname': 'note',
        // 'where': parameter,
        // 'value': topicid,
        'tname': tablename,
        'where': 'topic_id',
        'value': topicid,
      },
    );
    if (kDebugMode) {
      // print(URLS.gettablemultirow);
      // print(response.statusCode);
      // print(response.body);
    }
    if (response.statusCode == 200) {
      final bodyasjson = jsonDecode(response.body) as Map<String, dynamic>;

      if (bodyasjson['status'] != 'error') {
        final data = Videomodel.fromJson(bodyasjson);
        // print(data.data![1].subjectId);
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

Future<Audiomodel?> getaudio(String tablename, String? topicid) async {
  try {
    final response = await post(
      Uri.parse(URLS.gettablemultirow),
      body: {
        // 'tname': 'note',
        // 'where': parameter,
        // 'value': topicid,
        'tname': tablename,
        'where': 'topic_id',
        'value': topicid,
      },
    );
    if (kDebugMode) {
      // print(URLS.gettablemultirow);
      // print(response.statusCode);
      // print(response.body);
    }
    if (response.statusCode == 200) {
      final bodyasjson = jsonDecode(response.body) as Map<String, dynamic>;

      if (bodyasjson['status'] != 'error') {
        final data = Audiomodel.fromJson(bodyasjson);
        // print(data.data![1].subjectId);
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

Future<Timetablemodel?> gettimetableview(String day) async {
  try {
    final response = await post(
      Uri.parse(URLS.gettimetable),
      body: {
        // 'tname': 'note',
        // 'where': parameter,
        // 'value': topicid,
        'class_id': classid,
        'section_id': sectionId,
        'day': day,
      },
    );
    if (kDebugMode) {
      // print(URLS.gettablemultirow);
      // print(response.statusCode);
      // print(response.body);
    }
    if (response.statusCode == 200) {
      final bodyasjson = jsonDecode(response.body) as Map<String, dynamic>;

      if (bodyasjson['status'] != 'error') {
        final data = Timetablemodel.fromJson(bodyasjson);
        // print(data.data![1].subjectId);
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

Future<Examlistdata?> getexamlist(String subId) async {
  try {
    final response = await post(
      Uri.parse(URLS.examlist),
      body: {
        // 'user_id': studentid,
        ///giving studentid as statis for checking correct it after
        'user_id': studentid,
        'subject_id': subId,
      },
    );

    if (kDebugMode) {
      // print(subId);
      // print(URLS.examlist);
      // print(response.statusCode);
      // print(response.body);
    }
    if (response.statusCode == 200) {
      final bodyasjson = jsonDecode(response.body) as Map<String, dynamic>;

      if (bodyasjson['status'] != 'error') {
        final data = Examlistdata.fromJson(bodyasjson);
        // print(data.data![1].subjectId);
        return data;
      } else {
        // print('returning null');
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    // print(e.toString());
    return null;
  }
}

Future<String?> nextquestion(String examid, String ans, String qusid) async {
  try {
    final response = await post(
      Uri.parse(URLS.nextquestion),
      body: {
        // 'user_id': studentid,
        ///giving studentid as statis for checking correct it after
        'qnsid': qusid,
        'ans': ans,
        // 'ans':ans,
        'examid': examid,
        'user_id': studentid,
      },
    );

    if (kDebugMode) {
      // print(subId);
      print(examid);
      print(ans);
      print(qusid);
      print(studentid);
      print(URLS.nextquestion);
      print(response.statusCode);
      print(response.body);
    }
    if (response.statusCode == 200) {
      final bodyasjson = jsonDecode(response.body) as Map<String, dynamic>;

      if (bodyasjson['status'] != 'error') {
        final data = bodyasjson['message'];

        // print(data.data![1].subjectId);
        return data;
      } else {
        final data = bodyasjson['message'];
        // print('returning null');
        return data;
      }
    } else {
      return null;
    }
  } catch (e) {
    // print(e.toString());
    return null;
  }
}

Future<Examquestionmodel?> startexam(String exid) async {
  try {
    final response = await post(
      Uri.parse(URLS.startexam),
      body: {
        // 'user_id': studentid,
        ///giving studentid as statis for checking correct it after
        'user_id': studentid,
        'examid': exid,
      },
    );

    if (kDebugMode) {
      print(exid);
      print(URLS.startexam);
      print(response.statusCode);
      print(response.body);
    }
    if (response.statusCode == 200) {
      final bodyasjson = jsonDecode(response.body) as Map<String, dynamic>;

      if (bodyasjson['status'] != 'error') {
        final data = Examquestionmodel.fromJson(bodyasjson);
        // print(data.data![1].subjectId);
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    // print(e.toString());
    return null;
  }
}

Future<Assignmentmodel?> assignmentdata([String? subid]) async {
  try {
    final response = await post(
      Uri.parse(URLS.getassignment),
      body: {
        // 'user_id': studentid,
        ///giving studentid as statis for checking correct it after
        'class_id': classid,
        'subject_id': subid,
        'user_id': studentid,
      },
    );

    if (kDebugMode) {
      print(subid);
      print(URLS.getassignment);
      print(response.statusCode);
      print(response.body);
    }
    if (response.statusCode == 200) {
      final bodyasjson = jsonDecode(response.body) as Map<String, dynamic>;

      if (bodyasjson['status'] != 'error') {
        final data = Assignmentmodel.fromJson(bodyasjson);
        print('returning data');
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    // print(e.toString());
    return null;
  }
}

Future<String?> assignmentupload(String assignId, String fileUrl) async {
  try {
    final response = await post(
      Uri.parse(URLS.uploadassignment),
      body: {
        // 'user_id': studentid,
        ///giving studentid as statis for checking correct it after
        'name': fileUrl,
        'assignment_id': assignId,
        'student_id': studentid,
        'parent_id': '10',
      },
    );

    if (kDebugMode) {
      print(assignId);
      print(URLS.uploadassignment);
      print(response.statusCode);
      print(response.body);
    }
    if (response.statusCode == 200) {
      final bodyasjson = jsonDecode(response.body) as Map<String, dynamic>;

      if (bodyasjson['status'] != 'error') {
        final data = bodyasjson['status'];
        print('returning data');
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    // print(e.toString());
    return null;
  }
}

Future<Progressbarmodel?> progressbardata() async {
  try {
    final response = await post(
      Uri.parse(URLS.progressbar),
      body: {
        // 'user_id': studentid,
        ///giving studentid as statis for checking correct it after
        'class_id': classid,
        'student_id': studentid,
      },
    );

    if (kDebugMode) {
      // print(exid);
      print(URLS.progressbar);
      print(response.statusCode);
      print(response.body);
    }
    if (response.statusCode == 200) {
      final bodyasjson = jsonDecode(response.body) as Map<String, dynamic>;

      if (bodyasjson['status'] != 'error') {
        final data = Progressbarmodel.fromJson(bodyasjson);
        // print(data.data![1].subjectId);
        return data;
      } else {
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    // print(e.toString());
    return null;
  }
}

Future<String> updateprofile(
  String name,
  String phone,
  String dob,
  // File image
) async {
  try {
    final response = await post(
      Uri.parse(URLS.editprofile),
      body: {
        'student_id': studentid,
        'name': name,
        'phone': phone,
        'dob': dob,
        // 'profile_img': image
      },
    );

    if (kDebugMode) {
      print(name);
      print(phone);
      print(dob);
      print(URLS.editprofile);
      print(response.statusCode);
      print(response.body);
    }
    if (response.statusCode == 200) {
      print('returned data');

      final bodyasjson = jsonDecode(response.body) as Map<String, dynamic>;

      if (bodyasjson['status'] != 'error') {
        final data = bodyasjson['message'];
        print('returned data');
        return data;
      } else {
        return 'null';
      }
    } else {
      return 'null';
    }
  } catch (e) {
    return 'null';
  }
}

Future<OtpResponse?> otpsend(String email) async {
  try {
    final response = await post(
      Uri.parse(URLS.sendotp),
      body: {'email': email},
    );
    final bodyasjson = jsonDecode(response.body) as Map<String, dynamic>;
    print(response.body);
    print(bodyasjson['message']);
    if (response.statusCode == 200) {
      if (bodyasjson['message'] != 'Send Successfully') {
        return null;
      } else {
        final data = OtpResponse.fromJson(bodyasjson);
        return data;
      }
    } else {
      throw Exception('Failed to fetch data: ${response.reasonPhrase}');
    }
  } catch (e) {
    throw Exception('Failed to fetch data: $e');
  }
}

Future<Examresultmodel?> examresult(String userid, String examid) async {
  try {
    final response = await post(
      Uri.parse(URLS.viewexam),
      // headers: headers,
      body: {'user_id': userid, 'examid': examid},
    );

    if (response.statusCode == 200) {
      final bodyasjson = json.decode(response.body) as Map<String, dynamic>;
      ;

      if (bodyasjson['status'] == 'success') {
        final data = Examresultmodel.fromJson(bodyasjson);
        // List<Map<String, dynamic>> dataList =
        //     List<Map<String, dynamic>>.from(data['data']);
        // Map<String, dynamic> result =
        //     Map<String, dynamic>.from(data['f_result']);
        // course_count = dataList.length.toInt();

        // List<dynamic> listOfLists = [dataList, result];
        return data;
      } else {
        throw Exception('Failed to fetch data: ${bodyasjson['message']}');
      }
    } else {
      throw Exception('Failed to fetch data: ${response.reasonPhrase}');
    }
  } catch (e) {}
  return null;
}
