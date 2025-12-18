
class AttendanceResponse {
  final String status;
  final String message;
  final List<AttendanceData> data;

  AttendanceResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AttendanceResponse.fromJson(Map<String, dynamic> json) {
    return AttendanceResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>)
          .map((e) => AttendanceData.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}


class AttendanceData {
  final String attendanceId;
  final String timestamp;
  final String year;
  final String courseId;
  final String classId;
  final String sectionId;
  final String subjectId;
  final String studentId;
  final String classRoutineId;
  final String status;
  final String setPeriodId;

  AttendanceData({
    required this.attendanceId,
    required this.timestamp,
    required this.year,
    required this.courseId,
    required this.classId,
    required this.sectionId,
    required this.subjectId,
    required this.studentId,
    required this.classRoutineId,
    required this.status,
    required this.setPeriodId,
  });

  factory AttendanceData.fromJson(Map<String, dynamic> json) {
    return AttendanceData(
      attendanceId: json['attendance_id'] ?? '',
      timestamp: json['timestamp'] ?? '',
      year: json['year'] ?? '',
      courseId: json['course_id'] ?? '',
      classId: json['class_id'] ?? '',
      sectionId: json['section_id'] ?? '',
      subjectId: json['subject_id'] ?? '',
      studentId: json['student_id'] ?? '',
      classRoutineId: json['class_routine_id'] ?? '',
      status: json['status'] ?? '',
      setPeriodId: json['set_period_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attendance_id': attendanceId,
      'timestamp': timestamp,
      'year': year,
      'course_id': courseId,
      'class_id': classId,
      'section_id': sectionId,
      'subject_id': subjectId,
      'student_id': studentId,
      'class_routine_id': classRoutineId,
      'status': status,
      'set_period_id': setPeriodId,
    };
  }
}
