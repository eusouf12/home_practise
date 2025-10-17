import 'package:event_platform/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:event_platform/view/screens/thrillseekers_part/home_screen/widget/custom_bar_card/custom_bar_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../service/api_url.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../components/custom_loader/custom_loader.dart';
import '../../../../../components/custom_nav_bar/dm_navbar.dart';
import '../../controller/favourite_controller.dart';

class FavouriteScreen extends StatelessWidget {
  FavouriteScreen({super.key});

  final FavouriteController favouriteController = Get.put(FavouriteController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      favouriteController.getFavouriteNonEvent();
    });

    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const CustomRoyelAppbar(
          leftIcon: false,
          titleName: "Favorite",
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Obx(() {
            if (favouriteController.rxFavouriteNonEventStatus.value == Status.loading) {
              return const Center(child: CustomLoader());
            }

            if (favouriteController.rxFavouriteNonEventStatus.value == Status.error) {
              return const Center(child: Text("Failed to load favourite events"));
            }

            if (favouriteController.favouriteEvents.isEmpty) {
              return const Center(child: Text("No favourite events found"));
            }

            final events = favouriteController.favouriteEvents;

            return ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child:
                  CustomBarCard(
                    img: event.image ?? "",
                    title: event.name ?? "Unknown Event",
                    isFavorite: true,
                    // isFavorite: event.isFavorite ?? true,
                    onFavoriteTap: () async {
                      await favouriteController.deleteFavorite(deleteId: event.id!);
                      debugPrint(event.id!);
                    },

                    onViewDetails: () {
                      Get.toNamed(AppRoutes.barDetailsPage, arguments: event);
                      debugPrint(event.id);
                    },
                  ),


                );
              },
            );
          }),
        ),
        bottomNavigationBar: DmNavBar(currentIndex: 1),
      ),
    );
  }
}
