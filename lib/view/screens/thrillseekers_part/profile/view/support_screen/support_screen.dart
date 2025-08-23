// import 'package:flutter/material.dart';
// import 'package:time/view/components/custom_from_card/custom_from_card.dart';
// import 'package:time/view/components/custom_gradient/custom_gradient.dart';
// import 'package:time/view/components/custom_royel_appbar/custom_royel_appbar.dart';
//
// import '../../../../../../utils/app_colors/app_colors.dart';
// import '../../../../../components/custom_button/custom_button.dart';
// import '../../../../../components/custom_text/custom_text.dart';
//
// class SupportScreen extends StatelessWidget {
//   const SupportScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomGradient(
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: Column(
//           children: [
//             CustomRoyelAppbar(titleName: 'Support And Feedback'),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CustomText(
//                     text: 'Contact Support',
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                   CustomText(
//                     text: 'Reach out to us anytime. Our team is available 24/7',
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                     color: AppColors.grey,
//                     maxLines: 2,
//                     textAlign: TextAlign.start,
//                   ),
//                   CustomFormCard(
//                     title: 'Name',
//                     controller: TextEditingController(),
//                     hintText: 'Your Name',
//                   ),
//                   CustomFormCard(
//                     title: 'Email',
//                     controller: TextEditingController(),
//                     hintText: 'email@gmail.com',
//                   ),
//                   CustomFormCard(
//                     title: 'Select Subject',
//                     controller: TextEditingController(),
//                     hintText: 'Select A Subject',
//                   ),
//                   CustomFormCard(
//                     title: 'Message',
//                     controller: TextEditingController(),
//                     hintText: 'Write Your Message here...',
//                   ),
//                   CustomButton(
//                     onTap: () {},
//                     title: 'Send Request',
//                     fillColor: AppColors.green_01,
//                   ),
//                   SizedBox(height: 20),
//                   Container(
//                     height: 220,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: AppColors.white,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 10,
//                         vertical: 10,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           CustomText(text: 'Feedback & Suggestions', fontSize: 16,
//                             fontWeight: FontWeight.w600,),
//                           CustomText(
//                             text: 'Help us to improve your event experience', fontSize: 16,
//                             fontWeight: FontWeight.w400,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(Icons.star, color: AppColors.grey_08,),
//                               Icon(Icons.star, color: AppColors.grey_08,),
//                               Icon(Icons.star, color: AppColors.grey_08,),
//                               Icon(Icons.star, color: AppColors.grey_08,),
//                               Icon(Icons.star, color: AppColors.grey_08,),
//                             ],
//                           ),
//                           Center(child: CustomText(text: 'Select Your rating', fontSize: 16,
//                             fontWeight: FontWeight.w400,)),
//                           SizedBox(height: 20),
//                           Center(
//                             child: CustomButton(
//                               width: 250,
//                               onTap: () {},
//                               title: 'Send Rating',
//                               fillColor: AppColors.green_01,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
