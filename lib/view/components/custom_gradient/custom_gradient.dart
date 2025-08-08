import 'package:flutter/material.dart';

class CustomGradient extends StatelessWidget {
  final Widget child;

  const CustomGradient({
    super.key,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors:[
                  Color(0xFFD0F2D3),
                  Color(0xFF5BCDA4),
                ]
            )
        ),
        child: child,
    );
  }
}