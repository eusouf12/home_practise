import 'package:flutter/material.dart';

class CustomGradient extends StatelessWidget {
  final Widget child;
  final Color color1;
  final Color color2;

  const CustomGradient({
    super.key,
    required this.child,
    this.color1 = const Color(0xFFD0F2D3),
    this.color2 = const Color(0xFF5BCDA4),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color1,
            color2,
          ],
        ),
      ),
      child: child,
    );
  }
}
