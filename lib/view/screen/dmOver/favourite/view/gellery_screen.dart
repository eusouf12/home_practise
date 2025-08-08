import 'package:event_management/view/components/custom_gradient/custom_gradient.dart';
import 'package:flutter/material.dart';

abstract class GelleryScreen extends StatefulWidget {
  const GelleryScreen({super.key});

  @override
  State<GelleryScreen> createState() => _GelleryScreenState();
}

class _GelleryScreenState extends State<GelleryScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(

      )
      );
  }
}
