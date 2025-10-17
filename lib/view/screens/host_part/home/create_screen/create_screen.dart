import 'package:event_platform/view/components/custom_from_card/custom_from_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_button/custom_button.dart';
import '../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../controller/home_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  bool isFacilitiesExpanded = false;
  bool isAudienceExpanded = false;
  bool isNotificationExpanded2 = false;
  bool isExpanded = false;

  String ageFilter = 'No Age Restriction';
  final List<String> ageOptions = ['No Age Restriction', '13+', '18+', '21+'];
  final List<Map<String, dynamic>> options = [
    {"title": "Allow photo/video uploads", "value": false},
    {"title": "Enable event gallery", "value": false},
    {"title": "Enable social sharing", "value": false},
    {"title": "live streaming", "value": false},
  ];
  final List<Map<String, dynamic>> notificationOptions = [
    {"title": "Enable live chat or Q&A", "value": false},
    {"title": "Enable push notifications for last-minute changes", "value": false},
    {"title": "Set live event countdown", "value": false},
  ];
  final homeController = Get.find<HomeController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomRoyelAppbar( leftIcon: true,titleName: "Create Event",),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 20),
                child: Obx(() {
                  return Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///event name
                        CustomFormCard(
                          title: "Event Name",
                          hintText: "Give your event a name",
                          controller: homeController.titleController.value,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {return "Event name is required";}
                            return null;
                          },
                        ),
                    
                        ///event des
                        CustomFormCard(
                          title: "Description",
                          hintText: "Describe Your Event",
                          maxLine: 4,
                          controller: homeController.descriptionController.value,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {return "Event description is required";}return null;
                          },
                        ),
                    
                        ///event img
                        Align(
                          alignment: Alignment.topLeft,
                          child: CustomText(
                            textAlign: TextAlign.start,
                            text: "Upload Cover Image",
                            fontSize: 16.w,
                            fontWeight: FontWeight.w500,
                            bottom: 8.h,
                          ),
                        ),
                        Obx(() {
                          return GestureDetector(
                            onTap: () async {
                              // Show options to pick image
                              await homeController.pickImageFromGallery();
                              // Or you can show a dialog to choose camera/gallery
                            },
                            child: Container(
                              height: 120,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: Color(0xff96C9B8)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: homeController.selectedImage.value !=
                                        null
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(15),
                                        child: Image.file(
                                          homeController.selectedImage.value!,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: 120,
                                        ),
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.upload_file,
                                              size: 50,
                                              color: Color(0xff96C9B8)),
                                          SizedBox(height: 10.h),
                                          CustomText(
                                            text: 'Upload a event photo',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            color: AppColors.primary,
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          );
                        }),
                        SizedBox(height: 20.h),
                    
                        /// Date
                        CustomFormCard(
                          onTap: () {
                            homeController.pickDate();
                          },
                          title: "Date",
                          readOnly: true,
                          hintText: "Select date",
                          suffixIcon: Icon(Icons.calendar_month, color: AppColors.primary),
                          controller: TextEditingController(text: homeController.formattedDate),
                          validator: (value) {
                            if (homeController.selectedDate.value == null) {return "Event date is required";}return null;},
                        ),
                    
                        /// Start & End Time
                        Row(
                          children: [
                            Flexible(
                              child: CustomFormCard(
                                onTap: () => homeController.pickStartTime(),
                                title: "Start Time",
                                readOnly: true,
                                hintText: "Start time",
                                controller: TextEditingController(text: homeController.formattedStartTime,),
                                suffixIcon: Icon(Icons.access_time, color: AppColors.primary),
                                validator: (value) {
                                  if (homeController.startTime.value == null) {return "Start time is required";}return null;},
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Flexible(
                              child: CustomFormCard(
                                onTap: () => homeController.pickEndTime(),
                                title: "End Time",
                                readOnly: true,
                                hintText: "End time",
                                controller: TextEditingController(text: homeController.formattedEndTime,),
                                suffixIcon: Icon(Icons.access_time, color: AppColors.primary),
                                validator: (value) {
                                 if (homeController.endTime.value == null) {return "End time is required";}return null;},
                              ),
                            ),
                          ],
                        ),
                    
                        ///event Location
                        CustomFormCard(
                          title: "Location",
                          hintText: "Your location",
                          controller: homeController.locationController.value,
                          onChanged: (value) {
                            // if (value.isNotEmpty) {
                            //   homeController.getCoordinates(value);
                            // }
                          },
                        ),
                        SizedBox(height: 10.h),
                    
                        ///  "Venue Facilities",
                        Align(
                          alignment: Alignment.topLeft,
                          child: CustomText(
                            textAlign: TextAlign.start,
                            text: "Venue Facilities",
                            fontSize: 16.w,
                            fontWeight: FontWeight.w500,
                            bottom: 8.h,
                          ),
                        ),
                        Card(
                          color: Colors.transparent,
                          semanticContainer: true,
                          borderOnForeground: true,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header with toggle
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isFacilitiesExpanded =
                                        !isFacilitiesExpanded;
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                        color: const Color(0xff96C9B8),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          "Add Venue Facilities",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      Icon(
                                        isFacilitiesExpanded
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down,
                                        color: Colors.black54,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 15,),
                              // venue facilities
                              AnimatedCrossFade(
                                firstChild: SizedBox.shrink(),
                                secondChild: Container(
                    
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                        color: const Color(0xff96C9B8),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomFormCard(
                                        title: "Washroom",
                                        hintText: "Enter Washroom location",
                                        controller: homeController
                                            .washroomController.value,
                                      ),
                                      CustomFormCard(
                                        title: "Hand Wash Station",
                                        hintText: "Enter Hand Wash Station",
                                        controller: homeController
                                            .handWashController.value,
                                      ),
                                      CustomFormCard(
                                        title: "Smoking Zone",
                                        hintText: "Enter Hand Wash Station",
                                        controller: homeController
                                            .smokingZoneController.value,
                                      ),
                                      CustomFormCard(
                                        title: "Food Court",
                                        hintText: "Enter Food Court Area",
                                        controller: homeController
                                            .foodCourtController.value,
                                      ),
                                      CustomFormCard(
                                        title: "Rest Area",
                                        hintText: "Enter Rest Area",
                                        controller: homeController
                                            .restAreaController.value,
                                      ),
                                    ],
                                  ),
                                ),
                                crossFadeState: isFacilitiesExpanded
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                duration: const Duration(milliseconds: 300),
                              ),
                            ],
                          ),
                        ),
                    
                        /// Event Category
                        Align(
                          alignment: Alignment.topLeft,
                          child: CustomText(
                            textAlign: TextAlign.start,
                            text: "Event Category",
                            fontSize: 16.w,
                            fontWeight: FontWeight.w500,
                            bottom: 8.h,
                          ),
                        ),
                        DropdownButtonFormField2<String>(
                          value: homeController.eventFilter,
                          isExpanded: true,
                          items: homeController.eventOptions.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.w400),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              homeController.eventFilter = value!;
                            });
                          },
                          dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.black_03, width: 1.5),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.black_03, width: 2),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.black_03, width: 1.5),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                    
                        /// event_features"
                        Align(
                          alignment: Alignment.topLeft,
                          child: CustomText(
                            textAlign: TextAlign.start,
                            text: "Event Features",
                            fontSize: 16.w,
                            fontWeight: FontWeight.w500,
                            bottom: 8.h,
                          ),
                        ),
                        DropdownButtonFormField2<String>(
                          value:  homeController.eventFeatures,
                          isExpanded: true,
                          items:  homeController.featuresOptions.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.black,fontSize: 13,fontWeight: FontWeight.w400),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              homeController.eventFeatures = value!;
                            });
                          },
                          dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            padding:
                            const EdgeInsets.symmetric(horizontal: 0),
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.black_03,),
                              borderRadius: BorderRadius.circular(16),
                            ),
                    
                          ),
                        ),
                        SizedBox(height: 8,),
                        /// Expandable Audience & Settings Card
                        Card(
                          color: Colors.transparent,
                          semanticContainer: true,
                          borderOnForeground: true,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header with toggle
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isAudienceExpanded = !isAudienceExpanded;
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                        color: const Color(0xff96C9B8),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.people_outline,
                                          color: Colors.black87),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: CustomText(
                                          text: "Audience & Settings",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                      Icon(isAudienceExpanded
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              // Expandable Content
                              AnimatedCrossFade(
                                firstChild: const SizedBox.shrink(),
                                secondChild: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                        color: const Color(0xff96C9B8),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Age Filter
                                      CustomText(
                                        textAlign: TextAlign.start,
                                        text: "Age Filter",
                                        fontSize: 16.w,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      const SizedBox(height: 6),
                                      DropdownButtonFormField2<String>(
                                        value: ageFilter,
                                        isExpanded: true,
                                        items: ageOptions.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                  fontWeight:
                                                      FontWeight.w400),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            ageFilter = value!;
                                            homeController.ageController.value.text = value;
                                          });
                                        },
                                        dropdownStyleData: DropdownStyleData(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 0),
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 10),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.black_03,
                                                width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.black_03,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.black_03,
                                                width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),
                    
                                      SizedBox(height: 10),
                                      ///Max Capacity
                                      CustomFormCard(
                                        title: "Max Capacity",
                                        hintText: "Leave empty for no limit",
                                        controller: homeController.maxCapacityController.value,
                                        validator: (value) {
                                          if (value == null || value.trim().isEmpty) {return "Max capacity is required";}return null;},
                                      ),
                                      const SizedBox(height: 10),
                    
                                      // Visibility
                                      CustomText(
                                        textAlign: TextAlign.start,
                                        text: "Visibility",
                                        fontSize: 16.w,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      Row(
                                        children: [
                                          Radio(
                                            value: true,
                                            activeColor: AppColors.primary,
                                            groupValue: homeController.isPublic.value,
                                            onChanged: ( value) {
                                              if (value != null) {
                                                homeController.updateVisibility(value);
                                              }
                                            },
                                          ),
                                          const Text("Public"),
                                          const SizedBox(width: 20),
                                          Radio(
                                            activeColor: AppColors.primary,
                                            value: false,
                                            groupValue: homeController.isPublic.value,
                                            onChanged: (value) {
                                              if (value != null) {
                                                homeController.updateVisibility(value);
                                              }
                                            },
                                          ),
                                          const Text("Private"),
                                        ],
                                      ),
                    
                                      SizedBox(height: 10),
                    
                                      // Send email
                                      const Text("Send a mail for specific person."),
                                      const SizedBox(height: 6),
                                      TextField(
                                        controller: homeController.emailController.value,
                                        decoration: InputDecoration(
                                          enabled: !homeController.isPublic.value,
                                          hintText: "Write a email address",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.black_03,
                                                width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.black_03,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.black_03,
                                                width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                crossFadeState: isAudienceExpanded
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                duration: const Duration(milliseconds: 300),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                    
                        ///'Media & Social'
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                      color: const Color(0xff96C9B8), width: 1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.image,
                                              color: AppColors.primary),
                                          const SizedBox(width: 10),
                                          CustomText(
                                            text: 'Media & Social',
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.w,
                                          ),
                                        ],
                                      ),
                                      Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                        color: AppColors.black,),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                    
                            ///  Expandable Content
                            // Media & Social
                            AnimatedCrossFade(
                              firstChild: const SizedBox.shrink(),
                              secondChild: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.black_03, width: 1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Obx(
                                          () => Column(
                                        children: homeController.socialMedia.entries.map((entry) {
                                          return Row(
                                            children: [
                                              Checkbox(
                                                activeColor: AppColors.primary,
                                                value: entry.value,
                                                onChanged: (value) {
                                                  homeController.toggleOption(entry.key, value!);
                                                },
                                              ),
                                              CustomText(
                                                text: homeController.optionSocialMedia[entry.key] ?? entry.key,
                                              ),
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                  Obx(() => !homeController.isSocialMediaValid
                                      ? Padding(
                                    padding: const EdgeInsets.only(top: 5, left: 10),
                                    child: Text(
                                      "Please select at least one option",
                                      style: TextStyle(color: Colors.red, fontSize: 12),
                                    ),
                                  )
                                      : const SizedBox.shrink()),
                                ],
                              ),
                              crossFadeState: isExpanded
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                              duration: const Duration(milliseconds: 300),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                    
                        /// Notification
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isNotificationExpanded2 = !isNotificationExpanded2;
                                });
                              },
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                      color: const Color(0xff96C9B8),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.image,
                                              color: AppColors.primary),
                                          const SizedBox(width: 10),
                                          CustomText(
                                            text: 'Notification',
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.w,
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        isNotificationExpanded2
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down,
                                        color: AppColors.black,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            AnimatedCrossFade(
                              firstChild: const SizedBox.shrink(),
                              secondChild: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.black_03, width: 1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Obx(
                                          () => Column(
                                        children: homeController.notification.entries.map((entry) {
                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Checkbox(
                                                activeColor: AppColors.primary,
                                                value: entry.value,
                                                onChanged: (value) {
                                                  homeController.toggleOptionNotification(entry.key, value!);
                                                },
                                              ),
                                              CustomText(
                                                text: homeController.optionNotification[entry.key] ?? entry.key,
                                              ),
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),

                                  /// Validation message
                                  Obx(() => !homeController.isNotificationValid
                                      ? Padding(
                                    padding: const EdgeInsets.only(top: 5, left: 10),
                                    child: Text(
                                      "Please select at least one option",
                                      style: TextStyle(color: Colors.red, fontSize: 12),
                                    ),
                                  )
                                      : const SizedBox.shrink()),
                                ],
                              ),
                              crossFadeState: isNotificationExpanded2
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                              duration: const Duration(milliseconds: 300),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                    
                        PointSystemWidget(),
                        TicketingWidget(),
                        SizedBox(height: 20.h),
                        ///submit btn
                        CustomButton(
                          onTap: () async{

                            await homeController.getCoordinates(homeController.locationController.value.text.trim());
                            debugPrint("Location =======: ${homeController.locationController.value.text}");
                            debugPrint("Latttttt =======: ${homeController.latitude}");
                            debugPrint("Locnnnnn =======: ${homeController.longitude}");

                            if (_formKey.currentState!.validate()) {
                              // Check all required fields (example: title, description, date, location)
                              if (homeController.titleController.value.text.isEmpty ||
                                  homeController.descriptionController.value.text.isEmpty) {
                                // Show error if any field is missing
                                showCustomSnackBar(
                                  "Please fill all required fields before submitting",
                                  isError: true,
                                );
                                return; // Stop execution, don't call API
                              }

                              // All fields are valid, call API
                              homeController.createEvent();
                            } else {
                              // Form validation failed (if you have validators)
                              showCustomSnackBar(
                                "Please correct errors in the form",
                                isError: true,
                              );
                            }
                          },
                          title: "Submit",
                        ),

                        SizedBox(height: 20.h),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PointSystemWidget extends StatelessWidget {
  const PointSystemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Toggle
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.black_03),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Point System",
                  style:
                  TextStyle(fontWeight: FontWeight.w400, fontSize: 13)),
              Switch(
                value: homeController.pointSystemEnabled.value,
                activeColor: AppColors.primary,
                onChanged: (val) {
                  homeController.pointSystemEnabled.value = val;
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),

        // People + Point Section
        AbsorbPointer(
          absorbing: !homeController.pointSystemEnabled.value,
          child: Opacity(
            opacity: homeController.pointSystemEnabled.value ? 1 : 0.5,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.black_03),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // People Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("People (Max 5)",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w400)),
                      Row(
                        children: [
                          _counterButton("-", () {
                            if (homeController.peopleCount.value > 0) {
                              homeController.peopleCount.value--;
                              if (homeController.pointValue.value > 0) {
                                homeController.pointValue.value -= 10;
                              }
                            }
                          }),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              "${homeController.peopleCount.value}",
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          _counterButton("+", () {
                            if (homeController.peopleCount.value < 5) {
                              homeController.peopleCount.value++;
                              if (homeController.pointValue.value < 50) {
                                homeController.pointValue.value += 10;
                              }
                            }
                          }),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Point Slider
                  const Text("Point", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400)),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: AppColors.primary,
                      inactiveTrackColor: Colors.grey.shade300,
                      thumbColor: AppColors.primary,
                      overlayColor: AppColors.primary,
                      valueIndicatorColor: AppColors.primary,
                    ),
                    child: Slider(
                      value: homeController.pointValue.value,
                      min: 0,
                      max: 50,
                      divisions: 5,
                      label: homeController.pointValue.value.round().toString(),
                      onChanged: homeController.pointSystemEnabled.value
                          ? (val) {
                        homeController.pointValue.value = val;
                        homeController.peopleCount.value = (val ~/ 10); // auto update count
                      }
                          : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [Text("0"), Text("10"), Text("20"), Text("30"), Text("40"), Text("50"),],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }

  Widget _counterButton(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}




class TicketingWidget extends StatefulWidget {
  const TicketingWidget({super.key});

  @override
  State<TicketingWidget> createState() => _TicketingWidgetState();
}

class _TicketingWidgetState extends State<TicketingWidget> {
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16,),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: const [
                Icon(Icons.confirmation_num, color: AppColors.primary),
                SizedBox(width: 8),
                Text(
                  "Ticketing",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          // Ticket Price Section
      Obx(() => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.black_03),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Ticket Price", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),),
            const SizedBox(height: 10),
            Row(
              children: [
                Radio<String>(
                  value: "Free",
                  groupValue: homeController.ticketType.value,
                  activeColor: AppColors.primary,
                  onChanged: (val) {
                    homeController.ticketType.value = val!;
                  },
                ),
                const Text("Free"),
                const SizedBox(width: 20),
                Radio<String>(
                  value: "Paid",
                  groupValue: homeController.ticketType.value,
                  activeColor: AppColors.primary,
                  onChanged: (val) {
                    homeController.ticketType.value = val!;
                  },
                ),
                const Text("Paid"),
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              controller: homeController.priceController.value,
              enabled: homeController.ticketType.value == "Paid",
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixText: "\$ ",
                hintText: "Price",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.black_03),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.black_03),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.black_03),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ))

      ],
      ),
    );
  }
}
