import 'package:event_management/view/components/custom_gradient/custom_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_button/custom_button.dart';
import '../../../../../components/custom_text/custom_text.dart';

class DmFilter extends StatefulWidget {
  const DmFilter({super.key});

  @override
  State<DmFilter> createState() => _DmFilterState();
}

class _DmFilterState extends State<DmFilter> {
  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppBar(
                          automaticallyImplyLeading: false,
                          backgroundColor: Colors.transparent,
                          leading: Container(
                            height: 38.5.h,
                            width: 38.5.h,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              shape: BoxShape.circle,
                            ),
                            child: BackButton(color: AppColors.black),
                          ),
                        ),
                        SizedBox(height: 20,),
                        CustomText(
                          text: 'Event Type',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              height: 50,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColors.white,
                              ),
                              child: Center(
                                child: CustomText(
                                  text: 'Concerts',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: 50,
                              width: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColors.white,
                              ),
                              child: Center(
                                child: CustomText(
                                  text: 'Sports',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: 50,
                              width: 160,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColors.white,
                              ),
                              child: Center(
                                child: CustomText(
                                  text: 'Family-Friendly',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 50,
                          width: 230,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: AppColors.white,
                          ),
                          child: Center(
                            child: CustomText(
                              text: 'Neighborhood Events',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              height: 50,
                              width: 160,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColors.white,
                              ),
                              child: Center(
                                child: CustomText(
                                  text: 'Food Festivals',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            // this is card
                            Container(
                              height: 50,
                              width: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColors.white,
                              ),
                              child: Center(
                                child: CustomText(
                                  text: 'Sports',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: 50,
                              width: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColors.white,
                              ),
                              child: Center(
                                child: CustomText(
                                  text: 'Others',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Divider(color: Colors.grey, thickness: 1, height: 20),
                        SizedBox(height: 10),
                        CustomText(
                          text: 'Price Range',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              height: 50,
                              width: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColors.white,
                              ),
                              child: Center(
                                child: CustomText(
                                  text: 'Free',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: 50,
                              width: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColors.white,
                              ),
                              child: Center(
                                child: CustomText(
                                  text: 'Paid',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        CustomText(
                          text: 'Timeline',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        Divider(color: Colors.grey, thickness: 1, height: 20),
                        Row(
                          children: [
                            Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColors.white,
                              ),
                              child: Center(
                                child: CustomText(
                                  text: 'Today',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: 50,
                              width: 130,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColors.white,
                              ),
                              child: Center(
                                child: CustomText(
                                  text: 'Tomorrow',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: 50,
                              width: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColors.white,
                              ),
                              child: Center(
                                child: CustomText(
                                  text: 'This Weekend',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 50,
                          width: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: AppColors.white,
                          ),
                          child: Center(
                            child: CustomText(
                              text: 'Next Week',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Divider(color: Colors.grey, thickness: 1, height: 20),
                        CustomText(
                          text: 'Access Type',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColors.white,
                              ),
                              child: Center(
                                child: CustomText(
                                  text: 'Today',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: 50,
                              width: 130,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColors.white,
                              ),
                              child: Center(
                                child: CustomText(
                                  text: 'Tomorrow',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Divider(color: Colors.grey, thickness: 1, height: 20),
                        CustomText(
                          text: 'Event Features',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              height: 50,
                              width: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColors.white,
                              ),
                              child: Center(
                                child: CustomText(
                                  text: 'Outdoor',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: 50,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColors.white,
                              ),
                              child: Center(
                                child: CustomText(
                                  text: 'Indoor',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: 50,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColors.white,
                              ),
                              child: Center(
                                child: CustomText(
                                  text: 'wheelchair accessible',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              height: 50,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColors.white,
                              ),
                              child: Center(
                                child: CustomText(
                                  text: 'Pet Friendly',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: 50,
                              width: 160,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColors.white,
                              ),
                              child: Center(
                                child: CustomText(
                                  text: 'ASL Interpreter',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Divider(color: Colors.grey, thickness: 1, height: 20),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomButton(
                                onTap: () {},
                                title: 'Apply Filters',
                                width: 169,
                                height: 56,
                                fillColor: AppColors.green_01,
                              ),

                              CustomButton(
                                onTap: () {},
                                title: 'Apply Filters',
                                width: 169,
                                height: 56,
                                borderWidth: 2,
                                borderRadius: 30,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ),
    );
  }
}
