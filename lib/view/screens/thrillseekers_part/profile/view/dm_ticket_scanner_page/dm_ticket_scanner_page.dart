import 'package:event_platform/utils/app_images/app_images.dart';
import 'package:event_platform/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../components/custom_image/custom_image.dart';
import '../../../../../components/custom_text/custom_text.dart';

class DmTicketScannerPage extends StatefulWidget {
  const DmTicketScannerPage({super.key});

  @override
  State<DmTicketScannerPage> createState() => _QrConfirmState();
}

class _QrConfirmState extends State<DmTicketScannerPage> {
  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar:CustomRoyelAppbar(leftIcon: true, titleName: "Events Check-In",),
         body: Padding(
           padding: const EdgeInsets.symmetric(horizontal: 10),
           child: Center(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
              children: [
               CustomImage(imageSrc: AppImages.qrImage),
                SizedBox(height: 45,),
                CustomText(
                  text: "Please show the QR to start Event",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ],
             ),
           ),
         ),
      ),
    );
  }
}
