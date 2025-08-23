import 'package:event_platform/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:event_platform/view/screens/thrillseekers_part/home_screen/widget/custom_bar_card/custom_bar_card.dart';
import 'package:flutter/material.dart';
import '../../../../../components/custom_gradient/custom_gradient.dart';
import '../../../../../components/custom_nav_bar/dm_navbar.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomRoyelAppbar(leftIcon: false, titleName: "Favorite",),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
          child: Column(
            children: List.generate(10, (index) {
              return Column(
                children: [
                  CustomBarCard(
                    isFavorite: true,
                    title: "Italiano by Pucchini",
                  )
                ],
              );
            }),
          ),
        ),

       bottomNavigationBar: DmNavBar(currentIndex: 1),
      ),
    );
  }
}
