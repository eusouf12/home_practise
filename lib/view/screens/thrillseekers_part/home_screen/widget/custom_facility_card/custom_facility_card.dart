
import 'package:flutter/material.dart';
import '../../../../../../utils/app_icons/app_icons.dart';
import '../../../../../components/custom_image/custom_image.dart';
import '../../../../../components/custom_text/custom_text.dart';

class CustomFacilityCard extends StatefulWidget {
  final String title;
  final String description;
  final Widget? preicon;
  final Widget? posticonUp;
  final Widget? posticonDown;

  const CustomFacilityCard({
    super.key,
    this.title = "",
    this.description = "",
    this.preicon,
    this.posticonUp,
    this.posticonDown,
  });

  @override
  State<CustomFacilityCard> createState() => _CustomFacilityCardState();
}

class _CustomFacilityCardState extends State<CustomFacilityCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      widget.preicon ?? const SizedBox(),
                      if (widget.preicon != null) const SizedBox(width: 12),
                      CustomText(
                        text: widget.title,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black.withValues(alpha: 0.8),
                      ),
                    ],
                  ),
                  //
                  widget.posticonUp != null && widget.posticonDown != null
                      ? (isExpanded ? widget.posticonUp! : widget.posticonDown!)
                      : CustomImage(
                    imageSrc: isExpanded
                        ? AppIcons.star
                        : AppIcons.star,
                  ),
                ],
              ),
            ),

            // Expanded Content
            if (isExpanded)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: Colors.grey, height: 1),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 68,bottom: 10,top:3),
                    child: CustomText(
                      text: widget.description,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withValues(alpha: 0.8),
                      maxLines: 10,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
