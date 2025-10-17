import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/app_routes/app_routes.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../../../utils/app_images/app_images.dart';
import '../../../utils/app_strings/app_strings.dart';
import '../../../utils/local_storage/local_storage.dart';
import '../../components/custom_button/custom_button.dart';
import '../../components/custom_image/custom_image.dart';
import '../../components/custom_text/custom_text.dart';

class ChooseRoleScreen extends StatefulWidget {
  const ChooseRoleScreen({super.key});

  @override
  _ChooseRoleScreenState createState() => _ChooseRoleScreenState();
}

class _ChooseRoleScreenState extends State<ChooseRoleScreen> {
  int selectedIndex = -1;
  final StorageService storageService = StorageService();

  @override
  void initState() {
    super.initState();
    storageService.initStorage();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        children: [
          CustomImage(
            imageSrc: AppImages.backG,
            width: size.width,
            height: size.height,
            boxFit: BoxFit.cover,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    CustomText(
                      top: 20.h,
                      text: AppStrings.chooseYourRole,
                      fontSize: 32.w,
                      fontWeight: FontWeight.w600,
                    ),
                    CustomText(
                      text: AppStrings.chooseYourRoleTitle,
                      fontSize: 16.w,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black_02,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // First Container
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = 0; 
                        });
                        StorageService().write("role", "host");
                        print(" Saved role: host");
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: size.width / 2.4,
                        decoration: BoxDecoration(
                          color: selectedIndex == 0
                              ? AppColors.primary
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            CustomImage(
                                imageSrc: AppImages.image1,
                                width: 100.w,
                                height: 120.h
                            ),
                            CustomText(
                              top: 8.h,
                              text: "HOST",
                              fontSize: 16.w,
                              color:  selectedIndex == 0
                                  ? AppColors.white
                                  : Colors.black,
                              fontWeight: FontWeight.w600,
                              bottom: 8.h,
                            ),
                            CustomText(
                              text:
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                              fontSize: 12.w,
                              fontWeight: FontWeight.w400,
                              maxLines: 3,
                              color: selectedIndex == 0
                                  ? AppColors.white
                                  : AppColors.black_02,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    // Second Container
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = 1; 
                        });
                        StorageService().write("role", "thrillseekers");
                        print("Saved role: thrillseekers");
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: size.width / 2.3,
                        decoration: BoxDecoration(
                          color: selectedIndex == 1
                              ? AppColors.primary
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            CustomImage(
                                imageSrc: AppImages.image2,
                                width: 110.w,
                                height: 130.h),
                            CustomText(
                              text: "Thrillseekers",
                              fontSize: 16.w,
                              fontWeight: FontWeight.w600,
                              bottom: 8.h,
                              color: selectedIndex == 1
                                  ? AppColors.white
                                  : Colors.black,
                            ),
                            CustomText(
                              text:
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                              fontSize: 12.w,
                              fontWeight: FontWeight.w400,
                              maxLines: 3,
                              color: selectedIndex == 1
                                  ? AppColors.white
                                  : AppColors.black_02,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // btn
                CustomButton(
                  onTap: () {
                    if (selectedIndex == -1) return;
                    Get.toNamed(AppRoutes.signUpScreen);
                  },
                  title: AppStrings.continueText,
                  textColor: selectedIndex != -1? AppColors.white :AppColors.white,
                  fillColor: selectedIndex != -1? AppColors.primary :AppColors.primary.withValues(alpha: .3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}