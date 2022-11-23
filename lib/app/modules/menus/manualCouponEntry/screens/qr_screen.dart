import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../../../../app/modules/menus/manualCouponEntry/providers/manual_coupon_code_provider.dart';
import '../../../../../app/widgets/app_bar_widget.dart';
import '../../../../../app/widgets/app_spacer.dart';

import '../../../../../core/utils/extensions/screen_extension.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({Key? key}) : super(key: key);

  @override
  _QrScreenState createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? result;
  bool isFlashTurnedOn = false;
  bool scanSuccessful = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: '',
        actions: [
          IconButton(
            onPressed: () async {
              await controller?.toggleFlash();
              setState(() {
                isFlashTurnedOn = !isFlashTurnedOn;
              });
            },
            icon: Icon(
              isFlashTurnedOn ? Icons.flash_off : Icons.flash_on,
            ),
          ),
          IconButton(
            onPressed: () async {
              await controller?.flipCamera();
            },
            icon: const Icon(
              Icons.flip_camera_ios,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: scanSuccessful
          ? FloatingActionButton.extended(
              onPressed: () {
                setState(() {
                  controller?.resumeCamera();
                  scanSuccessful = false;
                  result = null;
                });
              },
              label: Row(
                children: [
                  const Icon(Icons.qr_code),
                  AppSpacer.p4(),
                  const Text(
                    'Scan More',
                  )
                ],
              ),
            )
          : const SizedBox.shrink(),
      body: SizedBox(
        height: context.height,
        width: context.width,
        child: QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
              borderLength: 20,
              borderWidth: 10,
              borderRadius: 10,
              cutOutSize: context.width * 0.8),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        Vibrate.feedback(FeedbackType.success);
        controller.pauseCamera();
        scanSuccessful = true;
        result = scanData;
        checkQRCodeResult();
        result = null;
      });
    });
  }

  checkQRCodeResult() async {
    context.read<ManualCouponCodeProvider>().redeemCoupon(
          result?.code,
        );
  }
}
