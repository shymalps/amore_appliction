import 'package:amore_student_erp/screens/meetscreen.dart';
import 'package:flutter/material.dart';
// import 'package:gnanodaya_lms/zoom/view/meetingscreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

import '../../others/constants.dart';
import '../common widgets/commonappbar.dart';

// Meeting model class
class Meeting {
  final String meetingId;
  final String classId;
  final String staffId;
  final String topic;
  final String duration;
  final String meetingUrl;
  final String? otherUrl;
  final String joinUrl;
  final String meetingPassword;
  final String encryptedPassword;
  final int scheduleDate;
  final int createDate;
  final String meetingNumber;
  final String staffName;

  Meeting({
    required this.meetingId,
    required this.classId,
    required this.staffId,
    required this.topic,
    required this.duration,
    required this.meetingUrl,
    this.otherUrl,
    required this.joinUrl,
    required this.meetingPassword,
    required this.encryptedPassword,
    required this.scheduleDate,
    required this.createDate,
    required this.meetingNumber,
    required this.staffName,
  });

  factory Meeting.fromJson(Map<String, dynamic> json) {
    return Meeting(
      meetingId: json['meeting_id'] ?? '',
      classId: json['class_id'] ?? '',
      staffId: json['staff_id'] ?? '',
      topic: json['topic'] ?? '',
      duration: json['duration'] ?? '',
      meetingUrl: json['meeting_url'] ?? '',
      otherUrl: json['other_url'],
      joinUrl: json['join_url'] ?? '',
      meetingPassword: json['meeting_password'] ?? '',
      encryptedPassword: json['encrypted_password'] ?? '',
      scheduleDate: int.tryParse(json['schedule_date'].toString()) ?? 0,
      createDate: int.tryParse(json['create_date'].toString()) ?? 0,
      meetingNumber: json['meetingid'] ?? '',
      staffName: json['staff_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meeting_id': meetingId,
      'class_id': classId,
      'staff_id': staffId,
      'topic': topic,
      'duration': duration,
      'meeting_url': meetingUrl,
      'other_url': otherUrl,
      'join_url': joinUrl,
      'meeting_password': meetingPassword,
      'encrypted_password': encryptedPassword,
      'schedule_date': scheduleDate,
      'create_date': createDate,
      'meetingid': meetingNumber,
      'staff_name': staffName,
    };
  }

  DateTime get scheduleDateTime =>
      DateTime.fromMillisecondsSinceEpoch(scheduleDate * 1000, isUtc: true);

  DateTime get createDateTime =>
      DateTime.fromMillisecondsSinceEpoch(createDate * 1000);
}

// API Response model
class ApiResponse {
  final String status;
  final String message;
  final List<Meeting> data;

  ApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List? ?? [];
    List<Meeting> meetings = list.map((i) => Meeting.fromJson(i)).toList();

    return ApiResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: meetings,
    );
  }
}

// Main Meeting List Screen
class MeetingListScreen extends StatefulWidget {
  @override
  _MeetingListScreenState createState() => _MeetingListScreenState();
}

class _MeetingListScreenState extends State<MeetingListScreen> {
  List<Meeting> meetings = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchMeetings();
  }

  // Fetch meetings from API
  Future<void> fetchMeetings() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    print('classId $classid');
    try {
      final response = await http.get(
        Uri.parse('$baseurl/upcomingMeetings/$classid'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final apiResponse = ApiResponse.fromJson(json.decode(response.body));

        if (apiResponse.status == 'success') {
          setState(() {
            meetings = apiResponse.data;
            isLoading = false;
          });
        } else {
          setState(() {
            errorMessage = apiResponse.message;
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage =
              'Failed to load meetings. Status: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Network error: ${e.toString()}';
        isLoading = false;
      });
    }
  }

  // Format timestamp to readable date
  String formatDate(String timestamp) {
    try {
      int ts = int.parse(timestamp);
      DateTime date =
          DateTime.fromMillisecondsSinceEpoch(ts * 1000, isUtc: true);
      return DateFormat('EEEE, MMMM d, y \'at\' h:mm a').format(date);
    } catch (e) {
      return 'Invalid Date';
    }
  }

  // Format duration
  String formatDuration(String minutes) {
    try {
      int mins = int.parse(minutes);
      if (mins == 0) return 'Not specified';

      int hours = mins ~/ 60;
      int remainingMins = mins % 60;

      if (hours > 0) {
        return '${hours}h ${remainingMins}m';
      }
      return '${mins}m';
    } catch (e) {
      return 'Not specified';
    }
  }

  // Launch URL
  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: commonappbar(context: context, title: 'Live class'),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[600]!),
            ),
            SizedBox(height: 16),
            Text(
              'Loading meetings...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Colors.red[600],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Error Loading Meetings',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    errorMessage!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: fetchMeetings,
                    child: Text('Try Again'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    if (meetings.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.event_note,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No Meetings Found',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'There are no upcoming meetings scheduled at this time.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: fetchMeetings,
      child: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: meetings.length,
        itemBuilder: (context, index) {
          final meeting = meetings[index];
          final meetingDuration = int.parse(meeting.duration);
          final difference =
              meeting.scheduleDateTime.difference(DateTime.now());

          print('difference.inMinutes ${meeting.scheduleDateTime.toString()}');
          print('difference.inMinutes ${DateTime.now().toString()}');
          print('difference.inMinutes ${difference.inMinutes}');
          final isNextMeeting = (difference.inMinutes <= 5 &&
                  difference.inMinutes >= 0) || // Within 5 mins before start
              (difference.inMinutes < 0 &&
                  difference.inMinutes >= -meetingDuration);
          print('difference.inMinutes $isNextMeeting');
          final date =
              DateFormat('EEE, MMM dd ').format(meeting.scheduleDateTime);
          final starttime =
              DateFormat('h:mm a').format(meeting.scheduleDateTime);
          final endtime = DateFormat('h:mm a').format(meeting.scheduleDateTime
              .add(Duration(minutes: int.parse(meeting.duration))));
          return _buildMeetingCard(meetings[index], true);
        },
      ),
    );
  }

  Widget _buildMeetingCard(Meeting meeting, bool active) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.video_call,
                    color: Colors.blue[600],
                    size: 24,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meeting.topic,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[900],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 16,
                            color: Colors.grey[600],
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Instructor: ${meeting.staffName}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Meeting Details
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _buildDetailRow(
                    Icons.schedule,
                    'Schedule',
                    // DateFormat('h:mm a').format(meeting.scheduleDateTime)
                    // meeting.scheduleDateTime.toString()
                    // meeting.scheduleDate.toString()
                    formatDate(meeting.scheduleDate.toString()),
                  ),
                  //  final starttime = DateFormat('h:mm a')
                  //             .format(meeting.scheduleDateTime);
                  SizedBox(height: 8),
                  _buildDetailRow(
                    Icons.timer,
                    'Duration',
                    formatDuration(meeting.duration),
                  ),
                  // SizedBox(height: 8),
                  // _buildDetailRow(
                  //   Icons.fingerprint,
                  //   'Meeting ID',
                  //   meeting.meetingIdNumber,
                  // ),
                  // SizedBox(height: 8),
                  // _buildDetailRow(
                  //   Icons.lock,
                  //   'Password',
                  //   meeting.meetingPassword,
                  // ),
                ],
              ),
            ),

            SizedBox(height: 16),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      print('hi its testing');
                      if (active) {
                        print('hi its testing1');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ZoomMeetingScreen(
                                meetingUrl:
                                    'https://us05web.zoom.us/wc/join/${meeting.meetingNumber}?pwd=${meeting.encryptedPassword}&uname=stuname',
                                stuname: 'stuname',
                                topic: '${meeting.topic}',
                              ),
                            ));
                        // Get.to(() => ZoomMeetingScreen(
                        //       meetingUrl:
                        //           'https://us05web.zoom.us/wc/join/${meeting.meetingNumber}?pwd=${meeting.encryptedPassword}&uname=$stuname',
                        //       stuname: stuname,
                        //       topic: meeting.topic,
                        //     ));
                      } else {
                        print('hi its testing2');
                        // ToastHelper.warningToast(context,
                        //     title: 'Meting Scheduled',
                        //     desc: 'Meeting not started yet');
                      }
                    },
                    icon: Icon(Icons.launch, size: 18),
                    label: Text('Join Meeting'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: active ? Colors.blue[600] : Colors.grey,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                // if (meeting.meetingUrl.isNotEmpty) ...[
                //   SizedBox(width: 12),
                //   Expanded(
                //     child: OutlinedButton.icon(
                //       onPressed: () => _launchUrl(meeting.meetingUrl),
                //       icon: Icon(Icons.video_call, size: 18),
                //       label: Text('Meeting URL'),
                //       style: OutlinedButton.styleFrom(
                //         foregroundColor: Colors.blue[600],
                //         padding: EdgeInsets.symmetric(vertical: 12),
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(8),
                //         ),
                //       ),
                //     ),
                //   ),
                // ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.grey[600],
        ),
        SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
            fontSize: 14,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.grey[900],
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
