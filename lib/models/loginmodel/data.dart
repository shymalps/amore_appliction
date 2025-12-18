import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  @JsonKey(name: 'student_id')
  String? studentId;
  @JsonKey(name: 'student_code')
  String? studentCode;
  @JsonKey(name: 'name')
  String? name;
  String? birthday;
  String? sex;
  String? religion;
  @JsonKey(name: 'blood_group')
  String? bloodGroup;
  String? address;
  String? phone;
  String? email;
  String? password;
  @JsonKey(name: 'parent_id')
  String? parentId;
  @JsonKey(name: 'dormitory_id')
  String? dormitoryId;
  @JsonKey(name: 'transport_id')
  String? transportId;
  @JsonKey(name: 'dormitory_room_number')
  String? dormitoryRoomNumber;
  @JsonKey(name: 'authentication_key')
  String? authenticationKey;
  @JsonKey(name: 'father_name')
  String? fatherName;
  @JsonKey(name: 'father_phone')
  String? fatherPhone;
  @JsonKey(name: 'mother_name')
  String? motherName;
  @JsonKey(name: 'mother_phone')
  String? motherPhone;
  @JsonKey(name: 'guardian_name')
  String? guardianName;
  @JsonKey(name: 'guardian_phone')
  String? guardianPhone;
  String? caste;
  @JsonKey(name: 'aadhar_number')
  String? aadharNumber;
  @JsonKey(name: 'upload_certificates')
  dynamic uploadCertificates;
  @JsonKey(name: 'father_occupation')
  String? fatherOccupation;
  @JsonKey(name: 'mother_occupation')
  String? motherOccupation;
  @JsonKey(name: 'disability_status')
  String? disabilityStatus;
  @JsonKey(name: 'disability_description')
  String? disabilityDescription;
  String? notification;
  @JsonKey(name: 'date_admission')
  dynamic dateAdmission;
  String? status;
  dynamic ip;
  @JsonKey(name: 'device_id')
  dynamic deviceId;
  @JsonKey(name: 'seen_notes')
  dynamic seenNotes;
  @JsonKey(name: 'seen_video')
  String? seenVideo;
  @JsonKey(name: 'seen_audio')
  dynamic seenAudio;
  @JsonKey(name: 'class_id')
  String? classId;
  @JsonKey(name: 'section_id')
  String? sectionId;
  String? utype;

  Data({
    this.studentId,
    this.studentCode,
    this.name,
    this.birthday,
    this.sex,
    this.religion,
    this.bloodGroup,
    this.address,
    this.phone,
    this.email,
    this.password,
    this.parentId,
    this.dormitoryId,
    this.transportId,
    this.dormitoryRoomNumber,
    this.authenticationKey,
    this.fatherName,
    this.fatherPhone,
    this.motherName,
    this.motherPhone,
    this.guardianName,
    this.guardianPhone,
    this.caste,
    this.aadharNumber,
    this.uploadCertificates,
    this.fatherOccupation,
    this.motherOccupation,
    this.disabilityStatus,
    this.disabilityDescription,
    this.notification,
    this.dateAdmission,
    this.status,
    this.ip,
    this.deviceId,
    this.seenNotes,
    this.seenVideo,
    this.seenAudio,
    this.classId,
    this.sectionId,
    this.utype,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
