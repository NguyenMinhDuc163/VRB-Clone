import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../models/custom_overlay_shape.dart';

class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({super.key});
  static String routeName = '/qr_code_screen';
  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  late QRViewController _controller;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: QRView(
              key: _qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: CustomOverlayShape(),
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    _controller.toggleFlash();
                  },
                  child: Text('Flash'),
                )),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _controller = controller;
    });
    _controller.scannedDataStream.listen((scanData) {
      print('Scanned Data: ${scanData.code}');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
