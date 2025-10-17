import 'package:event_platform/utils/app_icons/app_icons.dart';
import 'package:event_platform/view/components/custom_button/custom_button.dart';
import 'package:event_platform/view/components/custom_gradient/custom_gradient.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_images/app_images.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../components/custom_text/custom_text.dart';

class PaymentSetupScreen extends StatelessWidget {
  const PaymentSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            /// Appbar
            const CustomRoyelAppbar(
              leftIcon: true,
              titleName: "Payment Setup",
            ),

            /// Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),

                  /// Payment Box
                  Container(
                    height: 285,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                            text: 'Choose Payment Platform',
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(height: 20),

                          /// Row 1 (Stripe + PayPal)
                          Row(
                            children: [
                              /// Stripe
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    // Get.toNamed(AppRoutes.stripeScreen);
                                  },
                                  child: Container(
                                    height: 82,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.primary2,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        CustomImage(imageSrc: AppIcons.icon1),
                                        const CustomText(
                                          text: 'Stripe',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: AppColors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),

                              /// PayPal
                              Expanded(
                                child: Container(
                                  height: 82,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.primary2,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      CustomImage(imageSrc: AppIcons.icon2),
                                      const CustomText(
                                        text: 'PayPal',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: AppColors.black_80,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          /// Row 2 (Bank + UPI)
                          Row(
                            children: [
                              /// Bank
                              Expanded(
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: 82,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.primary2,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        CustomImage(imageSrc: AppIcons.icon3),
                                        const CustomText(
                                          text: 'Bank',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: AppColors.black_80,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),

                              /// UPI
                              Expanded(
                                child: Container(
                                  height: 82,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.primary2,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      CustomImage(imageSrc: AppIcons.icon4),
                                      const CustomText(
                                        text: 'UPI',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: AppColors.black_80,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      
        /// Save Button
        bottomNavigationBar: Padding(
          padding:
          const EdgeInsets.only(bottom: 40.0, left: 16, right: 16),
          child: CustomButton(
            onTap: () {},
            title: "Save",
          ),
        ),
      ),
    );
  }
}