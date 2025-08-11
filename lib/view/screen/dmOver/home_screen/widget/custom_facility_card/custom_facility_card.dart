import 'package:flutter/material.dart';
import '../../../../../components/custom_text/custom_text.dart';

class CustomFacilityCard extends StatefulWidget {
  final String title;
  final Widget? preicon;
  final Widget? posticon;

  const CustomFacilityCard({
    super.key,
    this.title = "Washroom",
     this.preicon,
     this.posticon,
  });

  @override
  State<CustomFacilityCard> createState() => _CustomFacilityCardState();
}

class _CustomFacilityCardState extends State<CustomFacilityCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 70,
        width: double.infinity,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             Row(
               children: [
                 widget.preicon ?? SizedBox(),
                 SizedBox(width: 20,),
                 CustomText(text: widget.title , fontSize: 16, fontWeight: FontWeight.w700,),
               ],
             ),
              widget.posticon?? SizedBox() ,
            ],
          ),
        ),
      ),
    );
  }
}
