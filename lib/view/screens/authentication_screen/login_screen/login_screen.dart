import 'package:event_platform/utils/app_icons/app_icons.dart';
import 'package:event_platform/utils/app_strings/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_images/app_images.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_from_card/custom_from_card.dart';
import '../../../components/custom_image/custom_image.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_text/custom_text.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final AuthController authController = Get.put(AuthController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? email, password;

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
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                   Column(
                     children: [
                       CustomText(
                         top: 20.h,
                         text: AppStrings.welcomeBack,
                         fontSize: 32.w,
                         fontWeight: FontWeight.w600,
                       ),
                       CustomText(
                         text: AppStrings.welcomeBackTitle,
                         fontSize: 14.w,
                         fontWeight: FontWeight.w500,
                         color: AppColors.black_02,
                       ),
                     ],
                   ),
                   // SizedBox(height: 50.h),
                    Column(
                      children: [
                        CustomFormCard(
                          title: AppStrings.email,
                          hintText: AppStrings.enterYourEmail,
                          maxLine: 1,
                          controller: authController.loginEmailController.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.emailFieldCantBeEmpty;
                            }
                            return null;
                          },
                        ),
                        CustomFormCard(
                          title: AppStrings.password,
                          hintText: AppStrings.enterYourPassword,
                          isPassword: true,
                          controller: authController.loginPasswordController.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.passwordFieldCantBeEmpty;
                            }
                            return null;
                          },
                        ),
                        GestureDetector(
                          onTap: (){
                            Get.toNamed(AppRoutes.forgotScreen);
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: CustomText(
                              text: AppStrings.forgetPassword,
                              fontSize: 16.w,
                              fontWeight: FontWeight.w400,
                              bottom: 20.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40,),
                    CustomText(
                      text: "Or",
                      fontSize: 16.w,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 60,),
                    CustomButton(
                      showSocialButton: true,
                      onTap: () {},
                      imageSrc: AppIcons.google,
                      title: AppStrings.signInWithGoogle,
                      fillColor: AppColors.white,
                      textColor: AppColors.black,
                      fontSize: 16.w,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 40,),
                   Column(
                     children: [
                       Obx(() {
                         return authController.loginLoading.value
                             ? CustomLoader()
                             : CustomButton(
                           onTap: () {
                             if (formKey.currentState!.validate()) {
                               authController.loginUser();
                             }
                           },
                           title: AppStrings.login,
                         );
                       }),
                       SizedBox(height: 10.h),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           CustomText(
                             text: AppStrings.dontHaveAccount,
                             fontSize: 16.w,
                             fontWeight: FontWeight.w400,
                             color: AppColors.black_02,
                           ),
                           GestureDetector(
                             onTap: (){
                               Get.offAllNamed(AppRoutes.chooseRoleScreen);
                             },
                             child: CustomText(
                               text: AppStrings.signUp,
                               fontWeight: FontWeight.w700,
                               color: AppColors.primary,
                             ),
                           ),
                         ],
                       )
                     ],
                   )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
