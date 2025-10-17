import 'package:event_platform/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../core/app_routes/app_routes.dart';
import '../../../../components/custom_button/custom_button.dart';
import '../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../../../../components/custom_text_field/custom_text_field.dart';
import '../../../thrillseekers_part/favorite/widget/custom_invite_card/custom_invite_card.dart';


class HostFollowersScreen extends StatefulWidget {
  const HostFollowersScreen({super.key});

  @override
  State<HostFollowersScreen> createState() => _InvitedScreenState();
}

class _InvitedScreenState extends State<HostFollowersScreen> {
  List<bool> isCheckedList = List.generate(10, (_) => false);
  @override
  Widget build(BuildContext context) {
    return CustomGradient(
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

                      // Checkbox change
                      onChanged: (value) {
                        setState(() {
                          isCheckedList[index] = value;
                        });
                      },

                      // More icon চাপলে অন্য পেজে যাবে
                      onChangedFollowing: (value) {
                        // সরাসরি showModalBottomSheet কল করো
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (context) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.15,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Expanded(
                                      child: ListView(
                                        children: [
                                          optionItem("Block Ronald Richards "),
                                          optionItem("Unfollow Ronald Richards "),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 20),

                                    /// Next button

                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },

                    );
                  },
                ),
                // CustomButton(
                //   onTap: (){
                //     Navigator.pop(context);
                //   },
                //   title: "Send invite (8)",
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


Widget optionItem(String text) {
  // icon select করার জন্য condition
  IconData iconData;
  if (text.toLowerCase().startsWith("block")) {
    iconData = Icons.block;
  } else if (text.toLowerCase().startsWith("unfollow")) {
    iconData = Icons.person_remove;
  } else if (text.toLowerCase().startsWith("follow")) {
    iconData = Icons.person_add;
  } else {
    iconData = Icons.help; // default icon
  }

  return InkWell(
    onTap: () {

    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(iconData, size: 16),
          SizedBox(width: 10.w),
          CustomText(text: text),
        ],
      ),
    ),
  );
}
