import 'package:event_platform/view/components/custom_gradient/custom_gradient.dart';
import 'package:event_platform/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../components/custom_loader/custom_loader.dart';
import '../../../../components/general_error.dart';
import '../controller/profile_controller.dart';

class TermsConditionScreen extends StatelessWidget {
  final ProfileController profileController = Get.find<ProfileController>();
  TermsConditionScreen({super.key}){
    profileController.getTermsConditions();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
        profileController.getTermsConditions();

    });
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Terms & Conditions",),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(
                () {
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
                      onTap: () => profileController.getTermsConditions());
                case Status.completed:
                  return Column(
                    children: [
                      HtmlWidget(
                        profileController.termsModel.value.termsCondition != null
                            ? profileController.termsModel.value.termsCondition!
                            : 'Terms & Conditions Is Empty Data',
                        textStyle: TextStyle(
                          color: AppColors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  );
              }
            },
          ),
        ),
        // bottomNavigationBar: HostNavbar(currentIndex: 0,),
      ),
    );
  }
}
 