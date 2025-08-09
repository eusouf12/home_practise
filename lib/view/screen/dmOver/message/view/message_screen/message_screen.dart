import 'package:event_management/view/components/custom_gradient/custom_gradient.dart';
import 'package:event_management/view/components/custom_nav_bar/dm_navbar.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: Text("message"),backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,),


        bottomNavigationBar:DmNavBar(currentIndex: 2),
      ),
    );
  }
}