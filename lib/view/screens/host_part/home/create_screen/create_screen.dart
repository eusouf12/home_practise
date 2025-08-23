import 'package:event_platform/view/components/custom_from_card/custom_from_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_images/app_images.dart';
import '../../../../../utils/app_strings/app_strings.dart';
import '../../../../components/custom_button/custom_button.dart';
import '../../../../components/custom_dropdown/custom_royel_dropdown.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../controller/home_controller.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  String ageFilter = 'No Age Restriction';
  bool isExpanded = false;
  final List<String> ageOptions = [
    'No Age Restriction',
    '13+',
    '18+',
    '21+',
  ];
  final List<Map<String, dynamic>> options = [
    {"title": "Allow photo/video uploads", "value": true},
    {"title": "Enable push notifications", "value": false},
    {"title": "Allow comments", "value": true},
    {"title": "Send email reminders", "value": false},
  ];
  final TextEditingController maxCapacityController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool isPublic = true;
  bool isAudienceExpanded = false; // 🔹 Expand toggle state
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomImage(
            imageSrc: AppImages.backG,
            width: size.width,
            height: size.height,
            boxFit: BoxFit.cover,
            fit: BoxFit.cover,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomRoyelAppbar(
                leftIcon: true,
                titleName: "Create Event",
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 20),
                  child: Obx(() {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFormCard(
                          title: "Event Name",
                          hintText: "Give your event a name",
                          controller: TextEditingController(),
                        ),
                        CustomFormCard(
                          title: "Description",
                          hintText: "Describe Your Event",
                          maxLine: 4,
                          controller: TextEditingController(),
                        ),
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
                        Container(
                          height: 120,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Color(0xff96C9B8)),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.upload_file,
                                  size: 50, color: Color(0xff96C9B8)),
                              CustomText(
                                top: 10.h,
                                text: 'Upload a photo or video',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: AppColors.primary,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),

                        /// Date
                        CustomFormCard(
                          onTap: () {
                            homeController.pickDate();
                          },
                          title: "Date",
                          readOnly: true,
                          hintText: "Select date",
                          suffixIcon: Icon(Icons.calendar_month,
                              color: AppColors.primary),
                          controller: TextEditingController(
                              text: homeController.formattedDate),
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
                                controller: TextEditingController(
                                  text: homeController.formattedStartTime,
                                ),
                                suffixIcon: Icon(Icons.access_time,
                                    color: AppColors.primary),
                              ),
                            ),
                            SizedBox(width: 20.w),
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

                        /// Dropdown
                        CustomRoyelDropdown(
                          items: homeController.catagoryName,
                          fillColor: Colors.transparent,
                          popupColor: AppColors.white,
                          hintText: "Select Category",
                          controller: TextEditingController(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.typeYourDate;
                            }
                            return null;
                          },
                          onChanged: (value) {},
                        ),
                        SizedBox(
                          height: 8,
                        ),

                        /// 🔹 Expandable Audience & Settings Card
                        Card(
                          color: Colors.white,
                          semanticContainer: true,
                          borderOnForeground: true,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
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
                                  child: Row(
                                    children: [
                                      const Icon(Icons.people_outline,
                                          color: Colors.black87),
                                      const SizedBox(width: 8),
                                      const Expanded(
                                        child: Text(
                                          "Audience & Settings",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Icon(
                                        isAudienceExpanded
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down,
                                        color: Colors.black54,
                                      ),
                                    ],
                                  ),
                                ),

                                // Expandable Content
                                AnimatedCrossFade(
                                  firstChild: const SizedBox.shrink(),
                                  secondChild: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 20),

                                      // Age Filter
                                      const Text("Age Filter"),
                                      const SizedBox(height: 6),
                                      DropdownButtonFormField<String>(
                                        value: ageFilter,
                                        items: ageOptions.map((String value) {
                                          return DropdownMenuItem(
                                              value: value, child: Text(value));
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            ageFilter = value!;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 12),
                                        ),
                                      ),

                                      const SizedBox(height: 20),

                                      // Max Capacity
                                      const Text("Max Capacity"),
                                      const SizedBox(height: 6),
                                      TextField(
                                        controller: maxCapacityController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: "Leave empty for no limit",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 20),

                                      // Visibility
                                      const Text("Visibility"),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Radio(
                                            value: true,
                                            groupValue: isPublic,
                                            onChanged: (value) {
                                              setState(() {
                                                isPublic = value!;
                                              });
                                            },
                                          ),
                                          const Text("Public"),
                                          const SizedBox(width: 20),
                                          Radio(
                                            value: false,
                                            groupValue: isPublic,
                                            onChanged: (value) {
                                              setState(() {
                                                isPublic = value!;
                                              });
                                            },
                                          ),
                                          const Text("Private"),
                                        ],
                                      ),

                                      const SizedBox(height: 20),

                                      // Send email
                                      const Text(
                                          "Send a mail for specific person."),
                                      const SizedBox(height: 6),
                                      TextField(
                                        controller: emailController,
                                        decoration: InputDecoration(
                                          hintText: "Write a email address",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  crossFadeState: isAudienceExpanded
                                      ? CrossFadeState.showSecond
                                      : CrossFadeState.showFirst,
                                  duration: const Duration(milliseconds: 300),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Column(
                          children: [
                            /// 🔹 Header (Expandable toggle)
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
                                            text: 'Media & Social',
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.w,
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        isExpanded
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down,
                                        color: AppColors.black,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            /// 🔹 Expandable Content
                            AnimatedCrossFade(
                              firstChild: const SizedBox.shrink(),
                              secondChild: Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey.shade300, width: 1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: options.map((item) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Checkbox(
                                          activeColor: AppColors.primary,
                                          value: item["value"],
                                          onChanged: (value) {
                                            setState(() {
                                              item["value"] = value;
                                            });
                                          },
                                        ),
                                        CustomText(text: item["title"]),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                              crossFadeState: isExpanded
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                              duration: const Duration(milliseconds: 300),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Column(
                          children: [
                            /// 🔹 Header (Expandable toggle)
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
                                        isExpanded
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down,
                                        color: AppColors.black,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            /// 🔹 Expandable Content
                            AnimatedCrossFade(
                              firstChild: const SizedBox.shrink(),
                              secondChild: Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey.shade300, width: 1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: options.map((item) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Checkbox(
                                          activeColor: AppColors.primary,
                                          value: item["value"],
                                          onChanged: (value) {
                                            setState(() {
                                              item["value"] = value;
                                            });
                                          },
                                        ),
                                        CustomText(text: item["title"]),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                              crossFadeState: isExpanded
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
                        CustomButton(onTap: (){}, title: "Submit",),
                        SizedBox(height: 20.h),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}







class PointSystemWidget extends StatefulWidget {
  const PointSystemWidget({super.key});

  @override
  State<PointSystemWidget> createState() => _PointSystemWidgetState();
}

class _PointSystemWidgetState extends State<PointSystemWidget> {
  bool pointSystemEnabled = true;
  int peopleCount = 1;
  double pointValue = 10;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Point System Toggle
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Point System",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Switch(
                  value: pointSystemEnabled,
                  activeColor: Colors.green.shade900,
                  onChanged: (val) {
                    setState(() {
                      pointSystemEnabled = val;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),

          // People Counter
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // People Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "People (Max 5)",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        _counterButton("-", () {
                          setState(() {
                            if (peopleCount > 1) peopleCount--;
                          });
                        }),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            "$peopleCount",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        _counterButton("+", () {
                          setState(() {
                            if (peopleCount < 5) peopleCount++;
                          });
                        }),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Point Slider
                const Text(
                  "Point",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.green.shade900,
                    inactiveTrackColor: Colors.grey.shade300,
                    thumbColor: Colors.green.shade900,
                    // ignore: deprecated_member_use
                    overlayColor: Colors.green.withOpacity(0.2),
                  ),
                  child: Slider(
                    value: pointValue,
                    min: 10,
                    max: 50,
                    divisions: 4,
                    label: pointValue.round().toString(),
                    onChanged: (value) {
                      setState(() {
                        pointValue = value;
                      });
                    },
                  ),
                ),
                // Numbers below slider
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("10"),
                    Text("20"),
                    Text("30"),
                    Text("40"),
                    Text("50"),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _counterButton(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.green.shade900,
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
  String ticketType = "Free";
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountTypeController = TextEditingController();
  final TextEditingController discountValueController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  Future<void> pickDate(BuildContext context, bool isStart) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: const [
                Icon(Icons.confirmation_num, color: Colors.blue),
                SizedBox(width: 8),
                Text(
                  "Ticketing",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Ticket Price Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Ticket Price",
                    style: TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 14)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Radio<String>(
                      value: "Free",
                      groupValue: ticketType,
                      activeColor: Colors.blue,
                      onChanged: (val) {
                        setState(() => ticketType = val!);
                      },
                    ),
                    const Text("Free"),
                    const SizedBox(width: 20),
                    Radio<String>(
                      value: "Paid",
                      groupValue: ticketType,
                      activeColor: Colors.blue,
                      onChanged: (val) {
                        setState(() => ticketType = val!);
                      },
                    ),
                    const Text("Paid"),
                  ],
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: priceController,
                  enabled: ticketType == "Paid",
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixText: "\$ ",
                    hintText: "Price",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Discount Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Discount",
                    style: TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 14)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: discountTypeController,
                        decoration: InputDecoration(
                          hintText: "Offer Type",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: discountValueController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Discount Value",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Valid Time Section
                const Text("Valid time",
                    style: TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 14)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => pickDate(context, true),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            hintText: "Start Date",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            suffixIcon: const Icon(Icons.calendar_today, size: 18),
                          ),
                          child: Text(
                            startDate != null
                                ? "${startDate!.day}/${startDate!.month}/${startDate!.year}"
                                : "",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: InkWell(
                        onTap: () => pickDate(context, false),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            hintText: "End Date",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            suffixIcon: const Icon(Icons.calendar_today, size: 18),
                          ),
                          child: Text(
                            endDate != null
                                ? "${endDate!.day}/${endDate!.month}/${endDate!.year}"
                                : "",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}