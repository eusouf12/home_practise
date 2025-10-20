import 'dart:convert';
import 'package:event_platform/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../components/custom_royel_appbar/custom_royel_appbar.dart';

class QrConfirm extends StatelessWidget {
  final String payloadData;
  const QrConfirm({super.key, required this.payloadData});

  Map<String, dynamic> decodeQr(String jsonStr) {
    try {
      return Map<String, dynamic>.from(
          jsonDecode(jsonStr) as Map<String, dynamic>);
    } catch (e) {
      debugPrint("Decode error: $e");
      return {};
    }
  }

  String formatQrText(Map<String, dynamic> data) {
    return '''
Ticket ID: ${data['ticketId']}
Event: ${data['eventTitle']}
Date: ${data['date']}
Start: ${data['start']}
End: ${data['end']}
Location: ${data['location']}
Buyer: ${data['buyerName']}
Email: ${data['email']}
Price: ${data['price']}
Total Ticket: ${data['totalTicket']}
Issued At: ${data['issuedAt']}
''';
  }

  @override
  Widget build(BuildContext context) {
    final decoded = decodeQr(payloadData);
    final readableText = formatQrText(decoded);

    return CustomGradient(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            leading: Container(
              height: 20.h,
              width: 20.w,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
              ),
              child: BackButton(onPressed: (){
                Get.toNamed(AppRoutes.dmHomeScreen);
              },
                  color: AppColors.black
              ),
            ),
            title: CustomText(
              text: "Event Check-In",
              fontSize: 16,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  QrImageView(
                    data: readableText,
                    version: QrVersions.auto,
                    size: 300.0,
                    backgroundColor: Colors.white,
                  ),
                  const SizedBox(height: 40),
                  CustomText(text: "Please show the QR to start Event",fontSize: 16,fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
