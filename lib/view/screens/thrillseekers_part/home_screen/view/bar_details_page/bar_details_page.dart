import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../components/custom_loader/custom_loader.dart';
import '../../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../favorite/controller/favourite_controller.dart';
import '../../../favorite/model/favourite_model.dart';
import '../../widget/custom_common_details_br_card/custom_common_details_br_card.dart';
import '../../../../../../core/app_routes/app_routes.dart';

class BarDetailsPage extends StatelessWidget {
  final FavouriteController favouriteController = Get.put(FavouriteController());
  final MyFavoriteEvent event = Get.arguments as MyFavoriteEvent;

  BarDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch favourite details after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      favouriteController.getFavouriteDetails(specificId: event.id.toString());
    });

    return CustomGradient(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CustomRoyelAppbar(
            titleName: event.name ?? "Event Details",
            leftIcon: true,
          ),
          body: Obx(() {
            // Show loader
            if (favouriteController.isLoadingDetails.value) {
              return const Center(child: CustomLoader());
            }

            // Show error message
            if (favouriteController.rxFavouriteDetails.value == Status.error ||
                favouriteController.favouriteDetails.value == null) {
              return const Center(child: Text("Failed to load data"));
            }

            // Success: safely get EventData
            final eventData = favouriteController.favouriteDetails.value!;

            return SingleChildScrollView(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 23, bottom: 65),
              child: CustomCommonDetailsBrCard(
                title: eventData.name ?? "",
                address: eventData.address ?? "",
                image: eventData.image ?? "",
                type: eventData.types?.isNotEmpty == true ? eventData.types!.first : "",
                lat: eventData.location?.lat ?? 0,
                lon: eventData.location?.lng ?? 0,
                onSharePressed: () => debugPrint("Share pressed"),
                onGalleryPressed: () {
                  Get.toNamed(AppRoutes.galleryScreen, arguments: eventData.id);
                  debugPrint(eventData.id);
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}
