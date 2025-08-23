import 'package:flutter/material.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_images/app_images.dart';
import '../../../../../utils/app_strings/app_strings.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_nav_bar/dm_navbar.dart';
import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../components/custom_text_field/custom_text_field.dart';
import '../widgets/custom_message_list_card.dart';

class DmMessageScreen extends StatelessWidget {
  const DmMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomImage(
            imageSrc: AppImages.backG,
            width: size.width,
            height: size.height,
            boxFit: BoxFit.cover,
            fit: BoxFit.cover,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomRoyelAppbar(
                leftIcon: false,
                titleName: "Messages",
              ),
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
              ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: 4,
                separatorBuilder: (context, index) =>
                    SizedBox(height: 10),
                itemBuilder: (context, index) {
                  return CustomMessageList(
                    title: 'Chat with Andrew',
                    subtitle: 'This is a subtitle for user',
                    time: '10:00 AM',
                    icon1: Icon(Icons.done_all, color: Colors.green),
                   // icon2: Icon(Icons.arrow_forward_ios, size: 18),
                  );
                },
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: DmNavBar(
              currentIndex: 2,
            ),
          )
        ],
      ),
      // bottomNavigationBar: HostNavbar(currentIndex: 0,),
    );
  }
}
