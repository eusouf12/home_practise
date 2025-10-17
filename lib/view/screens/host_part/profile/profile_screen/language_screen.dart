import 'package:event_platform/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/app_images/app_images.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  _LanguageSelectorState createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageScreen> {
  String selectedLang = "English";

  final List<String> languages = [
    "English",
    "French",
    "Spanish",
    "Lgbo",
  ];

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
              CustomRoyelAppbar(leftIcon: true,titleName: "Choose Languages",),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                child: Column(
                  children: languages.map((lang) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          lang,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        Radio<String>(
                          activeColor: AppColors.primary,
                          value: lang,
                          groupValue: selectedLang,
                          onChanged: (value) {
                            setState(() {
                              selectedLang = value!;
                            });
                          },
                        ),
                      ],
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        ],
      ),
      // bottomNavigationBar: HostNavbar(currentIndex: 0,),
    );
  }
}