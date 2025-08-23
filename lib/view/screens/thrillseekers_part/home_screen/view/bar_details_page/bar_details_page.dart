import 'package:event_platform/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../widget/custom_common_details_br_card/custom_common_details_br_card.dart';

class BarDetailsPage extends StatefulWidget {
  const BarDetailsPage({super.key});

  @override
  State<BarDetailsPage> createState() => _BarDetailsPageState();
}

class _BarDetailsPageState extends State<BarDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomRoyelAppbar(
          titleName: "Italiano Pucchini",
         leftIcon: true,
        ),

        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 20,right: 20,top: 23,bottom: 65),
          child: CustomCommonDetailsBrCard(

          ),
        ),
      ),
    );
  }
}
