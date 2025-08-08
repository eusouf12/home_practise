import 'package:event_management/view/components/custom_gradient/custom_gradient.dart';
import 'package:flutter/material.dart';

abstract class ItalianoScreen extends StatefulWidget {
  const ItalianoScreen({super.key});

  @override
  State<ItalianoScreen> createState() => _ItalianoScreenState();
}

class _ItalianoScreenState extends State<ItalianoScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(

      )
      );
  }
}
