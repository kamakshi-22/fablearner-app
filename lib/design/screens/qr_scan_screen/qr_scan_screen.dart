import 'dart:io';
import 'package:fablearner_app/design/screens/qr_scan_screen/qr_instruction_box.dart';
import 'package:fablearner_app/providers/qr_scan_provider.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final qrProvider = Provider.of<QRScanProvider>(context, listen: false);

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
            alignment: Alignment.topCenter,
            children: [
              buildQrView(context),
              const QRInstructionBox(),
              Consumer<QRScanProvider>(
                builder: (context, qrProvider, child) {
                  if (qrProvider.isLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return SizedBox.shrink(); // Empty widget if not loading
                  }
                },
              ),
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
    final qrProvider = Provider.of<QRScanProvider>(context, listen: false);
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) async {
      await qrProvider.handleQRCode(scanData.code!, context);
      controller.pauseCamera();
    });

    // Reset the flag here when the QR scanner view is created
    qrProvider.setLessonScreenOpened(false);
  }

  // Dispose the controller
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
