import 'package:event_management/view/components/custom_gradient/custom_gradient.dart';
import 'package:flutter/material.dart';

abstract class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(

      )
      );
  }
}
