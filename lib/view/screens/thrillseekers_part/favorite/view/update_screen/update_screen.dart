import 'package:event_platform/utils/app_const/app_const.dart';
import 'package:event_platform/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../components/custom_text_field/custom_text_field.dart';
import '../../widget/update_card/update_card.dart';


class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final List<Map<String, dynamic>> posts = [
    {
      "profileImage": AppConstants.profileImage,
      "profileName": "Alex Johnson",
      "topicName": "Traffic",
      "topicIcon": Icons.bus_alert,
      "topicIconColor": Colors.red,
      "timeAgo": "15m ago",
      "description":
          "Heavy traffic on Main Street due to an accident. Avoid if possible and use 5th Avenue instead.",
      "postImage": "",
      "location": "Main Street, 7th Avenue",
      "likes": 24,
      "comments": 6,
    },
    {
      "profileImage": AppConstants.profileImage,
      "profileName": "Sarah Lee",
      "topicName": "lost",
      "topicIcon": Icons.search,
      "topicIconColor": AppColors.primary,
      "timeAgo": "30m ago",
      "description":
          "Lost a blue backpack with laptop near the food court. If found, please contact me!",
      "postImage": AppConstants.profileImage,
      "location": "Main Street, 7th Avenue",
      "likes": 50,
      "comments": 12,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomRoyelAppbar(
          titleName: "Update & Reports",
          leftIcon: true,
        ),

        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 10, right: 10, top: 23),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                //Live Update
                CustomTextField(
                  prefixIcon: Icon(Icons.search, color: AppColors.primary),
                  hintText: 'Live Update',
                  hintStyle: TextStyle(color: AppColors.black_02),
                  fillColor: AppColors.white,
                  fieldBorderRadius: 41,
                ),
                SizedBox(height: 10,),
                Column(
                  children: List.generate(2, (index) {
                    return Column(
                      children: [
                        UpdateCard(
                          profileImage: posts[index]["profileImage"],
                          profileName: posts[index]["profileName"],
                          topicName: posts[index]["topicName"],
                          topicIcon: posts[index]["topicIcon"],
                          topicIconColor: posts[index]["topicIconColor"],
                          timeAgo: posts[index]["timeAgo"],
                          description: posts[index]["description"],
                          postImage: posts[index]["postImage"],
                          location: posts[index]["location"],
                          initialLikes: posts[index]["likes"],
                          initialComments: posts[index]["comments"],
                        ),
                        SizedBox(height: 29,),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          child: Icon(Icons.add, color: AppColors.white),
        ),
      ),
    );
  }
}
