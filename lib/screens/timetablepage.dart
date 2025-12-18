// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:amore_student_erp/common%20widgets/commonappbar.dart';
// import 'package:amore_student_erp/common%20widgets/listviewbuilder.dart';
// import 'package:amore_student_erp/common%20widgets/tabbarbuilder.dart';
// import 'package:amore_student_erp/common%20widgets/textwidget.dart';
// import 'package:amore_student_erp/datalayer.dart/apicalls.dart';
// import 'package:amore_student_erp/models/timetablemodel/timetableitem.dart';
// import 'package:amore_student_erp/others/clors.dart';
// import 'package:amore_student_erp/screens/studymaterialslisting.dart';

// import '../others/constants.dart';

// class Timetablepage extends StatefulWidget {
//   const Timetablepage({super.key});

//   @override
//   State<Timetablepage> createState() => _TimetablepageState();
// }

// class _TimetablepageState extends State<Timetablepage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   final _selectedColor = Appcolor.darkblue;
//   final _unselectedColor = Appcolor.black;
//   final _tabs = const [
//     // Tab(child: Text('Mon')),
//     Tab(child: Text('Mon')),
//     Tab(child: Text('Tue')),
//     Tab(child: Text('Wed')),
//     Tab(child: Text('Thu')),
//     Tab(child: Text('Fri')),
//   ];
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: _tabs.length, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Appcolor.darkblue,
//       appBar: commonappbar(context: context, title: 'Time Table'),
//       body: SafeArea(
//           child: Container(
//         width: double.infinity,
//         // height: ,
//         decoration: BoxDecoration(
//             color: Appcolor.white,
//             borderRadius:
//                 BorderRadius.vertical(top: Radius.circular(largeradius))),
//         child: Center(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TabBar(
//                 controller: _tabController,
//                 labelColor: _selectedColor,
//                 unselectedLabelColor: _unselectedColor,
//                 indicatorSize: TabBarIndicatorSize.label,
//                 indicator: MaterialDesignIndicator(
//                   indicatorHeight: 6,
//                   indicatorColor: _selectedColor,
//                 ),
//                 tabs: _tabs,
//               ),
//               Expanded(
//                   child: TabBarView(
//                 controller: _tabController,
//                 children: const [
//                   timetabletab(
//                     day: 'Monday',
//                   ),
//                   timetabletab(day: 'Tuesday'),
//                   timetabletab(
//                     day: 'Wednesday',
//                   ),
//                   timetabletab(
//                     day: 'Thursday',
//                   ),
//                   timetabletab(
//                     day: 'Friday',
//                   ),
//                 ],
//               )),
//             ],
//           ),
//         ),
//       )),
//     );
//   }
// }

// class timetabletab extends StatefulWidget {
//   final String day;
//   const timetabletab({
//     super.key,
//     required this.day,
//   });

//   @override
//   State<timetabletab> createState() => _timetabletabState();
// }

// class _timetabletabState extends State<timetabletab> {
//   List<Timetableitem>? timetable = [];
//   bool nodata = false;
//   bool loading = false;
//   @override
//   void initState() {
//     super.initState();
//     _gettimetable();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return nodata
//         ? const Center(child: Text('No Timetable Found'))
//         : loading
//             ? Container(
//                 color: Appcolor.white,
//                 height: double.infinity,
//                 width: double.infinity,
//                 child: Column(children: [
//                   Expanded(
//                     child: CustomListViewBuilder(
//                       itemCount: timetable!.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return GestureDetector(
//                             // onTap: () =>
//                             // Image.asset('asset/images/iconvideo.png')
//                             //     Navigator.pushNamed(context, '/topiclist'),
//                             child: Padding(
//                           padding: const EdgeInsets.all(10),
//                           child: Timetablelistitem(
//                             index: index,
//                             subject: timetable![index].subject!,
//                             teacher: timetable![index].teacher!,
//                             starttime: timetable![index].timeStart,
//                             endtime: timetable![index].timeEnd,
//                           ),
//                         ));
//                       },
//                     ),
//                   ),
//                 ]),
//               )
//             : const Center(
//                 child: SpinKitCircle(
//                   color: Appcolor.darkblue,
//                   size: 75.0,
//                   // lineWidth: 3.0,
//                 ),
//               );
//   }

//   Future<void> _gettimetable() async {
//     final data = await gettimetableview(widget.day);
//     // print(data!.data);
//     if (data != null) {
//       setState(() {
//         timetable = data.data;
//         loading = true;
//       });
//     } else {
//       setState(() {
//         nodata = true;
//       });
//     }
//   }
// }

// class Timetablelistitem extends StatelessWidget {
//   final int index;
//   final String subject;
//   final String teacher;
//   final String? starttime;
//   final String? endtime;
//   const Timetablelistitem({
//     super.key,
//     required this.index,
//     required this.subject,
//     required this.teacher,
//     required this.starttime,
//     required this.endtime,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: Container(
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: Colors.transparent,
//             border: Border.all(
//               color: Appcolor.darkblue,
//             )),
//         width: double.infinity,
//         child: Row(
//           children: [
//             Expanded(
//               flex: 1,
//               child: Padding(
//                 padding: const EdgeInsets.all(5),
//                 child: Container(
//                   decoration: const BoxDecoration(
//                       // color: Colors.amber,
//                       border: Border(
//                           right: BorderSide(color: Appcolor.grey, width: 2))),
//                   child: Padding(
//                     padding: const EdgeInsets.all(5),
//                     child: Column(
//                       children: [
//                         buildtext(
//                             text: starttime ?? '',
//                             fontcolor: Appcolor.grey,
//                             fontsize: smallfontsize),
//                         const SizedBox(height: 15),
//                         buildtext(
//                             text: endtime ?? '',
//                             fontcolor: Appcolor.grey,
//                             fontsize: smallfontsize),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 2,
//               child: Container(
//                 // color: Colors.blue,
//                 child: Padding(
//                   padding: EdgeInsets.all(5),
//                   child: Column(
//                       // crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               buildtext(
//                                   text: 'Subject  :', fontsize: comonfontsize),
//                               buildtext(
//                                   text: '  $subject', fontsize: comonfontsize),
//                             ]),
//                         SizedBox(height: 10),
//                         SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 buildtext(
//                                     text: 'Staff  :', fontsize: comonfontsize),
//                                 buildtext(
//                                     text: '  $teacher',
//                                     fontsize: comonfontsize),
//                               ]),
//                         )
//                       ]),
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 1,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Appcolor.darkblue,
//                   borderRadius:
//                       BorderRadius.horizontal(right: Radius.circular(10)),
//                 ),
//                 // constraints: BoxConstraints.expand(),
//                 // width: double.infinity,
//                 // height: double.infinity,

//                 child: Padding(
//                   padding: EdgeInsets.all(25),
//                   child: Center(
//                     child: buildtext(
//                       text: '${index + 1}',
//                       fontcolor: Appcolor.white,
//                       fontsize: 30,
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:amore_student_erp/datalayer.dart/apicalls.dart';
import 'package:amore_student_erp/models/time_table/time_table.dart';

import 'package:amore_student_erp/others/clors.dart';
import 'package:amore_student_erp/others/constants.dart';
import 'package:flutter/material.dart';

class TimetableScreen extends StatefulWidget {
  // final String? classId;
  // final String? sectionId;
  final String studentId;

  const TimetableScreen({
    Key? key,
    //  this.classId,
    //  this.sectionId,
    required this.studentId,
  }) : super(key: key);

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  bool _isLoading = false;
  String _errorMessage = '';
  PeriodData? _periodData;
  String _selectedDay = '';

  @override

  void initState() {
    super.initState();
    _fetchTimetable();
    _selectedDay = _getCurrentDay();
  }

  

  String _getCurrentDay() {
    final now = DateTime.now();
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return days[now.weekday - 1];
  }

  Future<void> _fetchTimetable() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final response = await getperioddata(
        // widget.classId!,
        // widget.sectionId!,
        widget.studentId
      );

      if (response != null && response.status == 'success') {
        setState(() {
          _periodData = response.data;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = response?.message ?? 'Failed to load timetable';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error loading timetable: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Time Table'),
        backgroundColor: Appcolor.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchTimetable,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? _buildErrorView()
              : _periodData == null
                  ? const Center(child: Text('No data available'))
                  : Column(
                      children: [
                        _buildInfoCard(),
                        _buildDaySelector(),
                        Expanded(child: _buildScheduleView()),
                      ],
                    ),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red.shade400,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              _errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _fetchTimetable,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolor.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildInfoCard() {
    if (_periodData == null) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Appcolor.blue, Appcolor.blue.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Appcolor.blue.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.school,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Class ${_periodData!.classId} - ${_periodData!.sectionId}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Course: ${_periodData!.courseId}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDaySelector() {
    final weekdays = _getAllWeekdays();
    if (weekdays.isEmpty) return const SizedBox.shrink();

    return Container(
      height: 70,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weekdays.length,
        itemBuilder: (context, index) {
          final day = weekdays[index];
          final isSelected = day == _selectedDay;
          final isToday = day == _getCurrentDay();

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDay = day;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? Appcolor.blue : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isToday ? Appcolor.blue : Colors.grey.shade300,
                  width: isToday ? 2 : 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Appcolor.blue.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    day.substring(0, 3),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  ),
                  if (isToday && !isSelected)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      width: 6,
                      height: 6,
                      decoration:const BoxDecoration(
                        color:  Color.fromARGB(255, 2, 2, 2),
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildScheduleView() {
    final subjects = _periodData!.periodTiming.keys.toList();
    final daySchedule = _getDaySchedule(subjects, _selectedDay);

    if (daySchedule.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_busy,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'No classes scheduled for $_selectedDay',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: daySchedule.length,
      itemBuilder: (context, index) {
        print('6256566626');
        print(daySchedule.length);
        final period = daySchedule[index];

        return _buildPeriodCard(period, index);
      },
    );
  }

  Widget _buildPeriodCard(Map<String, String> period, int index) {
    final color = _getSubjectColor(period['subject']!);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: 6,
                color: color,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${period['periodNumber']}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: color,
                              ),
                            ),
                            Text(
                              'Period',
                              style: TextStyle(
                                fontSize: 10,
                                color: color,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              period['subject']!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 16,
                                  color: Colors.grey.shade600,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  period['time']!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.book,
                          color: color,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, String>> _getDaySchedule(
    List<String> subjects,
    String weekday,
  ) {
    List<Map<String, String>> schedule = [];

    for (var subjectName in subjects) {
      final subject = _periodData!.periodTiming[subjectName]!;

      for (int i = 0; i < subject.weekdays.length; i++) {
        if (subject.weekdays[i] == weekday && i < subject.periodName.length) {
          final periodName = subject.periodName[i];
          final periodNumberMatch = RegExp(r'\d+').firstMatch(periodName);
          final periodNumber =
              periodNumberMatch != null ? periodNumberMatch.group(0) : '0';

          schedule.add({
            'subject': subjectName,
            'time': i < subject.hours.length ? subject.hours[i] : '',
            'periodNumber': periodNumber!,
            'periodName': periodName,
          });
        }
      }
    }

    schedule.sort((a, b) =>
        int.parse(a['periodNumber']!).compareTo(int.parse(b['periodNumber']!)));

    return schedule;
  }

  Color _getSubjectColor(String subject) {
    final colors = [
      Colors.blue.shade600,
      Colors.green.shade600,
      Colors.orange.shade600,
      Colors.purple.shade600,
      Colors.teal.shade600,
      Colors.red.shade600,
      Colors.indigo.shade600,
      Colors.pink.shade600,
    ];
    return colors[subject.hashCode % colors.length];
  }

  List<String> _getAllWeekdays() {
    final Set<String> weekdaysSet = {};
    for (var subject in _periodData!.periodTiming.values) {
      weekdaysSet.addAll(subject.weekdays);
    }
    final weekdays = weekdaysSet.toList();
    weekdays.sort((a, b) => _getDayOrder(a).compareTo(_getDayOrder(b)));
    return weekdays;
  }

  int _getDayOrder(String day) {
    const dayOrder = {
      'Monday': 1,
      'Tuesday': 2,
      'Wednesday': 3,
      'Thursday': 4,
      'Friday': 5,
      'Saturday': 6,
      'Sunday': 7,
    };
    return dayOrder[day] ?? 8;
  }
}
