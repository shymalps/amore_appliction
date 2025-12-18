class PeriodResponse {
  final String status;
  final String message;
  final PeriodData data;

  PeriodResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PeriodResponse.fromJson(Map<String, dynamic> json) {
    return PeriodResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: PeriodData.fromJson(json['data'] ?? {}),
    );
  }
}

class PeriodData {
  final String courseId;
  final String classId;
  final String sectionId;
  final Map<String, SubjectPeriod> periodTiming;

  PeriodData({
    required this.courseId,
    required this.classId,
    required this.sectionId,
    required this.periodTiming,
  });

  factory PeriodData.fromJson(Map<String, dynamic> json) {
    final Map<String, SubjectPeriod> timingMap = {};

    if (json['period_timing'] != null) {
      json['period_timing'].forEach((key, value) {
        timingMap[key] = SubjectPeriod.fromJson(value);
      });
    }

    return PeriodData(
      courseId: json['course_id']?.toString() ?? '',
      classId: json['class_id']?.toString() ?? '',
      sectionId: json['section_id']?.toString() ?? '',
      periodTiming: timingMap,
    );
  }
}

class SubjectPeriod {
  final List<String> periodName;
  final List<String> weekdays;
  final List<String> hours;

  SubjectPeriod({
    required this.periodName,
    required this.weekdays,
    required this.hours,
  });

  factory SubjectPeriod.fromJson(Map<String, dynamic> json) {
    return SubjectPeriod(
      periodName: List<String>.from(json['period_name'] ?? []),
      weekdays: List<String>.from(json['weekdays'] ?? []),
      hours: List<String>.from(json['hours'] ?? []),
    );
  }
}
