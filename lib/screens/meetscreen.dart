import 'dart:async';
import 'package:amore_student_erp/others/clors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:oyster_lms/app/config/theme/text.dart';
// import 'package:oyster_lms/core/helpers/appbarhelper.dart';
// import 'package:oyster_lms/core/helpers/dialougehelper.dart';
// import 'package:oyster_lms/core/helpers/toasthelper.dart';
// import 'package:oyster_lms/core/utils/debuprint.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:permission_handler/permission_handler.dart';

// import '../../../app/Di/dimensions.dart';
// import '../../../app/config/theme/colors.dart';

class ZoomMeetingScreen extends StatefulWidget {
  const ZoomMeetingScreen(
      {super.key,
      required this.meetingUrl,
      required this.stuname,
      required this.topic});
  final String meetingUrl;
  final String stuname;
  final String topic;

  @override
  State<ZoomMeetingScreen> createState() => _ZoomMeetingScreenState();
}

class _ZoomMeetingScreenState extends State<ZoomMeetingScreen> {
  late final WebViewController _controller;
  bool _meetingEnded = false;
  bool _permissionsGranted = false;
  bool _isLoadingPermissions = true;
  Timer? _meetingCheckTimer;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    _meetingCheckTimer?.cancel();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  Future<void> _requestPermissions() async {
    Map<Permission, PermissionStatus> permissions = await [
      Permission.microphone,
      Permission.camera,
    ].request();

    bool allGranted = permissions.values.every(
      (status) => status == PermissionStatus.granted,
    );

    setState(() {
      _permissionsGranted = allGranted;
      _isLoadingPermissions = false;
    });

    if (allGranted) {
      _initializeWebView();
      _startMeetingCheckTimer();
    } else {
      _showPermissionDialog();
    }
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permissions Required'),
          content: const Text(
            'This app needs microphone and camera permissions to join Zoom meetings. Please grant these permissions in app settings.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Exit the meeting screen
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _requestPermissions(); // Try again
              },
              child: const Text('Retry'),
            ),
          ],
        );
      },
    );
  }

  void _initializeWebView() {
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        // allowsInlineMediaPlaybook: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(
      params,
      onPermissionRequest: (WebViewPermissionRequest request) {
        _handleWebViewPermissionRequest(request);
      },
    );

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            return NavigationDecision.navigate;
          },
          onUrlChange: (change) {
            debugPrint('URL changed to: ${change.url}');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.meetingUrl));

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController androidController =
          controller.platform as AndroidWebViewController;
      androidController
        ..setMediaPlaybackRequiresUserGesture(false)
        ..setOnShowFileSelector(_androidFileSelectorHandler);
    }

    _controller = controller;
  }

  Future<void> _handleWebViewPermissionRequest(
      WebViewPermissionRequest request) async {
    debugPrint('WebView permission request for: ${request.types}');

    bool needsMicrophone =
        request.types.contains(WebViewPermissionResourceType.microphone);
    bool needsCamera =
        request.types.contains(WebViewPermissionResourceType.camera);

    bool hasAppPermissions = true;
    if (needsMicrophone) {
      final micStatus = await Permission.microphone.status;
      hasAppPermissions = hasAppPermissions && micStatus.isGranted;
    }
    if (needsCamera) {
      final cameraStatus = await Permission.camera.status;
      hasAppPermissions = hasAppPermissions && cameraStatus.isGranted;
    }

    if (hasAppPermissions) {
      await request.grant();
    } else {
      await request.deny();
      if (mounted) {
        _showWebViewPermissionDialog();
      }
    }
  }

  void _showWebViewPermissionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permission Required'),
          content: const Text(
            'Zoom needs access to your microphone and camera to join the meeting. Please enable these permissions.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
          ],
        );
      },
    );
  }

  Future<List<String>> _androidFileSelectorHandler(
      FileSelectorParams params) async {
    return <String>[];
  }

  void _startMeetingCheckTimer() {
    _meetingCheckTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _checkMeetingStatus();
    });
  }

  Future<void> _checkMeetingStatus() async {
    final currentUrl = await _controller.currentUrl();
    debugPrint('Current URL: $currentUrl');

    if (currentUrl?.contains('zoom.us/postattendee') ?? false) {
      _endMeeting(reason: 'Meeting has ended');
    }

    if (currentUrl?.contains('zoom.us/thankyou') ?? false) {
      _endMeeting(reason: 'Meeting has ended');
    }

    try {
      final meetingEnded = await _controller.runJavaScriptReturningResult(
        '''
        (function() {
          const endedMessage = document.querySelector('[data-testid="meeting-ended"]') || 
                               document.querySelector('.meeting-ended') ||
                               document.querySelector('[aria-label*="meeting has ended"]');
          
          const isPostMeeting = window.location.href.includes('postattendee') ||
                                window.location.href.includes('thankyou') ||
                                document.title.toLowerCase().includes('thank you');
          
          return endedMessage !== null || isPostMeeting;
        })();
        ''',
      );

      if (meetingEnded.toString() == 'true') {
        _endMeeting(reason: 'Meeting has ended');
      }
    } catch (e) {
      debugPrint('Error checking meeting status: $e');
    }
  }

  void _endMeeting({String reason = ''}) {
    if (_meetingEnded) return;

    setState(() {
      _meetingEnded = true;
    });

    _meetingCheckTimer?.cancel();
    Navigator.of(context).pop();

    if (reason.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(reason)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingPermissions) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.topic),
        ),
        // Appbarhelper.pageAppbar(title: widget.topic, leading: false),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Checking permissions...'),
            ],
          ),
        ),
      );
    }

    if (!_permissionsGranted) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.topic),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.mic_off,
                size: 64,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              const Text(
                'Microphone and Camera permissions are required',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Please grant permissions to join the meeting',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _requestPermissions,
                child: const Text('Request Permissions'),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => openAppSettings(),
                child: const Text('Open App Settings'),
              ),
            ],
          ),
        ),
      );
    }
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        // void showWarningMessage(BuildContext context) {
        //   SnackBarHelper.showWarningSnackBar(
        //     context,
        //     title: 'Warning',
        //     desc: 'You cant go back without leaving the meeting',
        //   );
        // }

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.topic),
        ),
        body: Stack(
          children: [
            WebViewWidget(controller: _controller),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: Appcolor.blue,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(screenWidth * 0.1),
                  ),
                ),
                height: screenWidth * 0.1,
                width: screenWidth * 0.6,
                child: Center(child: Text(widget.topic)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SnackBarHelper {
  static void showWarningSnackBar(
    BuildContext context, {
    required String title,
    required String desc,
    Duration duration = const Duration(seconds: 4),
  }) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: Colors.orange,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
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
      backgroundColor: const Color(0xFF424242), // Dark grey background
      duration: duration,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.all(16),
      action: SnackBarAction(
        label: 'OK',
        textColor: Colors.orange,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
