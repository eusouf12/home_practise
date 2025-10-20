import 'package:event_platform/view/components/custom_gradient/custom_gradient.dart';
import 'package:event_platform/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:event_platform/view/components/custom_text/custom_text.dart';
import 'package:event_platform/view/components/custom_button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // make sure GetX is imported

import '../../../../components/custom_from_card/custom_from_card.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final String? reason = args?['reason'];
    final TextEditingController reportController = TextEditingController(text: reason == "Other (Custom Reason)" ? "" : reason ?? "");

    return CustomGradient(
      child: Scaffold(
        appBar: const CustomRoyelAppbar(
          leftIcon: true,
          titleName: 'Report Reason',
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomFormCard(
                title: "",
                hintText: "Describe your reason here...",
                maxLine: 4,
                controller: reportController,
              ),

              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  title: "Submit",
                  onTap: () {
                    final reportText = reportController.text.trim();
                    if (reportText.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter a report reason."),
                        ),
                      );
                      return;
                    }
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        resizeToAvoidBottomInset: true,
      ),
    );
  }
}
