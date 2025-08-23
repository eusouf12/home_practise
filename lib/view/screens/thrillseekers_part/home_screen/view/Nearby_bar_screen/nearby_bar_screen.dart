import 'package:event_platform/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../widget/custom_bar_card/custom_bar_card.dart';

class NearbyBarScreen extends StatefulWidget {
  const NearbyBarScreen({super.key});

  @override
  State<NearbyBarScreen> createState() => _NearbyBarScreenState();
}

class _NearbyBarScreenState extends State<NearbyBarScreen> {
  final List<Map<String, dynamic>> bars = [
    {
      "title": "The Codfather", "distance": 0.8, "isFavorite": false,
    },
    {
      "title": "Best Buffet", "distance": 1.5, "isFavorite": false,

    },
    {
      "title": "Sushi House", "distance": 0.5, "isFavorite": false,

    },
  ];

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomRoyelAppbar(
          titleName: "Nearby Bar Location",
          leftIcon: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(bars.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 23),
                  child: CustomBarCard(
                    title: bars[index]["title"],
                    distance: bars[index]["distance"],
                    imgName: "Bar",
                    img: AppConstants.ntrition,
                    isFavorite: bars[index]["isFavorite"],
                    onFavoriteTap: () {
                      setState(() {
                        bars[index]["isFavorite"] = !bars[index]["isFavorite"];
                      });
                    },
                    onShareTap: () {
                      // Share logic
                    },
                    onViewDetails: () {
                      Get.toNamed(AppRoutes.barDetailsPage);
                    },
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
