import 'package:flutter/material.dart';
import '../../../../../../utils/app_colors/app_colors.dart';

class Custom2ndHintTextField extends StatelessWidget {
  final String? firstHint;
  final Color firstHintColor;
  final double firstHintSize;
  final FontWeight firstHintWeight;

  final String? secondHint;
  final Color secondHintColor;
  final double secondHintSize;
  final FontWeight secondHintWeight;

  final Widget? prefixIcon;
  final double iconSize;
  final Color? iconColor;
  final EdgeInsetsGeometry iconPadding;

  final double borderRadius;
  final Color borderColor;
  final EdgeInsetsGeometry contentPadding;
  final FocusNode? focusNode;

  const Custom2ndHintTextField({
    super.key,
    this.firstHint = "Bar",
    this.firstHintColor = Colors.black,
    this.firstHintSize = 16,
    this.firstHintWeight = FontWeight.w500,


    this.secondHint = "Italiano by pucchini",
    this.secondHintColor = AppColors.black_80,
    this.secondHintSize = 16,
    this.secondHintWeight = FontWeight.w400,

    this.prefixIcon,
    this.iconSize = 20,
    this.iconColor = AppColors.black_80,
    this.iconPadding = const EdgeInsets.only(left: 23, right: 10),

    this.borderRadius = 15,
    this.borderColor = Colors.transparent,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 18,
    ),
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor),
        ),

        fillColor: Colors.white,
        filled: true,
        contentPadding: contentPadding,
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: iconPadding,
                child: prefixIcon ??Icon(Icons.search)
              )
            : null,
        hintText: '',
        label: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: firstHint,
                style: TextStyle(
                  color: firstHintColor,
                  fontSize: firstHintSize,
                  fontWeight: firstHintWeight,
                ),
              ),
              if (secondHint != null) ...[
                WidgetSpan(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: secondHintColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  alignment: PlaceholderAlignment.middle,
                ),
                TextSpan(
                  text: secondHint,
                  style: TextStyle(
                    color: secondHintColor,
                    fontSize: secondHintSize,
                    fontWeight: secondHintWeight,
                  ),
                ),
              ],
            ],
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    );
  }
}
