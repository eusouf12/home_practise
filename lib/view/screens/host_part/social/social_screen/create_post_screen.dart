import 'package:event_platform/utils/app_strings/app_strings.dart';
import 'package:event_platform/view/components/custom_button/custom_button.dart';
import 'package:event_platform/view/components/custom_from_card/custom_from_card.dart';
import 'package:event_platform/view/components/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_images/app_images.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../components/custom_text/custom_text.dart';
class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _tags = ["Jane Cooper", "Jane Cooper"]; // initial sample

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomRoyelAppbar(leftIcon: true, titleName: "Create Post"),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                 children: [
                   Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                       child: Column(
                         children: [
                           Container(
                             height: 200,
                             width: double.infinity,
                             decoration: BoxDecoration(
                               color: Colors.transparent,
                               border: Border.all(color: Color(0xff96C9B8)),
                               borderRadius: BorderRadius.circular(15),
                             ),
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Icon(Icons.upload_file,size: 50,color: Color(0xff96C9B8)),
                                 CustomText(
                                   top: 10.h,
                                   text: 'Upload a photo or video',
                                   fontWeight: FontWeight.w400,
                                   fontSize: 16,
                                   color: AppColors.primary,
                                 ),
                               ],
                             ),
                           ),
                           SizedBox(height: 20.h,),
                           CustomFormCard(title: AppStrings.caption,
                               hintText: AppStrings.writeCaption,
                               maxLine: 4,
                               controller: TextEditingController()),
                           /// tags filed
                           Container(
                             padding: const EdgeInsets.all(16),
                             decoration: BoxDecoration(
                               color: Colors.transparent,
                               borderRadius: BorderRadius.circular(12),
                             ),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 // Tag title
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     const Text(
                                       "Tag People (Optional)",
                                       style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                     ),
                                     Text(
                                       "${_tags.length}/220",
                                       style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                                     )
                                   ],
                                 ),
                                 const SizedBox(height: 8),

                                 // Tags list
                                 Wrap(
                                   spacing: 8,
                                   runSpacing: 8,
                                   children: _tags
                                       .map(
                                         (tag) => Chip(
                                       label: Text(tag),
                                       deleteIcon: const Icon(Icons.close, size: 18),
                                       onDeleted: () {
                                         setState(() {
                                           _tags.remove(tag);
                                         });
                                       },
                                       shape: RoundedRectangleBorder(
                                         borderRadius: BorderRadius.circular(10),
                                         side: BorderSide(color: AppColors.primary),
                                       ),
                                     ),
                                   )
                                       .toList(),
                                 ),

                                 const SizedBox(height: 12),

                                 // Input with Add button
                                 Row(
                                   children: [
                                     Expanded(
                                         child: CustomTextField(
                                           textEditingController: _controller,
                                           fillColor: Colors.transparent,
                                           fieldBorderColor: Colors.black26,
                                           hintText: AppStrings.enterName,
                                           hintStyle: TextStyle(color: AppColors.primary),
                                         )
                                     ),
                                     const SizedBox(width: 4),

                                     ElevatedButton(
                                       onPressed: () {
                                         if (_controller.text.isNotEmpty) {
                                           setState(() {
                                             _tags.add(_controller.text.trim());
                                             _controller.clear();
                                           });
                                         }
                                       },
                                       style: ElevatedButton.styleFrom(
                                         backgroundColor: AppColors.primary, // dark green button
                                         shape: RoundedRectangleBorder(
                                           borderRadius: BorderRadius.circular(10),
                                         ),
                                         padding:
                                         const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                                       ),
                                       child: CustomText(text: "Add",fontSize: 16.w,color: AppColors.white_50,),
                                     )
                                   ],
                                 ),

                               ],
                             ),
                           ),
                           SizedBox(height: 20.h,),
                           CustomButton(onTap: (){}, title: "Post",),
                           SizedBox(height: 20.h,),
                         ],
                       )
                   ),
                 ],
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
