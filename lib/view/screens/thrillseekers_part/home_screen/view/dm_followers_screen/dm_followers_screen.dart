import 'package:event_platform/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_button/custom_button.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../../../../components/custom_text_field/custom_text_field.dart';
import '../../../favorite/widget/custom_invite_card/custom_invite_card.dart';


class DmFollowersScreen extends StatefulWidget {
  const DmFollowersScreen({super.key});

  @override
  State<DmFollowersScreen> createState() => _InvitedScreenState();
}

class _InvitedScreenState extends State<DmFollowersScreen> {
  List<bool> isCheckedList = List.generate(10, (_) => false);
  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Followers",),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 21,horizontal: 20),
              child: Column(
                children: [
                  CustomTextField(
                    fillColor: AppColors.white,
                    fieldBorderRadius: 30,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Icon(
                        Icons.search,
                        color: AppColors.primary,
                        size: 28,
                      ),
                    ),
                    hintText: "Search",
                    hintStyle: TextStyle(color: AppColors.black_02),
        
                  ),
                  SizedBox(height: 20,),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(text: "Followers(850)", fontSize: 16.w,fontWeight: FontWeight.w600,color: AppColors.primaryLight,),
                      CustomText(text: "Following", fontSize: 16.w,fontWeight: FontWeight.w600,color: AppColors.black_02,),
                    ],
                  ),
                  ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    itemCount: isCheckedList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (_, __) => const SizedBox(height: 18),
                    itemBuilder: (context, index) {
                      return CustomInviteCard(
                        moreIcon: false,
                        checkedColor: AppColors.primary,
                        isChecked: isCheckedList[index],
                        onChanged: (value) {
                          setState(() {
                            isCheckedList[index] = value;
                          });
                        },
                      );
                    },
                  ),
                  CustomButton(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    title: "Send invite (8)",
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}