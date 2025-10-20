// import 'package:event_platform/view/components/custom_button/custom_button.dart';
// import 'package:event_platform/view/components/custom_text/custom_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import '../../../../../service/api_url.dart';
// import '../../../../../utils/app_colors/app_colors.dart';
// import '../../../../../utils/app_const/app_const.dart';
// import '../../../../components/custom_from_card/custom_from_card.dart';
// import '../../../../components/custom_gradient/custom_gradient.dart';
// import '../../../../components/custom_loader/custom_loader.dart';
// import '../../../../components/custom_netwrok_image/custom_network_image.dart';
// import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
// import '../../home/controller/home_controller.dart';
//
// class HostUpdateScreen extends StatefulWidget {
//   const HostUpdateScreen({super.key});
//
//   @override
//   State<HostUpdateScreen> createState() => _HostUpdateScreenState();
// }
//
// class _HostUpdateScreenState extends State<HostUpdateScreen> {
//   final homeController = Get.find<HomeController>();
//
//   @override
//   Widget build(BuildContext context) {
//     final arguments = Get.arguments??{};
//     final eventId = arguments["eventId"];
//     homeController.fetchEventById(eventId);
//
//     return CustomGradient(
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: CustomRoyelAppbar( leftIcon: true,titleName: "Update Event",),
//         body: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 15, vertical: 30),
//                 child: Obx(() {
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CustomFormCard(
//                         title: "Event Name",
//                         hintText: "Give your event a name",
//                         controller: homeController.updateTitleController.value,
//                       ),
//                       CustomFormCard(
//                         title: "Description",
//                         hintText: "Describe Your Event",
//                         maxLine: 4,
//                         controller: homeController.updateDescriptionController.value,
//                       ),
//
//                       CustomText(
//                         text: 'Upload Cover Image',
//                         color: AppColors.black,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 16.w,
//                         bottom: 8.h,
//                         maxLines: 2,
//                       ),
//
//                       Stack(
//                         children: [
//                           Obx(() {
//                             if (homeController.selectedImage.value != null) {
//                               return ClipRRect(
//                                 borderRadius: BorderRadius.circular(20),
//                                 child: Image.file(
//                                   homeController.selectedImage.value!,
//                                   height: 200.h,
//                                   width: MediaQuery.sizeOf(context).width,
//                                   fit: BoxFit.cover,
//                                 ),
//                               );
//                             }
//                             return CustomNetworkImage(
//                                imageUrl: '${ApiUrl.baseUrl}/${homeController.eventImage.value}',
//                               height: 200.h,
//                               borderRadius: BorderRadius.circular(20),
//                               width: MediaQuery.sizeOf(context).width,
//                             );
//                           }),
//
//
//                           // Obx(() => homeController.eventImage.value.isNotEmpty
//                           //     ? Image.network(homeController.eventImage.value, width: double.infinity, height: 200,)
//                           //     : Container(height: 250, color: Colors.grey[300])),
//
//                           // Edit Button
//                           Positioned(
//                             right: 10.w,
//                             bottom: 10.w,
//                             child: GestureDetector(
//                               onTap: () {
//                                 homeController.pickImageFromGallery();
//                               },
//                               child: Container(
//                                 height: 35,
//                                 width: 35,
//                                 decoration: BoxDecoration(
//                                   color: AppColors.white.withOpacity(0.7),
//                                   shape: BoxShape.circle,
//
//                                 ),
//                                 child: const Icon(Icons.file_upload, size: 25),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 10.h, ),
//
//                       /// Date
//                       Obx(() => CustomFormCard(
//                       onTap: () => homeController.pickDate(),
//                       title: "Date",
//                       readOnly: true,
//                       hintText: "Select date",
//                       suffixIcon: Icon(Icons.calendar_month, color: AppColors.primary),
//                       controller: TextEditingController(
//                       text: homeController.selectedDate.value != null
//                       ? DateFormat('dd-MM-yyyy').format(homeController.selectedDate.value!) : ''),
//                       validator: (value) {
//                       if (homeController.selectedDate.value == null) {
//                       return "Event date is required";
//                       }
//                       return null;
//                       },
//                   )),
//
//
//                   /// Start & End Time
//                       Row(
//                         children: [
//                           Flexible(
//                             child: CustomFormCard(
//                               onTap: () => homeController.pickStartTime(),
//                               title: "Start Time",
//                               readOnly: true,
//                               hintText: "Start time",
//                               controller: TextEditingController(
//                                 text: homeController.formattedStartTime,
//                               ),
//                               suffixIcon: Icon(Icons.access_time,
//                                   color: AppColors.primary),
//                               validator: (value) {
//                                 if (homeController.startTime.value ==
//                                     null) {
//                                   return "Start time is required";
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                           SizedBox(width: 10.w),
//                           Flexible(
//                             child: CustomFormCard(
//                               onTap: () => homeController.pickEndTime(),
//                               title: "End Time",
//                               readOnly: true,
//                               hintText: "End time",
//                               controller: TextEditingController(
//                                 text: homeController.formattedEndTime,
//                               ),
//                               suffixIcon: Icon(Icons.access_time,
//                                   color: AppColors.primary),
//                               validator: (value) {
//                                 if (homeController.endTime.value == null) {
//                                   return "End time is required";
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                       Obx(() => CustomFormCard(
//                         title: "Location",
//                         hintText: "Your location",
//                         controller: homeController.locationController.value,
//                         onChanged: (value) {
//                           if (value.isNotEmpty) {
//                             homeController.getCoordinates(value);
//                           }
//                         },
//                       )),
//                       Obx(() => homeController.updateEventLoading.value
//                           ? const CustomLoader()
//                           : CustomButton(
//                         onTap: () {
//                           if (eventId != null) {
//                             homeController.updateEvent(eventId);
//                           } else {
//                             Get.snackbar('Error', 'Event ID is missing');
//                           }
//                         },
//                         title: 'Save Changes',
//                         fillColor: AppColors.primary,
//                       )),
//                     ],
//                   );
//                 }),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:event_platform/view/components/custom_button/custom_button.dart';
import 'package:event_platform/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_from_card/custom_from_card.dart';
import '../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../components/custom_loader/custom_loader.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../home/controller/home_controller.dart';

class HostUpdateScreen extends StatelessWidget {
  const HostUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final arguments = Get.arguments ?? {};
    final eventId = arguments["eventId"];


    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeController.fetchEventById(eventId);
    });

    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const CustomRoyelAppbar(
          leftIcon: true,
          titleName: "Update Event",
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Event Title
                  CustomFormCard(
                    title: "Event Name",
                    hintText: "Give your event a name",
                    controller: homeController.updateTitleController.value,
                  ),

                  /// Description
                  CustomFormCard(
                    title: "Description",
                    hintText: "Describe Your Event",
                    maxLine: 4,
                    controller:
                    homeController.updateDescriptionController.value,
                  ),

                  CustomText(
                    text: 'Upload Cover Image',
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.w,
                    bottom: 8.h,
                  ),

                  /// Image Picker
                  Stack(
                    children: [
                      Obx(() {
                        if (homeController.selectedImage.value != null) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              homeController.selectedImage.value!,
                              height: 200.h,
                              width: MediaQuery.sizeOf(context).width,
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                        return CustomNetworkImage(
                          imageUrl: homeController.eventImage.value,
                          height: 200.h,
                          borderRadius: BorderRadius.circular(20),
                          width: MediaQuery.sizeOf(context).width,
                        );
                      }),

                      Positioned(
                        right: 10.w,
                        bottom: 10.w,
                        child: GestureDetector(
                          onTap: () => homeController.pickImageFromGallery(),
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: AppColors.white.withOpacity(0.7),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.file_upload, size: 25),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),

                  /// Date Picker
                 Obx((){
                   debugPrint("hi ${homeController.selectedDate.value}");
                   return  CustomFormCard(
                     onTap: () => homeController.pickDate(),
                     title: "Date",
                     readOnly: true,
                     hintText: "Select date",
                     suffixIcon: Icon(Icons.calendar_month, color: AppColors.primary),
                     controller: TextEditingController(text: homeController.formattedDate), // shows selected date
                     validator: (value) {
                       if (homeController.selectedDate.value == null) {
                         return "Event date is required";
                       }
                       return null;
                     },
                   );
                 }),


                  /// Start & End Time
                  Row(
                    children: [
                      Flexible(
                        child: CustomFormCard(
                          onTap: () => homeController.pickStartTime(),
                          title: "Start Time",
                          readOnly: true,
                          hintText: "Start time",
                          controller: TextEditingController(
                            text: homeController.formattedStartTime,
                          ),
                          suffixIcon: Icon(Icons.access_time,
                              color: AppColors.primary),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Flexible(
                        child: CustomFormCard(
                          onTap: () => homeController.pickEndTime(),
                          title: "End Time",
                          readOnly: true,
                          hintText: "End time",
                          controller: TextEditingController(
                            text: homeController.formattedEndTime,
                          ),
                          suffixIcon: Icon(Icons.access_time,
                              color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),

                  /// Location
                  Obx(() => CustomFormCard(
                    title: "Location",
                    hintText: "Your location",
                    controller: homeController.locationController.value,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        homeController.getCoordinates(value);
                      }
                    },
                  )),

                  /// Save Changes Button
                  Obx(
                        () => homeController.updateEventLoading.value
                        ? const CustomLoader()
                        : CustomButton(
                      onTap: () {
                        if (eventId != null) {
                          homeController.updateEvent(eventId);
                        } else {
                          Get.snackbar(
                              'Error', 'Event ID is missing or invalid');
                        }
                      },
                      title: 'Save Changes',
                      fillColor: AppColors.primary,
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
