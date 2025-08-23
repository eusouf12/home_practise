
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/app_routes/app_routes.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_icons/app_icons.dart';
import '../../../../../components/custom_button/custom_button.dart';
import '../../../../../components/custom_image/custom_image.dart';

class PaymentMethoodCard extends StatefulWidget {
  const PaymentMethoodCard({super.key});

  @override
  State<PaymentMethoodCard> createState() => _PaymentMethoodCardState();
}

class _PaymentMethoodCardState extends State<PaymentMethoodCard> {
  final List<Map<String, dynamic>> paymentMethods = [
    {'title': 'UPI', 'icon': AppIcons.upi},
    {'title': 'Wallet', 'icon': AppIcons.wallet},
    {'title': 'Credit/Debit Card', 'icon': AppIcons.cradit},
    {
      'title': 'Apple Pay / Google Pay', 'icon': AppIcons.apple},
  ];

  final RxInt selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color:  Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 27,left: 28,top:20,bottom: 38 ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select Payment Method",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 14),
              ...paymentMethods.asMap().entries.map((entry) {
                int index = entry.key;
                var method = entry.value;
                bool isSelected = selectedIndex.value == index;

                return GestureDetector(
                  onTap: () => selectedIndex.value = index,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green.shade50 : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected ? AppColors.primary : AppColors.black_80,
                        width: 1.2,
                      ),
                    ),
                    child: Row(
                      children: [
                        CustomImage(
                          imageSrc: method['icon'],
                          height: 36,
                          width: 36,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            method['title'],
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        Icon(
                          isSelected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          color: isSelected ? AppColors.primary : Colors.grey,
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 28),
              CustomButton(
                onTap: () {
                  Get.toNamed(AppRoutes.confarmation);
                },
                title: "Confirm & Pay \$21.50",
                fontWeight: FontWeight.w600,
                fontSize: 16,
                fillColor: AppColors.primary,
                height: 60,
                borderRadius: 59,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
