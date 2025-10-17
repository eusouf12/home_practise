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
import '../../../favorite/controller/favourite_controller.dart';

class NonEventScreen extends StatelessWidget {

  NonEventScreen({super.key});

  final FavouriteController favouriteController = Get.put(FavouriteController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      favouriteController.getNearNonEvent(lat: '', lon: '', type: '');// argument diye see all api call korbo
    });

    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const CustomRoyelAppbar(
          leftIcon: false,
          titleName: "Nearby Bar",
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Obx(() {
            if (favouriteController.rxNonEvenNeartStatus.value == Status.loading) {
              return const Center(child: CustomLoader());
            }

            if (favouriteController.rxNonEvenNeartStatus.value == Status.error) {
              return const Center(child: Text("Failed to load favourite events"));
            }

            if (favouriteController.favouriteNearNonEvents.isEmpty) {
              return const Center(child: Text("No favourite events found"));
            }

            final events = favouriteController.favouriteNearNonEvents;

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
                    onFavoriteTap: () {
                      favouriteController.toggleFavorite(event);
                      //favouriteController.getNearNonEvent(lat: event.location!.lat.toString(), lon: event.location!.lng.toString(), type: ""); Post favourite api call korbo
                    },
                    // onViewDetails: () {
                    //  // Get.toNamed(AppRoutes.barDetailsPage, arguments: event);
                    //   debugPrint(event.id);
                    // },
                  ),


                );
              },
            );
          }),
        ),
      ),
    );
  }
}
