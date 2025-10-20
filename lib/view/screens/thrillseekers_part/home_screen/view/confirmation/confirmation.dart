import 'package:event_platform/view/components/custom_image/custom_image.dart';
import 'package:event_platform/view/screens/thrillseekers_part/home_screen/view/qr_confirm/qr_confirm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_images/app_images.dart';
import '../../../../../components/custom_button/custom_button.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../../../host_part/home/controller/home_controller.dart';
import '../../../profile/controller/dm_profile_controller.dart';
import '../../controller/home_controller/dm_home_controller.dart';
import '../../widget/Generate_Qr/generate_qr.dart';

class Confirmation extends StatefulWidget {
  const Confirmation({super.key});

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  final DmHomeController dmHomeController = Get.put(DmHomeController());
  final DmProfileController dmProfileController = Get.put(DmProfileController());
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      dmHomeController.getLiveEventDetails();
    });
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
          body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

             CustomImage(imageSrc: AppImages.success),
              SizedBox(height: 24,),
              CustomText(
                text: "Ticket confirmed",
                fontWeight: FontWeight.w500,
                fontSize: 24,
                color: AppColors.black_80,
              ),
              SizedBox(height: 16,),
              CustomText(
                text: "Thank you for your payment. You will receive email confirmation shortly.",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.black_80,
                maxLines: 10,
              ),
              SizedBox(height: 40,),
              CustomButton(onTap: (){
                final ticketInformation = dmHomeController.ticketInfo.value;
                final user = dmProfileController.userProfileModel.value;
                final eventLocation = dmHomeController.specificEvent.value?.audienceSettings?.eventLocation;
                if (eventLocation != null) {
                  homeController.getPlaceNameFromCoordinates(
                    eventLocation.lat ?? "",
                    eventLocation.lon ?? "",
                  );
                }
                final payloadData = GenerateQr(
                  ticketId: "12345",
                  eventTitle: ticketInformation!.eventTitle!,
                  date: "${ticketInformation.date != null ? DateFormat('dd-MM-yyyy').format(ticketInformation.date!): ""}",
                  start: ticketInformation.startingTime!,
                  end: ticketInformation.endingTime!,
                  location: homeController.placeName.value,
                  buyerName: user.name!,
                  email: user.email!,
                  totalTicket: dmHomeController.ticketCount,
                  price: dmHomeController.totalTicketPrice,
                );
                debugPrint("======$payloadData");
                Get.to(QrConfirm(payloadData: payloadData));
              },
                title: "Continue",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
