import 'package:event_platform/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../widget/custom_bar_card/custom_bar_card.dart';

class NearbyRestaurantsScreen extends StatefulWidget {
  const NearbyRestaurantsScreen({super.key});

  @override
  State<NearbyRestaurantsScreen> createState() =>
      _NearbyRestaurantsScreenState();
}

class _NearbyRestaurantsScreenState extends State<NearbyRestaurantsScreen> {
  final List<Map<String, dynamic>> restaurants = [
    {"title": "The Codfather", "distance": 0.8, "isFavorite": false},
    {"title": "Best Buffet", "distance": 1.7, "isFavorite": false},
    {"title": "Sushi House", "distance": 0.5, "isFavorite": false},
    {"title": "Sushi House2", "distance": 0.5, "isFavorite": false},
  ];


  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomRoyelAppbar(
          titleName: "Nearby Restaurants Location",
          leftIcon: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(restaurants.length, (index) {
                return Padding(
                  padding:  EdgeInsets.only(top: 10),
                  child: CustomBarCard(
                    title: restaurants[index]["title"],
                    distance: restaurants[index]["distance"],
                    imgName: "Restaurant",
                    img: AppConstants.ntrition,
                    isFavorite: restaurants[index]["isFavorite"],
                    onFavoriteTap: () {
                      setState(() {
                        restaurants[index]["isFavorite"] =
                        !restaurants[index]["isFavorite"];
                      });
                    },
                    onShareTap: () {
                      // Share logic
                    },
                    onViewDetails: () {
                      Get.toNamed(AppRoutes.restaurantDetailsPage);
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
