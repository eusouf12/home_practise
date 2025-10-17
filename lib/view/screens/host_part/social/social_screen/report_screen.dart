import 'package:event_platform/view/components/custom_gradient/custom_gradient.dart';
import 'package:event_platform/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:event_platform/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../components/custom_from_card/custom_from_card.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
        child: Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: 'Report Reason',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: CustomFormCard(
          title: "",
          hintText: "Describe Your Event",
          maxLine: 4,
          controller: TextEditingController(),
        ),
      ),
    ));
  }
}
