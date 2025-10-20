import 'package:event_platform/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_icons/app_icons.dart';
import '../../../../../components/custom_button/custom_button.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../components/custom_image/custom_image.dart';
import '../../../../../components/custom_loader/custom_loader.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../../../host_part/home/controller/home_controller.dart';
import '../../controller/home_controller/dm_home_controller.dart';
import '../../widget/custom_live_details/custom_live_comment.dart';
import '../../widget/middle_details/middle_details.dart';
import '../../widget/payment_method_card/payment_method_card.dart';

class ConfirmBooking extends StatelessWidget {
  ConfirmBooking({super.key});
  final DmHomeController dmHomeController = Get.put(DmHomeController());
  final homeController = Get.find<HomeController>();
  int calculateTotalPrice(int ticketCount, int ticketPrice) {
    return ticketCount * ticketPrice;
  }
  String selectedMethod = "Paypal";

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      dmHomeController.getLiveEventDetails();
    });
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Confirm Booking"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child:Obx((){
                  final event = dmHomeController.specificEvent.value!;
                  dmHomeController.saveTicketInfo(event);
                  final int ticket = dmHomeController.ticketCount;
                  final int price = event.audienceSettings!.price!;
                  final int totalPrice = calculateTotalPrice(ticket, price);
                  final eventLocation = dmHomeController.specificEvent.value?.audienceSettings?.eventLocation;
                  if (eventLocation != null) {
                    homeController.getPlaceNameFromCoordinates(
                      eventLocation.lat ?? "",
                      eventLocation.lon ?? "",
                    );
                  }
                  return Column(
                    children: [
                      // song+date+location
                      Column(
                        children: [
                          MiddleDetails(
                            title: event.eventTitle??" ",
                            isTrue: true,
                            location: homeController.placeName.value,
                            date: "${event.date != null ? DateFormat('dd-MM-yyyy').format(event.date!) : ''} - ${event.startingTime}",
                          ),
                          //Ticket Information
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 24,
                              bottom: 8,
                              left: 5,
                            ),
                            child: Row(
                              children: [
                                CustomImage(imageSrc: AppIcons.ticket),
                                SizedBox(width: 8),
                                CustomText(
                                  text: "Ticket Information",
                                  fontSize: 13.6,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                          //Ticket InformationQuantity+Prise+Booking
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8,right: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: "Quantity",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: AppColors.primary,
                                      ),
                                      Spacer(),
                                      CustomText(
                                        text: "$ticket",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: AppColors.black,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8,),
                                //Price per Ticket
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 8),
                                    CustomText(
                                      text: "Price per Ticket",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: AppColors.primary,
                                    ),
                                    Spacer(),
                                    CustomText(
                                      text: "\$$price",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: AppColors.black,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8,),
                              ],
                            ),
                          ),
                          //total pay
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30,top: 13),
                            child: Card(
                              color: Colors.white,
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 16,bottom: 16,left: 16,right: 8),
                                child: CustomLiveComment(
                                  isPreIcon: true,
                                  isTrue: true,
                                  title: "Price per Ticket",
                                  title2: "\$${totalPrice}",
                                  subtitle: "Includes all fees",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontWeight3: FontWeight.w400,
                                  fontSize3: 12,
                                  fontWeight2: FontWeight.w700,
                                  fontSize2: 16,
                                  color: AppColors.black,
                                  color2: AppColors.primary,
                                  color3: AppColors.red,

                                ),
                              ),
                            ),
                          ),
                          PaymentMethoodCard(
                            onSelect: (method){
                              selectedMethod = method;
                            },
                          ),
                          SizedBox(height: 20,),
                          Obx(() => (selectedMethod == "Paypal"?dmHomeController.isPayment.value :dmHomeController.isPaymentStripe.value)
                              ? const CustomLoader()
                              : CustomButton(
                            onTap: () {
                              SharePrefsHelper.setInt('TicketPrice', totalPrice);
                              // Get.toNamed(AppRoutes.confarmation);
                              debugPrint("selectedMethod: $selectedMethod");
                              (selectedMethod == "Paypal"
                                  ? dmHomeController.paymentMethod(totalPrise: totalPrice,selectedMethod: selectedMethod, ticketCount: ticket,)
                                  : dmHomeController.paymentGetMethodStripe(totalPrise: totalPrice,selectedMethod: selectedMethod, ticketCount: ticket,)
                              );
                            },
                            title: "Confirm & Pay \$ ${totalPrice}",
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            fillColor: AppColors.primary,
                            height: 60,
                            borderRadius: 59,
                          ),),


                          SizedBox(height: 20,),
                        ],
                      ),

                    ],
                  );
                })

              ),
            ],
          ),
        ),
      ),
    );
  }
}
