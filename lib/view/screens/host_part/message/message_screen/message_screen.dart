import 'package:event_platform/utils/app_colors/app_colors.dart';
import 'package:event_platform/utils/app_strings/app_strings.dart';
import 'package:event_platform/view/components/custom_gradient/custom_gradient.dart';
import 'package:event_platform/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:event_platform/view/components/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import '../../../../components/custom_nav_bar/host_navbar.dart';
import '../widgets/custom_message_list_card.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return
      CustomGradient(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CustomRoyelAppbar(leftIcon: false, titleName: "Messages"),

          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomTextField(
                  hintText: AppStrings.search,
                  fillColor: Colors.transparent,
                  hintStyle: TextStyle(color: AppColors.black_80,),
                  textEditingController: TextEditingController(),
                  fieldBorderColor: Color(0xff96C9B8),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: 20,
                  separatorBuilder: (context, index) =>
                      SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return CustomMessageList(
                      title: 'Chat with Andrew',
                      subtitle: 'This is a subtitle for user',
                      time: '10:00 AM',
                      icon1: Icon(Icons.done_all, color: Colors.green),
                    );
                  },
                ),
              ),
            ],
          ),
          bottomNavigationBar: HostNavbar(currentIndex: 3,),
        ),
      );
  }
}
