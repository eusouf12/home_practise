import 'package:event_platform/view/components/custom_gradient/custom_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_strings/app_strings.dart';
import '../../../../components/custom_button/custom_button.dart';
import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../components/custom_text_field/custom_text_field.dart';
import '../controller/profile_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar:  CustomRoyelAppbar(leftIcon: true, titleName: "Change Password", ),
        body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        fillColor: Colors.transparent,
                        fieldBorderColor: Color(0xff96C9B8),
                        isPassword: true,
                        hintText: 'Current Password',
                        hintStyle: TextStyle( color: AppColors.black_05,),
                        inputTextStyle: TextStyle(color: AppColors.black,),
                        textEditingController: profileController.oldPasswordController.value,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        fillColor: Colors.transparent,
                        fieldBorderColor: Color(0xff96C9B8),
                        isPassword: true,
                        hintText: 'New Password',
                        hintStyle: TextStyle( color: AppColors.black_05,),
                        inputTextStyle: TextStyle(color: AppColors.black,),
                        textEditingController: profileController.newPasswordController.value,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        fillColor: Colors.transparent,
                        fieldBorderColor: Color(0xff96C9B8),
                        isPassword: true,
                        hintText: 'Retype Password',
                        hintStyle: TextStyle( color: AppColors.black_05,),
                        inputTextStyle: TextStyle(color: AppColors.black,),
                        textEditingController: profileController.confirmPasswordController.value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.confirmPassword;
                          } else if (value !=
                              profileController.newPasswordController.value.text) {
                            return AppStrings.passwordNotMatch;
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomButton(
                onTap: () {
                  profileController.changePassword();
                },
                title: 'Save Changes',
                fillColor: AppColors.primary,
              ),
            ),

      ),
    );
  }
}
