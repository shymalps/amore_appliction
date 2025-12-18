import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:amore_student_erp/common%20widgets/commonappbar.dart';
import 'package:amore_student_erp/common%20widgets/snackbar.dart';
import 'package:amore_student_erp/common%20widgets/textwidget.dart';
import 'package:amore_student_erp/common%20widgets/videoplayerarguments.dart';
import 'package:amore_student_erp/datalayer.dart/apicalls.dart';

import 'package:amore_student_erp/others/clors.dart';
import 'package:amore_student_erp/others/constants.dart';

import '../dospace/dospace.dart' as dospace;

class Assignmentuploadpage extends StatefulWidget {
  const Assignmentuploadpage({super.key});

  @override
  State<Assignmentuploadpage> createState() => _AssignmentuploadpageState();
}

class _AssignmentuploadpageState extends State<Assignmentuploadpage> {
  late dospace.Spaces spaces;
  void initState() {
    super.initState();
    spaces = dospace.Spaces(
      region: "sgp1",
      accessKey: "BGLVYU6ZS6AZDD6K5J3S",
      secretKey: "x28kyTc8W+NuopycNIYGo2Qzk6OFjDuYV2xIFkI8nfA",
    );
  }

  @override
  void dispose() {
    // Close Spaces when the widget is disposed
    spaces.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Assignmentuploadarguments arguments =
        ModalRoute.of(context)!.settings.arguments as Assignmentuploadarguments;
    return Scaffold(
      backgroundColor: Appcolor.darkblue,
      appBar: commonappbar(context: context, title: arguments.title),
      body: SafeArea(
          child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: Appcolor.white,
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(largeradius))),
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.only(
              top: devicewidth! * 0.05,
              left: devicewidth! * 0.05,
              right: devicewidth! * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildtext(
                  text: arguments.qus,
                  maxlines: 1000,
                  fontsize: devicewidth! * 0.04),
              SizedBox(
                height: devicewidth! * 0.05,
              ),
              Row(children: [
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () => gotoroute(arguments.questionfile, context),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Appcolor.blue,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Padding(
                          padding: EdgeInsets.all(devicewidth! * 0.02),
                          child: buildtext(
                              text: 'View question Attachments Here')),
                    ),
                  ),
                ),
                SizedBox(
                  width: devicewidth! * 0.05,
                ),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () => fileupload(arguments.assignmentid),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Appcolor.blue,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Padding(
                          padding: EdgeInsets.all(devicewidth! * 0.02),
                          child: buildtext(text: 'Upload your answer here')),
                    ),
                  ),
                ),
              ]),
              SizedBox(
                height: devicewidth! * 0.05,
              ),
              SizedBox(
                height: devicewidth! * 0.05,
              ),
            ],
          ),
        )),
      )),
    );
  }

  bool checkFileExtension(String url, String extension) {
    String lowercaseUrl = url.toLowerCase();
    return lowercaseUrl.endsWith(extension);
  }

  void gotoroute(String file, BuildContext context) {
    if (checkFileExtension(file, '.pdf')) {
      Navigator.pushNamed(context, '/pdfview', arguments: file);
    } else if (checkFileExtension(file, '.jpg') ||
        checkFileExtension(file, '.jpeg') ||
        checkFileExtension(file, '.png')) {
      Navigator.pushNamed(context, '/imageviewer', arguments: file);
    } else {
      showSubscriptionActiveSnackBar(context, 'The filetype is not supported');
    }
  }

  fileupload(String assignId) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'txt'],
      );

      if (result != null) {
        // Access the selected file
        PlatformFile platformFile = result.files.first;
        File file = File(platformFile.path!);

        String projectName = "databackupservices";
        String region = "sgp1";
        String folderName = "klass";
        String fileName = platformFile.name;

        // print('Selected file: ${platformFile.name}');
        // print('File path: ${platformFile.path}');

        // Ensure that the file exists before attempting to upload
        if (!file.existsSync()) {
          // print('File does not exist at path: ${file.path}');
          return;
        }

        // Perform the upload
        String? etag = await spaces.bucket(projectName).uploadFile(
              '$folderName/$fileName',
              file,
              'application/octet-stream',
              dospace.Permissions.public,
            );

        if (etag != null) {
          // print('Upload success: $etag');

          String uploadedFileUrl =
              "https://$projectName.$region.digitaloceanspaces.com/$folderName/$fileName";
          // print('Uploaded file URL: $uploadedFileUrl');
          final result = await assignmentupload(assignId, uploadedFileUrl);
          if (result == 'success') {
            showSubscriptionActiveSnackBar(
                context, 'File uploaded successfully,');
          } else {
            showSubscriptionActiveSnackBar(
                context, 'Something went wrong file is not uploaded');
          }
        } else {
          showSubscriptionActiveSnackBar(
              context, 'Something went wrong file is not uploaded');
        }
      } else {
        showSubscriptionActiveSnackBar(context, 'No file Selected');
      }
    } catch (e) {
      showSubscriptionActiveSnackBar(
          context, 'Something went wrong file is not uploaded');
    }
  }
}
