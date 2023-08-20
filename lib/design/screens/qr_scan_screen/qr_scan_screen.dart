import 'dart:convert';
import 'dart:io';

import 'package:fablearner_app/data/user_preferences.dart';
import 'package:fablearner_app/design/screens/lesson_screen/lesson_screen.dart';
import 'package:fablearner_app/providers/lesson_provider.dart';
import 'package:fablearner_app/providers/user_provider.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanScreen extends StatefulWidget {
  const QRScanScreen({super.key});

  @override
  State<QRScanScreen> createState() => _QRScanScreenState();
}

class _QRScanScreenState extends State<QRScanScreen> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool lessonScreenOpened = false;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Lesson QR Scan",
              style: AppTextStyles.displaySmall,
            ),
          ),
        ),
        body: GestureDetector(
          child: Stack(
            alignment: Alignment.center,
            children: [
              buildQrView(context),
              Positioned(
                bottom: AppLayout.getHeight(10),
                child: Text(
                  'fe',
                ),
              )
            ],
          ),
        ));
  }

  Widget buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        cutOutSize: AppLayout.getScreenWidth() * 0.8,
        borderWidth: 10,
        borderLength: 20,
        borderRadius: 10,
        borderColor: AppColors.primaryColor,
      ),
    );
  }

  void onQRViewCreated(QRViewController controller) {
    
    setState(() => this.controller = controller);

    controller.scannedDataStream.listen((scanData) async {
      if (lessonScreenOpened) {
        return; // Return if the lesson screen is already opened
      }
      try {
        String scannedResult = scanData.code!;
        printIfDebug("result Id: $scannedResult");

        Map<String, dynamic> data = json.decode(scannedResult);

        if (data.containsKey('id')) {
          int oldId = int.parse(data['id']);
          printIfDebug("Old Id : $oldId");

          String jsonString =
              await rootBundle.loadString('assets/files/mappings.json');
          List<dynamic> mappings = json.decode(jsonString);
          int newId = mappings.firstWhere((m) => m['Old ID'] == oldId,
              orElse: () => {'New ID': oldId})['New ID'];
          printIfDebug("New ID found: $newId");

          final userProvider =
              Provider.of<UserProvider>(context, listen: false);
          final String token =
              UserPreferences.getUserToken() ?? userProvider.user.token;
          final lessonProvider =
              Provider.of<LessonProvider>(context, listen: false);
          try {
            await lessonProvider.fetchLessonModel(newId, token);
            final lesson = lessonProvider.lessonModel;
            lessonScreenOpened = true;
            printIfDebug(
                "Lesson Found in QR SCAN : ${lessonProvider.lessonModel}");
            if (mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LessonScreen(
                      lesson: lesson,
                    );
                  },
                ),
              );
            }
          } catch (e) {
            printIfDebug("Error fetching lesson: $e");
            showErrorToast("Lesson Not Found");
          }
        } else {
          printIfDebug("No Id present");
          showErrorToast("Invalid QR Code");
        }
      } catch (e) {
        printIfDebug("Error decoding QR Code: $e");
        showErrorToast("Invalid QR Code");
      } finally {
        controller.pauseCamera();
      }
    });
  }

  // Dispose the controller
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
