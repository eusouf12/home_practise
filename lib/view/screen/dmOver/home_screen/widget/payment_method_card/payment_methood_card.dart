import 'package:event_management/view/components/custom_images/custom_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentMethoodCard extends StatefulWidget {

  const PaymentMethoodCard({super.key});

  @override
  State<PaymentMethoodCard> createState() => _PaymentMethoodCardState();
}

class _PaymentMethoodCardState extends State<PaymentMethoodCard> {
  final List<Map<String, dynamic>> paymentMethods = [
    {
      'title': 'UPI',
      'icon': 'assets/icons/upi.svg',
    },
    {
      'title': 'Wallet',
      'icon': 'assets/icons/wallet.svg',
    },
    {
      'title': 'Credit/Debit Card',
      'icon': 'assets/icons/card.svg',
    },
    {
      'title': 'Apple Pay / Google Pay',
      'icon': 'assets/icons/apple_google.svg',
    },
  ];

  final RxInt selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Select Payment Method",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          ...paymentMethods.asMap().entries.map((entry) {
            int index = entry.key;
            var method = entry.value;
            bool isSelected = selectedIndex.value == index;

            return GestureDetector(
              onTap: () => selectedIndex.value = index,
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.green.shade50 : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected ? Colors.green : Colors.grey.shade300,
                    width: 1.2,
                  ),
                ),
                child: Row(
                  children: [
                    CustomImage(
                      imageSrc: method['icon'],
                      height: 22,
                      width: 22,
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
                      color: isSelected ? Colors.green : Colors.grey,
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 15),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade800,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {},
            child: const Text(
              "Confirm & Pay \$21.50",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
