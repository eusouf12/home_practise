import 'package:flutter/material.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../../components/custom_text/custom_text.dart';

class DmPrivacyScreen extends StatelessWidget {
  const DmPrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
              children: [
                CustomRoyelAppbar(leftIcon: true, titleName: 'Privacy Policy'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text:
                            'We respect your privacy. When you use our app, we collect basic info like your name, email, and event preferences to help you manage, join, or host events easily.  We never sell your data. We only share it with trusted services to run the app smoothly (like payments, notifications, etc.).  You control your data — update your profile, manage permissions, or delete your account anytime.  Your security is our priority.At [Your App Name], we collect basic personal information to help you manage and attend events more easily. This includes your name, email, phone number, and event activity like RSVPs or event creation.  We may also collect your device info and location (only if you allow it) to improve your experience and offer personalized event suggestions.  Your privacy is important to us. We do not sell your personal data to anyone. We only share necessary info with trusted services that help us run the app — like payment providers or notification tools. You always have control. You can edit your profile, manage permissions, or delete your account whenever you want. We take data security seriously and use standard practices to keep your information safe. For any questions or support, contact us at [your@email.com].',
                        maxLines: 30,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
