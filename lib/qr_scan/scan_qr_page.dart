import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ugd6_b_9/constant/app_constant.dart';
import 'package:ugd6_b_9/database/Client/PresensiClient.dart';
import 'package:ugd6_b_9/qr_scan/scanner_error_widget.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;

class BarcodeScannerPageView extends StatefulWidget {
  const BarcodeScannerPageView({Key? key}) : super(key: key);

  @override
  State<BarcodeScannerPageView> createState() => _BarcodeScannerPageViewState();
}

class _BarcodeScannerPageViewState extends State<BarcodeScannerPageView>
    with SingleTickerProviderStateMixin {
  BarcodeCapture? barcodeCapture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView(
        children: [
          cameraView(),
          Container(),
        ],
      ),
    );
  }

  Widget cameraView() {
    return Builder(
      builder: (context) {
        return Stack(
          children: [
            MobileScanner(
              startDelay: true,
              controller: MobileScannerController(torchEnabled: false),
              fit: BoxFit.contain,
              errorBuilder: (context, error, child) {
                return ScannerErrorWidget(error: error);
              },
              onDetect: (capture) => setBarcodeCapture(capture),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                alignment: Alignment.bottomCenter,
                height: 100,
                color: Colors.black.withOpacity(0.4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 120,
                        height: 50,
                        child: FittedBox(
                          child: GestureDetector(
                            onTap: () => getURLResult(),
                            child: barcodeCaptureTextResult(context),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Text barcodeCaptureTextResult(BuildContext context) {
    return Text(
      barcodeCapture?.barcodes.first.rawValue ??
          LabelTextConstant.scanQrPlaceholderLabel,
      overflow: TextOverflow.fade,
      style: Theme.of(context)
          .textTheme
          .headlineMedium!
          .copyWith(color: Colors.white),
    );
  }


  void showInvalidQRMessage() {
    // Tampilkan pesan kesalahan di snackbar.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("QR code tidak valid untuk presensi.")),
    );
  }

  void setBarcodeCapture(BarcodeCapture capture) {
    // Kita ambil data QR code pertama (atau satu-satunya).
    final qrCode = capture.barcodes.first.rawValue;
    if (qrCode != null) {
      setState(() {
        barcodeCapture = capture;
      });
      // QR code valid, proses lebih lanjut untuk presensi.
      processAttendance(qrCode);
    } else {
      // Jika QR code tidak valid, tampilkan pesan kesalahan.
      showInvalidQRMessage();
    }
  }

  void getURLResult() {
    final qrCode = barcodeCapture?.barcodes.first.rawValue;
    if (qrCode != null) {
      copytoClipboard(qrCode);
    }
  }

  Future<void> processAttendance(String qrCode) async {
    final String code = "Fithub__";

    if(!qrCode.contains(code)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("QR code tidak valid untuk presensi.")),
      );
    }else
      {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("QR code valid untuk presensi.")),
        );
      }

  }

  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void copytoClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text(LabelTextConstant.textOnCopyingClipboard)),
  );
}
}