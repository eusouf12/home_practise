import 'package:event_management/view/components/custom_gradient/custom_gradient.dart';
import 'package:event_management/view/components/custom_nav_bar/dm_navbar.dart';
import 'package:flutter/material.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomGradient(
        child:Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(title: Text("Fevourite"),backgroundColor: Colors.transparent,),

          bottomNavigationBar:DmNavBar(currentIndex: 1),
        )
    );
  }
}