// import 'dart:io';

// import 'package:date_input_formater_alp/date_input_formater_alp.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:amore_student_erp/common%20widgets/textwidget.dart';
// import 'package:amore_student_erp/common%20widgets/timestampconvert.dart';
// import 'package:amore_student_erp/datalayer.dart/apicalls.dart';
// import 'package:amore_student_erp/models/profileviewmodel/profileviewmodel.dart';
// import 'package:amore_student_erp/others/clors.dart';
// import 'package:amore_student_erp/others/constants.dart';
// import 'package:amore_student_erp/screens/settingspage.dart';

// class Profiledit extends StatefulWidget {
//   Profiledit({super.key});

//   @override
//   State<Profiledit> createState() => _ProfileditState();
// }

// class _ProfileditState extends State<Profiledit> {
//   TextEditingController name = TextEditingController();
//   TextEditingController dob = TextEditingController();
//   TextEditingController phone = TextEditingController();
//   Profileviewmodel? userdata;
//   File? _image;

//   bool tap = false;

//   bool loading = false;
//   void initState() {
//     super.initState();
//     _getstudentdata();
//   }

//   Future<void> _pickImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return loading
//         ? userdata == null
//             ? const Scaffold(
//                 backgroundColor: Appcolor.white,
//                 body: Center(
//                   child: Text(
//                       'We are habving a trouble to load user data. pleasse try later'),
//                 ),
//               )
//             : Scaffold(
//                 backgroundColor: Appcolor.darkblue,
//                 appBar: AppBar(
//                   backgroundColor: Appcolor.transparent,
//                 ),
//                 body: Container(
//                   height: double.infinity,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Appcolor.white,
//                     borderRadius:
//                         BorderRadius.vertical(top: Radius.circular(30)),
//                   ),
//                   child: SingleChildScrollView(
//                     child: Padding(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: devicewidth! * 0.1),
//                       child: Column(
//                         children: [
//                           SizedBox(
//                               height: deviceheight! * 0.2,
//                               width: deviceheight! * 0.2,
//                               child: GestureDetector(
//                                 onTap: _pickImage,
//                                 child: _image != null
//                                     ? ClipOval(
//                                         child: Image.file(
//                                           _image!,
//                                           fit: BoxFit.cover,
//                                           width: 50,
//                                           height: 50,
//                                         ),
//                                       )
//                                     : profileimage(
//                                         // image: menavathar,
//                                         image: userdata!.data!.profileImg ?? '',
//                                         border: true,
//                                         circle: true,
//                                       ),
//                               )),
//                           const SizedBox(
//                             height: 15,
//                           ),
//                           // listitem_profile(
//                           //   label: 'Name',
//                           //   controller: name,
//                           // ),
//                           _buildTextFormField(
//                             controller: name,
//                             labelText: 'Name',
//                             borderStyle: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                   color: Appcolor.black, width: 1.0),
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 15,
//                           ),
//                           _buildTextFormField(
//                             controller: dob,
//                             labelText: 'Date of Birth (yyyy/mm/dd)',
//                             keyboardType: TextInputType.number,
//                             // inputFormatters: [DateInputFormatter()],
//                             suffixIcon: IconButton(
//                               icon: const Icon(Icons.calendar_today),
//                               onPressed: () => _selectDate(context),
//                             ),
//                             onChanged: (value) {
//                               // if (value.isNotEmpty) {
//                               //   _updateAge();
//                               // } else {
//                               //   controller.ageController.clear();
//                               // }
//                             },
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter your date of birth';
//                               }
//                               return null;
//                             },
//                             borderStyle: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                   color: Appcolor.black, width: 1.0),
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 15,
//                           ),
//                           _buildTextFormField(
//                             controller: phone,
//                             labelText: 'Phone Number',
//                             keyboardType: TextInputType.number,
//                             inputFormatters: [
//                               FilteringTextInputFormatter
//                                   .digitsOnly, // Only allow digits
//                               LengthLimitingTextInputFormatter(
//                                   10), // Limit to 10 digits (or adjust based on your requirement)
//                             ],
//                             borderStyle: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                   color: Appcolor.black, width: 1.0),
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 15,
//                           ),
//                           // listitem_profile(
//                           //   label: 'DOB',
//                           //   controller: dob,date: true
//                           // ),
//                           // const SizedBox(
//                           //   height: 15,
//                           // ),
//                           Container(
//                             width: double.infinity,
//                             height: 50,
//                             color: Appcolor.blue,
//                             child: TextButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     tap = true;
//                                   });
//                                   print('tap');
//                                   print(name.text);
//                                   print(dob.text);
//                                   print(phone.text);
//                                   print(_image);
//                                   if (name.text == userdata!.data!.name! &&
//                                       _image == null &&
//                                       phone.text == userdata!.data!.phone! &&
//                                       dob.text ==
//                                           timeconvert(
//                                               userdata!.data!.birthday!)) {
//                                     showMyDialog(
//                                         context, 'Nothing to update', 'Error');
//                                     setState(() {
//                                       tap = false;
//                                       _image = null;
//                                     });
//                                   } else {
//                                     if (phone.text.length != 10) {
//                                       setState(() {
//                                         tap = false;
//                                       });
//                                       showMyDialog(
//                                           context,
//                                           'Phone number must be ten digit',
//                                           'Error');
//                                     } else if (isValidDate(dob.text) != true) {
//                                       setState(() {
//                                         tap = false;
//                                       });
//                                       showMyDialog(context,
//                                           'Enter a correct date', 'Error');
//                                     } else {
//                                       print('profileupdate');
//                                       if (_image == null) {
//                                         profileupdate(
//                                             name.text, phone.text, dob.text);
//                                       } else {
//                                         profileupdate(name.text, phone.text,
//                                             dob.text, _image!);
//                                       }

//                                       setState(() {
//                                         tap = false;
//                                       });
//                                     }
//                                   }

//                                   // profileupdate(name.text, phone.text, dob.text);
//                                 },
//                                 child: buildtext(
//                                   text: tap ? 'loading...' : 'UPDATE',
//                                 )),
//                           )
//                           // Text('${userdata!.data!.toJson()}'),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//         : const Scaffold(
//             body: Center(
//               child: SpinKitCircle(
//                 color: Appcolor.darkblue,
//                 size: 75.0,
//                 // lineWidth: 3.0,
//               ),
//             ),
//           );
//   }

//   Column listitem_profile(
//       {required String label,
//       required TextEditingController controller,
//       bool date = false,
//       bool phone = false}) {
//     // TextEditingController controller = TextEditingController();
//     // controller.text = data;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         buildtext(text: label),
//         TextField(
//           controller: controller,
//           decoration: InputDecoration(
//             // labelText: 'Enter text',
//             border: OutlineInputBorder(), // Adds a border around the text field
//           ),
//           keyboardType:
//               phone ? TextInputType.phone : null, // Show phone number keyboard
//           inputFormatters: phone
//               ? [
//                   FilteringTextInputFormatter.digitsOnly, // Only allow digits
//                   LengthLimitingTextInputFormatter(
//                       10), // Limit to 10 digits (or adjust based on your requirement)
//                 ]
//               : null,
//         ),
//         // Container(
//         //     width: devicewidth,
//         //     decoration: BoxDecoration(
//         //         borderRadius: BorderRadius.circular(8),
//         //         border: Border.all(color: Appcolor.blue)),
//         //     child: Padding(
//         //       padding: EdgeInsets.all(5),
//         //       child: buildtext(text: data),
//         //     ))
//       ],
//     );
//   }

//   Future<void> _getstudentdata() async {
//     final logindata = await profileview();
//     print(logindata!.data!.name!);

//     // if (logindata != null) {}
//     setState(() {
//       userdata = logindata;
//       name.text = userdata!.data!.name!;
//       dob.text = timeconvert(userdata!.data!.birthday!);
//       phone.text = userdata!.data!.phone!;
//       loading = true;
//     });
//   }

//   Future<void> profileupdate(String name, String phone, String dob,
//       [File? image]) async {
//     print('profile updated started.........');
//     print('new $dob');
//     final update = await updateprofile(
//       name, phone, dob,
//       // image
//     );
//     print('update');
//     if (update != null) {
//       if (update == 'Updated Successfully') {
//         showMyDialog(context, update, 'Success');
//         print('Updated Successfully');
//         _getstudentdata();
//       }
//     }
//   }

//   bool isValidDate(String dateString) {
//     try {
//       // Split the date string by the hyphen
//       List<String> dateParts = dateString.split('-');

//       // Check if we have exactly 3 parts (day, month, year)
//       if (dateParts.length != 3) {
//         return false;
//       }

//       // Parse the day, month, and year from the string
//       int day = int.parse(dateParts[2]);
//       int month = int.parse(dateParts[1]);
//       int year = int.parse(dateParts[0]);

//       // Check valid ranges for month and day
//       if (month < 1 || month > 12 || day < 1 || day > 31) {
//         return false;
//       }

//       // Check if the date exists
//       DateTime date = DateTime(year, month, day);

//       // Verify the day and month values to catch invalid dates like "30-02-2021"
//       if (date.year == year && date.month == month && date.day == day) {
//         return true;
//       } else {
//         return false;
//       }
//     } catch (e) {
//       // If parsing fails, the date is invalid
//       return false;
//     }
//   }
//   // Future<void> pickImage(ImageSource source) async {
//   //   final XFile? pickedFile = await _picker.pickImage(source: source);
//   //   if (pickedFile != null) {
//   //     image = File(pickedFile.path);
//   //   }
//   // }

//   Widget _buildTextFormField({
//     required TextEditingController controller,
//     required String labelText,
//     TextInputType? keyboardType,
//     List<TextInputFormatter>? inputFormatters,
//     Widget? suffixIcon,
//     String? Function(String?)? validator,
//     bool readOnly = false,
//     int? maxLines,
//     required OutlineInputBorder borderStyle,
//     void Function(String)? onChanged,
//   }) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: labelText,
//         enabledBorder: borderStyle,
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(25),
//           borderSide: const BorderSide(
//             color: Appcolor.black,
//             width: 2.0,
//           ),
//         ),
//         suffixIcon: suffixIcon,
//       ),
//       onChanged: onChanged,
//       keyboardType: keyboardType,
//       inputFormatters: inputFormatters,
//       validator: validator,
//       readOnly: readOnly,
//       // enabled: false,
//       maxLines: maxLines,
//     );
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     DateTime now = DateTime.now();
//     DateTime eighteenYearsAgo = DateTime(now.year - 18, now.month, now.day);

//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: eighteenYearsAgo,
//       firstDate: DateTime(1950),
//       lastDate: now,
//     );

//     if (pickedDate != null) {
//       dob.text = DateFormat('yyyy-MM-dd').format(pickedDate);
//       // _updateAge();
//     }
//   }
// }

// void showMyDialog(BuildContext context, String msg, String head) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text(head),
//         content: Text(msg),
//         actions: <Widget>[
//           TextButton(
//             child: Text('Close'),
//             onPressed: () {
//               Navigator.of(context).pop(); // Close the dialog
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
