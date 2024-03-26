import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vrb_client/core/constants/assets_path.dart';
import 'package:vrb_client/generated/locale_keys.g.dart';
import 'package:vrb_client/representation/widgets/app_bar_continer_widget.dart';

import '../../models/custom_overlay_shape.dart';

class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({super.key});
  static String routeName = '/qr_code_screen';
  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

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
      appBar: AppBarContainerWidget(title: 'QR Code Scanner'),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Image(
                    width: 50,
                    height: 45,
                    image: Image.asset(AssetPath.vietQR).image,
                    fit: BoxFit.cover, // hoặc BoxFit.contain tùy theo yêu cầu của bạn
                  ),
                ),

                Expanded(child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Image.asset(AssetPath.logo_1x),
                  ],
                )),
              ],
            ),
            Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: CustomOverlayShape(),
              ),
              // child: Container(),
            ),
            //TODO den flash

            Column(
              children: [
                SizedBox(height: 20,),
                Text(LocaleKeys.instruct1.tr(), style: TextStyle(fontSize: 14, color: Colors.white),),
                Text(LocaleKeys.instruct2.tr(), style: TextStyle(fontSize: 14, color: Colors.white),),
                // Icon(FontAwesomeIcons.boltLightning)
              ],
            ),
            Expanded(
              flex: 1,
              child: Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      controller?.toggleFlash();
                    },
                    child: Icon(Icons.flash_on),
                  )),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: (result != null)
                    ? Text(
                    '${LocaleKeys.showCode.tr()} ${describeEnum(result!.format)}   : ${result!.code}', style: TextStyle(fontSize: 14, color: Colors.white))
                    : Text(LocaleKeys.findCode.tr(), style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold))
            )),
            Expanded(child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton((){}, LocaleKeys.createQR.tr()),
                _buildButton((){}, LocaleKeys.downloadQR.tr()),
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget _buildButton(Function() onTap, String name) {
    return Container(
      width: 120, // Kích thước chiều rộng của nút là rộng nhất có thể
      margin: EdgeInsets.symmetric(vertical: 8), // Khoảng cách giữa các nút
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Màu chữ của nút
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black), // Màu nền của nút
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(16)), // Khoảng cách giữa các cạnh của nút và văn bản bên trong
          shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))), // Đường viền cong của nút
          side: MaterialStateProperty.resolveWith<BorderSide>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return BorderSide(color: Colors.grey); // Màu viền khi nút bị vô hiệu hóa
              }
              return BorderSide(color: Colors.white); // Màu viền mặc định khi nút được kích hoạt
            },
          ),
        ),
        child: Text(name),
      ),
    );
  }



  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
