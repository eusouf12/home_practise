
import 'package:flutter/material.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_icons/app_icons.dart';
import '../../../../../components/custom_image/custom_image.dart';
import '../../../../../components/custom_text/custom_text.dart';

class CustomTicketHistory extends StatefulWidget {
  final String? ticketCount;
  final String? price;
  final String? totalPrice;

  const CustomTicketHistory({
    super.key,
    this.ticketCount,
    this.price,
    this.totalPrice,
  });

  @override
  State<CustomTicketHistory> createState() => _CustomTicketHistoryState();
}

class _CustomTicketHistoryState extends State<CustomTicketHistory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CustomImage(imageSrc: AppIcons.ticket, imageColor: AppColors.primary,),
              SizedBox(width: 8),
              CustomText(
                text: 'Ticket Information',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Ticket Type',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.black_80,
              ),
              CustomText(
                text: 'General Admission',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Quantity',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.black_80,
              ),
              CustomText(
                text: widget.ticketCount??'1',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'price per Ticket',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.black_80,
              ),
              CustomText(
                text: widget.price??'\$ 20.00',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
         SizedBox(height: 16,),
          Container(
            decoration: BoxDecoration(
              color: AppColors.greyLight,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Total to Pay',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomText(
                      text: widget.totalPrice ??'\$ 21.50',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ],
                ),
                CustomText(text: 'Includes all fees', fontSize: 12,
                  fontWeight: FontWeight.w400, color: AppColors.black_80,)
              ],
            ),

          )

        ],
      ),
    );
  }
}
