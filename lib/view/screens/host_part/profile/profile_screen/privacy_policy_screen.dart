import 'package:event_platform/view/components/custom_gradient/custom_gradient.dart';
import 'package:event_platform/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart'
    show HtmlWidget;
import 'package:get/get.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../components/custom_loader/custom_loader.dart';
import '../../../../components/general_error.dart';
import '../controller/profile_controller.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  final ProfileController profileController = Get.find<ProfileController>();
  PrivacyPolicyScreen({super.key});


  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (profileController.privacyModel.value.privacyPolicy == null) {
        profileController.getPrivacyPolicy();
      }
    });
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar:  CustomRoyelAppbar(leftIcon: true, titleName: "Privacy Policy",),
        body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Obx(() {
                      switch (profileController.rxTermsStatus.value) {
                        case Status.loading:
                          return Center(
                            child: CustomLoader(),
                          );
                        case Status.internetError:
                          return Center(
                            child: CustomLoader(),
                          );
                        case Status.error:
                          return GeneralErrorScreen(
                              onTap: () => profileController.getPrivacyPolicy());
                        case Status.completed:
                          return Column(
                            children: [
                              HtmlWidget(
                                profileController.privacyModel.value.privacyPolicy ?? 'Privacy Policy is empty',
                                textStyle: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          );
                      }
                    }),
                  ),
        )
      ),
    );
  }
}
