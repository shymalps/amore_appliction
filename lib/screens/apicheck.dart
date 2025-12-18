import 'package:flutter/material.dart';

import 'package:amore_student_erp/common%20widgets/commonappbar.dart';

import 'package:lottie/lottie.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonappbar(context: context, title: 'Aminater'),
      body: Column(children: [
        // Lottie.asset('asset/images/examtimeout.json'),
        Lottie.network(
            'https://lottie.host/657dfff2-ea6f-42b7-82e1-30165445f337/Le1VSFQlu1.json')
      ]),
    );
  }
}
// class MyWidget extends StatelessWidget {
//   const MyWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//             onPressed: () async {
//               // final data = await getstudymaterials(
//               //   'notes',
//               //   'topic_id',
//               //   '2',
//               // );
//               // print('data $data');
//             },
//             child: Text('data')),
//       ),
//     );
//   }
// }

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:dospace/dospace.dart' as dospace;
// import 'package:file_picker/file_picker.dart';

// class DOSpacesFileUpload extends StatefulWidget {
//   @override
//   _DOSpacesFileUploadState createState() => _DOSpacesFileUploadState();
// }

// class _DOSpacesFileUploadState extends State<DOSpacesFileUpload> {

//   dospace.Spaces spaces = new dospace.Spaces(
//     //change with your project's region
//     region: "nyc3",
//     //change with your project's accessKey
//     accessKey: "G3K3EPCZPCVRLQKOYUQE",
//     //change with your project's secretKey
//     secretKey: "PLpo3JZ9ARyf7Ash/wOBGRnnpnNvKFVzie86us/nNIk",
//   );

//   @override
//   Widget build(BuildContext context) {

//     return MaterialApp(
//       home: Scaffold(
//         body: SafeArea(
//           child: Center(
//             child: ElevatedButton(
//               child: Text('Upload File to DO Spaces'),
//               onPressed: () async {

//                 File file = await FilePicker.getFile(
//                   type: FileType.custom,
//                   allowedExtensions: ['pdf','txt'],
//                 );

//                 // change with your project's name
//                 String project_name = "project_name";
//                 // change with your project's region
//                 String region = "nyc3";
//                 // change with your project's folder
//                 String folder_name = "taxdocs";
//                 String file_name = file.path.split('/').last;

//                 String etag = await spaces.bucket(project_name).uploadFile(
//                     folder_name + '/' + file_name,
//                     file,
//                     'text/plain',
//                     dospace.Permissions.public);
//                 print('upload: $etag');

//                 String uploaded_file_url = "https://"+project_name+"."+region+".digitaloceanspaces.com/" + folder_name + "/" + file_name;

//                 await spaces.close();
//               },
//             )
//           )
//         )
//       )
//     );
//   }

// }
